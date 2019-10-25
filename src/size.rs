use super::*;

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerSizeU64 {
    pub width: u64,
    pub height: u64,
}

#[no_mangle]
pub fn boxer_size_u64_create() -> *mut BoxerSizeU64 {
    CBox::into_raw(BoxerSizeU64::default())
}

#[no_mangle]
pub fn boxer_size_u64_get_width(_size_ptr: *mut BoxerSizeU64) -> u64 {
    CBox::with_raw(_size_ptr, |size| size.width )
}

#[no_mangle]
pub fn boxer_size_u64_set_width(_size_ptr: *mut BoxerSizeU64, width: u64) {
    CBox::with_raw(_size_ptr, |size| size.width = width )
}

#[no_mangle]
pub fn boxer_size_u64_get_height(_size_ptr: *mut BoxerSizeU64) -> u64 {
    CBox::with_raw(_size_ptr, |size| size.height )
}

#[no_mangle]
pub fn boxer_size_u64_set_height(_size_ptr: *mut BoxerSizeU64, height: u64) {
    CBox::with_raw(_size_ptr, |size| size.height = height )
}

#[no_mangle]
pub fn boxer_size_u64_drop(_ptr: *mut BoxerSizeU64) {
    CBox::drop(_ptr)
}

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerSizeF64 {
    pub width: f64,
    pub height: f64,
}

#[no_mangle]
pub fn glutin_size_f64() -> *mut BoxerSizeF64 {
    CBox::into_raw(BoxerSizeF64::default())
}

#[no_mangle]
pub fn boxer_size_f64_get_width(_size_ptr: *mut BoxerSizeF64) -> f64 {
    CBox::with_raw(_size_ptr, |size| size.width )
}

#[no_mangle]
pub fn boxer_size_f64_set_width(_size_ptr: *mut BoxerSizeF64, width: f64) {
    CBox::with_raw(_size_ptr, |size| size.width = width )
}

#[no_mangle]
pub fn boxer_size_f64_get_height(_size_ptr: *mut BoxerSizeF64) -> f64 {
    CBox::with_raw(_size_ptr, |size| size.height )
}

#[no_mangle]
pub fn boxer_size_f64_set_height(_size_ptr: *mut BoxerSizeF64, height: f64) {
    CBox::with_raw(_size_ptr, |size| size.height = height )
}

#[no_mangle]
pub fn glutin_size_f64_drop(_ptr: *mut BoxerSizeF64) {
    CBox::drop(_ptr)
}