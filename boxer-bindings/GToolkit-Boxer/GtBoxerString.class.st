Class {
	#name : #GtBoxerString,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerString class >> fromString: aString [
	^ self new string: aString
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
GtBoxerString >> string [
	"Return UTF-8 decoded string"
	<return: #String>
	| aLength aBuffer |
	
	aLength := self length.
	aLength isZero
		ifTrue: [ ^ '' ].
	
	"memory is handled by rust"
	aBuffer := FFIExternalArray fromHandle: self primGetData getHandle type: FFIUInt8 externalType size: aLength + 1.

	^ ZnCharacterEncoder utf8 decodeBytes: aBuffer asArray allButLast
]

{ #category : #accessing }
GtBoxerString >> string: aString [
	| anEncodedString aBuffer |

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
	
	aBuffer := FFIExternalArray externalNewType: FFIUInt8 externalType size: anEncodedString size.
	aBuffer atAll: (1 to: anEncodedString size) putAll: anEncodedString.
	[ self primSetData: aBuffer getHandle length: (anEncodedString size - 1) ]
		ensure: [ aBuffer free ]
]
