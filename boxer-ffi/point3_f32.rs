use boxer::point3::BoxerPoint3F32;
use boxer::ValueBox;

#[no_mangle]
pub fn boxer_point3_f32_default() -> *mut ValueBox<BoxerPoint3F32> {
    BoxerPoint3F32::boxer_point_default()
}

#[no_mangle]
pub fn boxer_point3_f32_create(x: f32, y: f32, z: f32) -> *mut ValueBox<BoxerPoint3F32> {
    BoxerPoint3F32::boxer_point_create(x, y, z)
}

#[no_mangle]
pub fn boxer_point3_f32_drop(ptr: *mut ValueBox<BoxerPoint3F32>) {
    BoxerPoint3F32::boxer_point_drop(ptr);
}

#[no_mangle]
pub fn boxer_point3_f32_get_x(_point_ptr: *mut ValueBox<BoxerPoint3F32>) -> f32 {
    BoxerPoint3F32::boxer_point_get_x(_point_ptr)
}

#[no_mangle]
pub fn boxer_point3_f32_set_x(_point_ptr: *mut ValueBox<BoxerPoint3F32>, x: f32) {
    BoxerPoint3F32::boxer_point_set_x(_point_ptr, x);
}

#[no_mangle]
pub fn boxer_point3_f32_get_y(_point_ptr: *mut ValueBox<BoxerPoint3F32>) -> f32 {
    BoxerPoint3F32::boxer_point_get_y(_point_ptr)
}

#[no_mangle]
pub fn boxer_point3_f32_set_y(_point_ptr: *mut ValueBox<BoxerPoint3F32>, y: f32) {
    BoxerPoint3F32::boxer_point_set_y(_point_ptr, y);
}

#[no_mangle]
pub fn boxer_point3_f32_get_z(_point_ptr: *mut ValueBox<BoxerPoint3F32>) -> f32 {
    BoxerPoint3F32::boxer_point_get_z(_point_ptr)
}

#[no_mangle]
pub fn boxer_point3_f32_set_z(_point_ptr: *mut ValueBox<BoxerPoint3F32>, z: f32) {
    BoxerPoint3F32::boxer_point_set_z(_point_ptr, z);
}
