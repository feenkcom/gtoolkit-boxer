use crate::boxes::{from_raw, into_raw};
use crate::{BoxerError, Result};
use std::any::type_name;
use std::fmt::{Debug, Formatter};
use std::intrinsics::transmute;
use std::mem::ManuallyDrop;
use std::ops::{Deref, DerefMut};

#[repr(transparent)]
pub struct ValueBox<T> {
    value: Option<T>,
}

#[repr(transparent)]
pub struct BoxRef<T> {
    value_box: ManuallyDrop<Box<ValueBox<T>>>,
}

impl<T> Deref for BoxRef<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        self.value_box.deref().value.as_ref().unwrap()
    }
}

impl<T> DerefMut for BoxRef<T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.value_box.deref_mut().value.as_mut().unwrap()
    }
}

impl<T> Debug for BoxRef<T> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("BoxRef")
            .field(
                "value",
                self.value_box
                    .deref()
                    .value
                    .as_ref()
                    .map_or(&"None", |_| &"Some"),
            )
            .finish()
    }
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
        trace!("[has_value] value pointer: {:?}", unsafe {
            transmute::<Option<&T>, *const T>(self.value.as_ref())
        });
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
        debug!(
            "Dropping {} of {}",
            self.value.as_ref().map_or("None", |_| { "Some" }),
            type_name::<T>()
        );
    }
}

pub trait ValueBoxPointer<T> {
    fn to_ref(&self) -> Result<BoxRef<T>>;
    fn to_value(&self) -> Result<T>;

    fn with_box<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut Box<ValueBox<T>>, DefaultBlock) -> Return;

    fn is_valid(&self) -> bool;
    fn has_value(&self) -> bool;
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
}

pub trait ValueBoxPointerReference<T> {
    fn drop(self);
}

impl<T> ValueBoxPointer<T> for *mut ValueBox<T> {
    fn to_ref(&self) -> Result<BoxRef<T>> {
        if self.is_null() {
            return BoxerError::NullPointer(std::any::type_name::<T>().to_string()).into();
        }
        let value_box = ManuallyDrop::new(unsafe { from_raw(*self) });

        if value_box.has_value() {
            Ok(BoxRef { value_box })
        } else {
            BoxerError::NoValue(std::any::type_name::<T>().to_string()).into()
        }
    }

    fn to_value(&self) -> Result<T> {
        if self.is_null() {
            return BoxerError::NullPointer(std::any::type_name::<T>().to_string()).into();
        }
        let mut value_box = ManuallyDrop::new(unsafe { from_raw(*self) });
        value_box
            .take_value()
            .ok_or(BoxerError::NoValue(std::any::type_name::<T>().to_string()))
    }

    fn with_box<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut Box<ValueBox<T>>, DefaultBlock) -> Return,
    {
        if self.is_null() {
            debug!("ValueBox pointer of {} is null", type_name::<T>());
            return default();
        }

        let mut value_box = unsafe { from_raw(*self) };
        let result = block(&mut value_box, default);
        let new_pointer = into_raw(value_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");
        result
    }

    fn is_valid(&self) -> bool {
        self.with_box(|| false, |value_box, _| value_box.has_value())
    }

    fn has_value(&self) -> bool {
        self.with_box(|| false, |value_box, _| value_box.has_value())
    }

    fn mutate(&self, object: T) {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");
        self.with_box(|| (), |value_box, _| value_box.set_value(object));
    }

    fn get_ptr(&self) -> *const T {
        self.with_box(|| std::ptr::null(), |value_box, _| value_box.as_ptr())
    }

    fn with<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut T) -> Return,
    {
        self.with_box(default, |value_box, default| {
            value_box
                .as_ref_mut()
                .map(|value| block(value))
                .unwrap_or_else(|| {
                    debug!("ValueBox value of {} is None", type_name::<T>());
                    default()
                })
        })
    }

    fn with_not_null<Block>(&self, block: Block)
    where
        Block: FnOnce(&mut T),
    {
        self.with(|| (), block);
    }

    fn with_not_null_return<Block, Return>(&self, default: Return, block: Block) -> Return
    where
        Block: FnOnce(&mut T) -> Return,
    {
        self.with(|| default, block)
    }

    fn with_value<DefaultBlock, Block, Return>(&self, default: DefaultBlock, block: Block) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(T) -> Return,
        T: Clone,
    {
        self.with_box(default, |value_box, default| {
            value_box
                .clone_value()
                .map(|value| block(value))
                .unwrap_or_else(|| {
                    debug!("ValueBox value of {} is None", type_name::<T>());
                    default()
                })
        })
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
        self.with_value(|| default, block)
    }

    fn with_not_null_value_mutate<Block>(&mut self, block: Block)
    where
        Block: FnOnce(T) -> T,
    {
        self.with_box(
            || (),
            |value_box, _| match value_box.take_value().map(block) {
                None => {
                    debug!("ValueBox value of {} is None", type_name::<T>());
                }
                Some(result) => value_box.set_value(result),
            },
        )
    }

    /// I do not drop the box
    fn with_value_consumed<DefaultBlock, Block, Return>(
        &mut self,
        default: DefaultBlock,
        block: Block,
    ) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(T, &mut Box<ValueBox<T>>) -> Return,
    {
        self.with_box(default, |value_box, default| {
            value_box
                .take_value()
                .map(|value| block(value, value_box))
                .unwrap_or_else(|| {
                    debug!("ValueBox value of {} is None", type_name::<T>());
                    default()
                })
        })
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
}

impl<T> ValueBoxPointerReference<T> for &mut *mut ValueBox<T> {
    fn drop(self) {
        let ptr = *self;

        if !ptr.is_null() {
            let value_box = unsafe { from_raw(ptr) };
            std::mem::drop(value_box)
        } else {
            debug!("Trying to double-free the memory of {}", type_name::<T>());
        }
        *self = std::ptr::null_mut()
    }
}

#[cfg(test)]
mod test {
    use crate::error::ReturnBoxerResult;
    use crate::value_box::{ValueBox, ValueBoxPointer};
    use crate::ValueBoxPointerReference;
    use anyhow::anyhow;
    use std::error::Error;
    use std::fmt::{Display, Write};

    use super::*;

    #[derive(Debug)]
    pub struct CustomError {}

    impl Display for CustomError {
        fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
            f.write_str("CustomError")
        }
    }

    impl std::error::Error for CustomError {}

    #[test]
    pub fn value_box_as_ref() -> Result<()> {
        let value_box = ValueBox::new(5);
        let value_box_ptr = value_box.into_raw();

        let reference = value_box_ptr.to_ref()?;
        assert_eq!(reference.deref(), &5);
        drop(reference);

        let value = value_box_ptr
            .to_ref()
            .and_then(|value| Err(anyhow!("New error").into()))
            .or_print(0);
        assert_eq!(value, 0);

        let value = value_box_ptr
            .to_ref()
            .and_then(|value| Err((Box::new(CustomError {}) as Box<dyn Error>).into()))
            .or_print(0);
        assert_eq!(value, 0);

        Ok(())
    }

    #[test]
    pub fn value_box_as_ref_mut() -> Result<()> {
        let value_box = ValueBox::new(5);
        let mut value_box_ptr = value_box.into_raw();

        let mut reference = value_box_ptr.to_ref()?.deref_mut().clone();
        assert_eq!(reference, 5);

        Ok(())
    }

    #[test]
    fn value_box_with_consumed() {
        let value_box = ValueBox::new(5);

        let mut value_box_ptr = value_box.into_raw();
        assert_eq!(value_box_ptr.is_null(), false);
        assert_eq!(value_box_ptr.has_value(), true);

        let result = value_box_ptr.with_not_null_value_consumed_return(0, |value| value * 2);

        assert_eq!(result, 10);
        assert_eq!(value_box_ptr.is_null(), false);
        assert_eq!(value_box_ptr.has_value(), false);
        assert_eq!(value_box_ptr.is_valid(), false);
    }

    #[test]
    fn value_box_with_value() {
        let value_box = ValueBox::new(5);

        let mut value_box_ptr = value_box.into_raw();
        assert_eq!(value_box_ptr.is_null(), false);

        let result = value_box_ptr.with_not_null_value_return(0, |value| value * 2);
        assert_eq!(value_box_ptr.is_null(), false);
        assert_eq!(result, 10);

        (&mut value_box_ptr).drop();
    }

    #[test]
    fn value_box_drop() {
        let mut ptr = ValueBox::new(42).into_raw();
        let ptr_ref = &mut ptr.clone();
        ptr_ref.drop();
        assert_eq!(ptr_ref.is_null(), true);
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
        (&mut parent_ptr).drop();

        assert_eq!(parents_drop, 1);
        assert_eq!(children_drop, 1);
    }
}
