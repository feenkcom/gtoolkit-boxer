use boxer::array::BoxerArrayPointF32;
use boxer::point::BoxerPointF32;
use boxer::{ValueBox, ValueBoxPointer};

#[no_mangle]
pub fn boxer_array_point_f32_create() -> *mut ValueBox<BoxerArrayPointF32> {
    BoxerArrayPointF32::boxer_array_create()
}

#[no_mangle]
pub fn boxer_array_point_f32_create_with(
    element_ptr: *mut ValueBox<BoxerPointF32>,
    amount: usize,
) -> *mut ValueBox<BoxerArrayPointF32> {
    element_ptr.with_not_null_value_return(std::ptr::null_mut(), |point| {
        BoxerArrayPointF32::boxer_array_create_with(point, amount)
    })
}

#[no_mangle]
pub fn boxer_array_point_f32_create_from_data(
    _data: *mut BoxerPointF32,
    amount: usize,
) -> *mut ValueBox<BoxerArrayPointF32> {
    BoxerArrayPointF32::boxer_array_create_from_data(_data, amount)
}

#[no_mangle]
pub fn boxer_array_point_f32_drop(_ptr: &mut *mut ValueBox<BoxerArrayPointF32>) {
    BoxerArrayPointF32::boxer_array_drop(_ptr);
}

#[no_mangle]
pub fn boxer_array_point_f32_get_length(_ptr: *mut ValueBox<BoxerArrayPointF32>) -> usize {
    BoxerArrayPointF32::boxer_array_get_length(_ptr)
}

#[no_mangle]
pub fn boxer_array_point_f32_get_capacity(_ptr: *mut ValueBox<BoxerArrayPointF32>) -> usize {
    BoxerArrayPointF32::boxer_array_get_capacity(_ptr)
}

#[no_mangle]
pub fn boxer_array_point_f32_get_data(
    _ptr: *mut ValueBox<BoxerArrayPointF32>,
) -> *mut BoxerPointF32 {
    BoxerArrayPointF32::boxer_array_get_data(_ptr)
}

#[cfg(test)]
mod test {
    use crate::array_point_f32::boxer_array_point_f32_create_with;
    use crate::point_f32::{boxer_point_f32_create, boxer_point_f32_default};

    #[test]
    fn create_with_point() {
        let point = boxer_point_f32_default();
        let array = boxer_array_point_f32_create_with(point, 10);
    }
}
