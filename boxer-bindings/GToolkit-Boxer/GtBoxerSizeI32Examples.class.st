Class {
	#name : #GtBoxerSizeI32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeI32Examples >> default [
	<gtExample>
	| aSize |
	
	aSize := GtBoxerSizeI32 new.
	self assert: aSize width isInteger.
	self assert: aSize height isInteger.
	self assert: aSize width isZero.
	self assert: aSize height isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeI32Examples >> getHeightFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint height isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerSizeI32Examples >> getWidthFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint width isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerSizeI32Examples >> release [
	<gtExample>
	| aPoint |
	
	aPoint := self default.
	aPoint release.
	
	self assert: aPoint isNull.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerSizeI32Examples >> releaseTwice [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #accessing }
GtBoxerSizeI32Examples >> withHeight200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize height: 200.
	
	self assert: aSize height equals: 200.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeI32Examples >> withWidth200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize width: 200.
	
	self assert: aSize width equals: 200.
	self assert: aSize height isZero.
	
	^ aSize
]
