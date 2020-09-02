use crate::value_box::{ValueBox, ValueBoxPointer};
use crate::ValueBoxPointerReference;

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerPoint<T>
where
    T: From<u8> + Default + Copy,
{
    pub x: T,
    pub y: T,
}

impl<T> BoxerPoint<T>
where
    T: From<u8> + Default + Copy,
{
    pub fn be_zero(&mut self) {
        self.x = 0u8.into();
        self.y = 0u8.into();
    }

    pub fn new(x: T, y: T) -> Self {
        BoxerPoint::<T> { x, y }
    }

    pub fn boxer_point_default() -> *mut ValueBox<BoxerPoint<T>> {
        ValueBox::new(BoxerPoint::<T>::default()).into_raw()
    }

    pub fn boxer_point_create(x: T, y: T) -> *mut ValueBox<BoxerPoint<T>> {
        ValueBox::new(BoxerPoint::<T>::new(x, y)).into_raw()
    }

    pub fn boxer_point_drop(ptr: &mut *mut ValueBox<BoxerPoint<T>>) {
        ptr.drop();
    }

    pub fn boxer_point_get_x(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>) -> T {
        _maybe_null_ptr.with_not_null_return(0u8.into(), |point| point.x)
    }

    pub fn boxer_point_set_x(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>, x: T) {
        _maybe_null_ptr.with_not_null(|point| point.x = x)
    }

    pub fn boxer_point_get_y(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>) -> T {
        _maybe_null_ptr.with_not_null_return(0u8.into(), |point| point.y)
    }

    pub fn boxer_point_set_y(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>, y: T) {
        _maybe_null_ptr.with_not_null(|point| point.y = y)
    }
}

pub type BoxerPointU64 = BoxerPoint<u64>;
pub type BoxerPointF64 = BoxerPoint<f64>;
pub type BoxerPointF32 = BoxerPoint<f32>;
pub type BoxerPointI32 = BoxerPoint<i32>;
