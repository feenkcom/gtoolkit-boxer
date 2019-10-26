#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerUint128 {
    pub high: u64,
    pub low: u64
}

impl BoxerUint128 {
    pub fn from(number: u128) -> Self {
        let low = number as u64 ;
        let high = (number >> 64) as u64;
        BoxerUint128 { high, low }
    }
}