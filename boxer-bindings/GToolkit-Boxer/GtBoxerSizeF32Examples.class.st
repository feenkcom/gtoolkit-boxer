Class {
	#name : #GtBoxerSizeF32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeF32Examples >> default [
	<gtExample>
	| aSize |
	
	aSize := GtBoxerSizeF32 new.
	self assert: aSize width isFloat.
	self assert: aSize height isFloat.
	self assert: aSize width isZero.
	self assert: aSize height isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> getHeightFromReleased [
	<gtExample>
	| aSize |
	
	aSize := self release.
	self assert: aSize height isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> getWidthFromReleased [
	<gtExample>
	| aSize |
	
	aSize := self release.
	self assert: aSize width isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> release [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize release.
	
	self assert: aSize isNull.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> releaseTwice [
	<gtExample>
	| aSize |
	
	aSize := self release.
	aSize release.
	self assert: aSize isNull.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeF32Examples >> withHeight200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize height: 200.0.
	
	self assert: aSize height equals: 200.0.
	self assert: aSize width isZero.
	
	^ aSize
]

{ #category : #accessing }
GtBoxerSizeF32Examples >> withWidth200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize width: 200.0.
	
	self assert: aSize width equals: 200.0.
	self assert: aSize height isZero.
	
	^ aSize
]
