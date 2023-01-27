Trait {
	#name : #TGtWithArrayBoxInt,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayInt [
	^ GtArrayBoxInt
		fromOwnedHandle: self primArrayIntCreate
		library: self
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayInt: aSize withAll: aValue [
	"Answer an instance of an int array, with aSize of aValue elements"

	^ GtArrayBoxInt
		fromOwnedHandle: (self primArrayIntCreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayIntFromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxInt
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayIntWithAll: aCollectionOfNumbers during: aBlock [
	"Create a new int array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxInt
		fromOwnedHandle: (self primArrayIntCreateNew: aCollectionOfNumbers size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfNumbers withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayInt: anArrayBoxInt at: anIndex [
	^ self ffiCall: #(void boxer_array_int_at(
		GtArrayBoxInt anArrayBoxInt,
		size_t anIndex))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayInt: anArrayBoxInt at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_int_at(
		GtArrayBoxInt anArrayBoxInt,
		size_t anIndex,
		int anItem))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayInt: anArrayBoxInt copyInto: anotherArrayBoxInt [
	^ self ffiCall: #(void boxer_array_int_copy_into(
		GtArrayBoxInt anArrayBoxInt,
		GtArrayBoxInt anotherArrayBoxInt))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayIntCreate [
	^ self ffiCall: #(void* boxer_array_int_create())
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayIntCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_int_create_with(int aValue, size_t aSize))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayIntGetCapacity: anArrayBoxInt [
	^ self ffiCall: #(size_t boxer_array_int_get_capacity(GtArrayBoxInt anArrayBoxInt))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayIntGetData: anArrayBoxInt [
	^ self ffiCall: #(void* boxer_array_int_get_data(GtArrayBoxInt anArrayBoxInt))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayIntGetLength: anArrayBoxInt [
	^ self ffiCall: #(size_t boxer_array_int_get_length(GtArrayBoxInt anArrayBoxInt))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayIntRelease: aHandle [
	self ffiCall: #(void boxer_array_int_drop(void* aHandle))
]
