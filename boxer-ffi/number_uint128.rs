use boxer::CBox;
use boxer::number::{BoxerUint128};

#[no_mangle]
pub fn boxer_number_uint128_create() -> *mut BoxerUint128 {
    CBox::into_raw(BoxerUint128::default())
}

#[no_mangle]
pub fn glutin_number_uint128_drop(_ptr: *mut BoxerUint128) {
    CBox::drop(_ptr)
}

#[no_mangle]
pub fn boxer_number_uint128_get_low(_number_ptr: *mut BoxerUint128) -> u64 {
    CBox::with_optional_raw(_number_ptr, |option| match option {
        None => 0,
        Some(number) => { number.low },
    } )
}

#[no_mangle]
pub fn boxer_number_uint128_set_low(_number_ptr: *mut BoxerUint128, low: u64) {
    CBox::with_optional_raw(_number_ptr, |option| match option {
        None => {},
        Some(number) => { number.low = low },
    } );
}

#[no_mangle]
pub fn boxer_number_uint128_get_high(_number_ptr: *mut BoxerUint128) -> u64 {
    CBox::with_optional_raw(_number_ptr, |option| match option {
        None => 0,
        Some(number) => { number.high },
    } )
}

#[no_mangle]
pub fn boxer_number_uint128_set_high(_number_ptr: *mut BoxerUint128, high: u64) {
    CBox::with_optional_raw(_number_ptr, |option| match option {
        None => {},
        Some(number) => { number.high = high },
    } );
}

#[no_mangle]
pub fn boxer_number_uint128_set_max(_number_ptr: *mut BoxerUint128) {
    CBox::with_optional_raw(_number_ptr, |option| match option {
        None => {},
        Some(number) => { number.set(std::u128::MAX) },
    } );
}

#[no_mangle]
pub fn boxer_number_uint128_set_min(_number_ptr: *mut BoxerUint128) {
    CBox::with_optional_raw(_number_ptr, |option| match option {
        None => {},
        Some(number) => { number.set(std::u128::MIN) },
    } );
}