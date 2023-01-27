Trait {
	#name : #TGtWithArrayBoxUInt,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> newArrayUInt [
	^ GtArrayBoxUInt
		fromOwnedHandle: self primArrayUIntCreate
		library: self
]

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> newArrayUInt: aSize withAll: aValue [
	"Answer an array of type `uint` with aSize of aValue elements"

	^ GtArrayBoxUInt
		fromOwnedHandle: (self primArrayUIntCreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> newArrayUIntFromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxUInt
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> newArrayUIntWithAll: aCollectionOfNumbers during: aBlock [
	"Create a new uint array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxUInt
		fromOwnedHandle: (self primArrayUIntCreateNew: aCollectionOfNumbers size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfNumbers withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUInt: anArrayBoxUInt at: anIndex [
	^ self ffiCall: #(void boxer_array_uint_at(
		GtArrayBoxUInt anArrayBoxUInt,
		size_t anIndex))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUInt: anArrayBoxUInt at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_uint_at(
		GtArrayBoxUInt anArrayBoxUInt,
		size_t anIndex,
		uint anItem))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUInt: anArrayBoxUInt copyInto: anotherArrayBoxUInt [
	^ self ffiCall: #(void boxer_array_uint_copy_into(
		GtArrayBoxUInt anArrayBoxUInt,
		GtArrayBoxUInt anotherArrayBoxUInt))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUIntCreate [
	^ self ffiCall: #(void* boxer_array_uint_create())
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUIntCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_uint_create_with(uint aValue, size_t aSize))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUIntGetCapacity: anArrayBoxUInt [
	^ self ffiCall: #(size_t boxer_array_uint_get_capacity(GtArrayBoxUInt anArrayBoxUInt))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUIntGetData: anArrayBoxUInt [
	^ self ffiCall: #(void* boxer_array_uint_get_data(GtArrayBoxUInt anArrayBoxUInt))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUIntGetLength: anArrayBoxUInt [
	^ self ffiCall: #(size_t boxer_array_uint_get_length(GtArrayBoxUInt anArrayBoxUInt))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUIntRelease: aHandle [
	self ffiCall: #(void boxer_array_uint_drop(void* aHandle))
]
