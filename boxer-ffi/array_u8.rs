use boxer::array::BoxerArrayU8;
use boxer::boxes::ValueBox;

#[no_mangle]
pub fn boxer_array_u8_create() -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create()
}

#[no_mangle]
pub fn boxer_array_u8_create_with(element: u8, amount: usize) -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create_with(element, amount)
}

#[no_mangle]
pub fn boxer_array_u8_create_from_data(_data: *mut u8, amount: usize) -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create_from_data(_data, amount)
}

#[no_mangle]
pub fn boxer_array_u8_get_length(_ptr: *mut ValueBox<BoxerArrayU8>) -> usize {
    BoxerArrayU8::boxer_array_get_length(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_get_capacity(_ptr: *mut ValueBox<BoxerArrayU8>) -> usize {
    BoxerArrayU8::boxer_array_get_capacity(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_get_data(_ptr: *mut ValueBox<BoxerArrayU8>) -> *mut u8 {
    BoxerArrayU8::boxer_array_get_data(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_at_put(_ptr: *mut ValueBox<BoxerArrayU8>, index: usize, item: u8) {
    BoxerArrayU8::boxer_array_at_put(_ptr, index, item);
}

#[no_mangle]
pub fn boxer_array_u8_drop(_ptr: *mut ValueBox<BoxerArrayU8>) {
    BoxerArrayU8::boxer_array_drop(_ptr);
}