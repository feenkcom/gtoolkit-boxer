Class {
	#name : #GtBoxerSize,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer'
}

{ #category : #converting }
GtBoxerSize >> asPoint [
	^ self width @ self height
]

{ #category : #accessing }
GtBoxerSize >> height [
	^ self primGetHeight
]

{ #category : #accessing }
GtBoxerSize >> height: aNumber [
	self primSetHeight: aNumber
]

{ #category : #'private - ffi' }
GtBoxerSize >> primGetHeight [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerSize >> primGetWidth [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerSize >> primSetHeight: aNumber [
	self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerSize >> primSetWidth: aNumber [
	self subclassResponsibility
]

{ #category : #printing }
GtBoxerSize >> printOn: aStream [
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
GtBoxerSize >> width [
	^ self primGetWidth
]

{ #category : #accessing }
GtBoxerSize >> width: aNumber [
	self primSetWidth: aNumber
]
