Class {
	#name : #GtBoxerString,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerString class >> fromByteArray: aByteArray [
	"I create an auto-release string that copies a given data.
	The last element of the aByteArray must be 0"

	self
		assert: [ aByteArray last isZero ]
		description: [ 'A string must be created from a null-terminated byte array' ].

	^ self
		fromHandle: aByteArray
		size: aByteArray size - 1
]

{ #category : #'instance creation' }
GtBoxerString class >> fromByteArray: aByteArray during: aBlock [
	"I create a string that copies a given data for duration of a block.
	The last element of the aByteArray must be 0"

	self
		assert: [ aByteArray last isZero ]
		description: [ 'A string must be created from a null-terminated byte array' ].

	^ self
		fromHandle: aByteArray
		size: aByteArray size - 1
		during: aBlock
]

{ #category : #'private - instance creation' }
GtBoxerString class >> fromHandle: anExternalAddress size: aSize [
	"anExternalAddress should not neccesseraly overlive the string, because it will be copied"

	^ self fromNativeHandle: (self primCreateFromData: anExternalAddress size: aSize)
]

{ #category : #'private - instance creation' }
GtBoxerString class >> fromHandle: anExternalAddress size: aSize during: aBlock [
	"anExternalAddress should not neccesseraly overlive the string, because it will be copied"

	^ self fromNativeHandle: (self primCreateFromData: anExternalAddress size: aSize) during: aBlock
]

{ #category : #'instance creation' }
GtBoxerString class >> fromString: aString [
	self
		assert: [ aString isNotNil ]
		description: [ 'String must not be nil' ].

	^ self fromNativeHandle: (aString isByteString
		ifTrue: [ self primCreateFromByteString: aString size: aString size ]
		ifFalse: [ self primCreateFromWideString: aString size: aString size ])
]

{ #category : #'instance creation' }
GtBoxerString class >> fromString: aString during: aBlock [
	self
		assert: [ aString isNotNil ]
		description: [ 'String must not be nil' ].

	^ self fromNativeHandle: (aString isByteString
		ifTrue: [ self primCreateFromByteString: aString size: aString size ]
		ifFalse: [ self primCreateFromWideString: aString size: aString size ])
			during: aBlock
]

{ #category : #'instance creation' }
GtBoxerString class >> getStringFrom: aBlock [
	<return: #String>
	| aString |

	aString := ''.

	self newDuring: [ :aBoxerString |
		aBlock value: aBoxerString.
		aString := aBoxerString string ].

	^ aString
]

{ #category : #'private - ffi' }
GtBoxerString class >> primCreate [
	^ self ffiCall: #(void* boxer_string_create())
]

{ #category : #'private - ffi' }
GtBoxerString class >> primCreateFromByteString: aByteString size: aSize [
	^ self ffiCall: #(void* boxer_string_from_byte_string(void* aByteString, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerString class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_string_from_utf8_string(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerString class >> primCreateFromWideString: aWideString size: aSize [
	aWideString pinInMemory.
	^ self
		primCreateFromWideStringOop: (PointerUtils oopForObject: aWideString)
		size: aSize
]

{ #category : #'private - ffi' }
GtBoxerString class >> primCreateFromWideStringOop: aWideStringPointer size: aSize [
	^ self ffiCall: #(void* boxer_string_from_wide_string(void* aWideStringPointer, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerString class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_string_drop(void** aHandle))
]

{ #category : #converting }
GtBoxerString >> asArray [
	^ self data asArray
]

{ #category : #accessing }
GtBoxerString >> charIndexToByteInterval: anIndex [
	<return: #Interval>

	^ GtBoxerRangeUSize newDuring: [ :aRange |
		self primCharIndex: anIndex - 1 toByteRange: aRange.
		aRange asInterval ]
]

{ #category : #accessing }
GtBoxerString >> charIndexToUtf16Interval: anIndex [
	<return: #Interval>

	^ GtBoxerRangeUSize newDuring: [ :aRange |
		self primCharIndex: anIndex - 1 toUtf16Range: aRange.
		aRange asInterval ]
]

{ #category : #accessing }
GtBoxerString >> data [	
	| anExternalHandle |
	
	anExternalHandle := self primGetData getHandle.
	anExternalHandle isNull
		ifTrue: [ ^ (GtBoxer externalArrayNewType: FFIUInt8 size: 0) autoRelease ].

	"the memory is managed by external library, we should not auto-release it"
	^ GtBoxer
		externalArrayFromHandle: self primGetData getHandle
		type: FFIUInt8
		size: self length
]

{ #category : #accessing }
GtBoxerString >> length [
	"Return the byte size of the string"
	<return: #Number>

	^ self primLength
]

{ #category : #'private - ffi' }
GtBoxerString >> primCharIndex: anIndex toByteRange: aGtBoxerRangeUSize [
	^ self ffiCall: #(void boxer_string_char_index_to_byte_range(
		self,
		size_t anIndex,
		GtBoxerRangeUSize aGtBoxerRangeUSize))
]

{ #category : #'private - ffi' }
GtBoxerString >> primCharIndex: anIndex toUtf16Range: aGtBoxerRangeUSize [
	^ self ffiCall: #(void boxer_string_char_index_to_utf16_range(
		self,
		size_t anIndex,
		GtBoxerRangeUSize aGtBoxerRangeUSize))
]

{ #category : #'private - ffi' }
GtBoxerString >> primGetCharCount [
	^ self ffiCall: #(size_t boxer_string_get_char_count(self))
]

{ #category : #'private - ffi' }
GtBoxerString >> primGetData [
	^ self ffiCall: #(void* boxer_string_get_ptr(self))
]

{ #category : #'private - ffi' }
GtBoxerString >> primLength [
	^ self ffiCall: #(size_t boxer_string_get_len(self))
]

{ #category : #'private - ffi' }
GtBoxerString >> primSetData: aData length: aLength [
	^ self ffiCall: #(void boxer_string_set_data(self, void* aData, size_t aLength))
]

{ #category : #'private - ffi' }
GtBoxerString >> primUtf16PositionToCharIndex: anIndex [
	^ self ffiCall: #(size_t boxer_string_utf16_position_to_char_index(
		self,
		size_t anIndex))
]

{ #category : #printing }
GtBoxerString >> printOn: aStream [
	aStream print: self string
]

{ #category : #accessing }
GtBoxerString >> size [
	"Return the amount of characters in the string"
	<return: #Number>

	^ self primGetCharCount
]

{ #category : #accessing }
GtBoxerString >> string [
	"Return UTF-8 decoded string"
	<return: #String>
	| aLength |
	
	aLength := self length.
	aLength isZero
		ifTrue: [ ^ '' ].
	
	^ ZnCharacterEncoder utf8 decodeBytes: (GtBoxer
		externalArrayFromHandle: self primGetData getHandle
		type: FFIUInt8
		size: aLength "a zero byte is at aLength + 1, we ignore it"
		during: [ :anExternalArray | anExternalArray asArray ])
]

{ #category : #accessing }
GtBoxerString >> string: aString [
	self deprecated: 'Create a new string instead'
]

{ #category : #accessing }
GtBoxerString >> utf16PositionToCharIndex: anIndex [
	^ self primUtf16PositionToCharIndex: anIndex
]
