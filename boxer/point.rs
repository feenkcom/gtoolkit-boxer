use super::*;

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

    pub fn boxer_point_create() -> *mut BoxerPoint<T>{
        CBox::into_raw(BoxerPoint::<T>::default())
    }

    pub fn boxer_point_drop(_ptr: *mut BoxerPoint<T>)  {
        CBox::drop(_ptr)
    }

    pub fn boxer_point_get_x(_point_ptr: *mut BoxerPoint<T>) -> T {
        CBox::with_optional_raw(_point_ptr, |option| match option {
            None => 0u8.into(),
            Some(point) => { point.x },
        } )
    }

    pub fn boxer_point_set_x(_point_ptr: *mut BoxerPoint<T>, x: T) {
        CBox::with_optional_raw(_point_ptr, |option| match option {
            None => {},
            Some(point) => { point.x = x },
        } )
    }

    pub fn boxer_point_get_y(_point_ptr: *mut BoxerPoint<T>) -> T {
        CBox::with_optional_raw(_point_ptr, |option| match option {
            None => 0u8.into(),
            Some(point) => { point.y },
        } )
    }

    pub fn boxer_point_set_y(_point_ptr: *mut BoxerPoint<T>, y: T) {
        CBox::with_optional_raw(_point_ptr, |option| match option {
            None => {},
            Some(point) => { point.y = y },
        } )
    }
}

pub type BoxerPointU64 = BoxerPoint<u64>;
pub type BoxerPointF64 = BoxerPoint<f64>;
pub type BoxerPointF32 = BoxerPoint<f32>;