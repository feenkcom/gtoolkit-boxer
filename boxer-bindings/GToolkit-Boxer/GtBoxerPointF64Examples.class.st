Class {
	#name : #GtBoxerPointF64Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerPointF64Examples >> default [
	<gtExample>
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
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint x isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> getYFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint y isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> release [
	<gtExample>
	| aPoint |
	
	aPoint := self default.
	aPoint release.
	
	self assert: aPoint isNull.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> releaseTwice [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> setXFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint x: 200.0.
	self assert: aPoint x isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPointF64Examples >> setYFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint y: 200.0.
	self assert: aPoint y isZero.
	
	^ aPoint
]

{ #category : #accessing }
GtBoxerPointF64Examples >> withX200 [
	<gtExample>
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
	| aSize |
	
	aSize := self default.
	aSize y: 200.0.
	
	self assert: aSize x isZero.
	self assert: aSize y equals: 200.0.
	
	^ aSize
]
