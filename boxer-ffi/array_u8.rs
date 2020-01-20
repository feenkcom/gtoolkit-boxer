use boxer::array::BoxerArrayU8;
use boxer::boxes::{ValueBox, ValueBoxPointer};

#[no_mangle]
pub fn boxer_array_u8_byte_size(count: usize) -> usize {
    BoxerArrayU8::boxer_array_byte_size(count)
}

#[no_mangle]
pub fn boxer_array_u8_create() -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create()
}

#[no_mangle]
pub fn boxer_array_u8_create_with(element: u8, amount: usize) -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create_with(element, amount)
}

#[no_mangle]
pub fn boxer_array_u8_create_from_data(
    _data: *mut u8,
    amount: usize,
) -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create_from_data(_data, amount)
}

#[no_mangle]
pub fn boxer_array_u8_copy_into(
    _ptr_src: *mut ValueBox<BoxerArrayU8>,
    _ptr_dst: *mut ValueBox<BoxerArrayU8>,
) {
    BoxerArrayU8::boxer_array_copy_into(_ptr_src, _ptr_dst);
}

#[no_mangle]
pub fn boxer_array_u8_copy_into_data(
    _ptr_src: *mut ValueBox<BoxerArrayU8>,
    _data: *mut u8,
    amount: usize,
) {
    BoxerArrayU8::boxer_array_copy_into_data(_ptr_src, _data, amount);
}

#[no_mangle]
pub fn boxer_array_u8_get_length(_ptr: *mut ValueBox<BoxerArrayU8>) -> usize {
    BoxerArrayU8::boxer_array_get_length(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_get_capacity(_ptr: *mut ValueBox<BoxerArrayU8>) -> usize {
    BoxerArrayU8::boxer_array_get_capacity(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_get_data(_ptr: *mut ValueBox<BoxerArrayU8>) -> *mut u8 {
    BoxerArrayU8::boxer_array_get_data(_ptr)
}

#[no_mangle]
pub fn boxer_array_u8_at_put(_ptr: *mut ValueBox<BoxerArrayU8>, index: usize, item: u8) {
    BoxerArrayU8::boxer_array_at_put(_ptr, index, item);
}

#[no_mangle]
pub fn boxer_array_u8_at(_ptr: *mut ValueBox<BoxerArrayU8>, index: usize) -> u8 {
    BoxerArrayU8::boxer_array_at(_ptr, index, 0)
}

/// In-place convert between color formats
pub fn boxer_array_u8_convert_color_format<Block>(slice: &mut [u8], _converter: Block)
where
    Block: Fn(u32) -> u32 + Send + Copy,
{
    if slice.len() % 4 == 0 {
        let slice_u32 = unsafe {
            std::slice::from_raw_parts_mut(slice.as_mut_ptr() as *mut u32, slice.len() / 4)
        };

        if slice_u32.len() > 512 {
            let threads = 16;
            let chunk_size =
                slice_u32.len() / threads + if slice_u32.len() % threads != 0 { 1 } else { 0 };

            // Scoped threads allow the compiler to prove that no threads will outlive
            // table (which would be bad).
            let _ = crossbeam::scope(|scope| {
                // Chop `table` into disjoint sub-slices.
                for each_chunk in slice_u32.chunks_mut(chunk_size) {
                    // Spawn a thread operating on that subslice.
                    scope.spawn(move |_| {
                        for color in each_chunk {
                            *color = _converter(*color);
                        }
                    });
                }
                // `crossbeam::scope` ensures that *all* spawned threads join before
                // returning control back from this closure.
            });
        } else {
            for color in slice_u32 {
                *color = _converter(*color);
            }
        }
    }
}

#[inline]
fn argb_to_rgba(argb: u32) -> u32 {
    argb.rotate_right(8)
}

#[inline]
fn bgra_to_argb(bgra: u32) -> u32 {
    bgra.swap_bytes()
}

#[inline]
fn rgba_to_argb(rgba: u32) -> u32 {
    rgba.rotate_left(8)
}

/// In-place convert argb to rgba
#[no_mangle]
pub fn boxer_array_u8_argb_to_rgba(_ptr: *mut ValueBox<BoxerArrayU8>) {
    _ptr.with_not_null(|array| {
        boxer_array_u8_convert_color_format(array.to_slice(), argb_to_rgba);
    })
}

/// In-place convert bgra to argb
#[no_mangle]
pub fn boxer_array_u8_bgra_to_argb(_ptr: *mut ValueBox<BoxerArrayU8>) {
    _ptr.with_not_null(|array| {
        boxer_array_u8_convert_color_format(array.to_slice(), bgra_to_argb);
    })
}

/// In-place convert rgba to argb
#[no_mangle]
pub fn boxer_array_u8_rgba_to_argb(_ptr: *mut ValueBox<BoxerArrayU8>) {
    _ptr.with_not_null(|array| {
        boxer_array_u8_convert_color_format(array.to_slice(), rgba_to_argb);
    })
}

#[no_mangle]
pub fn boxer_array_u8_drop(_ptr: *mut ValueBox<BoxerArrayU8>) {
    BoxerArrayU8::boxer_array_drop(_ptr);
}

#[test]
fn test_byte_size() {
    assert_eq!(boxer_array_u8_byte_size(0), 0);
    assert_eq!(boxer_array_u8_byte_size(1), 1);
    assert_eq!(boxer_array_u8_byte_size(2), 2);
}

#[test]
fn test_argb_to_rgba() {
    let argb = boxer_array_u8_create_with(0, 4);
    boxer_array_u8_at_put(argb, 0, 255);
    boxer_array_u8_at_put(argb, 1, 0);
    boxer_array_u8_at_put(argb, 2, 100);
    boxer_array_u8_at_put(argb, 3, 200);

    boxer_array_u8_argb_to_rgba(argb);

    assert_eq!(boxer_array_u8_at(argb, 0), 0);
    assert_eq!(boxer_array_u8_at(argb, 1), 100);
    assert_eq!(boxer_array_u8_at(argb, 2), 200);
    assert_eq!(boxer_array_u8_at(argb, 3), 255);
}

#[test]
fn test_rgba_to_argb() {
    let rgba = boxer_array_u8_create_with(0, 4);
    boxer_array_u8_at_put(rgba, 0, 0);
    boxer_array_u8_at_put(rgba, 1, 100);
    boxer_array_u8_at_put(rgba, 2, 200);
    boxer_array_u8_at_put(rgba, 3, 255);

    boxer_array_u8_rgba_to_argb(rgba);

    assert_eq!(boxer_array_u8_at(rgba, 0), 255);
    assert_eq!(boxer_array_u8_at(rgba, 1), 0);
    assert_eq!(boxer_array_u8_at(rgba, 2), 100);
    assert_eq!(boxer_array_u8_at(rgba, 3), 200);
}

#[test]
fn test_bgra_to_argb() {
    let bgra = boxer_array_u8_create_with(0, 4);
    boxer_array_u8_at_put(bgra, 0, 0);
    boxer_array_u8_at_put(bgra, 1, 100);
    boxer_array_u8_at_put(bgra, 2, 200);
    boxer_array_u8_at_put(bgra, 3, 255);

    boxer_array_u8_bgra_to_argb(bgra);

    assert_eq!(boxer_array_u8_at(bgra, 0), 255);
    assert_eq!(boxer_array_u8_at(bgra, 1), 200);
    assert_eq!(boxer_array_u8_at(bgra, 2), 100);
    assert_eq!(boxer_array_u8_at(bgra, 3), 0);
}
