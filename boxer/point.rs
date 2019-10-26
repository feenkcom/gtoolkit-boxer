#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerPointU64 {
    pub x: u64,
    pub y: u64,
}

impl BoxerPointU64 {
    pub fn be_zero(&mut self) {
        self.x = 0;
        self.y = 0;
    }
}

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerPointF64 {
    pub x: f64,
    pub y: f64,
}

impl BoxerPointF64 {
    pub fn be_zero(&mut self) {
        self.x = 0.0;
        self.y = 0.0;
    }
}