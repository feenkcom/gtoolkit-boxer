#![allow(non_snake_case)]

use crate::boxes::{ValueBox, from_raw, into_raw, ReferenceBox};

pub mod array;
pub mod point;
pub mod point3;
pub mod size;
pub mod number;
pub mod string;
pub mod boxes;

#[macro_export]
macro_rules! function {
    () => {{
        fn f() {}
        fn type_name_of<T>(_: T) -> &'static str {
            std::any::type_name::<T>()
        }
        let name = type_name_of(f);
        &name[..name.len() - 3]
    }}
}

#[inline]
pub fn assert_box<T>(_ptr: *mut ValueBox<T>, method_name: &str) {
    if cfg!(debug_assertions) {
        if _ptr.is_null() {
            eprintln!("[{}] ValueBox<{}> pointer is null", method_name, std::any::type_name::<T>());
            return;
        }
        let value_box = unsafe { from_raw(_ptr) };
        let pointer = value_box.boxed();
        into_raw(value_box);

        if pointer.is_null() {
            eprintln!("[{}] {} pointer is null", method_name, std::any::type_name::<T>())
        }
    }
}

#[inline]
pub fn assert_reference_box<T>(_ptr: *mut ReferenceBox<T>, method_name: &str) {
    if cfg!(debug_assertions) {
        if _ptr.is_null() {
            eprintln!("[{}] ReferenceBox<{}> pointer is null", method_name, std::any::type_name::<T>());
            return;
        }
        let reference_box = unsafe { from_raw(_ptr) };
        let pointer = reference_box.boxed();
        into_raw(reference_box);

        if pointer.is_null() {
            eprintln!("[{}] {} pointer is null", method_name, std::any::type_name::<T>())
        }
    }
}

pub struct CBox {}

// Implement support of Option
impl CBox {
    pub fn as_option<T> (pointer: *mut T) -> Option<*mut T> {
        if pointer.is_null() {
            None
        } else {
            Some(pointer)
        }
    }

    /// This is dangerous! Rust takes the control over the memory back
    fn from_optional_raw<T>(pointer: *mut T) -> Option<Box<T>> {
        assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
        match Self::as_option(pointer) {
            None => None,
            Some(_not_null_pointer) => unsafe { Some(Box::from_raw(_not_null_pointer)) },
        }
    }

    pub fn with_optional_raw<F, R, T>(pointer: *mut T, block: F) -> R where F : FnOnce(Option<&mut Box<T>>) -> R {
        let mut boxed_object: Option<Box<T>> = Self::from_optional_raw(pointer);
        let result: R = block(boxed_object.as_mut());
        Self::into_raw(boxed_object);
        result
    }
}

impl CBox {
    pub fn into_raw<T> (object: T) -> *mut T {
        assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
        Box::into_raw(Box::new(object))
    }

    /// Tell Rust to take back the control over memory
    /// This is dangerous! Rust takes the control over the memory back
    pub unsafe fn from_raw<T>(pointer: *mut T) -> Box<T> {
        assert_eq!(pointer.is_null(), false, "CBox::from_raw(): Pointer must not be null!");
        assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
        Box::from_raw(pointer)
    }

    pub fn drop<T>(pointer: *mut T) {
        assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
        if pointer.is_null() {
            return;
        }
        unsafe { CBox::from_raw(pointer) };
    }

    pub fn with_raw<F, R, T>(pointer: *mut T, block: F) -> R where F : FnOnce(&mut Box<T>) -> R {
        assert_eq!(pointer.is_null(), false, "CBox::with_raw(): Pointer must not be null!");

        let mut boxed_object: Box<T> = unsafe { Self::from_raw(pointer) };
        let result: R = block(&mut boxed_object);
        Self::into_raw(boxed_object);
        result
    }

    pub fn with_two_raw<F, R, T1, T2>(pointer_1: *mut T1, pointer_2: *mut T2, block: F) -> R where F : FnOnce(&mut Box<T1>, &mut Box<T2>) -> R {
        assert_eq!(pointer_1.is_null(), false, "CBox::with_raw(): Pointer #1 must not be null!");
        assert_eq!(pointer_2.is_null(), false, "CBox::with_raw(): Pointer #2 must not be null!");

        let mut boxed_object_1: Box<T1> = unsafe { Self::from_raw(pointer_1) };
        let mut boxed_object_2: Box<T2> = unsafe { Self::from_raw(pointer_2) };
        let result: R = block(&mut boxed_object_1, &mut boxed_object_2);
        Self::into_raw(boxed_object_1);
        Self::into_raw(boxed_object_2);
        result
    }

    pub fn with_three_raw<F, R, T1, T2, T3>(pointer_1: *mut T1, pointer_2: *mut T2, pointer_3: *mut T3, block: F)
                                            -> R where F : FnOnce(&mut Box<T1>, &mut Box<T2>, &mut Box<T3>) -> R {
        assert_eq!(pointer_1.is_null(), false, "CBox::with_raw(): Pointer #1 must not be null!");
        assert_eq!(pointer_2.is_null(), false, "CBox::with_raw(): Pointer #2 must not be null!");
        assert_eq!(pointer_3.is_null(), false, "CBox::with_raw(): Pointer #3 must not be null!");

        let mut boxed_object_1: Box<T1> = unsafe { Self::from_raw(pointer_1) };
        let mut boxed_object_2: Box<T2> = unsafe { Self::from_raw(pointer_2) };
        let mut boxed_object_3: Box<T3> = unsafe { Self::from_raw(pointer_3) };
        let result: R = block(&mut boxed_object_1, &mut boxed_object_2, &mut boxed_object_3);
        Self::into_raw(boxed_object_1);
        Self::into_raw(boxed_object_2);
        Self::into_raw(boxed_object_3);
        result
    }

    pub fn with_consumable_raw<F, T>(_ptr_consumable: *mut T, block: F) -> *mut T where F : FnOnce(T) -> T {
        let consumable = *unsafe { CBox::from_raw(_ptr_consumable) };
        let modified_consumable = block(consumable);
        CBox::into_raw(modified_consumable)
    }
}