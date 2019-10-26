#[derive(Debug, Copy, Clone, Default)]
#[repr(C)]
pub struct BoxerUint128 {
    pub high: u64,
    pub low: u64
}

impl BoxerUint128 {
    pub fn from(number: u128) -> Self {
        number.into()
    }

    pub fn set(&mut self, number: u128) {
        let boxed_number: BoxerUint128 = number.into();
        self.clone_from(&boxed_number);
    }

    pub fn get(&self) -> u128 {
        self.into()
    }
}

impl From<&BoxerUint128> for u128 {
    fn from(boxed_number: &BoxerUint128) -> u128 {
        ((boxed_number.high as u128) << 64) + (boxed_number.low as u128)
    }
}

impl From<u128> for BoxerUint128 {
    fn from(number: u128) -> BoxerUint128 {
        let low = number as u64 ;
        let high = (number >> 64) as u64;
        BoxerUint128 { high , low }
    }
}

#[test]
pub fn uint128_max() {
    println!("u128 max: {:?}", std::u128::MAX);
    let number = BoxerUint128::from(std::u128::MAX);
    assert_eq!(number.get(), std::u128::MAX)
}

#[test]
pub fn uint128_min() {
    println!("u128 min: {:?}", std::u128::MIN);
    let number = BoxerUint128::from(std::u128::MIN);
    assert_eq!(number.get(), std::u128::MIN)
}