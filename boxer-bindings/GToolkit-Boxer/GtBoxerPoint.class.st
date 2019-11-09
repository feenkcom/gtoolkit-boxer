Class {
	#name : #GtBoxerPoint,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerPoint class >> fromPoint: aPoint [
	^ self x: aPoint x y: aPoint y
]

{ #category : #'private - ffi' }
GtBoxerPoint class >> primCreateX: aX y: aY [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtBoxerPoint class >> x: aX y: aY [
	^ self fromNativeHandle: (self primCreateX: aX y: aY)
]

{ #category : #converting }
GtBoxerPoint >> asPoint [
	^ self x @ self y
]

{ #category : #'private - ffi' }
GtBoxerPoint >> primGetX [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint >> primGetY [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint >> primSetX: aNumber [
	self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint >> primSetY: aNumber [
	self subclassResponsibility
]

{ #category : #printing }
GtBoxerPoint >> printOn: aStream [
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
GtBoxerPoint >> x [
	^ self primGetX
]

{ #category : #'accessing structure variables' }
GtBoxerPoint >> x: aNumber [
	self primSetX: aNumber
]

{ #category : #'accessing structure variables' }
GtBoxerPoint >> y [
	^ self primGetY
]

{ #category : #'accessing structure variables' }
GtBoxerPoint >> y: aNumber [
	self primSetY: aNumber
]
