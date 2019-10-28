Class {
	#name : #GtBoxerExternalObject,
	#superclass : #FFIExternalObject,
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
	^ self basicNew setHandle: aHandle
]

{ #category : #'instance creation' }
GtBoxerExternalObject class >> new [
	^ (self fromHandle: (self primCreate getHandle)) autoRelease
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

{ #category : #'library path' }
GtBoxerExternalObject >> ffiLibraryName [
	^ self class ffiLibraryName
]

{ #category : #dependencies }
GtBoxerExternalObject >> release [	
	"#release is sent manually, so we want to make sure that resource is no longer
	added to weak registry - performance improvement"
	(FFIExternalResourceManager uniqueInstance instVarNamed: #registry) remove: self ifAbsent: [ ].

	self class release: self resourceData
]
