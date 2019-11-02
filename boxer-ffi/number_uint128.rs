use boxer::number::{BoxerUint128};
use boxer::boxes::{ValueBox, ValueBoxPointer};

#[no_mangle]
pub fn boxer_number_uint128_create() -> *mut ValueBox<BoxerUint128> {
    ValueBox::new(BoxerUint128::default()).into_raw()
}

#[no_mangle]
pub fn boxer_number_uint128_drop(_ptr: *mut ValueBox<BoxerUint128>) {
    _ptr.drop();
}

#[no_mangle]
pub fn boxer_number_uint128_get_low(_number_ptr: *mut ValueBox<BoxerUint128>) -> u64 {
    _number_ptr.with_not_null_return(0, | number | number.low)
}

#[no_mangle]
pub fn boxer_number_uint128_set_low(_number_ptr: *mut ValueBox<BoxerUint128>, low: u64) {
    _number_ptr.with_not_null(| number | number.low = low);
}

#[no_mangle]
pub fn boxer_number_uint128_get_high(_number_ptr: *mut ValueBox<BoxerUint128>) -> u64 {
    _number_ptr.with_not_null_return(0, | number | number.high)
}

#[no_mangle]
pub fn boxer_number_uint128_set_high(_number_ptr: *mut ValueBox<BoxerUint128>, high: u64) {
    _number_ptr.with_not_null(| number | number.high = high);
}

#[no_mangle]
pub fn boxer_number_uint128_set_max(_number_ptr: *mut ValueBox<BoxerUint128>) {
    _number_ptr.with_not_null(| number | number.set(std::u128::MAX));
}

#[no_mangle]
pub fn boxer_number_uint128_set_min(_number_ptr: *mut ValueBox<BoxerUint128>) {
    _number_ptr.with_not_null(| number | number.set(std::u128::MIN));
}