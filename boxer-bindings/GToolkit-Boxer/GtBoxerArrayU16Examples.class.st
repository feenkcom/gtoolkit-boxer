Class {
	#name : #GtBoxerArrayU16Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerArrayU16Examples >> default [
	<gtExample>
	<return: #GtBoxerArrayU16>
	| anArray |
	anArray := GtBoxerArrayU16 new.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero.
	self assert: anArray data isEmpty.

	^ anArray
]

{ #category : #'examples - null ptr' }
GtBoxerArrayU16Examples >> release [
	<gtExample>
	<return: #GtBoxerArrayU16>
	| anArray |
	anArray := self default.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero.
	self assert: anArray data isEmpty.

	^ anArray
]

{ #category : #accessing }
GtBoxerArrayU16Examples >> setElement [
	<gtExample>
	<return: #GtBoxerArrayU16>
	| anArray |
	anArray := GtBoxerArrayU16 new: 2 withAll: 0.
	self assert: anArray size equals: 2.
	self assert: anArray capacity >= 2.

	self assert: anArray asArray equals: #(0 0).

	anArray at: 1 put: 1.
	anArray at: 2 put: 2.

	self assert: anArray asArray equals: #(1 2).

	^ anArray
]

{ #category : #accessing }
GtBoxerArrayU16Examples >> withElement [
	<gtExample>
	<return: #GtBoxerArrayU16>
	| anArray |
	anArray := GtBoxerArrayU16 new: 100 withAll: 0.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray data asArray equals: (Array new: 100 withAll: 0).

	^ anArray
]
