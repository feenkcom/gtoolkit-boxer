Trait {
	#name : #TGtWithArrayBoxU8,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8 [
	^ GtArrayBoxU8
		fromOwnedHandle: self primArrayU8Create
		library: self
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8: aSize withAll: aValue [
	"Answer an instance of an uint8 array, with aSize of aValue elements"

	^ GtArrayBoxU8
		fromOwnedHandle: (self primArrayU8CreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8FromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxU8
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8WithAll: aCollectionOfNumbers during: aBlock [
	"Create a new uint8 array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxU8
		fromOwnedHandle: (self primArrayU8CreateNew: aCollectionOfNumbers size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfNumbers withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8: anArrayBoxU8 at: anIndex [
	^ self ffiCall: #(void boxer_array_u8_at(
		GtArrayBoxU8 anArrayBoxU8,
		size_t anIndex))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8: anArrayBoxU8 at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u8_at(
		GtArrayBoxU8 anArrayBoxU8,
		size_t anIndex,
		uint8 anItem))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8: anArrayBoxU8 copyInto: anotherArrayBoxU8 [
	^ self ffiCall: #(void boxer_array_u8_copy_into(
		GtArrayBoxU8 anArrayBoxU8,
		GtArrayBoxU8 anotherArrayBoxU8))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8: anArrayBoxU8 copyIntoData: anExternalAddress length: aLength [
	^ self ffiCall: #(void boxer_array_u8_copy_into_data(
		GtArrayBoxU8 anArrayBoxU8,
		void* anExternalAddress,
		size_t aLength))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8Create [
	^ self ffiCall: #(void* boxer_array_u8_create())
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8CreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u8_create_with(uint8 aValue, size_t aSize))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8GetCapacity: anArrayBoxU8 [
	^ self ffiCall: #(size_t boxer_array_u8_get_capacity(GtArrayBoxU8 anArrayBoxU8))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8GetData: anArrayBoxU8 [
	^ self ffiCall: #(void* boxer_array_u8_get_data(GtArrayBoxU8 anArrayBoxU8))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8GetLength: anArrayBoxU8 [
	^ self ffiCall: #(size_t boxer_array_u8_get_length(GtArrayBoxU8 anArrayBoxU8))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8Release: aHandle [
	self ffiCall: #(void boxer_array_u8_drop(void* aHandle))
]
