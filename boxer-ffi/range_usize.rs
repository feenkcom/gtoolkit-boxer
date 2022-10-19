use boxer::{ValueBox, ValueBoxPointer};
use std::ops::Range;

#[no_mangle]
pub fn boxer_range_usize_create() -> *mut ValueBox<Range<usize>> {
    ValueBox::new(0..0).into_raw()
}

#[no_mangle]
pub fn boxer_range_usize_drop(ptr: *mut ValueBox<Range<usize>>) {
    ptr.release();
}

#[no_mangle]
pub fn boxer_range_usize_get_start(ptr: *mut ValueBox<Range<usize>>) -> usize {
    ptr.with_not_null_return(0, |range| range.start)
}

#[no_mangle]
pub fn boxer_range_usize_set_start(ptr: *mut ValueBox<Range<usize>>, start: usize) {
    ptr.with_not_null(|range| range.start = start)
}

#[no_mangle]
pub fn boxer_range_usize_get_end(ptr: *mut ValueBox<Range<usize>>) -> usize {
    ptr.with_not_null_return(0, |range| range.end)
}

#[no_mangle]
pub fn boxer_range_usize_set_end(ptr: *mut ValueBox<Range<usize>>, end: usize) {
    ptr.with_not_null(|range| range.end = end)
}
