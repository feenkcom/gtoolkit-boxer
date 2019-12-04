Class {
	#name : #GtBoxer,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxer class >> externalArrayFromHandle: aHandle type: anFFIExternalTypeClass size: aNumber [
	<return: #FFIExternalArray>
	| aType |
	
	aType := anFFIExternalTypeClass isClass
		ifTrue: [ anFFIExternalTypeClass new ]
		ifFalse: [ anFFIExternalTypeClass ].

	"Type  resolution is very slow, so we initialize it manually"
	^ FFIExternalArray basicNew
		initializeHandle: aHandle
		type: aType
		size: aNumber
]

{ #category : #'instance creation' }
GtBoxer class >> externalArrayFromHandle: aHandle type: anFFIExternalTypeClass size: aNumber during: aBlock [
	| anExternalArray aType |
	
	aType := anFFIExternalTypeClass isClass
		ifTrue: [ anFFIExternalTypeClass new ]
		ifFalse: [ anFFIExternalTypeClass ].
	
	"Type  resolution is very slow, so we initialize it manually"
	anExternalArray := FFIExternalArray basicNew
		initializeHandle: aHandle
		type: aType
		size: aNumber.
	
	"the memory is managed by external library, we should not auto-release it"
	^ aBlock value: anExternalArray
]

{ #category : #'instance creation' }
GtBoxer class >> externalArrayNewType: anFFIExternalTypeClass size: aNumber [
	<return: #FFIExternalArray>
	| aType |
	
	aType := anFFIExternalTypeClass isClass
		ifTrue: [ anFFIExternalTypeClass new ]
		ifFalse: [ anFFIExternalTypeClass ].
	
	"Type  resolution is very slow, so we initialize it manually"
	^ FFIExternalArray basicNew
		initializeExternalType: aType size: aNumber;
		yourself
]

{ #category : #'instance creation' }
GtBoxer class >> externalArrayNewType: anFFIExternalTypeClass size: aNumber during: aBlock [
	"I free the memory right after evaluating aBlock"
	| anExternalArray aType |
	
	aType := anFFIExternalTypeClass isClass
		ifTrue: [ anFFIExternalTypeClass new ]
		ifFalse: [ anFFIExternalTypeClass ].
	
	"Type  resolution is very slow, so we initialize it manually"
	anExternalArray := FFIExternalArray basicNew
		initializeExternalType: aType
		size: aNumber.

	^ [ aBlock value: anExternalArray ] ensure: [ anExternalArray free ]
]
