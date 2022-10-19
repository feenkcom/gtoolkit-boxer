use boxer::size::BoxerSizeU32;
use boxer::ValueBox;

#[no_mangle]
pub fn boxer_size_u32_create() -> *mut ValueBox<BoxerSizeU32> {
    BoxerSizeU32::boxer_size_create()
}

#[no_mangle]
pub fn boxer_size_u32_drop(ptr: *mut ValueBox<BoxerSizeU32>) {
    BoxerSizeU32::boxer_size_drop(ptr);
}

#[no_mangle]
pub fn boxer_size_u32_get_width(ptr: *mut ValueBox<BoxerSizeU32>) -> u32 {
    BoxerSizeU32::boxer_size_get_width(ptr)
}

#[no_mangle]
pub fn boxer_size_u32_set_width(ptr: *mut ValueBox<BoxerSizeU32>, width: u32) {
    BoxerSizeU32::boxer_size_set_width(ptr, width);
}

#[no_mangle]
pub fn boxer_size_u32_get_height(ptr: *mut ValueBox<BoxerSizeU32>) -> u32 {
    BoxerSizeU32::boxer_size_get_height(ptr)
}

#[no_mangle]
pub fn boxer_size_u32_set_height(ptr: *mut ValueBox<BoxerSizeU32>, height: u32) {
    BoxerSizeU32::boxer_size_set_height(ptr, height);
}
