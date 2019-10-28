use boxer::CBox;
use boxer::point::{BoxerPointF64};

#[no_mangle]
pub fn boxer_point_f64_create() -> *mut BoxerPointF64 {
    CBox::into_raw(BoxerPointF64::default())
}

#[no_mangle]
pub fn boxer_point_f64_drop(_ptr: *mut BoxerPointF64) {
    CBox::drop(_ptr)
}

#[no_mangle]
pub fn boxer_point_f64_get_x(_point_ptr: *mut BoxerPointF64) -> f64 {
    CBox::with_optional_raw(_point_ptr, |option| match option {
        None => 0.0,
        Some(point) => { point.x },
    } )
}

#[no_mangle]
pub fn boxer_point_f64_set_x(_point_ptr: *mut BoxerPointF64, x: f64) {
    CBox::with_optional_raw(_point_ptr, |option| match option {
        None => {},
        Some(point) => { point.x = x },
    } )
}

#[no_mangle]
pub fn boxer_point_f64_get_y(_point_ptr: *mut BoxerPointF64) -> f64 {
    CBox::with_optional_raw(_point_ptr, |option| match option {
        None => 0.0,
        Some(point) => { point.y },
    } )
}

#[no_mangle]
pub fn boxer_point_f64_set_y(_point_ptr: *mut BoxerPointF64, y: f64) {
    CBox::with_optional_raw(_point_ptr, |option| match option {
        None => {},
        Some(point) => { point.y = y },
    } )
}