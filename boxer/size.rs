use super::*;

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

    pub fn boxer_size_create() -> *mut BoxerSize<T>{
        CBox::into_raw(BoxerSize::<T>::default())
    }

    pub fn boxer_size_drop(_ptr: *mut BoxerSize<T>)  {
        CBox::drop(_ptr)
    }

    pub fn boxer_size_get_width(_ptr: *mut BoxerSize<T>) -> T {
        CBox::with_optional_raw(_ptr, |option| match option {
            None => 0u8.into(),
            Some(size) => { size.width },
        } )
    }

    pub fn boxer_size_set_width(_ptr: *mut BoxerSize<T>, width: T) {
        CBox::with_optional_raw(_ptr, |option| match option {
            None => {},
            Some(size) => { size.width = width },
        } )
    }

    pub fn boxer_size_get_height(_ptr: *mut BoxerSize<T>) -> T {
        CBox::with_optional_raw(_ptr, |option| match option {
            None => 0u8.into(),
            Some(size) => { size.height },
        } )
    }

    pub fn boxer_size_set_height(_ptr: *mut BoxerSize<T>, height: T) {
        CBox::with_optional_raw(_ptr, |option| match option {
            None => {},
            Some(size) => { size.height = height },
        } )
    }
}

pub type BoxerSizeU64 = BoxerSize<u64>;
pub type BoxerSizeF64 = BoxerSize<f64>;
pub type BoxerSizeI32 = BoxerSize<i32>;