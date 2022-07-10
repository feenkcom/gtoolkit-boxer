Class {
	#name : #GtBoxerExternalStructure,
	#superclass : #FFIExternalStructure,
	#instVars : [
		'isAutoRelease'
	],
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerExternalStructure class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	"self ffiCall: #(void lib_object_drop(void** aHandle))"
	
	"by default delegate to the handle (this is a default behavior of an FFI External structure)"
	aHandle free
]

{ #category : #finalization }
GtBoxerExternalStructure class >> release: aHandle [
	aHandle isNull
		"A handle may already be null, if garbage collector did his job before us :)"
		ifTrue: [ ^ self ].
	
	aHandle isExternalAddress
		"External structures can be initialized from the in-memory array"
		ifFalse: [ ^ self ].

	"When an image is saved during finalization step (how?) and then re-opened on a new
	machine the ffi library path is sometimes different which results in an error.
	However, since the object is anyway invalid due to a new session we can continue and just ignore it nulling
	the pointer"
	[ self primRelease: aHandle ]
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

{ #category : #'external resource management' }
GtBoxerExternalStructure >> autoRelease [
	"Note, subclasses should implement #resourceData
	and #finalizeResourceData: on class side"

	isAutoRelease := true.
	super autoRelease
]

{ #category : #'examples - null ptr' }
GtBoxerExternalStructure >> release [
	"#release is sent manually, so we want to make sure that resource is no longer
	added to weak registry - performance improvement"
	
	"we compare with true because isAutoRelease is nil be default"
	isAutoRelease == true
		ifTrue: [
			(FFIExternalResourceManager uniqueInstance instVarNamed: #registry) remove: self ifAbsent: [ ].
			isAutoRelease := false ].

	self class release: self getHandle
]
