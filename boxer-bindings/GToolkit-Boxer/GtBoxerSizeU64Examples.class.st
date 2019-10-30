Class {
	#name : #GtBoxerSizeU64Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeU64Examples >> default [
	<gtExample>
	| aSize |
	
	aSize := GtBoxerSizeU64 new.
	self assert: aSize width isInteger.
	self assert: aSize height isInteger.
	self assert: aSize width isZero.
	self assert: aSize height isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU64Examples >> getHeightFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint height isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU64Examples >> getWidthFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint width isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU64Examples >> release [
	<gtExample>
	| aPoint |
	
	aPoint := self default.
	aPoint release.
	
	self assert: aPoint isNull.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU64Examples >> releaseTwice [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #accessing }
GtBoxerSizeU64Examples >> withHeight200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize height: 200.
	
	self assert: aSize height equals: 200.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeU64Examples >> withWidth200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize width: 200.
	
	self assert: aSize width equals: 200.
	self assert: aSize height isZero.
	
	^ aSize
]
