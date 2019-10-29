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