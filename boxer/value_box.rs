use crate::boxes::{from_raw, into_raw};
use std::any::type_name;

#[repr(C)]
pub struct ValueBox<T> {
    value: Option<T>,
}

impl<T> ValueBox<T> {
    pub fn new(object: T) -> Self {
        ValueBox {
            value: Some(object),
        }
    }

    pub fn null() -> Self {
        ValueBox { value: None }
    }

    pub fn has_value(&self) -> bool {
        self.value.is_some()
    }

    pub fn set_value(&mut self, object: T) {
        self.value = Some(object)
    }

    pub fn clone_value(&self) -> Option<T>
    where
        T: Clone,
    {
        self.value.clone()
    }

    pub fn take_value(&mut self) -> Option<T> {
        self.value.take()
    }

    pub fn into_raw(self) -> *mut Self {
        into_raw(Box::new(self))
    }

    pub fn as_ref_mut(&mut self) -> Option<&mut T> {
        self.value.as_mut()
    }

    pub fn as_ptr(&self) -> *const T {
        self.value
            .as_ref()
            .map_or(std::ptr::null(), |reference| reference as *const T)
    }

    pub fn as_ptr_mut(&mut self) -> *mut T {
        self.value
            .as_mut()
            .map_or(std::ptr::null_mut(), |reference| reference as *mut T)
    }
}

impl<T> Drop for ValueBox<T> {
    fn drop(&mut self) {
        log!(
            if self.value.is_some() { log::Level::Debug } else { log::Level::Warn },
            "Dropping {} of {}",
            self.value.as_ref().map_or("None", |_| { "Some" }),
            type_name::<T>()
        );
    }
}

pub trait ValueBoxPointer<T> {
    fn is_valid(&self) -> bool;
    fn mutate(&self, object: T);
    fn get_ptr(&self) -> *const T;

    fn with<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut T) -> Return;
    fn with_not_null<Block>(&self, block: Block)
    where
        Block: FnOnce(&mut T);
    fn with_not_null_return<Block, Return>(&self, default: Return, block: Block) -> Return
    where
        Block: FnOnce(&mut T) -> Return;

    fn with_value<DefaultBlock, Block, Return>(
        &self,
        default: DefaultBlock,
        block: Block,
    ) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(T) -> Return,
        T: Clone;

    fn with_not_null_value<Block>(&self, block: Block)
    where
        Block: FnOnce(T),
        T: Clone;
    fn with_not_null_value_return<Block, Return>(&self, default: Return, block: Block) -> Return
    where
        Block: FnOnce(T) -> Return,
        T: Clone;

    fn with_not_null_value_mutate<Block>(&mut self, block: Block)
    where
        Block: FnOnce(T) -> T;

    fn with_value_consumed<DefaultBlock, Block, Return>(
        &mut self,
        default: DefaultBlock,
        block: Block,
    ) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(T, &mut Box<ValueBox<T>>) -> Return;

    fn with_not_null_value_consumed<Block>(&mut self, block: Block)
    where
        Block: FnOnce(T);

    fn with_not_null_value_consumed_return<Block, Return>(
        &mut self,
        default: Return,
        block: Block,
    ) -> Return
    where
        Block: FnOnce(T) -> Return;

    fn drop(&mut self);
}

impl<T> ValueBoxPointer<T> for *mut ValueBox<T> {
    fn is_valid(&self) -> bool {
        if self.is_null() {
            return false;
        };

        let value_box = unsafe { from_raw(*self) };
        value_box.has_value()
    }

    fn mutate(&self, object: T) {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let mut value_box = unsafe { from_raw(*self) };
        value_box.set_value(object);

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");
    }

    fn get_ptr(&self) -> *const T {
        if self.is_null() {
            return std::ptr::null();
        };

        let value_box = unsafe { from_raw(*self) };
        let ptr = value_box.as_ptr();

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        ptr
    }

    fn with<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut T) -> Return,
    {
        if self.is_null() {
            debug!("ValueBox pointer of {} is null", type_name::<T>());
            return default();
        }
        let mut value_box = unsafe { from_raw(*self) };

        let result = value_box
            .as_ref_mut()
            .map(|value| block(value))
            .unwrap_or_else(||{
                debug!("ValueBox value of {} is None", type_name::<T>());
                default()
            });

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_not_null<Block>(&self, block: Block)
    where
        Block: FnOnce(&mut T),
    {
        self.with(|| (), |value| block(value));
    }

    fn with_not_null_return<Block, Return>(&self, default: Return, block: Block) -> Return
    where
        Block: FnOnce(&mut T) -> Return,
    {
        self.with(|| default, |value| block(value))
    }

    fn with_value<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(T) -> Return,
        T: Clone,
    {
        if self.is_null() {
            debug!("ValueBox pointer of {} is null", type_name::<T>());
            return default();
        }
        let value_box = unsafe { from_raw(*self) };

        let result = value_box
            .clone_value()
            .map(|value| block(value))
            .unwrap_or_else(||{
                debug!("ValueBox value of {} is None", type_name::<T>());
                default()
            });

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_not_null_value<Block>(&self, block: Block)
    where
        Block: FnOnce(T),
        T: Clone,
    {
        self.with_value(|| (), block);
    }

    fn with_not_null_value_return<Block, Return>(&self, default: Return, block: Block) -> Return
    where
        Block: FnOnce(T) -> Return,
        T: Clone,
    {
        self.with_value(|| default, |value| block(value))
    }

    fn with_not_null_value_mutate<Block>(&mut self, block: Block)
    where
        Block: FnOnce(T) -> T,
    {
        if self.is_null() {
            debug!("ValueBox pointer of {} is null", type_name::<T>());
            return;
        }

        let mut value_box = unsafe { from_raw(*self) };
        match value_box.take_value().map(block) {
            None => { debug!("ValueBox value of {} is None", type_name::<T>()); }
            Some(result) => value_box.set_value(result),
        }

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");
    }

    /// I also drop the box
    fn with_value_consumed<DefaultBlock, Block, Return>(
        &mut self,
        default: DefaultBlock,
        block: Block,
    ) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(T, &mut Box<ValueBox<T>>) -> Return,
    {
        if self.is_null() {
            debug!("ValueBox pointer of {} is null", type_name::<T>());
            return default();
        }

        let mut value_box = unsafe { from_raw(*self) };
        let result = value_box
            .take_value()
            .map(|value| block(value, &mut value_box))
            .unwrap_or_else(||{
                debug!("ValueBox value of {} is None", type_name::<T>());
                default()
            });

        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        // dropping the original box
        self.drop();

        result
    }

    fn with_not_null_value_consumed<Block>(&mut self, block: Block)
    where
        Block: FnOnce(T),
    {
        self.with_value_consumed(|| (), |value, _| block(value));
    }

    fn with_not_null_value_consumed_return<Block, Return>(
        &mut self,
        default: Return,
        block: Block,
    ) -> Return
    where
        Block: FnOnce(T) -> Return,
    {
        self.with_value_consumed(|| default, |value, _| block(value))
    }

    fn drop(&mut self) {
        if !self.is_null() {
            let value_box = unsafe { from_raw(*self) };
            std::mem::drop(value_box)
        }
        else {
            error!("Trying to double-free the memory of {}", type_name::<T>());
        }
        *self = std::ptr::null_mut()
    }
}

#[cfg(test)]
mod test {
    use crate::value_box::{ValueBox, ValueBoxPointer};

    #[test]
    fn value_box_with_consumed() {
        let value_box = ValueBox::new(5);

        let mut value_box_ptr = value_box.into_raw();
        assert_eq!(value_box_ptr.is_null(), false);

        let result = value_box_ptr.with_not_null_value_consumed_return(0, |value| value * 2);

        assert_eq!(result, 10);
        assert_eq!(value_box_ptr.is_null(), true);
    }

    #[test]
    fn value_box_with_value() {
        let value_box = ValueBox::new(5);

        let mut value_box_ptr = value_box.into_raw();
        assert_eq!(value_box_ptr.is_null(), false);

        let result = value_box_ptr.with_not_null_value_return(0, |value| value * 2);
        assert_eq!(value_box_ptr.is_null(), false);
        assert_eq!(result, 10);

        value_box_ptr.drop();
    }

    #[test]
    fn value_box_drop() {
        let mut ptr = ValueBox::new(42).into_raw();
        ptr.drop();
        assert_eq!(ptr, std::ptr::null_mut())
    }

    struct Child<'counter> {
        value: i32,
        counter: &'counter mut i32,
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

    fn create_parent<'counter>(
        parents_drop: &'counter mut i32,
        children_drop: &'counter mut i32,
    ) -> Parent<'counter> {
        Parent {
            child: Child {
                value: 5,
                counter: children_drop,
            },
            counter: parents_drop,
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

        let parent = create_parent(&mut parents_drop, &mut children_drop);

        put_parent_in_value_box_without_return(parent);

        assert_eq!(parents_drop, 0);
        assert_eq!(children_drop, 0);
    }

    #[test]
    fn drop_parent_by_dropping_value_box() {
        let mut parents_drop = 0;
        let mut children_drop = 0;

        let parent = create_parent(&mut parents_drop, &mut children_drop);

        let mut parent_ptr = put_parent_in_value_box_with_return(parent);
        parent_ptr.drop();

        assert_eq!(parents_drop, 1);
        assert_eq!(children_drop, 1);
    }
}
