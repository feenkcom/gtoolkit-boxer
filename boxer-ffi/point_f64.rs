use boxer::CBox;
use boxer::point::{BoxerPointF64};

#[no_mangle]
pub fn boxer_point_f64_create() -> *mut BoxerPointF64 {
    CBox::into_raw(BoxerPointF64::default())
}

#[no_mangle]
pub fn boxer_point_f64_get_x(_point_ptr: *mut BoxerPointF64) -> f64 {
    CBox::with_raw(_point_ptr, |point| point.x )
}

#[no_mangle]
pub fn boxer_point_f64_set_x(_point_ptr: *mut BoxerPointF64, x: f64) {
    CBox::with_raw(_point_ptr, |point| point.x = x )
}

#[no_mangle]
pub fn boxer_point_f64_get_y(_point_ptr: *mut BoxerPointF64) -> f64 {
    CBox::with_raw(_point_ptr, |point| point.y )
}

#[no_mangle]
pub fn boxer_point_f64_set_y(_point_ptr: *mut BoxerPointF64, y: f64) {
    CBox::with_raw(_point_ptr, |point| point.y = y )
}

#[no_mangle]
pub fn boxer_point_f64_drop(_ptr: *mut BoxerPointF64) {
    CBox::drop(_ptr)
}