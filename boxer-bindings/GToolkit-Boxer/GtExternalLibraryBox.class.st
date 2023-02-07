Class {
	#name : #GtExternalLibraryBox,
	#superclass : #FFIExternalObject,
	#traits : 'TGtValueBox',
	#classTraits : 'TGtValueBox classTrait',
	#instVars : [
		'library',
		'isAutoRelease'
	],
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'library path' }
GtExternalLibraryBox class >> ffiLibrary [
	"ValueBox require dynamic dispatch via an ffiLibrary on the instance side.
	Class side ffi methods are not supported"

	self shouldNotImplement
]

{ #category : #finalization }
GtExternalLibraryBox class >> finalizeResourceData: aGtValueBoxExternalAddress [
	self release: aGtValueBoxExternalAddress
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> fromBorrowedHandle: aHandle library: anFFILibrary [
	^ self basicNew
		setHandle: aHandle;
		ffiLibrary: anFFILibrary;
		initialize;
		yourself
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> fromBorrowedHandle: aHandle library: anFFILibrary during: aBlock [
	^ aBlock value: (self fromBorrowedHandle: aHandle library: anFFILibrary)
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> fromHandle: aHandle [
	"ValueBox objects live in a context of a specific library.
	The can not be created from an arbitrary handle, please use #fromHandle:library:"

	self shouldNotImplement
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> fromOwnedHandle: anExternalData library: anFFILibrary [
	^ (self fromBorrowedHandle: anExternalData getHandle library: anFFILibrary) autoRelease
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> fromOwnedHandle: anExternalData library: anFFILibrary during: aBlock [
	"I create a new instance of me without auto-release to evaluate a given block
	and then destroy me"
	| anExternalInstance |
	
	"Object understand release"
	anExternalInstance := Object new.
	^ [
		anExternalInstance := self
			fromBorrowedHandle: anExternalData getHandle
			library: anFFILibrary.
		aBlock value: anExternalInstance ]
	ensure: [ anExternalInstance release ]
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> new [
	"ValueBox objects live in a context of a specific ffi library.
	Consider using instance creation methods that take an ffi library as an argument"

	self shouldNotImplement
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> newDuring: aBlock [
	"ValueBox objects live in a context of an ffi library. Consider using methods that take library as an argument"
	self shouldNotImplement
]

{ #category : #'instance creation' }
GtExternalLibraryBox class >> null [
	"Should it support null?"

	self shouldNotImplement
]

{ #category : #'private - ffi' }
GtExternalLibraryBox class >> primRelease: aHandle library: anFFILibrary [
	"External objects must be released using a specific method from the ffi library similar to:"
	"self ffiCall: #(void lib_object_drop(void* aHandle))"

	self subclassResponsibility
]

{ #category : #finalization }
GtExternalLibraryBox class >> release: anExternalValueBoxAddress [
	| anExternalAddress aLibrary |
	
	anExternalAddress := anExternalValueBoxAddress externalAddress.
	aLibrary := anExternalValueBoxAddress library.
	anExternalAddress isNull
		"A handle may already be null, if garbage collector did its job before us :)"
		ifTrue: [ ^ self ].

	"When an image is saved during finalization step (how?) and then re-opened on a new
	machine the ffi library path is sometimes different which results in an error.
	However, since external object are anyway invalid due to a new session we can continue and just ignore it nulling
	the pointer"
	[
			self
				primRelease: anExternalAddress
				library: aLibrary.
			anExternalAddress beNull ]
		on: Error do: [ :anError | 
			NonInteractiveTranscript stdout
				nextPutAll: ('[Warning] Failed to release {1}({2}) due to {3}' format: { 
					self name.
					anExternalAddress printString.
					anError printString });
				cr.
			anExternalAddress beNull ].

	self
		assert: [ anExternalAddress isNull ]
		description: [ 'Pointer must be null after release' ]
]

{ #category : #'external resource management' }
GtExternalLibraryBox >> autoRelease [
	"Note, subclasses should implement #resourceData
	and #finalizeResourceData: on class side"

	isAutoRelease := true.
	super autoRelease
]

{ #category : #'library path' }
GtExternalLibraryBox >> ffiLibrary [
	^ library
]

{ #category : #'library path' }
GtExternalLibraryBox >> ffiLibrary: anFFILibrary [
	self
		assert: [ anFFILibrary isKindOf: FFILibrary ]
		description: [ 'Must be an instance of the FFILibrary' ].

	library := anFFILibrary
]

{ #category : #initialization }
GtExternalLibraryBox >> initialize [
	"!! We intentionally do not call `super initialize` to not waste resources on allocation of the null handle"
]

{ #category : #testing }
GtExternalLibraryBox >> isValid [
	<return: #Boolean>

	^ handle isNotNil and: [ handle isNull not ]
]

{ #category : #dependencies }
GtExternalLibraryBox >> release [
	"#release is sent manually, so we want to make sure that resource is no longer
	added to weak registry - performance improvement"
	
	"we compare with true because isAutoRelease is nil be default"
	isAutoRelease == true
		ifTrue: [
			(FFIExternalResourceManager uniqueInstance instVarNamed: #registry) remove: self ifAbsent: [ ].
			isAutoRelease := false ].

	self class release: self resourceData
]

{ #category : #'external resource management' }
GtExternalLibraryBox >> resourceData [
	^ GtExternalLibraryBoxAddress new
		externalAddress: handle;
		library: library
]
