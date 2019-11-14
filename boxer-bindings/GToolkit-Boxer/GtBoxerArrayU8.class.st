Class {
	#name : #GtBoxerArrayU8,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

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
GtBoxerArrayU8 >> asBitmap [
	| aByteArray alphaIndex blueIndex greenIndex redIndex red green blue alpha aBitmap |
	aByteArray := self asByteArray.
	
	"We should convert RGBA to ARGB"	
	1 to: aByteArray size // 4 do: [ :index |
		alphaIndex := 4 * index.
		blueIndex := alphaIndex - 1.
		greenIndex := blueIndex - 1.
		redIndex := greenIndex - 1.
		
		red := aByteArray at: redIndex.
		green := aByteArray at: greenIndex.
		blue := aByteArray at: blueIndex.
		alpha := aByteArray at: alphaIndex.
		
		aByteArray at: redIndex put: alpha.
		aByteArray at: greenIndex put: red.
		aByteArray at: blueIndex put: green.
		aByteArray at: alphaIndex put: blue ].

	aBitmap := Bitmap new: aByteArray size // 4.
	aBitmap copyFromByteArray: aByteArray.

	^ aBitmap
]

{ #category : #converting }
GtBoxerArrayU8 >> asByteArray [
	^ self data asByteArray
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> externalType [
	^ FFIUInt8 externalType
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primAt: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u8_at_put(self, size_t anIndex, uint8 anItem))
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
