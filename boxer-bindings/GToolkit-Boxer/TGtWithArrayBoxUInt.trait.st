Trait {
	#name : #TGtWithArrayBoxUInt,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - array uint' }
TGtWithArrayBoxUInt classSide >> exampleArrayUIntAt [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayUIntNewOfSizeWithAll.
	self assert: (anArray at: 1) equals: self exampleArrayUIntDefaultValue.
	^ anArray
]

{ #category : #'examples - array uint' }
TGtWithArrayBoxUInt classSide >> exampleArrayUIntAtPut [
	<gtExample>
	| anArray aNewValue |
	
	aNewValue := self exampleArrayUIntDefaultValue.
	
	anArray := self exampleArrayUIntNewOfSizeWithAll.
	anArray at: 1 put: aNewValue.
	self assert: (anArray at: 1) equals: aNewValue.
	^ anArray
]

{ #category : #'examples - array uint' }
TGtWithArrayBoxUInt classSide >> exampleArrayUIntDefaultValue [
	<gtExample>
	
	^ 0
]

{ #category : #'examples - array uint' }
TGtWithArrayBoxUInt classSide >> exampleArrayUIntLengthOfNull [
	"Make sure that the array api accepts and survives null address as an argument"
	<gtExample>
	| aLength |
	
	aLength := self uniqueInstance primArrayUIntGetLength: ExternalAddress null.
	self
		assert: aLength
		equals: 0.

	^ aLength
]

{ #category : #'examples - array uint' }
TGtWithArrayBoxUInt classSide >> exampleArrayUIntNew [
	<gtExample>
	| anArray |

	anArray := self uniqueInstance newArrayUInt.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - array uint' }
TGtWithArrayBoxUInt classSide >> exampleArrayUIntNewOfSizeWithAll [
	<gtExample>
	| aDefaultValue anArray |
	
	aDefaultValue := self exampleArrayUIntDefaultValue.
	anArray := self uniqueInstance
		newArrayUInt: 100
		withAll: aDefaultValue.
		
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (Array new: 100 withAll: aDefaultValue). 
	
	^ anArray
]

{ #category : #'examples - array uint' }
TGtWithArrayBoxUInt classSide >> exampleArrayUIntRelease [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayUIntNew.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

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
TGtWithArrayBoxUInt >> newArrayUInt: aSize withAll: aValue during: aBlock [
	"Create an array of type `uint` with aSize of aValue elements for the duration of aBlock"

	^ GtArrayBoxUInt
		fromOwnedHandle: (self primArrayUIntCreateNew: aSize withAll: aValue)
		library: self
		during: aBlock
]

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> newArrayUIntDuring: aBlock [
	^ GtArrayBoxUInt
		fromOwnedHandle: self primArrayUIntCreate
		library: self
		during: aBlock
]

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> newArrayUIntFromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxUInt
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> newArrayUIntWithAll: aCollectionOfItems during: aBlock [
	"Create a new uint array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxUInt
		fromOwnedHandle: (self primArrayUIntCreateNew: aCollectionOfItems size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfItems withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUInt: anArrayBoxUInt at: anIndex [
	^ self ffiCall: #(uint boxer_array_uint_at(
		GtArrayBoxUInt anArrayBoxUInt,
		size_t anIndex))
]

{ #category : #'private - array uint' }
TGtWithArrayBoxUInt >> primArrayUInt: anArrayBoxUInt at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_uint_at_put(
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
TGtWithArrayBoxUInt >> primArrayUIntCreateFromData: anExternalAddress length: aSize [
	^ self ffiCall: #(void* boxer_array_uint_create_from_data(
		void* anExternalAddress,
		size_t aSize))
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

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> unsafeNewArrayUIntFromData: anExternalAddress length: aLength [
	"Unsafe. Create an array from a given raw pointer to the data of given length.
	aLength is an amount of uint elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxUInt
		fromOwnedHandle: (self primArrayUIntCreateFromData: anExternalAddress length: aLength)
		library: self
]

{ #category : #'api - array uint' }
TGtWithArrayBoxUInt >> unsafeNewArrayUIntFromData: anExternalAddress length: aLength during: aBlock [
	"Unsafe. Create an array from a given raw pointer to the data
	of given length for the duration of aBlock.
	aLength is an amount of uint elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxUInt
		fromOwnedHandle: (self primArrayUIntCreateFromData: anExternalAddress length: aLength)
		library: self
		during: aBlock
]
