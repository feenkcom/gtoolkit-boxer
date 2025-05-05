Class {
	#name : #GtBoxerSizeF64Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeF64Examples >> default [
	<gtExample>
	<return: #GtBoxerSizeF64>
	| aSize |
	aSize := GtBoxerSizeF64 new.
	self assert: aSize width isFloat.
	self assert: aSize height isFloat.
	self assert: aSize width isZero.
	self assert: aSize height isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF64Examples >> getHeightFromReleased [
	<gtExample>
	<return: #GtBoxerSizeF64>
	| aSize |
	aSize := self release.
	self assert: aSize height isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF64Examples >> getWidthFromReleased [
	<gtExample>
	<return: #GtBoxerSizeF64>
	| aSize |
	aSize := self release.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF64Examples >> release [
	<gtExample>
	<return: #GtBoxerSizeF64>
	| aSize |
	aSize := self default.
	aSize release.

	self assert: aSize isNull.

	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF64Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerSizeF64>
	| aSize |
	aSize := self release.
	aSize release.
	self assert: aSize isNull.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeF64Examples >> withHeight200 [
	<gtExample>
	<return: #GtBoxerSizeF64>
	| aSize |
	aSize := self default.
	aSize height: 200.0.

	self assert: aSize height equals: 200.0.
	self assert: aSize width isZero.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeF64Examples >> withWidth200 [
	<gtExample>
	<return: #GtBoxerSizeF64>
	| aSize |
	aSize := self default.
	aSize width: 200.0.

	self assert: aSize width equals: 200.0.
	self assert: aSize height isZero.

	^ aSize
]
