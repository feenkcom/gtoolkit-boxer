use std::ops::DerefMut;

/// Tell Rust to take back the control over memory
/// This is dangerous! Rust takes the control over the memory back
unsafe fn from_raw<T>(pointer: *mut T) -> Box<T> {
    assert_eq!(pointer.is_null(), false, "from_raw(): Pointer must not be null!");
    assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
    Box::from_raw(pointer)
}

fn into_raw<T> (_box: Box<T>) -> *mut T {
    assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
    Box::into_raw(_box)
}

trait AbstractBoxPointer<T> {
    fn with<Block, Return>(&self, block: Block) -> Return where Block : FnOnce(&mut Box<T>) -> Return;
    fn with_reference<Block, Return>(&self, block: Block) -> Return where Block : FnOnce(&mut T) -> Return;
    fn with_value<Block, Return>(&self, block: Block) -> Return where
            Block: FnOnce(T) -> Return,
            T: Copy;
}

trait AbstractBox<T> {
    fn into_raw(self) -> *mut Self;
}

#[derive(Debug)]
#[repr(C)]
pub struct ValueBox<T> {
    boxed: Box<T>
}

impl <T> ValueBox<T> {
    fn new (object: T) -> Self {
        Self::from_box(Box::new(object))
    }

    fn from_box (_box: Box<T>) -> Self {
        ValueBox {
            boxed: _box
        }
    }
}

#[derive(Debug)]
#[repr(C)]
pub struct ReferenceBox<'boxed, T> {
    referenced: &'boxed T
}

impl<T> AbstractBoxPointer<T> for *mut ValueBox<T> {
    // self is `&*mut`
    fn with<Block, Return>(&self, block: Block) -> Return where Block: FnOnce(&mut Box<T>) -> Return {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        let boxed_object = &mut value_box.boxed;
        let result: Return = block(boxed_object);

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_reference<Block, Return>(&self, block: Block) -> Return where Block: FnOnce(&mut T) -> Return {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        let boxed_object = value_box.boxed.deref_mut();
        let result: Return = block(boxed_object);

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_value<Block, Return>(&self, block: Block) -> Return where
            Block: FnOnce(T) -> Return,
            T: Copy {

        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let value_box = unsafe { from_raw(*self) };
        let boxed_object = **(&value_box.boxed);
        let result: Return = block(boxed_object);

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }
}

impl<T> AbstractBox<T> for ValueBox<T> {
    fn into_raw(self) -> *mut Self {
        into_raw(Box::new(self))
    }
}

#[test]
fn value_box_with_value() {
    let _box = ValueBox::new(5);

    let _box_ptr = _box.into_raw();
    assert_eq!(_box_ptr.is_null(), false);

    let result = _box_ptr.with_value(|value| value * 2 );
    assert_eq!(_box_ptr.is_null(), false);
    assert_eq!(result, 10);
}

#[test]
fn value_box_with_reference() {
    let _box = ValueBox::new(5);

    let _box_ptr = _box.into_raw();
    assert_eq!(_box_ptr.is_null(), false);

    _box_ptr.with_reference(| value| *value = 2 );
    assert_eq!(_box_ptr.is_null(), false);

    let new_value = _box_ptr.with_value(|value| value );
    assert_eq!(new_value, 2);
}