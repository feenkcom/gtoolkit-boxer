Class {
	#name : #GtBoxerExternalObject,
	#superclass : #FFIExternalObject,
	#instVars : [
		'isAutoRelease'
	],
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'library path' }
GtBoxerExternalObject class >> ffiLibraryName [
	^ GtBoxerLibrary
]

{ #category : #finalization }
GtBoxerExternalObject class >> finalizeResourceData: aHandle [
	
	self release: aHandle
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> fromHandle: aHandle [
	^ self basicNew
		initialize;
		setHandle: aHandle
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
GtBoxerExternalObject class >> newDuring: aBlock [
	"I create a new instance of me without auto-release for to evaluate a given block
	and then destroy me"

	^ self fromNativeHandle: self primCreate during: aBlock
]

{ #category : #'private - ffi' }
GtBoxerExternalObject class >> primCreate [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerExternalObject class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self subclassResponsibility
]

{ #category : #finalization }
GtBoxerExternalObject class >> release: aHandle [
	aHandle isNull
		"A handle may already be null, if garbage collector did his job before us :)"
		ifTrue: [ ^ self ].

	self warning: [ '(release) Ptr: ', aHandle value asString ].
	self primRelease: aHandle.
	aHandle getHandle beNull
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
GtBoxerExternalObject >> ffiLibraryName [
	^ self class ffiLibraryName
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
