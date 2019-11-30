Class {
	#name : #GtBoxerArrayU8,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerArrayU8 class >> fromBitmap: aBitmap during: aBlock [
	"I create a boxer array that does not own a given data for duration of a block"
	| wasPinned |
	
	wasPinned := aBitmap pinInMemory.
	^ [ self fromHandle: aBitmap size: aBitmap size * 4 during: aBlock ]
		ensure: [ aBitmap setPinnedInMemory: wasPinned ]
]

{ #category : #'instance creation' }
GtBoxerArrayU8 class >> fromByteArray: aByteArray during: aBlock [
	"I create a boxer array that does not own a given data for duration of a block"
	| wasPinned |
	
	wasPinned := aByteArray pinInMemory.
	^ [ self fromHandle: aByteArray size: aByteArray size during: aBlock ]
		ensure: [ aByteArray setPinnedInMemory: wasPinned ]
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 class >> primCreate [
	^ self ffiCall: #(void* boxer_array_u8_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_u8_create_from_data(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u8_create_with(uint8 aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_u8_drop(void* aHandle))
]

{ #category : #'instance creation' }
GtBoxerArrayU8 class >> withAll: aCollectionOfBytes [
	| theBoxedBytes |
	
	theBoxedBytes := self new: aCollectionOfBytes size withAll: 0.0.
	aCollectionOfBytes withIndexDo: [ :eachByte :eachIndex | theBoxedBytes at: eachIndex put: eachByte ].

	^ theBoxedBytes
]

{ #category : #converting }
GtBoxerArrayU8 >> argbToRgba [
	"in place transform me from argb to rgba"
	
	self primArgbToRgba
]

{ #category : #converting }
GtBoxerArrayU8 >> asBitmap [
	| aBitmap |
	"The data must be in ARGB8888 format"
	
	aBitmap := Bitmap new: self size // 4.
	aBitmap copyFromByteArray: self asByteArray.

	^ aBitmap
]

{ #category : #converting }
GtBoxerArrayU8 >> asByteArray [
	^ self data asByteArray
]

{ #category : #converting }
GtBoxerArrayU8 >> bgraToArgb [
	"in place transform me from bgra to argb"
	
	self primBgraToArgb
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> externalType [
	^ FFIUInt8
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primArgbToRgba [
	^ self ffiCall: #(void boxer_array_u8_argb_to_rgba(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primAt: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u8_at_put(self, size_t anIndex, uint8 anItem))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primBgraToArgb [
	^ self ffiCall: #(void boxer_array_u8_bgra_to_argb(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_u8_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primGetData [
	^ self ffiCall: #(void* boxer_array_u8_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_u8_get_length(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primRgbaToArgb [
	^ self ffiCall: #(void boxer_array_u8_rgba_to_argb(self))
]

{ #category : #converting }
GtBoxerArrayU8 >> rgbaToArgb [
	"in place transform me from rgba to argb"
	
	self primBgraToArgb
]
