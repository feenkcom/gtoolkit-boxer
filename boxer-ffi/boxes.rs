use boxer::boxes::{ValueBox, ValueBoxPointer};
use std::os::raw::c_void;

#[no_mangle]
pub fn boxer_value_box_get_pointer(_ptr: *mut ValueBox<c_void>) -> *mut c_void {
    match _ptr.as_option() {
        None => std::ptr::null_mut(),
        Some(_value_box_ptr) => {
            let value_box = unsafe { boxer::boxes::from_raw(_value_box_ptr) };
            let pointer = value_box.boxed();
            boxer::boxes::into_raw(value_box);
            pointer
        }
    }
}
