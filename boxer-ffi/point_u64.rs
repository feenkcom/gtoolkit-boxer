use boxer::point::BoxerPointU64;
use boxer::ValueBox;

#[no_mangle]
pub fn boxer_point_u64_default() -> *mut ValueBox<BoxerPointU64> {
    BoxerPointU64::boxer_point_default()
}

#[no_mangle]
pub fn boxer_point_u64_create(x: u64, y: u64) -> *mut ValueBox<BoxerPointU64> {
    BoxerPointU64::boxer_point_create(x, y)
}

#[no_mangle]
pub fn boxer_point_u64_drop(_ptr: &mut *mut ValueBox<BoxerPointU64>) {
    BoxerPointU64::boxer_point_drop(_ptr);
}

#[no_mangle]
pub fn boxer_point_u64_get_x(_point_ptr: *mut ValueBox<BoxerPointU64>) -> u64 {
    BoxerPointU64::boxer_point_get_x(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_u64_set_x(_point_ptr: *mut ValueBox<BoxerPointU64>, x: u64) {
    BoxerPointU64::boxer_point_set_x(_point_ptr, x);
}

#[no_mangle]
pub fn boxer_point_u64_get_y(_point_ptr: *mut ValueBox<BoxerPointU64>) -> u64 {
    BoxerPointU64::boxer_point_get_y(_point_ptr)
}

#[no_mangle]
pub fn boxer_point_u64_set_y(_point_ptr: *mut ValueBox<BoxerPointU64>, y: u64) {
    BoxerPointU64::boxer_point_set_y(_point_ptr, y);
}
