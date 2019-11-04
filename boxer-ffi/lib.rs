#![allow(non_snake_case)]
extern crate boxer;

pub mod array_f32;
pub mod array_point_f32;
pub mod array_u16;
pub mod array_u8;
pub mod boxes;
pub mod number_uint128;
pub mod point_f32;
pub mod point_f64;
pub mod point_u64;
pub mod size_f64;
pub mod size_i32;
pub mod size_u64;
pub mod string;

#[no_mangle]
pub fn boxer_test() -> bool {
    return true;
}
