Class {
	#name : #GtBoxerPointI32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerPointI32Examples >> createFromXY [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := GtBoxerPointI32 x: 2 y: 3.
	self assert: aPoint x isInteger.
	self assert: aPoint y isInteger.
	self assert: aPoint x equals: 2.
	self assert: aPoint y equals: 3.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPointI32Examples >> default [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := GtBoxerPointI32 new.
	self assert: aPoint x isInteger.
	self assert: aPoint y isInteger.
	self assert: aPoint x isZero.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointI32Examples >> getXFromReleased [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := self release.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointI32Examples >> getYFromReleased [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := self release.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointI32Examples >> release [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := self default.
	aPoint release.

	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointI32Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointI32Examples >> setXFromReleased [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := self release.
	aPoint x: 200.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointI32Examples >> setYFromReleased [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aPoint |
	aPoint := self release.
	aPoint y: 200.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPointI32Examples >> withX200 [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aSize |
	aSize := self default.
	aSize x: 200.

	self assert: aSize x equals: 200.
	self assert: aSize y isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerPointI32Examples >> withY200 [
	<gtExample>
	<return: #GtBoxerPointI32>
	| aSize |
	aSize := self default.
	aSize y: 200.

	self assert: aSize x isZero.
	self assert: aSize y equals: 200.

	^ aSize
]
