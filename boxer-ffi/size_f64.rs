use boxer::size::{BoxerSizeF64};

#[no_mangle]
pub fn boxer_size_f64_create() -> *mut BoxerSizeF64 {
    BoxerSizeF64::boxer_size_create()
}

#[no_mangle]
pub fn boxer_size_f64_drop(_ptr: *mut BoxerSizeF64) {
    BoxerSizeF64::boxer_size_drop(_ptr);
}

#[no_mangle]
pub fn boxer_size_f64_get_width(_ptr: *mut BoxerSizeF64) -> f64 {
    BoxerSizeF64::boxer_size_get_width(_ptr)
}

#[no_mangle]
pub fn boxer_size_f64_set_width(_ptr: *mut BoxerSizeF64, width: f64) {
    BoxerSizeF64::boxer_size_set_width(_ptr, width);
}

#[no_mangle]
pub fn boxer_size_f64_get_height(_ptr: *mut BoxerSizeF64) -> f64 {
    BoxerSizeF64::boxer_size_get_height(_ptr)
}

#[no_mangle]
pub fn boxer_size_f64_set_height(_ptr: *mut BoxerSizeF64, height: f64) {
    BoxerSizeF64::boxer_size_set_height(_ptr, height);
}