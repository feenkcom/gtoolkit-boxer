use std::mem::transmute;
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

#[test]
pub fn test_is_valid() {
    let ptr = ValueBox::new(42).into_raw();

    let void_ptr: *mut ValueBox<c_void> = unsafe { transmute(ptr) };
    assert!(boxer_value_box_is_valid(void_ptr));
}
