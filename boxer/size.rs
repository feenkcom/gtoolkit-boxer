#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerSizeU64 {
    pub width: u64,
    pub height: u64,
}

impl BoxerSizeU64 {
    pub fn be_zero(&mut self) {
        self.width = 0;
        self.height = 0;
    }
}

#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerSizeF64 {
    pub width: f64,
    pub height: f64,
}

impl BoxerSizeF64 {
    pub fn be_zero(&mut self) {
        self.width = 0.0;
        self.height = 0.0;
    }
}