Class {
	#name : #GtBoxer,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxer class >> externalArrayFromHandle: aHandle type: anFFIExternalTypeClass size: aNumber [
	<return: #FFIExternalArray>

	"Type  resolution is very slow, so we initialize it manually"
	^ FFIExternalArray basicNew
		initializeHandle: aHandle
		type: anFFIExternalTypeClass new
		size: aNumber
]

{ #category : #'instance creation' }
GtBoxer class >> externalArrayFromHandle: aHandle type: anFFIExternalTypeClass size: aNumber during: aBlock [
	| anExternalArray |
	
	"Type  resolution is very slow, so we initialize it manually"
	anExternalArray := FFIExternalArray basicNew
		initializeHandle: aHandle
		type: anFFIExternalTypeClass new
		size: aNumber.
	
	"the memory is managed by external library, we should not auto-release it"
	^ aBlock value: anExternalArray
]

{ #category : #'instance creation' }
GtBoxer class >> externalArrayNewType: anFFIExternalTypeClass size: aNumber [
	<return: #FFIExternalArray>
	
	"Type  resolution is very slow, so we initialize it manually"
	^ FFIExternalArray basicNew
		initializeExternalType: anFFIExternalTypeClass new size: aNumber;
		yourself
]

{ #category : #'instance creation' }
GtBoxer class >> externalArrayNewType: anFFIExternalTypeClass size: aNumber during: aBlock [
	"I free the memory right after evaluating aBlock"
	| anExternalArray |
	
	"Type  resolution is very slow, so we initialize it manually"
	anExternalArray := FFIExternalArray basicNew
		initializeExternalType: anFFIExternalTypeClass new
		size: aNumber.

	^ [ aBlock value: anExternalArray ] ensure: [ anExternalArray free ]
]
