use crate::boxes::{ValueBox, ValueBoxPointer};
use crate::point::BoxerPointF32;
use std::os::raw::c_uint;

#[derive(Debug)]
#[repr(C)]
pub struct BoxerArray<T> {
    pub data: *mut T,
    pub length: usize,
    pub capacity: usize,
    pub owned: bool,
}

impl<T> BoxerArray<T> {
    pub fn new() -> Self {
        BoxerArray {
            length: 0,
            capacity: 0,
            data: std::ptr::null_mut(),
            owned: true,
        }
    }

    pub fn from_vector(vector: Vec<T>) -> Self {
        let mut array = Self::new();
        array.set_vector(vector);
        array
    }

    /// I create a copy of a given array
    pub fn from_array(array_buffer: &[T]) -> Self
    where
        T: Clone,
    {
        Self::from_vector(Vec::<T>::from(array_buffer))
    }

    /// Create an array assuming that I don't own the data
    pub fn from_data(_data: *mut T, _length: usize) -> Self {
        BoxerArray {
            length: _length,
            capacity: _length,
            data: _data,
            owned: false,
        }
    }

    /// Mutate me to hold a given vector
    pub fn set_vector(&mut self, vector: Vec<T>) {
        // first free existing char buffer
        Self::free_buffer(self.data, self.length, self.capacity, self.owned);
        let mut data = vector;
        data.shrink_to_fit();

        self.length = data.len();
        self.capacity = data.capacity();
        self.data = Self::vec_to_buffer(data)
    }

    /// Mutate me to hold a given vector
    pub fn set_array(&mut self, array_buffer: &[T])
    where
        T: Clone,
    {
        let vector = Vec::<T>::from(array_buffer);
        self.set_vector(vector);
    }

    pub fn to_slice(&self) -> &mut [T] {
        unsafe { std::slice::from_raw_parts_mut(self.data, self.length) }
    }

    pub fn copy_into(&self, another_array: &mut BoxerArray<T>) {
        assert!(
            self.length <= another_array.length,
            "The source does not fit into destination"
        );
        assert!(!self.data.is_null(), "The source data must not be nil");
        assert!(
            !another_array.data.is_null(),
            "The destination data must not be nil"
        );
        unsafe { std::ptr::copy_nonoverlapping::<T>(self.data, another_array.data, self.length) }
    }

    pub fn to_vector(&mut self) -> Vec<T>
    where
        T: Clone,
    {
        let vector = unsafe { Vec::from_raw_parts(self.data, self.length, self.capacity) };
        if self.owned {
            // I do not own data anymore
            self.owned = false;
            self.data = std::ptr::null_mut();
            vector
        } else {
            let clone = vector.clone();
            // do not de-allocate
            std::mem::forget(vector);
            clone
        }
    }

    pub fn at_put(&mut self, index: usize, object: T) {
        assert!(index < self.length, "Index must be less than array length");

        let slice = self.to_slice();
        slice[index] = object;
    }

    pub fn at(&mut self, index: usize) -> T
    where
        T: Clone,
    {
        assert!(index < self.length, "Index must be less than array length");

        let slice = self.to_slice();
        slice[index].clone()
    }
}

impl<T> BoxerArray<T> {
    fn vec_to_buffer(mut _data: Vec<T>) -> *mut T {
        let _ptr = _data.as_mut_ptr();
        std::mem::forget(_data);
        _ptr
    }

    fn free_buffer(_ptr_data: *mut T, _length: usize, _capacity: usize, _owned: bool) {
        if _ptr_data.is_null() {
            return;
        }
        if !_owned {
            return;
        }
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
        Self::free_buffer(self.data, self.length, self.capacity, self.owned);
        self.data = std::ptr::null_mut();
        self.length = 0;
        self.capacity = 0;
    }
}

impl<T> BoxerArray<T>
where
    T: Default + Copy,
{
    pub fn boxer_array_byte_size(count: usize) -> usize {
        std::mem::size_of::<T>() * count
    }

    pub fn boxer_array_create() -> *mut ValueBox<BoxerArray<T>> {
        ValueBox::new(BoxerArray::<T>::default()).into_raw()
    }

    pub fn boxer_array_create_with(element: T, amount: usize) -> *mut ValueBox<BoxerArray<T>> {
        ValueBox::new(BoxerArray::<T>::from_vector(vec![element; amount])).into_raw()
    }

    pub fn boxer_array_create_from_data(
        _data: *mut T,
        amount: usize,
    ) -> *mut ValueBox<BoxerArray<T>> {
        ValueBox::new(BoxerArray::<T>::from_data(_data, amount)).into_raw()
    }

    pub fn boxer_array_drop(_ptr: *mut ValueBox<BoxerArray<T>>) {
        _ptr.drop();
    }

    pub fn boxer_array_copy_into(
        _maybe_null_source_ptr: *mut ValueBox<BoxerArray<T>>,
        _maybe_null_destination_ptr: *mut ValueBox<BoxerArray<T>>,
    ) {
        _maybe_null_source_ptr.with_not_null(|source| {
            _maybe_null_destination_ptr.with_not_null(|destination| {
                source.copy_into(destination);
            })
        })
    }

    pub fn boxer_array_copy_into_data(
        _maybe_null_source_ptr: *mut ValueBox<BoxerArray<T>>,
        _destination_data: *mut T,
        length: usize,
    ) {
        _maybe_null_source_ptr.with_not_null(|source| {
            assert!(
                source.length <= length,
                "The source does not fit into destination"
            );
            assert!(!source.data.is_null(), "The source data must not be nil");
            assert!(
                !_destination_data.is_null(),
                "The destination data must not be nil"
            );
            unsafe { std::ptr::copy_nonoverlapping::<T>(source.data, _destination_data, length) }
        })
    }

    pub fn boxer_array_get_length(_maybe_null_ptr: *mut ValueBox<BoxerArray<T>>) -> usize {
        match _maybe_null_ptr.as_option() {
            None => 0,
            Some(_ptr) => _ptr.with(|array| array.length),
        }
    }

    pub fn boxer_array_get_capacity(_maybe_null_ptr: *mut ValueBox<BoxerArray<T>>) -> usize {
        match _maybe_null_ptr.as_option() {
            None => 0,
            Some(_ptr) => _ptr.with(|array| array.capacity),
        }
    }

    pub fn boxer_array_get_data(_maybe_null_ptr: *mut ValueBox<BoxerArray<T>>) -> *mut T {
        match _maybe_null_ptr.as_option() {
            None => std::ptr::null_mut(),
            Some(_ptr) => _ptr.with(|array| array.data),
        }
    }

    pub fn boxer_array_at_put(_maybe_null_ptr: *mut ValueBox<BoxerArray<T>>, index: usize, item: T)
    where
        T: Clone,
    {
        _maybe_null_ptr.with_not_null(|array| array.at_put(index, item));
    }

    pub fn boxer_array_at(
        _maybe_null_ptr: *mut ValueBox<BoxerArray<T>>,
        index: usize,
        default: T,
    ) -> T
    where
        T: Clone,
    {
        _maybe_null_ptr.with_not_null_return(default, |array| array.at(index))
    }
}

pub type BoxerArrayU8 = BoxerArray<u8>;
pub type BoxerArrayU16 = BoxerArray<u16>;
pub type BoxerArrayUInt = BoxerArray<c_uint>;
pub type BoxerArrayF32 = BoxerArray<f32>;
pub type BoxerArrayPointF32 = BoxerArray<BoxerPointF32>;

#[test]
fn default_array_u8() {
    let array = BoxerArray::<u8>::default();
    assert_eq!(array.capacity, 0);
    assert_eq!(array.length, 0);
    assert_eq!(array.data.is_null(), false);
}

#[test]
fn new_array_u8() {
    let array = BoxerArray::<u8>::from_vector(vec![0, 1, 2, 3, 4]);
    assert_eq!(array.capacity, 5);
    assert_eq!(array.length, 5);
    assert_eq!(array.data.is_null(), false);
}
