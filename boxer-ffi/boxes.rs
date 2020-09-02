use boxer::{ValueBox, ValueBoxPointer};
use std::os::raw::c_void;

#[no_mangle]
pub fn boxer_value_box_get_pointer(ptr: *mut ValueBox<c_void>) -> *const c_void {
    ptr.get_ptr()
}

#[no_mangle]
pub fn boxer_value_box_is_valid(ptr: *mut ValueBox<c_void>) -> bool {
    ptr.is_valid()
}
