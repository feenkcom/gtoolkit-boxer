Class {
	#name : #GtBoxerSizeU64Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeU64Examples >> default [
	<gtExample>
	<return: #GtBoxerSizeU64>
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
	<return: #GtBoxerSizeU64>
	| aSize |
	aSize := self release.
	self assert: aSize height isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU64Examples >> getWidthFromReleased [
	<gtExample>
	<return: #GtBoxerSizeU64>
	| aSize |
	aSize := self release.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU64Examples >> release [
	<gtExample>
	<return: #GtBoxerSizeU64>
	| aSize |
	aSize := self default.
	aSize release.

	self assert: aSize isNull.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU64Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerSizeU64>
	| aSize |
	aSize := self release.
	aSize release.
	self assert: aSize isNull.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeU64Examples >> withHeight200 [
	<gtExample>
	<return: #GtBoxerSizeU64>
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
	<return: #GtBoxerSizeU64>
	| aSize |
	aSize := self default.
	aSize width: 200.

	self assert: aSize width equals: 200.
	self assert: aSize height isZero.

	^ aSize
]
