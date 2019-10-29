use boxer::size::{BoxerSizeI32};

#[no_mangle]
pub fn boxer_size_i32_create() -> *mut BoxerSizeI32 {
    BoxerSizeI32::boxer_size_create()
}

#[no_mangle]
pub fn boxer_size_i32_drop(_ptr: *mut BoxerSizeI32) {
    BoxerSizeI32::boxer_size_drop(_ptr);
}

#[no_mangle]
pub fn boxer_size_i32_get_width(_ptr: *mut BoxerSizeI32) -> i32 {
    BoxerSizeI32::boxer_size_get_width(_ptr)
}

#[no_mangle]
pub fn boxer_size_i32_set_width(_ptr: *mut BoxerSizeI32, width: i32) {
    BoxerSizeI32::boxer_size_set_width(_ptr, width);
}

#[no_mangle]
pub fn boxer_size_i32_get_height(_ptr: *mut BoxerSizeI32) -> i32 {
    BoxerSizeI32::boxer_size_get_height(_ptr)
}

#[no_mangle]
pub fn boxer_size_i32_set_height(_ptr: *mut BoxerSizeI32, height: i32) {
    BoxerSizeI32::boxer_size_set_height(_ptr, height);
}