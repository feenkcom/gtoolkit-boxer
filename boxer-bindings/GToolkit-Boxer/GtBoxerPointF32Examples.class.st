Class {
	#name : #GtBoxerPointF32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerPointF32Examples >> createFromXY [
	<gtExample>
	<return: #GtBoxerPointF32>
	| aPoint |
	aPoint := GtBoxerPointF32 x: 2.0 y: 3.0.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint x equals: 2.0.
	self assert: aPoint y equals: 3.0.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPointF32Examples >> default [
	<gtExample>
	<return: #GtBoxerPointF32>
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
	<return: #GtBoxerPointF32>
	| aPoint |
	aPoint := self release.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> getYFromReleased [
	<gtExample>
	<return: #GtBoxerPointF32>
	| aPoint |
	aPoint := self release.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> release [
	<gtExample>
	<return: #GtBoxerPointF32>
	| aPoint |
	aPoint := self default.
	aPoint release.

	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerPointF32>
	| aPoint |
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> setXFromReleased [
	<gtExample>
	<return: #GtBoxerPointF32>
	| aPoint |
	aPoint := self release.
	aPoint x: 200.0.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF32Examples >> setYFromReleased [
	<gtExample>
	<return: #GtBoxerPointF32>
	| aPoint |
	aPoint := self release.
	aPoint y: 200.0.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPointF32Examples >> withX200 [
	<gtExample>
	<return: #GtBoxerPointF32>
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
	<return: #GtBoxerPointF32>
	| aSize |
	aSize := self default.
	aSize y: 200.0.

	self assert: aSize x isZero.
	self assert: aSize y equals: 200.0.

	^ aSize
]
