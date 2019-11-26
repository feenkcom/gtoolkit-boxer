use std::ops::DerefMut;

/// Tell Rust to take back the control over memory
/// This is dangerous! Rust takes the control over the memory back
pub unsafe fn from_raw<T>(pointer: *mut T) -> Box<T> {
    assert_eq!(pointer.is_null(), false, "from_raw(): Pointer must not be null!");
    assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
    Box::from_raw(pointer)
}

pub fn into_raw<T> (_box: Box<T>) -> *mut T {
    assert_eq!(std::mem::size_of::<*mut T>(), std::mem::size_of::<*mut std::ffi::c_void>(), "The pointer must be compatible with void*");
    Box::into_raw(_box)
}

#[derive(Debug)]
#[repr(C)]
pub struct ValueBox<T> {
   boxed: *mut T
}

impl <T> ValueBox<T> {
    pub fn new (object: T) -> Self {
        ValueBox {
            boxed: Box::into_raw(Box::new(object))
        }
    }

    pub fn from_box (_box: Box<T>) -> Self {
        ValueBox {
            boxed: Box::into_raw(_box)
        }
    }

    /// dangerously replaces a pointer with the one for the given object
    /// I do not drop an existing pointer
    pub unsafe fn mutate(&mut self, object: T) {
        self.boxed = Box::into_raw(Box::new(object))
    }

    pub fn into_raw(self) -> *mut Self {
        into_raw(Box::new(self))
    }

    pub fn boxed(&self) -> *mut T {
        self.boxed
    }
}

impl<T> Drop for ValueBox<T> {
    fn drop(&mut self) {
        if !self.boxed.is_null() {
            unsafe { from_raw(self.boxed) };
            self.boxed = std::ptr::null_mut();
        }
    }
}

pub trait ValueBoxPointer<T> {
    fn as_option(self) -> Option<*mut ValueBox<T>>;
    fn as_box(self) -> Option<Box<T>>;
    fn with<Block, Return>(&self, block: Block) -> Return where Block : FnOnce(&mut Box<T>) -> Return;
    fn with_not_null<Block>(&self, block: Block) where Block : FnOnce(&mut Box<T>);
    fn with_not_null_return<Block, Return>(&self, default: Return, block: Block) -> Return where Block : FnOnce(&mut Box<T>) -> Return;
    fn with_not_null_return_block<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return where
            DefaultBlock : FnOnce() -> Return,
            Block : FnOnce(&mut Box<T>) -> Return;
    fn with_reference<Block, Return>(&self, block: Block) -> Return where Block : FnOnce(&mut T) -> Return;
    fn with_value<Block, Return>(&self, block: Block) -> Return where
            Block: FnOnce(T) -> Return,
            T: Copy;
    fn with_value_consumed<Block, Return>(&mut self, block: Block) -> Return where Block: FnOnce(T) -> Return;
    fn with_value_and_box_consumed<Block, Return>(&mut self, block: Block) -> Return where Block: FnOnce(T, &mut Box<ValueBox<T>>) -> Return;
    fn drop(self);
}

impl<T> ValueBoxPointer<T> for *mut ValueBox<T> {
    fn as_option(self) -> Option<*mut ValueBox<T>> {
        if self.is_null() {
            None
        }
        else {
           Some(self)
        }
    }

    fn as_box(self) -> Option<Box<T>> {
        match self.as_option() {
            None => { None },
            Some(value_box_ptr) => {
                let value_box = unsafe { from_raw(value_box_ptr) };

                if value_box.boxed.is_null() {
                    None
                }
                else { unsafe { Some(from_raw(value_box.boxed)) } }
            }
        }
    }

    // self is `&*mut`
    fn with<Block, Return>(&self, block: Block) -> Return where Block: FnOnce(&mut Box<T>) -> Return {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        let mut boxed_object = unsafe { from_raw(value_box.boxed) };
        let result: Return = block(&mut boxed_object);

        let new_boxed_pointer = into_raw(boxed_object);
        assert_eq!(new_boxed_pointer, value_box.boxed, "The boxed pointer must not change");
        value_box.boxed = new_boxed_pointer;

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_not_null<Block>(&self, block: Block) where Block: FnOnce(&mut Box<T>) {
        if self.is_null() {
            return;
        }
        self.with(|boxed_object| { block(boxed_object); } );
    }

    fn with_not_null_return<Block, Return>(&self, default: Return, block: Block) -> Return where Block: FnOnce(&mut Box<T>) -> Return {
        if self.is_null() {
            return default;
        }
        self.with(block)
    }

    fn with_not_null_return_block<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut Box<T>) -> Return {
        if self.is_null() {
            return default()
        }
        self.with(block)
    }

    fn with_reference<Block, Return>(&self, block: Block) -> Return where Block: FnOnce(&mut T) -> Return {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        let mut boxed_object = unsafe { from_raw(value_box.boxed) };
        let result: Return = block(boxed_object.deref_mut());

        let new_boxed_pointer = into_raw(boxed_object);
        assert_eq!(new_boxed_pointer, value_box.boxed, "The boxed pointer must not change");
        value_box.boxed = new_boxed_pointer;

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_value<Block, Return>(&self, block: Block) -> Return where
            Block: FnOnce(T) -> Return,
            T: Copy {

        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        let boxed_object = unsafe { from_raw(value_box.boxed) };
        let object = (*boxed_object).clone();
        let result: Return = block(object);

        let new_boxed_pointer = into_raw(boxed_object);
        assert_eq!(new_boxed_pointer, value_box.boxed, "The boxed pointer must not change");
        value_box.boxed = new_boxed_pointer;

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    /// The value
    fn with_value_consumed<Block, Return>(&mut self, block: Block) -> Return where Block: FnOnce(T) -> Return {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        let boxed_object = unsafe { from_raw(value_box.boxed) };
        let object = *boxed_object;

        value_box.boxed = std::ptr::null_mut();
        let result: Return = block(object);

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    /// The value
    fn with_value_and_box_consumed<Block, Return>(&mut self, block: Block) -> Return where Block: FnOnce(T, &mut Box<ValueBox<T>>) -> Return {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        let boxed_object = unsafe { from_raw(value_box.boxed) };
        let object = *boxed_object;

        value_box.boxed = std::ptr::null_mut();
        let result: Return = block(object, &mut value_box);

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn drop(self) {
        if !self.is_null() {
            let value_box = unsafe { from_raw(self) };
            std::mem::drop(value_box)
        }
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

    pub fn boxed(&self) -> *mut T {
        self.referenced
    }
}

pub trait ReferenceBoxPointer<T> {
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

        let referenced_object_pointer: *mut T = unsafe { std::mem::transmute(referenced_object) };
        reference_box.referenced = referenced_object_pointer;

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
        let reference_box = unsafe { from_raw(self) };
        std::mem::drop(reference_box);
    }
}

#[cfg(test)]
mod test {
    use crate::boxes::{ValueBox, ValueBoxPointer, from_raw};

    #[test]
    fn value_box_with_consumed() {
        let _box = ValueBox::new(5);

        let mut _box_ptr = _box.into_raw();
        assert_eq!(_box_ptr.is_null(), false);

        let result = _box_ptr.with_value_consumed(|value| value * 2 );
        assert_eq!(_box_ptr.is_null(), false);

        let _box = unsafe { from_raw(_box_ptr) };
        assert_eq!(_box.boxed.is_null(), true);
        assert_eq!(result, 10);
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

    struct Child<'counter> {
        value: i32,
        counter: &'counter mut i32
    }

    struct Parent<'counter> {
        child: Child<'counter>,
        counter: &'counter mut i32,
    }

    impl<'counter> Drop for Parent<'counter> {
        fn drop(&mut self) {
            println!("destroyed Parent");
            *self.counter += 1;
        }
    }

    impl<'counter> Drop for Child<'counter> {
        fn drop(&mut self) {
            println!("destroyed Child");
            *self.counter += 1;
        }
    }

    fn create_parent<'counter>(parents_drop: &'counter mut i32, children_drop: &'counter mut i32) -> Parent<'counter> {
        Parent {
            child: Child {
                value: 5,
                counter: children_drop
            },
            counter: parents_drop
        }
    }

    #[test]
    fn drop_parent() {
        let mut parents_drop = 0;
        let mut children_drop = 0;

        let parent = create_parent(&mut parents_drop, &mut children_drop);

        std::mem::drop(parent);

        assert_eq!(parents_drop, 1);
        assert_eq!(children_drop, 1);
    }


    fn put_parent_in_value_box_without_return(parent: Parent) {
        put_parent_in_value_box_with_return(parent);
    }

    fn put_parent_in_value_box_with_return(parent: Parent) -> *mut ValueBox<Parent> {
        ValueBox::new(parent).into_raw()
    }

    #[test]
    fn leak_parent_by_putting_in_value_box_without_drop() {
        let mut parents_drop = 0;
        let mut children_drop = 0;

        let mut parent = create_parent(&mut parents_drop, &mut children_drop);

        put_parent_in_value_box_without_return(parent);

        assert_eq!(parents_drop, 0);
        assert_eq!(children_drop, 0);
    }

    #[test]
    fn drop_parent_by_dropping_value_box () {
        let mut parents_drop = 0;
        let mut children_drop = 0;

        let parent = create_parent(&mut parents_drop, &mut children_drop);

        let parent_ptr = put_parent_in_value_box_with_return(parent);
        parent_ptr.drop();

        assert_eq!(parents_drop, 1);
        assert_eq!(children_drop, 1);
    }
}