use boxer::point::{BoxerPointF32};

#[no_mangle]
pub fn boxer_point_f32_create() -> *mut BoxerPointF32 {
    BoxerPointF32::boxer_point_create()
}

#[no_mangle]
pub fn boxer_point_f32_drop(_ptr: *mut BoxerPointF32) {
    BoxerPointF32::boxer_point_drop(_ptr);
}

#[no_mangle]
pub fn boxer_point_f32_get_x(_point_ptr: *mut BoxerPointF32) -> f32 {
    BoxerPointF32::boxer_point_get_x(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_f32_set_x(_point_ptr: *mut BoxerPointF32, x: f32) {
    BoxerPointF32::boxer_point_set_x(_point_ptr, x);
}

#[no_mangle]
pub fn boxer_point_f32_get_y(_point_ptr: *mut BoxerPointF32) -> f32 {
    BoxerPointF32::boxer_point_get_y(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_f32_set_y(_point_ptr: *mut BoxerPointF32, y: f32) {
    BoxerPointF32::boxer_point_set_y(_point_ptr, y);
}