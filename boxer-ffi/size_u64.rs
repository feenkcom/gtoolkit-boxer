use boxer::ValueBox;
use boxer::size::BoxerSizeU64;

#[no_mangle]
pub fn boxer_size_u64_create() -> *mut ValueBox<BoxerSizeU64> {
    BoxerSizeU64::boxer_size_create()
}

#[no_mangle]
pub fn boxer_size_u64_drop(_ptr: *mut ValueBox<BoxerSizeU64>) {
    BoxerSizeU64::boxer_size_drop(_ptr);
}

#[no_mangle]
pub fn boxer_size_u64_get_width(_ptr: *mut ValueBox<BoxerSizeU64>) -> u64 {
    BoxerSizeU64::boxer_size_get_width(_ptr)
}

#[no_mangle]
pub fn boxer_size_u64_set_width(_ptr: *mut ValueBox<BoxerSizeU64>, width: u64) {
    BoxerSizeU64::boxer_size_set_width(_ptr, width);
}

#[no_mangle]
pub fn boxer_size_u64_get_height(_ptr: *mut ValueBox<BoxerSizeU64>) -> u64 {
    BoxerSizeU64::boxer_size_get_height(_ptr)
}

#[no_mangle]
pub fn boxer_size_u64_set_height(_ptr: *mut ValueBox<BoxerSizeU64>, height: u64) {
    BoxerSizeU64::boxer_size_set_height(_ptr, height);
}
