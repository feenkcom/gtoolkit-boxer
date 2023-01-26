Trait {
	#name : #TGtWithStringBox,
	#category : #'GToolkit-Boxer-New'
}

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
	^ GtStringBox fromOwnedHandle: (self primStringCreate) library: self
]

{ #category : #'api - string box' }
TGtWithStringBox >> newString: aString [
	self
		assert: [ aString isNotNil ]
		description: [ 'String must not be nil' ].

	^ GtStringBox
		fromOwnedHandle: (aString isByteString
			ifTrue: [ self primStringCreateFromByteString: aString size: aString size ]
			ifFalse: [ self primStringCreateFromWideString: aString size: aString size ])
		library: self
]

{ #category : #'api - string box' }
TGtWithStringBox >> newString: aString during: aBlock [
	^ GtStringBox
		fromOwnedHandle: (aString isByteString
			ifTrue: [ self primStringCreateFromByteString: aString size: aString size ]
			ifFalse: [ self primStringCreateFromWideString: aString size: aString size ])
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
	"aByteArray should not neccesseraly overlive the string, because it will be copied"

	^ GtStringBox
		fromOwnedHandle: (self
			primStringCreateFromData: aByteArray
			size: aByteArray size - 1)
		library: self
]

{ #category : #'api - string box' }
TGtWithStringBox >> newStringFromByteArray: aByteArray during: aBlock [
	"aByteArray should not neccesseraly overlive the string, because it will be copied"

	^ GtStringBox
		fromOwnedHandle: (self
			primStringCreateFromData: aByteArray
			size: aByteArray size - 1)
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
TGtWithStringBox >> primStringRelease: aHandle [
	self ffiCall: #(void boxer_string_drop(void* aHandle))
]
