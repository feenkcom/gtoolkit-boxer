use std::ops::DerefMut;
use std::borrow::BorrowMut;

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

#[derive(Debug)]
#[repr(C)]
pub struct ValueBox<T> {
    boxed: Box<T>,
    phantom: std::marker::PhantomData<T>,
}

impl <T> ValueBox<T> {
    pub fn new (object: T) -> Self {
        Self::from_box(Box::new(object))
    }

    pub fn from_box (_box: Box<T>) -> Self {
        ValueBox {
            boxed: _box,
            phantom: std::marker::PhantomData
        }
    }

    pub fn into_raw(self) -> *mut Self {
        into_raw(Box::new(self))
    }
}

trait ValueBoxPointer<T> {
    fn with<Block, Return>(&self, block: Block) -> Return where Block : FnOnce(&mut Box<T>) -> Return;
    fn with_reference<Block, Return>(&self, block: Block) -> Return where Block : FnOnce(&mut T) -> Return;
    fn with_value<Block, Return>(&self, block: Block) -> Return where
            Block: FnOnce(T) -> Return,
            T: Copy;
    fn drop(self);
}

impl<T> ValueBoxPointer<T> for *mut ValueBox<T> {
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

    fn drop(self) {
        let value_box = unsafe { from_raw(self) };
        std::mem::drop(value_box)
    }
}

#[derive(Debug)]
#[repr(C)]
pub struct ReferenceBox<T> {
    referenced: *mut T
}

impl <T> ReferenceBox<T> {
    pub fn new (_reference: &mut T) -> Self {
        let pointer: *mut T = unsafe { std::mem::transmute(_reference) };
        ReferenceBox {
            referenced: pointer,
        }
    }

    pub fn into_raw(self) -> *mut Self {
        into_raw(Box::new(self))
    }
}

impl<T> Drop for ReferenceBox<T> {
    fn drop(&mut self) {
        println!("destroyed ReferenceBox");
    }
}

trait ReferenceBoxPointer<T> {
    fn with<Block, Return>(&self, block: Block) -> Return where Block : FnOnce(&mut T) -> Return;
    fn with_value<Block, Return>(&self, block: Block) -> Return where
            Block: FnOnce(T) -> Return,
            T: Copy;
    fn drop(self);
}

impl<T> ReferenceBoxPointer<T> for *mut ReferenceBox<T> {
    fn with<Block, Return>(&self, block: Block) -> Return where Block: FnOnce(&mut T) -> Return {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut reference_box = unsafe { from_raw(*self) };
        let referenced_object: &mut T = unsafe { std::mem::transmute(reference_box.referenced) };
        let result: Return = block(referenced_object);

        referenced_object.borrow_mut();

        let new_pointer = into_raw(reference_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_value<Block, Return>(&self, block: Block) -> Return where
            Block: FnOnce(T) -> Return,
            T: Copy {

        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let reference_box = unsafe { from_raw(*self) };
        let referenced_object = * &mut unsafe { *reference_box.referenced };
        let result: Return = block(referenced_object);

        let new_pointer = into_raw(reference_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn drop(self) {
        let value_box = unsafe { from_raw(self) };
        std::mem::drop(value_box)
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


#[derive(Default, Debug)]
struct TestChild {
    value: i32
}

#[derive(Default, Debug)]
struct TestParent {
    child: TestChild
}

impl TestParent {
    fn child(&mut self) -> &mut TestChild {
        &mut self.child
    }
}

impl Drop for TestParent {
    fn drop(&mut self) {
        println!("destroyed {:?}", self);
    }
}

impl Drop for TestChild {
    fn drop(&mut self) {
        println!("destroyed {:?}", self);
    }
}

fn get_child_pointer(parent: &mut TestParent) -> *mut ReferenceBox<TestChild> {
    let reference = ReferenceBox::new(parent.child());
    reference.into_raw()
}

#[test]
fn reference_box_with_reference() {
    let mut parent = TestParent::default();
    parent.child.value = 5;

    let pointer = ReferenceBox::new(parent.child()).into_raw();
    let value = pointer.with(|child| child.value);
    assert_eq!(value, 5);
    pointer.drop();

    parent.child.value = 7;

    let pointer = get_child_pointer(&mut parent);
    let value = pointer.with(|child| child.value);
    assert_eq!(value, 7);
    pointer.drop();
}