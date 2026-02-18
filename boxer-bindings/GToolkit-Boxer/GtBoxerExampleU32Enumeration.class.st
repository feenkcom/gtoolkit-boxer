"
```rust
#[repr(u32)]
pub enum Enumeration {
    A,
    B,
    C,
}
```
"
Class {
	#name : #GtBoxerExampleU32Enumeration,
	#superclass : #GtExternalEnumeration,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #'enum declaration' }
GtBoxerExampleU32Enumeration class >> externalDeclaration [
	^ #(
		A,
		B,
		C,
	)
]

{ #category : #'enum declaration' }
GtBoxerExampleU32Enumeration class >> externalType [
	^ FFIUInt32 new
]
