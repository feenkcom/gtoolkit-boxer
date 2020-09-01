use boxer::array::BoxerArrayUInt;
use boxer::ValueBox;
use std::os::raw::c_uint;

#[no_mangle]
pub fn boxer_array_uint_create() -> *mut ValueBox<BoxerArrayUInt> {
    BoxerArrayUInt::boxer_array_create()
}

#[no_mangle]
pub fn boxer_array_uint_create_with(
    element: c_uint,
    amount: usize,
) -> *mut ValueBox<BoxerArrayUInt> {
    BoxerArrayUInt::boxer_array_create_with(element, amount)
}

#[no_mangle]
pub fn boxer_array_uint_create_from_data(
    _data: *mut c_uint,
    amount: usize,
) -> *mut ValueBox<BoxerArrayUInt> {
    BoxerArrayUInt::boxer_array_create_from_data(_data, amount)
}

#[no_mangle]
pub fn boxer_array_uint_get_length(_ptr: *mut ValueBox<BoxerArrayUInt>) -> usize {
    BoxerArrayUInt::boxer_array_get_length(_ptr)
}

#[no_mangle]
pub fn boxer_array_uint_get_capacity(_ptr: *mut ValueBox<BoxerArrayUInt>) -> usize {
    BoxerArrayUInt::boxer_array_get_capacity(_ptr)
}

#[no_mangle]
pub fn boxer_array_uint_get_data(_ptr: *mut ValueBox<BoxerArrayUInt>) -> *mut c_uint {
    BoxerArrayUInt::boxer_array_get_data(_ptr)
}

#[no_mangle]
pub fn boxer_array_uint_at_put(_ptr: *mut ValueBox<BoxerArrayUInt>, index: usize, item: c_uint) {
    BoxerArrayUInt::boxer_array_at_put(_ptr, index, item);
}

#[no_mangle]
pub fn boxer_array_uint_at(_ptr: *mut ValueBox<BoxerArrayUInt>, index: usize) -> c_uint {
    BoxerArrayUInt::boxer_array_at(_ptr, index, 0)
}

#[no_mangle]
pub fn boxer_array_uint_drop(_ptr: *mut ValueBox<BoxerArrayUInt>) {
    BoxerArrayUInt::boxer_array_drop(_ptr);
}
