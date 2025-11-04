Trait {
	#name : #TGtWithBareStringBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'examples - string' }
TGtWithBareStringBox classSide >> exampleStringNewByteString [
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
TGtWithBareStringBox >> getStringFrom: aBlock [
	<return: #String>
	| aString |

	aString := ''.

	self newStringDuring: [ :aBoxerString |
		aBlock value: aBoxerString.
		aString := aBoxerString string ].

	^ aString
]

{ #category : #'api - string box' }
TGtWithBareStringBox >> newString [
	^ GtStringBox
		fromOwnedHandle: self primStringCreate
		library: self
]

{ #category : #'api - string box' }
TGtWithBareStringBox >> newString: aString [
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
TGtWithBareStringBox >> newString: aString during: aBlock [
	^ GtStringBox
		fromOwnedHandle: (self primStringHandleFromString: aString)
		library: self
		during: aBlock
]

{ #category : #'api - string box' }
TGtWithBareStringBox >> newStringDuring: aBlock [
	^ GtStringBox
		fromOwnedHandle: self primStringCreate
		library: self
		during: aBlock
]

{ #category : #'api - string box' }
TGtWithBareStringBox >> newStringFromByteArray: aByteArray [
	"aByteArray should not neccesseraly outlive the string, because it will be copied"

	^ GtStringBox
		fromOwnedHandle: (self primStringHandleFromByteArray: aByteArray)
		library: self
]

{ #category : #'api - string box' }
TGtWithBareStringBox >> newStringFromByteArray: aByteArray during: aBlock [
	"aByteArray should not neccesseraly overlive the string, because it will be copied"

	^ GtStringBox
		fromOwnedHandle: (self primStringHandleFromByteArray: aByteArray)
		library: self
		during: aBlock
]

{ #category : #'api - string box' }
TGtWithBareStringBox >> newStringFromHandle: anExternalAddress during: aBlock [
	^ GtStringBox
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringCreate [
	^ self ffiBareCall: #(void* boxer_string_create())
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringCreateFromByteString: aByteString size: aSize [
	^ self ffiBareCall: #(void* boxer_string_from_byte_string(void* aByteString, size_t aSize))
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringCreateFromData: anExternalAddress size: aSize [
	^ self ffiBareCall: #(void* boxer_string_from_utf8_string(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringCreateFromWideString: aWideString size: aSize [
	^ self ffiBareCall: #(void* boxer_string_from_wide_string(void* aWideString, size_t aSize))
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringGetCharCount: aGtBoxerString [
	^ self ffiBareCall: #(size_t boxer_string_get_char_count(GtStringBox aGtBoxerString))
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringGetData: aGtBoxerString [
	^ self ffiBareCall: #(void* boxer_string_get_ptr(GtStringBox aGtBoxerString))
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringGetLength: aGtBoxerString [
	^ self ffiBareCall: #(size_t boxer_string_get_len(GtStringBox aGtBoxerString))
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringHandleFromByteArray: aByteArray [
	"Create a StringBox from a given ByteArray and return an ExternalData handle"
	^ self
		primStringCreateFromData: aByteArray
		size: aByteArray size - 1
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringHandleFromString: aString [
	"Create a StringBox from a given String and return an ExternalData handle"
	^ aString isByteString
		ifTrue: [ self primStringCreateFromByteString: aString size: aString size ]
		ifFalse: [ self primStringCreateFromWideString: aString size: aString size ]
]

{ #category : #'private - string box' }
TGtWithBareStringBox >> primStringRelease: aHandle [
	self ffiBareCall: #(void boxer_string_drop(void* aHandle))
]

{ #category : #'api - string box' }
TGtWithBareStringBox >> unsafeStringFromHandle: aStringBoxHandle during: aBlock [
	"Reify a given borrowed StringBox handle for the duration of aBlock
	without releasing the memory. This is marked as unsafe because of memory leak
	when used with owned handles. The main usecase is inside of the callbacks
	when a StringBox is still owned by the library and we only get a reference."

	^ GtStringBox
		fromBorrowedHandle: aStringBoxHandle
		library: self
		during: aBlock
]
