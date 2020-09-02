#![allow(non_snake_case)]
pub use widestring;
#[macro_use]
extern crate log;

use crate::boxes::{from_raw, into_raw, ReferenceBox};
pub use crate::value_box::{ValueBox, ValueBoxPointer, ValueBoxPointerReference};

pub mod array;
pub mod boxes;
pub mod number;
pub mod point;
pub mod point3;
pub mod size;
pub mod string;
mod value_box;

#[macro_export]
macro_rules! function {
    () => {{
        fn f() {}
        fn type_name_of<T>(_: T) -> &'static str {
            std::any::type_name::<T>()
        }
        let name = type_name_of(f);
        &name[..name.len() - 3]
    }};
}

#[inline]
pub fn assert_box<T>(_ptr: *mut ValueBox<T>, method_name: &str) {
    if cfg!(debug_assertions) {
        if _ptr.is_null() {
            eprintln!(
                "[{}] ValueBox<{}> pointer is null",
                method_name,
                std::any::type_name::<T>()
            );
            return;
        }
        let value_box = unsafe { from_raw(_ptr) };
        let has_value = value_box.has_value();
        into_raw(value_box);

        if !has_value {
            eprintln!(
                "[{}] {} pointer is null",
                method_name,
                std::any::type_name::<T>()
            )
        }
    }
}

#[inline]
pub fn assert_reference_box<T>(_ptr: *mut ReferenceBox<T>, method_name: &str) {
    if cfg!(debug_assertions) {
        if _ptr.is_null() {
            eprintln!(
                "[{}] ReferenceBox<{}> pointer is null",
                method_name,
                std::any::type_name::<T>()
            );
            return;
        }
        let reference_box = unsafe { from_raw(_ptr) };
        let pointer = reference_box.boxed();
        into_raw(reference_box);

        if pointer.is_null() {
            eprintln!(
                "[{}] {} pointer is null",
                method_name,
                std::any::type_name::<T>()
            )
        }
    }
}
