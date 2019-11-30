Class {
	#name : #GtBoxerArrayU16,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerArrayU16 class >> fromByteArray: aByteArray [
	"I create a boxer array from a given byte array that own the data"
	<return: #GtBoxerArrayU16>
	| aBoxerArray |
	
	aBoxerArray := self new: aByteArray size // 2 withAll: 0.
	
	GtBoxer
		externalArrayNewType: FFIUInt8
		size: aByteArray size
		during: [ :anExternalArrayU8 |
			GtBoxer
				externalArrayFromHandle: anExternalArrayU8 getHandle
				type: FFIUInt16
				size: anExternalArrayU8 size // 2
				during: [ :anExternalArrayU16 |
					1 to: aBoxerArray size do: [ :anIndex | aBoxerArray at: anIndex put: (anExternalArrayU16 at: anIndex) ] ] ].
	
	^ aBoxerArray
]

{ #category : #'instance creation' }
GtBoxerArrayU16 class >> fromByteArray: aByteArray during: aBlock [
	"I create a boxer array that does not own a given data for duration of a block"
	| wasPinned |
	
	wasPinned := aByteArray pinInMemory.
	^ [ self fromHandle: aByteArray size: aByteArray size // 2 during: aBlock ]
		ensure: [ aByteArray setPinnedInMemory: wasPinned ]
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 class >> primCreate [
	^ self ffiCall: #(void* boxer_array_u16_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_u16_create_from_data(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u16_create_with(uint8 aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_u16_drop(void* aHandle))
]

{ #category : #converting }
GtBoxerArrayU16 >> asByteArray [
	<return: #ByteArray>
	| anExternalHandle |
	
	anExternalHandle := self primGetData getHandle.
	anExternalHandle isNull
		ifTrue: [ ^ #[] ].

	^ GtBoxer
		externalArrayFromHandle: self primGetData
		getHandle type: FFIUInt8
		size: self size * 2
		during: [ :anExternalArray | anExternalArray asByteArray ]
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> externalType [
	^ FFIUInt16
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> primAt: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u16_at_put(self, size_t anIndex, uint16 anItem))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_u16_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> primGetData [
	^ self ffiCall: #(void* boxer_array_u16_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_u16_get_length(self))
]
