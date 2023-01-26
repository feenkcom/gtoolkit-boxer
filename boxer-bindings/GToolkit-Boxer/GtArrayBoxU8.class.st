Class {
	#name : #GtArrayBoxU8,
	#superclass : #GtArrayBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #accessing }
GtArrayBoxU8 class >> byteSize: anAmountOfBytes [
	^ self primByteSize: anAmountOfBytes
]

{ #category : #'instance creation' }
GtArrayBoxU8 class >> fromBitmap: aBitmap during: aBlock [
	"I create a boxer array that does not own a given data for duration of a block"
	| wasPinned |
	
	wasPinned := aBitmap pinInMemory.
	^ [ self fromHandle: aBitmap size: aBitmap size * 4 during: aBlock ]
		ensure: [ aBitmap setPinnedInMemory: wasPinned ]
]

{ #category : #'instance creation' }
GtArrayBoxU8 class >> fromByteArray: aByteArray during: aBlock [
	"I create a boxer array that does not own a given data for duration of a block"
	| wasPinned |
	
	wasPinned := aByteArray pinInMemory.
	^ [ self fromHandle: aByteArray size: aByteArray size during: aBlock ]
		ensure: [ aByteArray setPinnedInMemory: wasPinned ]
]

{ #category : #'private - ffi' }
GtArrayBoxU8 class >> primByteSize: aCount [
	^ self ffiCall: #(size_t boxer_array_u8_byte_size(size_t aCount))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 class >> primCreate [
	^ self ffiCall: #(void* boxer_array_u8_create())
]

{ #category : #'private - ffi' }
GtArrayBoxU8 class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_u8_create_from_data(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u8_create_with(uint8 aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primArrayU8Release: aHandle
]

{ #category : #'instance creation' }
GtArrayBoxU8 class >> withAll: aCollectionOfBytes [
	| theBoxedBytes |
	
	theBoxedBytes := self new: aCollectionOfBytes size withAll: 0.0.
	aCollectionOfBytes withIndexDo: [ :eachByte :eachIndex | theBoxedBytes at: eachIndex put: eachByte ].

	^ theBoxedBytes
]

{ #category : #converting }
GtArrayBoxU8 >> argbToRgba [
	"in place transform me from argb to rgba"
	
	self primArgbToRgba
]

{ #category : #converting }
GtArrayBoxU8 >> asBitmap [
	| aBitmap |
	"The data must be in ARGB8888 format"
	
	aBitmap := Bitmap new: self size // 4.
	aBitmap copyFromByteArray: self asByteArray.

	^ aBitmap
]

{ #category : #converting }
GtArrayBoxU8 >> asByteArray [
	<return: #ByteArray>
	| aByteArray |
	
	aByteArray := ByteArray new: self size.
	self copyIntoByteArray: aByteArray.
	^ aByteArray
]

{ #category : #converting }
GtArrayBoxU8 >> bgraToArgb [
	"in place transform me from bgra to argb"
	
	self primBgraToArgb
]

{ #category : #copying }
GtArrayBoxU8 >> copyIntoByteArray: aByteArray [
	self ffiLibrary
		primArrayU8: self
		copyIntoData: aByteArray
		length: aByteArray size
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> externalType [
	^ FFIUInt8
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primArgbToRgba [
	^ self ffiCall: #(void boxer_array_u8_argb_to_rgba(self))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primAt: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u8_at_put(self, size_t anIndex, uint8 anItem))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primBgraToArgb [
	^ self ffiCall: #(void boxer_array_u8_bgra_to_argb(self))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primCopyInto: aGtBoxerArrayU8 [
	^ self ffiCall: #(void boxer_array_u8_copy_into(self, GtBoxerArrayU8 aGtBoxerArrayU8))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primGetCapacity [
	^ self ffiLibrary primArrayU8GetCapacity: self
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primGetData [
	^ self ffiLibrary primArrayU8GetData: self
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primGetLength [
	^ self ffiLibrary primArrayU8GetLength: self
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primRgbaToArgb [
	^ self ffiCall: #(void boxer_array_u8_rgba_to_argb(self))
]

{ #category : #converting }
GtArrayBoxU8 >> rgbaToArgb [
	"in place transform me from rgba to argb"
	
	self primRgbaToArgb
]
