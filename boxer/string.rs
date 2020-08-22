use super::function;
use crate::CBox;
use std::ffi::CStr;
use std::ffi::CString;
use std::os::raw::c_char;

/**
 I represent a null-terminated string of a given length (without null character).
 I own the data
**/
#[derive(Debug)]
#[repr(C)]
pub struct BoxerString {
    pub data: *mut c_char,
    pub length: usize,
    pub owned: bool,
}

impl BoxerString {
    /// I create an instance BoxerString by copying and owning a given string slice
    pub fn from_slice(slice: &str) -> Self {
        BoxerString {
            data: Self::vec_to_chars(slice),
            length: slice.len(),
            owned: true,
        }
    }

    /// I create an instance of BoxerString without copying and not owning a given character buffer
    /// length must include the zero-byte
    pub fn from_data(data: *mut c_char, length: usize) -> Self {
        if cfg!(debug_assertions) {
            if unsafe { *data.offset((length - 1) as isize) } != 0 {
                eprintln!(
                    "[{}] string buffer of length {} is not zero-terminated ({}):",
                    function!(),
                    length,
                    unsafe { *data.offset((length - 1) as isize) }
                );
                eprintln!("[{}] {:?}", function!(), unsafe {
                    std::slice::from_raw_parts(data, length)
                });
            }
        }

        let slice = unsafe { std::slice::from_raw_parts(data, length) };
        slice.to_vec();

        let mut copy_vec = slice.to_vec();

        let ptr = copy_vec.as_mut_ptr();
        let len = copy_vec.len();
        std::mem::forget(copy_vec);

        BoxerString {
            data: ptr,
            length: len - 1,
            owned: true,
        }
    }

    /// I create an instance of BoxerString by copying and owning a given String
    pub fn from_string(string: &String) -> Self {
        BoxerString {
            data: Self::vec_to_chars(string.as_str()),
            length: string.len(),
            owned: true,
        }
    }

    /// I create an instance of BoxerString by copying and owning a given character buffer
    pub fn from_chars(_data: *mut c_char) -> BoxerString {
        Self::from_string(&Self::chars_to_string(_data))
    }

    /// I create an owned String by copying my data into it
    pub fn to_string(&self) -> String {
        Self::chars_to_string(self.data)
    }

    /// Make sure that I will live longer than the slice
    pub fn to_str(&self) -> &str {
        let slice = unsafe { CStr::from_ptr(self.data) };
        unsafe { std::str::from_utf8_unchecked(slice.to_bytes()) }
    }

    /// Mutate me to hold a copy of a given string in C format
    pub fn set_string(&mut self, string: String) {
        // first free existing char buffer
        if self.owned {
            Self::free_chars(self.data);
        }
        self.data = Self::vec_to_chars(string.as_str());
        self.length = string.len();
        self.owned = true;
    }

    /// Return a slice of character bytes
    pub fn to_slice_u8(&self) -> &[u8] {
        unsafe { std::slice::from_raw_parts(self.data as *const u8, self.length) }
    }
}

impl BoxerString {
    /// Creates a new C-compatible string from a container of bytes.
    ///
    /// This function will consume the provided data and use the
    /// underlying bytes to construct a new string, ensuring that
    /// there is a trailing 0 byte. This trailing 0 byte will be
    /// appended by this function; the provided data should *not*
    /// contain any 0 bytes in it.
    fn vec_to_chars<T: Into<Vec<u8>>>(_data: T) -> *mut c_char {
        let c_to_print = CString::new(_data).expect("CString::new failed");
        c_to_print.into_raw()
    }

    /// Free characters by retaking ownership of a `CString` that was transferred to C via [`into_raw`].
    fn free_chars(_ptr_contents: *mut c_char) {
        unsafe { CString::from_raw(_ptr_contents) };
    }

    /// Convert a given char buffer into a String by copying data
    pub fn chars_to_string(_data: *mut c_char) -> String {
        unsafe {
            // we are not using CString::from_raw because it retakes the ownership
            // and will drop the data. Instead we create a borrowed CStr which
            // we later copy into a String
            CStr::from_ptr(_data).to_string_lossy().into_owned()
        }
    }
}

pub trait BoxerStringPointer {
    fn with<Block, Return>(&self, block: Block) -> Return
    where
        Block: FnOnce(&mut Box<BoxerString>) -> Return;
    fn with_not_null<Block>(&self, block: Block)
    where
        Block: FnOnce(&mut Box<BoxerString>);
}

impl BoxerStringPointer for *mut BoxerString {
    fn with<Block, Return>(&self, block: Block) -> Return
    where
        Block: FnOnce(&mut Box<BoxerString>) -> Return,
    {
        CBox::with_raw(*self, block)
    }

    fn with_not_null<Block>(&self, block: Block)
    where
        Block: FnOnce(&mut Box<BoxerString>),
    {
        CBox::with_optional_raw(*self, |option| match option {
            None => {}
            Some(string) => block(string),
        })
    }
}

impl Default for BoxerString {
    fn default() -> Self {
        BoxerString {
            data: Self::vec_to_chars(""),
            length: 0,
            owned: true,
        }
    }
}

impl Drop for BoxerString {
    fn drop(&mut self) {
        self.length = 0;
        if self.owned {
            Self::free_chars(self.data);
        }
        self.data = std::ptr::null_mut();
        self.owned = false;
    }
}

#[test]
fn default_string() {
    let _boxer_string = BoxerString::default();
    let data = unsafe { Vec::from_raw_parts(_boxer_string.data, 1, 1) };

    assert_eq!(data, [0]);
    assert_eq!(_boxer_string.length, 0);

    // we don't want to take ownership over data
    std::mem::forget(data);
}

#[test]
fn from_string() {
    let _boxer_string = BoxerString::from_string(&String::from("HelloWorld"));
    let data = unsafe {
        Vec::from_raw_parts(
            _boxer_string.data,
            _boxer_string.length + 1,
            _boxer_string.length + 1,
        )
    };

    assert_eq!(data, [72, 101, 108, 108, 111, 87, 111, 114, 108, 100, 0]);
    assert_eq!(_boxer_string.length, 10);

    // we don't want to take ownership over data
    std::mem::forget(data);
}

#[test]
fn from_data() {
    let mut buffer = [72, 101, 108, 108, 111, 87, 111, 114, 108, 100, 0];
    let _boxer_string = BoxerString::from_data(buffer.as_mut_ptr(), buffer.len());
    buffer[0] = 0;

    let data = unsafe {
        Vec::from_raw_parts(
            _boxer_string.data,
            _boxer_string.length + 1,
            _boxer_string.length + 1,
        )
    };

    assert_eq!(data, [72, 101, 108, 108, 111, 87, 111, 114, 108, 100, 0]);
    assert_eq!(_boxer_string.length, 10);

    // we don't want to take ownership over data
    std::mem::forget(data);
}

#[test]
fn from_slice() {
    let _boxer_string = BoxerString::from_slice("HelloWorld");
    let data = unsafe {
        Vec::from_raw_parts(
            _boxer_string.data,
            _boxer_string.length + 1,
            _boxer_string.length + 1,
        )
    };

    assert_eq!(data, [72, 101, 108, 108, 111, 87, 111, 114, 108, 100, 0]);
    assert_eq!(_boxer_string.length, 10);

    // we don't want to take ownership over data
    std::mem::forget(data);
}

#[test]
fn to_string() {
    let _boxer_string = BoxerString::from_slice("HelloWorld");
    assert_eq!(_boxer_string.to_string(), String::from("HelloWorld"));
}
