Class {
	#name : #GtBoxerRange,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #converting }
GtBoxerRange >> asInterval [
	^ self start + 1 to: self end
]

{ #category : #accessing }
GtBoxerRange >> end [
	"Exclusive end"

	^ self primGetEnd
]

{ #category : #accessing }
GtBoxerRange >> end: anEnd [
	self primSetEnd: anEnd
]

{ #category : #'private - ffi' }
GtBoxerRange >> primGetEnd [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerRange >> primGetStart [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerRange >> primSetEnd: anEnd [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerRange >> primSetStart: aStart [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtBoxerRange >> start [
	^ self primGetStart
]

{ #category : #accessing }
GtBoxerRange >> start: aStart [
	self primSetStart: aStart
]
