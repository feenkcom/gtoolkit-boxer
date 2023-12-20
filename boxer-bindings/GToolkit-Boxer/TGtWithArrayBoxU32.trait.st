Trait {
	#name : #TGtWithArrayBoxU32,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - array u32' }
TGtWithArrayBoxU32 classSide >> exampleArrayU32At [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayU32NewOfSizeWithAll.
	self assert: (anArray at: 1) equals: self exampleArrayU32DefaultValue.
	^ anArray
]

{ #category : #'examples - array u32' }
TGtWithArrayBoxU32 classSide >> exampleArrayU32AtPut [
	<gtExample>
	| anArray aNewValue |
	
	aNewValue := self exampleArrayU32DefaultValue.
	
	anArray := self exampleArrayU32NewOfSizeWithAll.
	anArray at: 1 put: aNewValue.
	self assert: (anArray at: 1) equals: aNewValue.
	^ anArray
]

{ #category : #'examples - array u32' }
TGtWithArrayBoxU32 classSide >> exampleArrayU32DefaultValue [
	<gtExample>
	
	^ 0
]

{ #category : #'examples - array u32' }
TGtWithArrayBoxU32 classSide >> exampleArrayU32LengthOfNull [
	"Make sure that the array api accepts and survives null address as an argument"
	<gtExample>
	| aLength |
	
	aLength := self uniqueInstance primArrayU32GetLength: ExternalAddress null.
	self
		assert: aLength
		equals: 0.

	^ aLength
]

{ #category : #'examples - array u32' }
TGtWithArrayBoxU32 classSide >> exampleArrayU32New [
	<gtExample>
	| anArray |

	anArray := self uniqueInstance newArrayU32.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - array u32' }
TGtWithArrayBoxU32 classSide >> exampleArrayU32NewOfSizeWithAll [
	<gtExample>
	| aDefaultValue anArray |
	
	aDefaultValue := self exampleArrayU32DefaultValue.
	anArray := self uniqueInstance
		newArrayU32: 100
		withAll: aDefaultValue.
		
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (Array new: 100 withAll: aDefaultValue). 
	
	^ anArray
]

{ #category : #'examples - array u32' }
TGtWithArrayBoxU32 classSide >> exampleArrayU32Release [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayU32New.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> newArrayU32 [
	^ GtArrayBoxU32
		fromOwnedHandle: self primArrayU32Create
		library: self
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> newArrayU32: aSize withAll: aValue [
	"Answer an array of type `u32` with aSize of aValue elements"

	^ GtArrayBoxU32
		fromOwnedHandle: (self primArrayU32CreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> newArrayU32: aSize withAll: aValue during: aBlock [
	"Create an array of type `u32` with aSize of aValue elements for the duration of aBlock"

	^ GtArrayBoxU32
		fromOwnedHandle: (self primArrayU32CreateNew: aSize withAll: aValue)
		library: self
		during: aBlock
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> newArrayU32During: aBlock [
	^ GtArrayBoxU32
		fromOwnedHandle: self primArrayU32Create
		library: self
		during: aBlock
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> newArrayU32FromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxU32
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> newArrayU32WithAll: aCollectionOfItems during: aBlock [
	"Create a new u32 array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxU32
		fromOwnedHandle: (self primArrayU32CreateNew: aCollectionOfItems size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfItems withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32: anArrayBoxU32 at: anIndex [
	^ self ffiCall: #(uint32 boxer_array_u32_at(
		GtArrayBoxU32 anArrayBoxU32,
		size_t anIndex))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32: anArrayBoxU32 at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u32_at_put(
		GtArrayBoxU32 anArrayBoxU32,
		size_t anIndex,
		uint32 anItem))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32: anArrayBoxU32 copyInto: anotherArrayBoxU32 [
	^ self ffiCall: #(void boxer_array_u32_copy_into(
		GtArrayBoxU32 anArrayBoxU32,
		GtArrayBoxU32 anotherArrayBoxU32))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32Create [
	^ self ffiCall: #(void* boxer_array_u32_create())
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32CreateFromData: anExternalAddress length: aSize [
	^ self ffiCall: #(void* boxer_array_u32_create_from_data(
		void* anExternalAddress,
		size_t aSize))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32CreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u32_create_with(uint32 aValue, size_t aSize))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32GetCapacity: anArrayBoxU32 [
	^ self ffiCall: #(size_t boxer_array_u32_get_capacity(GtArrayBoxU32 anArrayBoxU32))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32GetData: anArrayBoxU32 [
	^ self ffiCall: #(void* boxer_array_u32_get_data(GtArrayBoxU32 anArrayBoxU32))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32GetLength: anArrayBoxU32 [
	^ self ffiCall: #(size_t boxer_array_u32_get_length(GtArrayBoxU32 anArrayBoxU32))
]

{ #category : #'private - array u32' }
TGtWithArrayBoxU32 >> primArrayU32Release: aHandle [
	self ffiCall: #(void boxer_array_u32_drop(void* aHandle))
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> unsafeNewArrayU32FromData: anExternalAddress length: aLength [
	"Unsafe. Create an array from a given raw pointer to the data of given length.
	aLength is an amount of u32 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxU32
		fromOwnedHandle: (self primArrayU32CreateFromData: anExternalAddress length: aLength)
		library: self
]

{ #category : #'api - array u32' }
TGtWithArrayBoxU32 >> unsafeNewArrayU32FromData: anExternalAddress length: aLength during: aBlock [
	"Unsafe. Create an array from a given raw pointer to the data
	of given length for the duration of aBlock.
	aLength is an amount of u32 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxU32
		fromOwnedHandle: (self primArrayU32CreateFromData: anExternalAddress length: aLength)
		library: self
		during: aBlock
]
