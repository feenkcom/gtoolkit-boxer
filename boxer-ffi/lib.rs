#![allow(non_snake_case)]
extern crate boxer;

pub mod size_f64;
pub mod size_u64;
pub mod number_uint128;

#[no_mangle]
pub fn boxer_test() -> bool {
    return true
}