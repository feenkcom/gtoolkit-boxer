use boxer::size::BoxerSizeF64;
use boxer::ValueBox;

#[no_mangle]
pub fn boxer_size_f64_create() -> *mut ValueBox<BoxerSizeF64> {
    BoxerSizeF64::boxer_size_create()
}

#[no_mangle]
pub fn boxer_size_f64_drop(ptr: *mut ValueBox<BoxerSizeF64>) {
    BoxerSizeF64::boxer_size_drop(ptr);
}

#[no_mangle]
pub fn boxer_size_f64_get_width(ptr: *mut ValueBox<BoxerSizeF64>) -> f64 {
    BoxerSizeF64::boxer_size_get_width(ptr)
}

#[no_mangle]
pub fn boxer_size_f64_set_width(ptr: *mut ValueBox<BoxerSizeF64>, width: f64) {
    BoxerSizeF64::boxer_size_set_width(ptr, width);
}

#[no_mangle]
pub fn boxer_size_f64_get_height(ptr: *mut ValueBox<BoxerSizeF64>) -> f64 {
    BoxerSizeF64::boxer_size_get_height(ptr)
}

#[no_mangle]
pub fn boxer_size_f64_set_height(ptr: *mut ValueBox<BoxerSizeF64>, height: f64) {
    BoxerSizeF64::boxer_size_set_height(ptr, height);
}
