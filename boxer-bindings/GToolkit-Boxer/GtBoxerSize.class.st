Class {
	#name : #GtBoxerSize,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer'
}

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

{ #category : #accessing }
GtBoxerSize >> width [
	^ self primGetWidth
]

{ #category : #accessing }
GtBoxerSize >> width: aNumber [
	self primSetWidth: aNumber
]
