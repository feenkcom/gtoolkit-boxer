"
Library-independent bindings to the [StringBox](https://docs.rs/string-box/latest/string_box/struct.StringBox.html) from the [string-box](https://crates.io/crates/string-box) crate.
Allows developers to pass and receive strings from Rust libraries. 
"
Class {
	#name : #GtStringBox,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtStringBox class >> primRelease: aHandle library: aLibrary [
	aLibrary primStringRelease: aHandle
]

{ #category : #converting }
GtStringBox >> asArray [
	^ self data asArray
]

{ #category : #accessing }
GtStringBox >> data [
	"Return an external array of u8 bytes that back the string.
	Please note that the StringBox must outlive the returned #data."
	<return: #FFIExternalArray>
	| anExternalHandle |
	
	anExternalHandle := self privateGetData getHandle.
	anExternalHandle isNull
		ifTrue: [ ^ (GtBoxer externalArrayNewType: FFIUInt8 size: 0) autoRelease ].

	"the memory is managed by an external library, we should not auto-release it"
	^ GtBoxer
		externalArrayFromHandle: anExternalHandle
		type: FFIUInt8
		size: self length
]

{ #category : #accessing }
GtStringBox >> length [
	"Return the byte size of the string.
	Please note, that this is not equal to the amount of logical characters in the string.
	A character encoded as UTF-8 may be represented by 1-4 bytes"
	<return: #Number>

	^ self ffiLibrary primStringGetLength: self
]

{ #category : #printing }
GtStringBox >> printOn: aStream [
	aStream print: self string
]

{ #category : #private }
GtStringBox >> privateGetData [
	^ self ffiLibrary primStringGetData: self
]

{ #category : #accessing }
GtStringBox >> size [
	"Return the amount of characters in the string"
	<return: #Number>

	^ self ffiLibrary primStringGetCharCount: self
]

{ #category : #accessing }
GtStringBox >> string [
	"Return UTF-8 decoded string"
	<return: #String>
	| aLength |
	
	aLength := self length.
	aLength isZero
		ifTrue: [ ^ '' ].

	^ ZnCharacterEncoder utf8 decodeBytes: (GtBoxer
		externalArrayFromHandle: self privateGetData getHandle
		type: FFIUInt8
		size: aLength "a zero byte is at aLength + 1, we ignore it"
		during: [ :anExternalArray | anExternalArray asArray ])
]
