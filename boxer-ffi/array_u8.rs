use boxer::array::BoxerArrayU8;

#[no_mangle]
pub fn boxer_array_u8_create_with(element: u8, amount: usize) -> *mut BoxerArrayU8 {
    BoxerArrayU8::boxer_array_create_with(element, amount)
}

#[no_mangle]
pub fn boxer_array_u8_drop(_ptr: *mut BoxerArrayU8) {
    BoxerArrayU8::boxer_array_drop(_ptr);
}

#[no_mangle]
pub fn boxer_array_u8_get_length(_ptr: *mut BoxerArrayU8) -> usize {
    BoxerArrayU8::boxer_array_get_length(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_get_capacity(_ptr: *mut BoxerArrayU8) -> usize {
    BoxerArrayU8::boxer_array_get_capacity(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_get_data(_ptr: *mut BoxerArrayU8) -> *mut u8 {
    BoxerArrayU8::boxer_array_get_data(_ptr)
}