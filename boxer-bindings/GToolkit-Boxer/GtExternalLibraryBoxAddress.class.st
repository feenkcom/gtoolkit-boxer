Class {
	#name : #GtExternalLibraryBoxAddress,
	#superclass : #Object,
	#instVars : [
		'externalAddress',
		'library'
	],
	#category : #'GToolkit-Boxer-New'
}

{ #category : #accessing }
GtExternalLibraryBoxAddress >> externalAddress [
	^ externalAddress
]

{ #category : #accessing }
GtExternalLibraryBoxAddress >> externalAddress: anObject [
	externalAddress := anObject
]

{ #category : #accessing }
GtExternalLibraryBoxAddress >> library [
	^ library
]

{ #category : #accessing }
GtExternalLibraryBoxAddress >> library: anObject [
	library := anObject
]
