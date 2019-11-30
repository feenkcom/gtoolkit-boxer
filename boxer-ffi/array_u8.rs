use boxer::array::BoxerArrayU8;
use boxer::boxes::{ValueBox, ValueBoxPointer};

#[no_mangle]
pub fn boxer_array_u8_create() -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create()
}

#[no_mangle]
pub fn boxer_array_u8_create_with(element: u8, amount: usize) -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create_with(element, amount)
}

#[no_mangle]
pub fn boxer_array_u8_create_from_data(_data: *mut u8, amount: usize) -> *mut ValueBox<BoxerArrayU8> {
    BoxerArrayU8::boxer_array_create_from_data(_data, amount)
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
pub fn boxer_array_u8_at(_maybe_null_ptr: *mut ValueBox<BoxerArrayU8>, index: usize) -> u8 {
    _maybe_null_ptr.with_not_null_return(0, |array|array.at(index))
}

/// In-place convert argb to rgba
#[no_mangle]
pub fn boxer_array_u8_argb_to_rgba(_ptr: *mut ValueBox<BoxerArrayU8>) {
    _ptr.with_not_null(|array| {
        let slice = array.to_slice();

        if slice.len() % 4 == 0 {
            let argb_u32 = unsafe { std::slice::from_raw_parts_mut(slice.as_mut_ptr() as *mut u32, slice.len() / 4) };

            if argb_u32.len() > 512 {
                let threads = 16;
                let chunk_size = argb_u32.len() / threads + if argb_u32.len() % threads != 0 { 1 } else { 0 };

                // Scoped threads allow the compiler to prove that no threads will outlive
                // table (which would be bad).
                let _ = crossbeam::scope(|scope| {
                    // Chop `table` into disjoint sub-slices.
                    for each_chunk in argb_u32.chunks_mut(chunk_size) {
                        // Spawn a thread operating on that subslice.
                        scope.spawn(move |_| {
                            for argb in each_chunk {
                                *argb = (*argb).rotate_right(8);
                            }
                        });
                    }
                    // `crossbeam::scope` ensures that *all* spawned threads join before
                    // returning control back from this closure.
                });
           }
            else {
                for argb in argb_u32 {
                    *argb = (*argb).rotate_right(8);
                }
            }
        }
    })
}

#[no_mangle]
pub fn boxer_array_u8_drop(_ptr: *mut ValueBox<BoxerArrayU8>) {
    BoxerArrayU8::boxer_array_drop(_ptr);
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