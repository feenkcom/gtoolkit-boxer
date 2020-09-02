use boxer::point::BoxerPointI32;
use boxer::ValueBox;

#[no_mangle]
pub fn boxer_point_i32_default() -> *mut ValueBox<BoxerPointI32> {
    BoxerPointI32::boxer_point_default()
}

#[no_mangle]
pub fn boxer_point_i32_create(x: i32, y: i32) -> *mut ValueBox<BoxerPointI32> {
    BoxerPointI32::boxer_point_create(x, y)
}

#[no_mangle]
pub fn boxer_point_i32_drop(_ptr: *mut ValueBox<BoxerPointI32>) {
    BoxerPointI32::boxer_point_drop(_ptr);
}

#[no_mangle]
pub fn boxer_point_i32_get_x(_point_ptr: *mut ValueBox<BoxerPointI32>) -> i32 {
    BoxerPointI32::boxer_point_get_x(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_i32_set_x(_point_ptr: *mut ValueBox<BoxerPointI32>, x: i32) {
    BoxerPointI32::boxer_point_set_x(_point_ptr, x);
}

#[no_mangle]
pub fn boxer_point_i32_get_y(_point_ptr: *mut ValueBox<BoxerPointI32>) -> i32 {
    BoxerPointI32::boxer_point_get_y(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_i32_set_y(_point_ptr: *mut ValueBox<BoxerPointI32>, y: i32) {
    BoxerPointI32::boxer_point_set_y(_point_ptr, y);
}
