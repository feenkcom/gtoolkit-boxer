Trait {
	#name : #TGtWithArrayBoxInt,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - array int' }
TGtWithArrayBoxInt classSide >> exampleArrayIntAt [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayIntNewOfSizeWithAll.
	self assert: (anArray at: 1) equals: self exampleArrayIntDefaultValue.
	^ anArray
]

{ #category : #'examples - array int' }
TGtWithArrayBoxInt classSide >> exampleArrayIntAtPut [
	<gtExample>
	| anArray aNewValue |
	
	aNewValue := self exampleArrayIntDefaultValue.
	
	anArray := self exampleArrayIntNewOfSizeWithAll.
	anArray at: 1 put: aNewValue.
	self assert: (anArray at: 1) equals: aNewValue.
	^ anArray
]

{ #category : #'examples - array int' }
TGtWithArrayBoxInt classSide >> exampleArrayIntDefaultValue [
	<gtExample>
	
	^ 0
]

{ #category : #'examples - array int' }
TGtWithArrayBoxInt classSide >> exampleArrayIntLengthOfNull [
	"Make sure that the array api accepts and survives null address as an argument"
	<gtExample>
	| aLength |
	
	aLength := self uniqueInstance primArrayIntGetLength: ExternalAddress null.
	self
		assert: aLength
		equals: 0.

	^ aLength
]

{ #category : #'examples - array int' }
TGtWithArrayBoxInt classSide >> exampleArrayIntNew [
	<gtExample>
	| anArray |

	anArray := self uniqueInstance newArrayInt.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - array int' }
TGtWithArrayBoxInt classSide >> exampleArrayIntNewOfSizeWithAll [
	<gtExample>
	| aDefaultValue anArray |
	
	aDefaultValue := self exampleArrayIntDefaultValue.
	anArray := self uniqueInstance
		newArrayInt: 100
		withAll: aDefaultValue.
		
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (Array new: 100 withAll: aDefaultValue). 
	
	^ anArray
]

{ #category : #'examples - array int' }
TGtWithArrayBoxInt classSide >> exampleArrayIntRelease [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayIntNew.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayInt [
	^ GtArrayBoxInt
		fromOwnedHandle: self primArrayIntCreate
		library: self
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayInt: aSize withAll: aValue [
	"Answer an array of type `int` with aSize of aValue elements"

	^ GtArrayBoxInt
		fromOwnedHandle: (self primArrayIntCreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayInt: aSize withAll: aValue during: aBlock [
	"Create an array of type `int` with aSize of aValue elements for the duration of aBlock"

	^ GtArrayBoxInt
		fromOwnedHandle: (self primArrayIntCreateNew: aSize withAll: aValue)
		library: self
		during: aBlock
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayIntDuring: aBlock [
	^ GtArrayBoxInt
		fromOwnedHandle: self primArrayIntCreate
		library: self
		during: aBlock
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayIntFromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxInt
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> newArrayIntWithAll: aCollectionOfItems during: aBlock [
	"Create a new int array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxInt
		fromOwnedHandle: (self primArrayIntCreateNew: aCollectionOfItems size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfItems withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayInt: anArrayBoxInt at: anIndex [
	^ self ffiCall: #(int boxer_array_int_at(
		GtArrayBoxInt anArrayBoxInt,
		size_t anIndex))
]

{ #category : #'private - array int' }
TGtWithArrayBoxInt >> primArrayInt: anArrayBoxInt at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_int_at_put(
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
TGtWithArrayBoxInt >> primArrayIntCreateFromData: anExternalAddress length: aSize [
	^ self ffiCall: #(void* boxer_array_int_create_from_data(
		void* anExternalAddress,
		size_t aSize))
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

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> unsafeNewArrayIntFromData: anExternalAddress length: aLength [
	"Unsafe. Create an array from a given raw pointer to the data of given length.
	aLength is an amount of int elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxInt
		fromOwnedHandle: (self primArrayIntCreateFromData: anExternalAddress length: aLength)
		library: self
]

{ #category : #'api - array int' }
TGtWithArrayBoxInt >> unsafeNewArrayIntFromData: anExternalAddress length: aLength during: aBlock [
	"Unsafe. Create an array from a given raw pointer to the data
	of given length for the duration of aBlock.
	aLength is an amount of int elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxInt
		fromOwnedHandle: (self primArrayIntCreateFromData: anExternalAddress length: aLength)
		library: self
		during: aBlock
]
