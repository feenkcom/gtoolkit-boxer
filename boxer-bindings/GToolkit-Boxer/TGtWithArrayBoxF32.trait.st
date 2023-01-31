Trait {
	#name : #TGtWithArrayBoxF32,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - array f32' }
TGtWithArrayBoxF32 classSide >> exampleArrayF32At [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayF32NewOfSizeWithAll.
	self assert: (anArray at: 1) equals: self exampleArrayF32DefaultValue.
	^ anArray
]

{ #category : #'examples - array f32' }
TGtWithArrayBoxF32 classSide >> exampleArrayF32AtPut [
	<gtExample>
	| anArray aNewValue |
	
	aNewValue := self exampleArrayF32DefaultValue.
	
	anArray := self exampleArrayF32NewOfSizeWithAll.
	anArray at: 1 put: aNewValue.
	self assert: (anArray at: 1) equals: aNewValue.
	^ anArray
]

{ #category : #'examples - array f32' }
TGtWithArrayBoxF32 classSide >> exampleArrayF32DefaultValue [
	<gtExample>
	
	^ 0
]

{ #category : #'examples - array f32' }
TGtWithArrayBoxF32 classSide >> exampleArrayF32LengthOfNull [
	"Make sure that the array api accepts and survives null address as an argument"
	<gtExample>
	| aLength |
	
	aLength := self uniqueInstance primArrayF32GetLength: ExternalAddress null.
	self
		assert: aLength
		equals: 0.

	^ aLength
]

{ #category : #'examples - array f32' }
TGtWithArrayBoxF32 classSide >> exampleArrayF32New [
	<gtExample>
	| anArray |

	anArray := self uniqueInstance newArrayF32.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - array f32' }
TGtWithArrayBoxF32 classSide >> exampleArrayF32NewOfSizeWithAll [
	<gtExample>
	| aDefaultValue anArray |
	
	aDefaultValue := self exampleArrayF32DefaultValue.
	anArray := self uniqueInstance
		newArrayF32: 100
		withAll: aDefaultValue.
		
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (Array new: 100 withAll: aDefaultValue). 
	
	^ anArray
]

{ #category : #'examples - array f32' }
TGtWithArrayBoxF32 classSide >> exampleArrayF32Release [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayF32New.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> newArrayF32 [
	^ GtArrayBoxF32
		fromOwnedHandle: self primArrayF32Create
		library: self
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> newArrayF32: aSize withAll: aValue [
	"Answer an array of type `f32` with aSize of aValue elements"

	^ GtArrayBoxF32
		fromOwnedHandle: (self primArrayF32CreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> newArrayF32: aSize withAll: aValue during: aBlock [
	"Create an array of type `f32` with aSize of aValue elements for the duration of aBlock"

	^ GtArrayBoxF32
		fromOwnedHandle: (self primArrayF32CreateNew: aSize withAll: aValue)
		library: self
		during: aBlock
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> newArrayF32During: aBlock [
	^ GtArrayBoxF32
		fromOwnedHandle: self primArrayF32Create
		library: self
		during: aBlock
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> newArrayF32FromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxF32
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> newArrayF32WithAll: aCollectionOfItems during: aBlock [
	"Create a new f32 array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxF32
		fromOwnedHandle: (self primArrayF32CreateNew: aCollectionOfItems size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfItems withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32: anArrayBoxF32 at: anIndex [
	^ self ffiCall: #(float32 boxer_array_f32_at(
		GtArrayBoxF32 anArrayBoxF32,
		size_t anIndex))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32: anArrayBoxF32 at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_f32_at_put(
		GtArrayBoxF32 anArrayBoxF32,
		size_t anIndex,
		float32 anItem))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32: anArrayBoxF32 copyInto: anotherArrayBoxF32 [
	^ self ffiCall: #(void boxer_array_f32_copy_into(
		GtArrayBoxF32 anArrayBoxF32,
		GtArrayBoxF32 anotherArrayBoxF32))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32Create [
	^ self ffiCall: #(void* boxer_array_f32_create())
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32CreateFromData: anExternalAddress length: aSize [
	^ self ffiCall: #(void* boxer_array_f32_create_from_data(
		void* anExternalAddress,
		size_t aSize))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32CreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_f32_create_with(float32 aValue, size_t aSize))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32GetCapacity: anArrayBoxF32 [
	^ self ffiCall: #(size_t boxer_array_f32_get_capacity(GtArrayBoxF32 anArrayBoxF32))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32GetData: anArrayBoxF32 [
	^ self ffiCall: #(void* boxer_array_f32_get_data(GtArrayBoxF32 anArrayBoxF32))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32GetLength: anArrayBoxF32 [
	^ self ffiCall: #(size_t boxer_array_f32_get_length(GtArrayBoxF32 anArrayBoxF32))
]

{ #category : #'private - array f32' }
TGtWithArrayBoxF32 >> primArrayF32Release: aHandle [
	self ffiCall: #(void boxer_array_f32_drop(void* aHandle))
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> unsafeNewArrayF32FromData: anExternalAddress length: aLength [
	"Unsafe. Create an array from a given raw pointer to the data of given length.
	aLength is an amount of f32 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxF32
		fromOwnedHandle: (self primArrayF32CreateFromData: anExternalAddress length: aLength)
		library: self
]

{ #category : #'api - array f32' }
TGtWithArrayBoxF32 >> unsafeNewArrayF32FromData: anExternalAddress length: aLength during: aBlock [
	"Unsafe. Create an array from a given raw pointer to the data
	of given length for the duration of aBlock.
	aLength is an amount of f32 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxF32
		fromOwnedHandle: (self primArrayF32CreateFromData: anExternalAddress length: aLength)
		library: self
		during: aBlock
]
