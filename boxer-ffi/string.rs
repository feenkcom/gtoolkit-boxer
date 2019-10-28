use boxer::CBox;
use boxer::string::{BoxerString};

use std::os::raw::c_char;

#[no_mangle]
pub fn boxer_string_create() -> *mut BoxerString {
    CBox::into_raw(BoxerString::default())
}

#[no_mangle]
pub fn boxer_string_drop(_ptr: *mut BoxerString) {
    CBox::drop(_ptr)
}

#[no_mangle]
pub fn boxer_string_get_length(_string_ptr: *mut BoxerString) -> usize {
    CBox::with_optional_raw(_string_ptr, |option| match option {
        None => 0,
        Some(string) => { string.length },
    } )
}

#[no_mangle]
pub fn boxer_string_get_data(_size_ptr: *mut BoxerString) -> *mut c_char {
    CBox::with_optional_raw(_size_ptr, |option| match option {
        None => std::ptr::null_mut(),
        Some(string) => { string.data },
    } )
}