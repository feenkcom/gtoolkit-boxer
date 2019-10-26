#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerPointU64 {
    pub x: u64,
    pub y: u64,
}

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerPointF64 {
    pub x: f64,
    pub y: f64,
}