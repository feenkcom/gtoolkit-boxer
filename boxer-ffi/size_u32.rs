use boxer::size::BoxerSizeU32;
use boxer::ValueBox;

#[no_mangle]
pub fn boxer_size_u32_create() -> *mut ValueBox<BoxerSizeU32> {
    BoxerSizeU32::boxer_size_create()
}

#[no_mangle]
pub fn boxer_size_u32_drop(_ptr: &mut *mut ValueBox<BoxerSizeU32>) {
    BoxerSizeU32::boxer_size_drop(_ptr);
}

#[no_mangle]
pub fn boxer_size_u32_get_width(_ptr: *mut ValueBox<BoxerSizeU32>) -> u32 {
    BoxerSizeU32::boxer_size_get_width(_ptr)
}

#[no_mangle]
pub fn boxer_size_u32_set_width(_ptr: *mut ValueBox<BoxerSizeU32>, width: u32) {
    BoxerSizeU32::boxer_size_set_width(_ptr, width);
}

#[no_mangle]
pub fn boxer_size_u32_get_height(_ptr: *mut ValueBox<BoxerSizeU32>) -> u32 {
    BoxerSizeU32::boxer_size_get_height(_ptr)
}

#[no_mangle]
pub fn boxer_size_u32_set_height(_ptr: *mut ValueBox<BoxerSizeU32>, height: u32) {
    BoxerSizeU32::boxer_size_set_height(_ptr, height);
}
