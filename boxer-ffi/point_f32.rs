use boxer::point::{BoxerPointF32};
use boxer::boxes::ValueBox;

#[no_mangle]
pub fn boxer_point_f32_default() -> *mut ValueBox<BoxerPointF32> {
    BoxerPointF32::boxer_point_default()
}

#[no_mangle]
pub fn boxer_point_f32_create(x: f32, y: f32) -> *mut ValueBox<BoxerPointF32> {
    BoxerPointF32::boxer_point_create(x, y)
}

#[no_mangle]
pub fn boxer_point_f32_drop(_ptr: *mut ValueBox<BoxerPointF32>) {
    BoxerPointF32::boxer_point_drop(_ptr);
}

#[no_mangle]
pub fn boxer_point_f32_get_x(_point_ptr: *mut ValueBox<BoxerPointF32>) -> f32 {
    BoxerPointF32::boxer_point_get_x(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_f32_set_x(_point_ptr: *mut ValueBox<BoxerPointF32>, x: f32) {
    BoxerPointF32::boxer_point_set_x(_point_ptr, x);
}

#[no_mangle]
pub fn boxer_point_f32_get_y(_point_ptr: *mut ValueBox<BoxerPointF32>) -> f32 {
    BoxerPointF32::boxer_point_get_y(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_f32_set_y(_point_ptr: *mut ValueBox<BoxerPointF32>, y: f32) {
    BoxerPointF32::boxer_point_set_y(_point_ptr, y);
}