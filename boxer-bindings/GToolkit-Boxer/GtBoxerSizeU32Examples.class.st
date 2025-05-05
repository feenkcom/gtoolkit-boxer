Class {
	#name : #GtBoxerSizeU32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeU32Examples >> default [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aSize |
	aSize := GtBoxerSizeU32 new.
	self assert: aSize width isInteger.
	self assert: aSize height isInteger.
	self assert: aSize width isZero.
	self assert: aSize height isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU32Examples >> getHeightFromReleased [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aSize |
	aSize := self release.
	self assert: aSize height isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU32Examples >> getWidthFromReleased [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aSize |
	aSize := self release.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU32Examples >> release [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aSize |
	aSize := self default.
	aSize release.

	self assert: aSize isNull.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeU32Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aSize |
	aSize := self release.
	aSize release.
	self assert: aSize isNull.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeU32Examples >> withHeight200 [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aSize |
	aSize := self default.
	aSize height: 200.

	self assert: aSize height equals: 200.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeU32Examples >> withWidth200 [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aSize |
	aSize := self default.
	aSize width: 200.

	self assert: aSize width equals: 200.
	self assert: aSize height isZero.

	^ aSize
]
