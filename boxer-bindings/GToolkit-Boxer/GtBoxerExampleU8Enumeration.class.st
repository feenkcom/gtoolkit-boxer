"
```rust
#[repr(u8)]
pub enum Enumeration {
    A,
    B,
    C,
}
```
"
Class {
	#name : #GtBoxerExampleU8Enumeration,
	#superclass : #GtExternalEnumeration,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #'enum declaration' }
GtBoxerExampleU8Enumeration class >> externalDeclaration [
	^ #(
		A,
		B,
		C,
	)
]

{ #category : #'enum declaration' }
GtBoxerExampleU8Enumeration class >> externalType [
	^ FFIUInt8 new
]
