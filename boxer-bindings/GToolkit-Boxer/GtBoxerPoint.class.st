Class {
	#name : #GtBoxerPoint,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer-Core'
}

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
