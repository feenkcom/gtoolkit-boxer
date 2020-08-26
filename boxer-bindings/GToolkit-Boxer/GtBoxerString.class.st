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
	^ self ffiCall: #(void* boxer_string_from_wide_string(void* aWideString, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerString class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_string_drop(void* aHandle))
]

{ #category : #'instance creation' }
GtBoxerString class >> stringToByteArray: aString [
	^ ByteArray streamContents: [ :aStream |
		ZnUTF8Encoder new 
			next: aString size 
			putAll: aString asString
			startingAt: 1 
			toStream: aStream.
		aStream nextPut: 0 ]
]

{ #category : #converting }
GtBoxerString >> asArray [
	^ self data asArray
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
	<return: #Number>

	^ self primLength
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

{ #category : #printing }
GtBoxerString >> printOn: aStream [
	aStream print: self string
]

{ #category : #accessing }
GtBoxerString >> size [
	<return: #Number>

	^ self string size
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
	| anEncodedString |

	self
		assert: [ aString isNotNil ]
		description: [ 'String must not be nil' ]
]
