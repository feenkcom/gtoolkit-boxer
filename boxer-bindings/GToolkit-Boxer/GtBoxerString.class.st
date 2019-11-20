Class {
	#name : #GtBoxerString,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerString class >> fromString: aString [
	^ self new string: aString
]

{ #category : #'instance creation' }
GtBoxerString class >> fromString: aString during: aBlock [
	^ self newDuring: [ :aBoxerString | aBlock value: (aBoxerString string: aString) ]
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
GtBoxerString class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_string_drop(void* aHandle))
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
		size: self size
]

{ #category : #accessing }
GtBoxerString >> length [
	<return: #Number>

	^ self primLength
]

{ #category : #'private - ffi' }
GtBoxerString >> primGetData [
	^ self ffiCall: #(void* boxer_string_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerString >> primLength [
	^ self ffiCall: #(size_t boxer_string_get_length(self))
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
		description: [ 'String must not be nil' ].

	"null-terminated utf-8 encoded string"
	anEncodedString := ByteArray streamContents: [ :aStream |
		ZnUTF8Encoder new 
			next: aString size 
			putAll: aString asString
			startingAt: 1 
			toStream: aStream.
		aStream nextPut: 0 ].
	
	GtBoxer
		externalArrayNewType: FFIUInt8
		size: anEncodedString size
		during: [ :anExternalArray |
			anExternalArray atAll: (1 to: anEncodedString size) putAll: anEncodedString.
			"anEncodedString size - 1 because we should not include a null char in amount of characters"
			self primSetData: anExternalArray getHandle length: (anEncodedString size - 1) ]
]
