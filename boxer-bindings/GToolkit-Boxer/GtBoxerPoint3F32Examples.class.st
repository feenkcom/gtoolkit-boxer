Class {
	#name : #GtBoxerPoint3F32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerPoint3F32Examples >> createFromXYZ [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := GtBoxerPoint3F32
			x: 2.0
			y: 3.0
			z: 4.0.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint z isFloat.
	self assert: aPoint x equals: 2.0.
	self assert: aPoint y equals: 3.0.
	self assert: aPoint z equals: 4.0.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> default [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := GtBoxerPoint3F32 new.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint z isFloat.
	self assert: aPoint x isZero.
	self assert: aPoint y isZero.
	self assert: aPoint z isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> getXFromReleased [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self release.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> getYFromReleased [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self release.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> getZFromReleased [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self release.
	self assert: aPoint z isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> release [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self default.
	aPoint release.

	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> setXFromReleased [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self release.
	aPoint x: 200.0.
	self assert: aPoint x isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> setYFromReleased [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self release.
	aPoint y: 200.0.
	self assert: aPoint y isZero.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> setZFromReleased [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aPoint |
	aPoint := self release.
	aPoint z: 200.0.
	self assert: aPoint z isZero.

	^ aPoint
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> withX200 [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aSize |
	aSize := self default.
	aSize x: 200.0.

	self assert: aSize x equals: 200.0.
	self assert: aSize y isZero.
	self assert: aSize z isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> withY200 [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aSize |
	aSize := self default.
	aSize y: 200.0.

	self assert: aSize x isZero.
	self assert: aSize y equals: 200.0.
	self assert: aSize z isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> withZ200 [
	<gtExample>
	<return: #GtBoxerPoint3F32>
	| aSize |
	aSize := self default.
	aSize z: 200.0.

	self assert: aSize x isZero.
	self assert: aSize y isZero.
	self assert: aSize z equals: 200.0.

	^ aSize
]
