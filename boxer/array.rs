use crate::CBox;

#[derive(Debug)]
#[repr(C)]
pub struct BoxerArray<T> {
    pub data: *mut T,
    pub length: usize,
    pub capacity: usize
}

impl<T> BoxerArray<T> {
    pub fn new() -> Self {
         BoxerArray {
            length: 0,
            capacity: 0,
            data: std::ptr::null_mut()
        }
    }

    pub fn from_vector(vector: Vec<T>) -> Self {
        let mut array = Self::new();
        array.set_vector(vector);
        array
    }

    /// I create a copy of a given array
    pub fn from_array(array_buffer: &[T]) -> Self where T: Clone {
        Self::from_vector(Vec::<T>::from(array_buffer))
    }

    /// Mutate me to hold a given vector
    pub fn set_vector(&mut self, vector: Vec<T>) {
        // first free existing char buffer
        Self::free_buffer(self.data, self.length, self.capacity);
        let mut data = vector;
        data.shrink_to_fit();

        self.length = data.len();
        self.capacity = data.capacity();
        self.data = Self::vec_to_buffer(data)
    }

    /// Mutate me to hold a given vector
    pub fn set_array(&mut self, array_buffer: &[T]) where T: Clone {
        let vector = Vec::<T>::from(array_buffer);
        self.set_vector(vector);
    }

    pub fn to_slice(&self) -> &mut [T] {
        unsafe { std::slice::from_raw_parts_mut(self.data, self.length) }
    }
}

impl<T> BoxerArray<T> {
    fn vec_to_buffer(mut _data: Vec<T>) -> *mut T {
        let _ptr = _data.as_mut_ptr();
        std::mem::forget(_data);
        _ptr
    }

    fn free_buffer(_ptr_data: *mut T, _length: usize, _capacity: usize) {
        if _ptr_data.is_null() { return }
        drop(unsafe { Vec::from_raw_parts(_ptr_data, _length, _capacity) });
    }
}

impl<T> Default for BoxerArray<T> {
    fn default() -> Self {
        BoxerArray::from_vector(vec![])
    }
}

impl<T> Drop for BoxerArray<T> {
    fn drop(&mut self) {
        Self::free_buffer(self.data, self.length, self.capacity);
        self.data = std::ptr::null_mut();
        self.length = 0;
        self.capacity = 0;
    }
}

impl<T> BoxerArray<T> where T: From<u8> + Default + Copy {
    pub fn boxer_array_create() -> *mut BoxerArray<T>{
        CBox::into_raw(BoxerArray::<T>::default())
    }

    pub fn boxer_array_create_with(element: T, amount: usize) -> *mut BoxerArray<T>{
        CBox::into_raw(BoxerArray::<T>::from_vector(vec![element; amount]))
    }

    pub fn boxer_array_drop(_ptr: *mut BoxerArray<T>)  {
        CBox::drop(_ptr)
    }

    pub fn boxer_array_get_length(_ptr: *mut BoxerArray<T>) -> usize {
        CBox::with_optional_raw(_ptr, |option| match option {
            None => 0,
            Some(array) => { array.length },
        } )
    }

    pub fn boxer_array_get_capacity(_ptr: *mut BoxerArray<T>) -> usize {
        CBox::with_optional_raw(_ptr, |option| match option {
            None => 0,
            Some(array) => { array.capacity },
        } )
    }

    pub fn boxer_array_get_data(_ptr: *mut BoxerArray<T>) -> *mut T {
        CBox::with_optional_raw(_ptr, |option| match option {
            None => std::ptr::null_mut(),
            Some(array) => { array.data },
        } )
    }
}

pub type BoxerArrayU8 = BoxerArray<u8>;

#[test]
fn default_array_u8() {
    let array = BoxerArray::<u8>::default();
    assert_eq!(array.capacity, 0);
    assert_eq!(array.length, 0);
    assert_eq!(array.data.is_null(), false);
}

#[test]
fn new_array_u8() {
    let array = BoxerArray::<u8>::from_vector(vec![0,1,2,3,4]);
    assert_eq!(array.capacity, 5);
    assert_eq!(array.length, 5);
    assert_eq!(array.data.is_null(), false);
}