Trait {
	#name : #TGtWithArrayBoxU8,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - array u8' }
TGtWithArrayBoxU8 classSide >> exampleArrayU8At [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayU8NewOfSizeWithAll.
	self assert: (anArray at: 1) equals: self exampleArrayU8DefaultValue.
	^ anArray
]

{ #category : #'examples - array u8' }
TGtWithArrayBoxU8 classSide >> exampleArrayU8AtPut [
	<gtExample>
	| anArray aNewValue |
	
	aNewValue := self exampleArrayU8DefaultValue.
	
	anArray := self exampleArrayU8NewOfSizeWithAll.
	anArray at: 1 put: aNewValue.
	self assert: (anArray at: 1) equals: aNewValue.
	^ anArray
]

{ #category : #'examples - array u8' }
TGtWithArrayBoxU8 classSide >> exampleArrayU8DefaultValue [
	<gtExample>
	
	^ 0
]

{ #category : #'examples - array u8' }
TGtWithArrayBoxU8 classSide >> exampleArrayU8LengthOfNull [
	"Make sure that the array api accepts and survives null address as an argument"
	<gtExample>
	| aLength |
	
	aLength := self uniqueInstance primArrayU8GetLength: ExternalAddress null.
	self
		assert: aLength
		equals: 0.

	^ aLength
]

{ #category : #'examples - array u8' }
TGtWithArrayBoxU8 classSide >> exampleArrayU8New [
	<gtExample>
	| anArray |

	anArray := self uniqueInstance newArrayU8.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - array u8' }
TGtWithArrayBoxU8 classSide >> exampleArrayU8NewOfSizeWithAll [
	<gtExample>
	| aDefaultValue anArray |
	
	aDefaultValue := self exampleArrayU8DefaultValue.
	anArray := self uniqueInstance
		newArrayU8: 100
		withAll: aDefaultValue.
		
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (Array new: 100 withAll: aDefaultValue). 
	
	^ anArray
]

{ #category : #'examples - array u8' }
TGtWithArrayBoxU8 classSide >> exampleArrayU8Release [
	<gtExample>
	| anArray |
	
	anArray := self exampleArrayU8New.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8 [
	^ GtArrayBoxU8
		fromOwnedHandle: self primArrayU8Create
		library: self
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8: aSize withAll: aValue [
	"Answer an array of type `u8` with aSize of aValue elements"

	^ GtArrayBoxU8
		fromOwnedHandle: (self primArrayU8CreateNew: aSize withAll: aValue)
		library: self
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8: aSize withAll: aValue during: aBlock [
	"Create an array of type `u8` with aSize of aValue elements for the duration of aBlock"

	^ GtArrayBoxU8
		fromOwnedHandle: (self primArrayU8CreateNew: aSize withAll: aValue)
		library: self
		during: aBlock
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8During: aBlock [
	^ GtArrayBoxU8
		fromOwnedHandle: self primArrayU8Create
		library: self
		during: aBlock
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8FromBitmap: aBitmap during: aBlock [
	"Create an ArrayU8 from a given Bitmap for duration of a block.
	Please note that the Bitmap is not copied, therefore we pin it for the
	duration of aBlock"
	| wasPinned |
	
	wasPinned := aBitmap pinInMemory.
	^ [ self
			unsafeNewArrayU8FromData: aBitmap
			length: aBitmap size * 4
			during: aBlock ]
		ensure: [ aBitmap setPinnedInMemory: wasPinned ]
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8FromByteArray: aByteArray during: aBlock [
	"Create an ArrayU8 from a given ByteArray for duration of a block.
	Please note that the ByteArray is not copied, therefore we pin it for the
	duration of aBlock"
	| wasPinned |
	
	wasPinned := aByteArray pinInMemory.
	^ [ self
			unsafeNewArrayU8FromData: aByteArray
			length: aByteArray size
			during: aBlock ]
		ensure: [ aByteArray setPinnedInMemory: wasPinned ]
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8FromHandle: anExternalAddress during: aBlock [
	^ GtArrayBoxU8
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> newArrayU8WithAll: aCollectionOfItems during: aBlock [
	"Create a new u8 array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBoxU8
		fromOwnedHandle: (self primArrayU8CreateNew: aCollectionOfItems size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfItems withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8: anArrayBoxU8 at: anIndex [
	^ self ffiCall: #(uint8 boxer_array_u8_at(
		GtArrayBoxU8 anArrayBoxU8,
		size_t anIndex))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8: anArrayBoxU8 at: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_u8_at_put(
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
TGtWithArrayBoxU8 >> primArrayU8CreateFromData: anExternalAddress length: aSize [
	^ self ffiCall: #(void* boxer_array_u8_create_from_data(
		void* anExternalAddress,
		size_t aSize))
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

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> unsafeNewArrayU8FromData: anExternalAddress length: aLength [
	"Unsafe. Create an array from a given raw pointer to the data of given length.
	aLength is an amount of u8 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxU8
		fromOwnedHandle: (self primArrayU8CreateFromData: anExternalAddress length: aLength)
		library: self
]

{ #category : #'api - array u8' }
TGtWithArrayBoxU8 >> unsafeNewArrayU8FromData: anExternalAddress length: aLength during: aBlock [
	"Unsafe. Create an array from a given raw pointer to the data
	of given length for the duration of aBlock.
	aLength is an amount of u8 elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBoxU8
		fromOwnedHandle: (self primArrayU8CreateFromData: anExternalAddress length: aLength)
		library: self
		during: aBlock
]
