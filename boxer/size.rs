#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerSizeU64 {
    pub width: u64,
    pub height: u64,
}

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerSizeF64 {
    pub width: f64,
    pub height: f64,
}