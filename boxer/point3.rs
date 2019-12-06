use crate::boxes::{ValueBox, ValueBoxPointer};

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerPoint3<T>
where
    T: From<u8> + Default + Copy,
{
    pub x: T,
    pub y: T,
    pub z: T,
}

impl<T> BoxerPoint3<T>
where
    T: From<u8> + Default + Copy,
{
    pub fn be_zero(&mut self) {
        self.x = 0u8.into();
        self.y = 0u8.into();
        self.z = 0u8.into();
    }

    pub fn new(x: T, y: T, z: T) -> Self {
        BoxerPoint3::<T> { x, y, z }
    }

    pub fn boxer_point_default() -> *mut ValueBox<BoxerPoint3<T>> {
        ValueBox::new(BoxerPoint3::<T>::default()).into_raw()
    }

    pub fn boxer_point_create(x: T, y: T, z: T) -> *mut ValueBox<BoxerPoint3<T>> {
        ValueBox::new(BoxerPoint3::<T>::new(x, y, z)).into_raw()
    }

    pub fn boxer_point_drop(_ptr: *mut ValueBox<BoxerPoint3<T>>) {
        _ptr.drop();
    }

    pub fn boxer_point_get_x(_maybe_null_ptr: *mut ValueBox<BoxerPoint3<T>>) -> T {
        _maybe_null_ptr.with_not_null_return(0u8.into(), |point| point.x)
    }

    pub fn boxer_point_set_x(_maybe_null_ptr: *mut ValueBox<BoxerPoint3<T>>, x: T) {
        _maybe_null_ptr.with_not_null(|point| point.x = x)
    }

    pub fn boxer_point_get_y(_maybe_null_ptr: *mut ValueBox<BoxerPoint3<T>>) -> T {
        _maybe_null_ptr.with_not_null_return(0u8.into(), |point| point.y)
    }

    pub fn boxer_point_set_y(_maybe_null_ptr: *mut ValueBox<BoxerPoint3<T>>, y: T) {
        _maybe_null_ptr.with_not_null(|point| point.y = y)
    }

    pub fn boxer_point_get_z(_maybe_null_ptr: *mut ValueBox<BoxerPoint3<T>>) -> T {
        _maybe_null_ptr.with_not_null_return(0u8.into(), |point| point.z)
    }

    pub fn boxer_point_set_z(_maybe_null_ptr: *mut ValueBox<BoxerPoint3<T>>, z: T) {
        _maybe_null_ptr.with_not_null(|point| point.z = z)
    }
}

pub type BoxerPoint3F32 = BoxerPoint3<f32>;
