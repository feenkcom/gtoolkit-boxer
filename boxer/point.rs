use crate::boxes::{ValueBox, ValueBoxPointer};

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerPoint<T> where T: From<u8> + Default + Copy {
    pub x: T,
    pub y: T,
}

impl<T> BoxerPoint<T> where T: From<u8> + Default + Copy {
    pub fn be_zero(&mut self) {
        self.x = 0u8.into();
        self.y = 0u8.into();
    }

    pub fn new(x: T, y: T) -> Self {
        BoxerPoint::<T> { x, y }
    }

    pub fn boxer_point_default() -> *mut ValueBox<BoxerPoint<T>>{
        ValueBox::new(BoxerPoint::<T>::default()).into_raw()
    }

    pub fn boxer_point_create(x: T, y: T) -> *mut ValueBox<BoxerPoint<T>>{
        ValueBox::new(BoxerPoint::<T>::new(x, y)).into_raw()
    }

    pub fn boxer_point_drop(_ptr: *mut ValueBox<BoxerPoint<T>>)  {
        _ptr.drop();
    }

    pub fn boxer_point_get_x(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>) -> T {
        match _maybe_null_ptr.as_option() {
            None => 0u8.into(),
            Some(_ptr) => _ptr.with(|point| point.x)
        }
    }

    pub fn boxer_point_set_x(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>, x: T) {
        match _maybe_null_ptr.as_option() {
            None => { },
            Some(_ptr) => _ptr.with(|point| point.x = x)
        }
    }

    pub fn boxer_point_get_y(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>) -> T {
        match _maybe_null_ptr.as_option() {
            None => 0u8.into(),
            Some(_ptr) => _ptr.with(|point| point.y)
        }
    }

    pub fn boxer_point_set_y(_maybe_null_ptr: *mut ValueBox<BoxerPoint<T>>, y: T) {
        match _maybe_null_ptr.as_option() {
            None => { },
            Some(_ptr) => _ptr.with(|point| point.y = y)
        }
    }
}

pub type BoxerPointU64 = BoxerPoint<u64>;
pub type BoxerPointF64 = BoxerPoint<f64>;
pub type BoxerPointF32 = BoxerPoint<f32>;