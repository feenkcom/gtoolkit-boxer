Class {
	#name : #GtPointBox,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #converting }
GtPointBox >> asPoint [
	^ self x @ self y
]

{ #category : #'private - ffi' }
GtPointBox >> primGetX [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtPointBox >> primGetY [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtPointBox >> primSetX: aNumber [
	self subclassResponsibility
]

{ #category : #'private - ffi' }
GtPointBox >> primSetY: aNumber [
	self subclassResponsibility
]

{ #category : #printing }
GtPointBox >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream nextPut: ${; space.

	aStream
		nextPutAll: 'x: ';
		print: self x.
	aStream
		nextPutAll: ' y: ';
		print: self y.
		
	aStream space; nextPut: $}.
]

{ #category : #'accessing structure variables' }
GtPointBox >> x [
	^ self primGetX
]

{ #category : #'accessing structure variables' }
GtPointBox >> x: aNumber [
	self primSetX: aNumber
]

{ #category : #'accessing structure variables' }
GtPointBox >> y [
	^ self primGetY
]

{ #category : #'accessing structure variables' }
GtPointBox >> y: aNumber [
	self primSetY: aNumber
]
