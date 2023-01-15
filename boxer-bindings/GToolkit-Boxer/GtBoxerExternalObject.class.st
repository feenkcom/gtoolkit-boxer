Class {
	#name : #GtBoxerExternalObject,
	#superclass : #FFIExternalObject,
	#instVars : [
		'isAutoRelease'
	],
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'library path' }
GtBoxerExternalObject class >> ffiLibrary [
	^ GtBoxerLibrary
]

{ #category : #finalization }
GtBoxerExternalObject class >> finalizeResourceData: aHandle [
	
	self release: aHandle
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> fromHandle: aHandle [
	^ self basicNew
		setHandle: aHandle;
		initialize;
		yourself
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> fromNativeHandle: anExternalData [
	^ (self fromHandle: (anExternalData getHandle)) autoRelease
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> fromNativeHandle: anExternalData during: aBlock [
	"I create a new instance of me without auto-release for to evaluate a given block
	and then destroy me"
	| anExternalInstance |
	
	"Object understand release"
	anExternalInstance := Object new.
	^ [
		anExternalInstance := self fromHandle: (anExternalData getHandle).
		aBlock value: anExternalInstance ]
	ensure: [ anExternalInstance release ]
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> new [
	^ self fromNativeHandle: self primCreate
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> new: anAmountOfObjects during: aBlock [
	"I create anAmountOfObjects of new instances of me without auto-release to evaluate a given block
	and then destroy all of them"
	| anArrayOfObjects |

	anArrayOfObjects := Array new: anAmountOfObjects.
	^ [
		anArrayOfObjects withIndexDo: [ :_ :anIndex |
			anArrayOfObjects at: anIndex put: (self fromHandle: (self primCreate getHandle)) ].
		aBlock value: anArrayOfObjects.
	] ensure: [ anArrayOfObjects
		select: [ :eachObject | eachObject isNotNil ]
		thenDo: [ :eachObject | eachObject release ] ]
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> newDuring: aBlock [
	"I create a new instance of me without auto-release for to evaluate a given block
	and then destroy me"

	^ self fromNativeHandle: self primCreate during: aBlock
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> null [
	^ self fromHandle: ExternalAddress new
]

{ #category : #'private - ffi' }
GtBoxerExternalObject class >> primCreate [
	"^ self ffiCall: #(void* lib_object_default())"
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerExternalObject class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	"self ffiCall: #(void lib_object_drop(void* aHandle))"
	self subclassResponsibility
]

{ #category : #finalization }
GtBoxerExternalObject class >> release: aHandle [
	aHandle isNull
		"A handle may already be null, if garbage collector did his job before us :)"
		ifTrue: [ ^ self ].

	self warning: [ '(release) Ptr: ', aHandle value asString ].
	
	"When an image is saved during finalization step (how?) and then re-opened on a new
	machine the ffi library path is sometimes different which results in an error.
	However, since the object is anyway invalid due to a new session we can continue and just ignore it nulling
	the pointer"
	[ self primRelease: aHandle . aHandle beNull ]
		on: Error do: [ :anError | 
			NonInteractiveTranscript stdout
				nextPutAll: ('[Warning] Failed to release {1}({2}) due to {3}' format: { 
					self name.
					aHandle printString.
					anError printString });
				cr.
			aHandle beNull ].
	self
		assert: [ aHandle isNull ]
		description: [ 'Pointer must be null after release' ]
]

{ #category : #debug }
GtBoxerExternalObject class >> warning: aMessageBlock [ 
	"| message |

	message := '[', self name asString ,'] ', aMessageBlock value.

	Transcript show: message; cr"
]

{ #category : #'external resource management' }
GtBoxerExternalObject >> autoRelease [
	"Note, subclasses should implement #resourceData
	and #finalizeResourceData: on class side"

	isAutoRelease := true.
	super autoRelease
]

{ #category : #'library path' }
GtBoxerExternalObject >> ffiLibrary [
	^ self class ffiLibrary
]

{ #category : #initialization }
GtBoxerExternalObject >> initialize [
	"!! We intentionally do not call `super initialize` to not waste resources on allocation of the null handle"
]

{ #category : #testing }
GtBoxerExternalObject >> isValid [
	<return: #Boolean>

	^ handle isNotNil and: [ handle isNull not ]
]

{ #category : #dependencies }
GtBoxerExternalObject >> release [
	"#release is sent manually, so we want to make sure that resource is no longer
	added to weak registry - performance improvement"
	
	"we compare with true because isAutoRelease is nil be default"
	isAutoRelease == true
		ifTrue: [
			(FFIExternalResourceManager uniqueInstance instVarNamed: #registry) remove: self ifAbsent: [ ].
			isAutoRelease := false ].

	self class release: self resourceData
]
