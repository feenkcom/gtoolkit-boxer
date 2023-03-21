Trait {
	#name : #TGtWithStringBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - string' }
TGtWithStringBox classSide >> exampleStringNewByteString [
	<gtExample>
	| byteString stringBox boxedString |
	
	byteString := String withAll: 'Hello'.

	self assert: byteString isPinnedInMemory not.
	stringBox := self uniqueInstance newString: byteString.
	self assert: byteString isPinnedInMemory not.
	
	boxedString := stringBox string.
	self assert: boxedString equals: byteString.
	self assert: boxedString isPinnedInMemory not.
	
	^ stringBox
]

{ #category : #'api - string box' }
TGtWithStringBox >> getStringFrom: aBlock [
	<return: #String>
	| aString |

	aString := ''.

	self newStringDuring: [ :aBoxerString |
		aBlock value: aBoxerString.
		aString := aBoxerString string ].

	^ aString
]

{ #category : #'api - string box' }
TGtWithStringBox >> newString [
	^ GtStringBox
		fromOwnedHandle: self primStringCreate
		library: self
]

{ #category : #'api - string box' }
TGtWithStringBox >> newString: aString [
	"Create a StringBox from a copy of the given string.
	Please note, that the returned StringBox is registered as #autoRelease.
	Consider using #newString:during: which only instantiates a StringBox for a duration of a BlockClosure"
	<return: #GtStringBox>
	self
		assert: [ aString isNotNil ]
		description: [ 'String must not be nil' ].

	^ GtStringBox
		fromOwnedHandle: (self primStringHandleFromString: aString)
		library: self
]

{ #category : #'api - string box' }
TGtWithStringBox >> newString: aString during: aBlock [
	^ GtStringBox
		fromOwnedHandle: (self primStringHandleFromString: aString)
		library: self
		during: aBlock
]

{ #category : #'api - string box' }
TGtWithStringBox >> newStringDuring: aBlock [
	^ GtStringBox
		fromOwnedHandle: self primStringCreate
		library: self
		during: aBlock
]

{ #category : #'api - string box' }
TGtWithStringBox >> newStringFromByteArray: aByteArray [
	"aByteArray should not neccesseraly outlive the string, because it will be copied"

	^ GtStringBox
		fromOwnedHandle: (self primStringHandleFromByteArray: aByteArray)
		library: self
]

{ #category : #'api - string box' }
TGtWithStringBox >> newStringFromByteArray: aByteArray during: aBlock [
	"aByteArray should not neccesseraly overlive the string, because it will be copied"

	^ GtStringBox
		fromOwnedHandle: (self primStringHandleFromByteArray: aByteArray)
		library: self
		during: aBlock
]

{ #category : #'api - string box' }
TGtWithStringBox >> newStringFromHandle: anExternalAddress during: aBlock [
	^ GtStringBox
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringCreate [
	^ self ffiCall: #(void* boxer_string_create())
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringCreateFromByteString: aByteString size: aSize [
	^ self ffiCall: #(void* boxer_string_from_byte_string(void* aByteString, size_t aSize))
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_string_from_utf8_string(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringCreateFromWideString: aWideString size: aSize [
	aWideString pinInMemory.
	^ self
		primStringCreateFromWideStringOop: (PointerUtils oopForObject: aWideString)
		size: aSize
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringCreateFromWideStringOop: aWideStringPointer size: aSize [
	^ self ffiCall: #(void* boxer_string_from_wide_string(void* aWideStringPointer, size_t aSize))
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringGetCharCount: aGtBoxerString [
	^ self ffiCall: #(size_t boxer_string_get_char_count(GtStringBox aGtBoxerString))
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringGetData: aGtBoxerString [
	^ self ffiCall: #(void* boxer_string_get_ptr(GtStringBox aGtBoxerString))
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringGetLength: aGtBoxerString [
	^ self ffiCall: #(size_t boxer_string_get_len(GtStringBox aGtBoxerString))
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringHandleFromByteArray: aByteArray [
	"Create a StringBox from a given ByteArray and return an ExternalData handle"
	| wasPinned |

	wasPinned := aByteArray isPinnedInMemory.
	^ [
		self
			primStringCreateFromData: aByteArray
			size: aByteArray size - 1 ]
		ensure: [ aByteArray setPinnedInMemory: wasPinned ]
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringHandleFromString: aString [
	"Create a StringBox from a given String and return an ExternalData handle"
	| wasPinned |

	wasPinned := aString isPinnedInMemory.
	^ [
		aString isByteString
			ifTrue: [ self primStringCreateFromByteString: aString size: aString size ]
			ifFalse: [ self primStringCreateFromWideString: aString size: aString size ] ]
		ensure: [ aString setPinnedInMemory: wasPinned ]
]

{ #category : #'private - string box' }
TGtWithStringBox >> primStringRelease: aHandle [
	self ffiCall: #(void boxer_string_drop(void* aHandle))
]

{ #category : #'api - string box' }
TGtWithStringBox >> unsafeStringFromHandle: aStringBoxHandle during: aBlock [
	"Reify a given borrowed StringBox handle for the duration of aBlock
	without releasing the memory. This is marked as unsafe because of memory leak
	when used with owned handles. The main usecase is inside of the callbacks
	when a StringBox is still owned by the library and we only get a reference."

	^ GtStringBox
		fromBorrowedHandle: aStringBoxHandle
		library: self
		during: aBlock
]
