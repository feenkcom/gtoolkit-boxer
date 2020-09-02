/// Tell Rust to take back the control over memory
/// This is dangerous! Rust takes the control over the memory back
pub unsafe fn from_raw<T>(pointer: *mut T) -> Box<T> {
    assert_eq!(
        pointer.is_null(),
        false,
        "from_raw(): Pointer must not be null!"
    );
    assert_eq!(
        std::mem::size_of::<*mut T>(),
        std::mem::size_of::<*mut std::ffi::c_void>(),
        "The pointer must be compatible with void*"
    );
    Box::from_raw(pointer)
}

pub fn into_raw<T>(_box: Box<T>) -> *mut T {
    assert_eq!(
        std::mem::size_of::<*mut T>(),
        std::mem::size_of::<*mut std::ffi::c_void>(),
        "The pointer must be compatible with void*"
    );
    Box::into_raw(_box)
}

#[derive(Debug)]
#[repr(C)]
pub struct ReferenceBox<T> {
    referenced: *mut T,
}

impl<T> ReferenceBox<T> {
    pub fn new(_reference: &mut T) -> Self {
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
    fn with<Block, Return>(&self, block: Block) -> Return
    where
        Block: FnOnce(&mut T) -> Return;
    fn with_value<Block, Return>(&self, block: Block) -> Return
    where
        Block: FnOnce(T) -> Return,
        T: Copy;
    fn with_not_null<Block>(&self, block: Block)
    where
        Block: FnOnce(&mut T);
    fn with_not_null_return<Block, Return>(&self, default: Return, block: Block) -> Return
    where
        Block: FnOnce(&mut T) -> Return;
    fn with_not_null_return_block<DefaultBlock, Block, Return>(
        &self,
        default: DefaultBlock,
        block: Block,
    ) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut T) -> Return;
    fn drop(self);
}

impl<T> ReferenceBoxPointer<T> for *mut ReferenceBox<T> {
    fn with<Block, Return>(&self, block: Block) -> Return
    where
        Block: FnOnce(&mut T) -> Return,
    {
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

    fn with_value<Block, Return>(&self, block: Block) -> Return
    where
        Block: FnOnce(T) -> Return,
        T: Copy,
    {
        assert_eq!(self.is_null(), false, "Pointer must not be null!");

        let reference_box = unsafe { from_raw(*self) };
        let referenced_object = *&mut unsafe { *reference_box.referenced };
        let result: Return = block(referenced_object);

        let new_pointer = into_raw(reference_box);
        assert_eq!(new_pointer, *self, "The pointer must not change");

        result
    }

    fn with_not_null<Block>(&self, block: Block)
    where
        Block: FnOnce(&mut T),
    {
        if self.is_null() {
            return;
        }
        self.with(|boxed_object| {
            block(boxed_object);
        });
    }

    fn with_not_null_return<Block, Return>(&self, default: Return, block: Block) -> Return
    where
        Block: FnOnce(&mut T) -> Return,
    {
        if self.is_null() {
            return default;
        }
        self.with(block)
    }

    fn with_not_null_return_block<DefaultBlock, Block, Return>(
        &self,
        default: DefaultBlock,
        block: Block,
    ) -> Return
    where
        DefaultBlock: FnOnce() -> Return,
        Block: FnOnce(&mut T) -> Return,
    {
        if self.is_null() {
            return default();
        }
        self.with(block)
    }

    fn drop(self) {
        let reference_box = unsafe { from_raw(self) };
        std::mem::drop(reference_box);
    }
}

#[derive(Debug)]
#[repr(C)]
pub struct DynamicBox<T> {
    boxed: Option<T>,
}

impl<T> DynamicBox<T> {
    pub fn new(object: T) -> Self {
        DynamicBox {
            boxed: Some(object),
        }
    }

    /// dangerously replaces a pointer with the one for the given object
    /// I do not drop an existing pointer
    pub unsafe fn mutate(&mut self, object: T) {
        self.boxed = Some(object);
    }

    pub fn into_raw(self) -> *mut Self {
        into_raw(Box::new(self))
    }
}
