use crate::boxes::{ValueBox, ValueBoxPointer};

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerSize<T> where T: From<u8> + Default + Copy {
    pub width: T,
    pub height: T,
}

impl<T> BoxerSize<T> where T: From<u8> + Default + Copy {
    pub fn be_zero(&mut self) {
        self.width = 0u8.into();
        self.height = 0u8.into();
    }

    pub fn new(width: T, height: T) -> Self {
        BoxerSize::<T> { width, height }
    }

    pub fn boxer_size_create() -> *mut ValueBox<BoxerSize<T>>{
        ValueBox::new(BoxerSize::<T>::default()).into_raw()
    }

    pub fn boxer_size_drop(_ptr: *mut ValueBox<BoxerSize<T>>)  {
        _ptr.drop();
    }

    pub fn boxer_size_get_width(_ptr: *mut ValueBox<BoxerSize<T>>) -> T {
        _ptr.with_not_null_return(0u8.into(), |size| size.width)
    }

    pub fn boxer_size_set_width(_ptr: *mut ValueBox<BoxerSize<T>>, width: T) {
        _ptr.with_not_null(|size| size.width = width);
    }

    pub fn boxer_size_get_height(_ptr: *mut ValueBox<BoxerSize<T>>) -> T {
        _ptr.with_not_null_return(0u8.into(), |size| size.height)
    }

    pub fn boxer_size_set_height(_ptr: *mut ValueBox<BoxerSize<T>>, height: T) {
        _ptr.with_not_null(|size| size.height = height);
    }
}

pub type BoxerSizeU64 = BoxerSize<u64>;
pub type BoxerSizeF32 = BoxerSize<f32>;
pub type BoxerSizeF64 = BoxerSize<f64>;
pub type BoxerSizeI32 = BoxerSize<i32>;