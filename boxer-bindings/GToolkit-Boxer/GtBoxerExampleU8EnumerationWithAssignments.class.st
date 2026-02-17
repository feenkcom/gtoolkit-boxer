"
```rust
#[repr(u8)]
pub enum EnumerationWithAssignments {
    A = 2,
    B,
    C = 6,
}
```
"
Class {
	#name : #GtBoxerExampleU8EnumerationWithAssignments,
	#superclass : #GtExternalEnumeration,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #'enum declaration' }
GtBoxerExampleU8EnumerationWithAssignments class >> externalDeclaration [
	^ #(
		A = 2,
		B,
		C = 6,
	)
]

{ #category : #'enum declaration' }
GtBoxerExampleU8EnumerationWithAssignments class >> externalType [
	^ FFIUInt8 new
]
