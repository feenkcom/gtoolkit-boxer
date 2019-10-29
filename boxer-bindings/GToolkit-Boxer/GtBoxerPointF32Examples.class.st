Class {
	#name : #GtBoxerPointF32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerPointF32Examples >> default [
	<gtExample>
	| aPoint |
	
	aPoint := GtBoxerPointF32 new.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint x isZero.
	self assert: aPoint y isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> getXFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint x isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> getYFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint y isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> release [
	<gtExample>
	| aPoint |
	
	aPoint := self default.
	aPoint release.
	
	self assert: aPoint isNull.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> releaseTwice [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> setXFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint x: 200.0.
	self assert: aPoint x isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> setYFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint y: 200.0.
	self assert: aPoint y isZero.
	
	^ aPoint
]

{ #category : #accessing }
GtBoxerPointF32Examples >> withX200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize x: 200.0.
	
	self assert: aSize x equals: 200.0.
	self assert: aSize y isZero.
	
	^ aSize
]

{ #category : #accessing }
GtBoxerPointF32Examples >> withY200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize y: 200.0.
	
	self assert: aSize x isZero.
	self assert: aSize y equals: 200.0.
	
	^ aSize
]
