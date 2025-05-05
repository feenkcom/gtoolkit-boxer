Class {
	#name : #GtBoxerSizeI32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeI32Examples >> default [
	<gtExample>
	<return: #GtBoxerSizeI32>
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
	<return: #GtBoxerSizeI32>
	| aSize |
	aSize := self release.
	self assert: aSize height isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeI32Examples >> getWidthFromReleased [
	<gtExample>
	<return: #GtBoxerSizeI32>
	| aSize |
	aSize := self release.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeI32Examples >> release [
	<gtExample>
	<return: #GtBoxerSizeI32>
	| aSize |
	aSize := self default.
	aSize release.

	self assert: aSize isNull.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeI32Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerSizeI32>
	| aSize |
	aSize := self release.
	aSize release.
	self assert: aSize isNull.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeI32Examples >> withHeight200 [
	<gtExample>
	<return: #GtBoxerSizeI32>
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
	<return: #GtBoxerSizeI32>
	| aSize |
	aSize := self default.
	aSize width: 200.

	self assert: aSize width equals: 200.
	self assert: aSize height isZero.

	^ aSize
]
