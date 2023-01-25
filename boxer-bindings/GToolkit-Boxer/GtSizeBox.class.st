Class {
	#name : #GtSizeBox,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #converting }
GtSizeBox >> asPoint [
	^ self width @ self height
]

{ #category : #accessing }
GtSizeBox >> height [
	^ self primGetHeight
]

{ #category : #accessing }
GtSizeBox >> height: aNumber [
	self primSetHeight: aNumber
]

{ #category : #'private - ffi' }
GtSizeBox >> primGetHeight [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtSizeBox >> primGetWidth [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtSizeBox >> primSetHeight: aNumber [
	self subclassResponsibility
]

{ #category : #'private - ffi' }
GtSizeBox >> primSetWidth: aNumber [
	self subclassResponsibility
]

{ #category : #printing }
GtSizeBox >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream nextPut: ${; space.

	aStream
		nextPutAll: 'width: ';
		print: self width.
	aStream
		nextPutAll: ' height: ';
		print: self height.
		
	aStream space; nextPut: $}.
]

{ #category : #accessing }
GtSizeBox >> width [
	^ self primGetWidth
]

{ #category : #accessing }
GtSizeBox >> width: aNumber [
	self primSetWidth: aNumber
]
