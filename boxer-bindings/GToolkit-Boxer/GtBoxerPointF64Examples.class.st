Class {
	#name : #GtBoxerPointF64Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerPointF64Examples >> createFromXY [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := GtBoxerPointF64 x: 2.0 y: 3.0.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint x equals: 2.0.
	self assert: aPoint y equals: 3.0.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPointF64Examples >> default [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := GtBoxerPointF64 new.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint x isZero.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> getXFromReleased [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := self release.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> getYFromReleased [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := self release.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> release [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := self default.
	aPoint release.

	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> setXFromReleased [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := self release.
	aPoint x: 200.0.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> setYFromReleased [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aPoint |
	aPoint := self release.
	aPoint y: 200.0.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPointF64Examples >> withX200 [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aSize |
	aSize := self default.
	aSize x: 200.0.

	self assert: aSize x equals: 200.0.
	self assert: aSize y isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerPointF64Examples >> withY200 [
	<gtExample>
	<return: #GtBoxerPointF64>
	| aSize |
	aSize := self default.
	aSize y: 200.0.

	self assert: aSize x isZero.
	self assert: aSize y equals: 200.0.

	^ aSize
]
