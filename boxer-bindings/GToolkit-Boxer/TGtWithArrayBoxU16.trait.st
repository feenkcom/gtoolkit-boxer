Trait {
	#name : #TGtWithArrayBoxU16,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - array u16' }
TGtWithArrayBoxU16 classSide >> exampleArrayU16At [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayU16NewOfSizeWithAll.
	self assert: (anArray at: 1) equals: self exampleArrayU16DefaultValue.
	^ anArray
]

{ #category : #'examples - array u16' }
TGtWithArrayBoxU16 classSide >> exampleArrayU16AtPut [
	<gtExample>
	| anArray aNewValue |
	
	aNewValue := self exampleArrayU16DefaultValue.
	
	anArray := self exampleArrayU16NewOfSizeWithAll.
	anArray at: 1 put: aNewValue.
	self assert: (anArray at: 1) equals: aNewValue.
	^ anArray
]

{ #category : #'examples - array u16' }
TGtWithArrayBoxU16 classSide >> exampleArrayU16DefaultValue [
	<gtExample>
	
	^ 0
]

{ #category : #'examples - array u16' }
TGtWithArrayBoxU16 classSide >> exampleArrayU16LengthOfNull [
	"Make sure that the array api accepts and survives null address as an argument"
	<gtExample>
	| aLength |
	
	aLength := self uniqueInstance primArrayU16GetLength: ExternalAddress null.
	self
		assert: aLength
		equals: 0.

	^ aLength
]

{ #category : #'examples - array u16' }
TGtWithArrayBoxU16 classSide >> exampleArrayU16New [
	<gtExample>
	| anArray |

	anArray := self uniqueInstance newArrayU16.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - array u16' }
TGtWithArrayBoxU16 classSide >> exampleArrayU16NewOfSizeWithAll [
	<gtExample>
	| aDefaultValue anArray |
	
	aDefaultValue := self exampleArrayU16DefaultValue.
	anArray := self uniqueInstance
		newArrayU16: 100
		withAll: aDefaultValue.
		
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (Array new: 100 withAll: aDefaultValue). 
	
	^ anArray
]

{ #category : #'examples - array u16' }
TGtWithArrayBoxU16 classSide >> exampleArrayU16Release [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayU16New.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'api - array u16' }
TGtWithArrayBoxU16 >> newArrayU16 [
	^ GtArrayBoxU16
		fromOwnedHandle: self primArrayU16Create
		library: self
]

{ #category : #'api - array u16' }
TGtWithArrayBoxU16 >> newArrayU16: aSize withAll: aValue [
	"Answer an array of type `u16` with aSize of aValue elements"

	^ GtArrayBoxU16
		fromOwnedHandle: (self primArrayU16CreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array u16' }
TGtWithArrayBoxU16 >> newArrayU16During: aBlock [
	^ GtArrayBoxU16
		fromOwnedHandle: self primArrayU16Create
		library: self
		during: aBlock
]

{ #category : #'api - array u16' }
TGtWithArrayBoxU16 >> newArrayU16FromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxU16
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array u16' }
TGtWithArrayBoxU16 >> newArrayU16WithAll: aCollectionOfNumbers during: aBlock [
	"Create a new u16 array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxU16
		fromOwnedHandle: (self primArrayU16CreateNew: aCollectionOfNumbers size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfNumbers withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16: anArrayBoxU16 at: anIndex [
	^ self ffiCall: #(uint16 boxer_array_u16_at(
		GtArrayBoxU16 anArrayBoxU16,
		size_t anIndex))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16: anArrayBoxU16 at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u16_at_put(
		GtArrayBoxU16 anArrayBoxU16,
		size_t anIndex,
		uint16 anItem))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16: anArrayBoxU16 copyInto: anotherArrayBoxU16 [
	^ self ffiCall: #(void boxer_array_u16_copy_into(
		GtArrayBoxU16 anArrayBoxU16,
		GtArrayBoxU16 anotherArrayBoxU16))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16: anArrayBoxU16 copyIntoData: anExternalAddress length: aLength [
	^ self ffiCall: #(void boxer_array_u16_copy_into_data(
		GtArrayBoxU16 anArrayBoxU16,
		void* anExternalAddress,
		size_t aLength))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16Create [
	^ self ffiCall: #(void* boxer_array_u16_create())
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16CreateFromData: anExternalAddress length: aSize [
	^ self ffiCall: #(void* boxer_array_u16_create_from_data(
		void* anExternalAddress,
		size_t aSize))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16CreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u16_create_with(uint16 aValue, size_t aSize))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16GetCapacity: anArrayBoxU16 [
	^ self ffiCall: #(size_t boxer_array_u16_get_capacity(GtArrayBoxU16 anArrayBoxU16))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16GetData: anArrayBoxU16 [
	^ self ffiCall: #(void* boxer_array_u16_get_data(GtArrayBoxU16 anArrayBoxU16))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16GetLength: anArrayBoxU16 [
	^ self ffiCall: #(size_t boxer_array_u16_get_length(GtArrayBoxU16 anArrayBoxU16))
]

{ #category : #'private - array u16' }
TGtWithArrayBoxU16 >> primArrayU16Release: aHandle [
	self ffiCall: #(void boxer_array_u16_drop(void* aHandle))
]

{ #category : #'api - array u16' }
TGtWithArrayBoxU16 >> unsafeNewArrayU16FromData: anExternalAddress length: aLength [
	"Unsafe. Create an array from a given raw pointer to the data of given length.
	aLength is an amount of u16 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxU16
		fromOwnedHandle: (self primArrayU16CreateFromData: anExternalAddress length: aLength)
		library: self
]

{ #category : #'api - array u16' }
TGtWithArrayBoxU16 >> unsafeNewArrayU16FromData: anExternalAddress length: aLength during: aBlock [
	"Unsafe. Create an array from a given raw pointer to the data
	of given length for the duration of aBlock.
	aLength is an amount of u16 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxU16
		fromOwnedHandle: (self primArrayU16CreateFromData: anExternalAddress length: aLength)
		library: self
		during: aBlock
]
