Class {
	#name : #GtBoxerUint128Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerUint128Examples >> default [
	<gtExample>
	<return: #GtBoxerUint128>
	| aNumber |
	aNumber := GtBoxerUint128 new.
	self assert: aNumber low isInteger.
	self assert: aNumber high isInteger.
	self assert: aNumber low isZero.
	self assert: aNumber high isZero.
	^ aNumber
]

{ #category : #'examples - null ptr' }
GtBoxerUint128Examples >> getHighFromReleased [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self release.
	self assert: aUint128 high equals: 0.

	^ aUint128
]

{ #category : #'examples - null ptr' }
GtBoxerUint128Examples >> getLowFromReleased [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self release.
	self assert: aUint128 low equals: 0.

	^ aUint128
]

{ #category : #accessing }
GtBoxerUint128Examples >> max [
	<gtExample>
	<return: #GtBoxerUint128>
	| aNumber |
	aNumber := GtBoxerUint128 max.
	self assert: aNumber asInteger equals: GtBoxerUint128 maxValue.

	^ aNumber
]

{ #category : #accessing }
GtBoxerUint128Examples >> min [
	<gtExample>
	<return: #GtBoxerUint128>
	| aNumber |
	aNumber := GtBoxerUint128 min.
	self assert: aNumber asInteger equals: GtBoxerUint128 minValue.

	^ aNumber
]

{ #category : #'examples - null ptr' }
GtBoxerUint128Examples >> release [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self default.
	aUint128 release.

	self assert: aUint128 isNull.

	^ aUint128
]

{ #category : #'examples - null ptr' }
GtBoxerUint128Examples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self release.
	aUint128 release.
	self assert: aUint128 isNull.

	^ aUint128
]

{ #category : #'examples - null ptr' }
GtBoxerUint128Examples >> setHighFromReleased [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self release.
	aUint128 high: 200.
	self assert: aUint128 high equals: 0.

	^ aUint128
]

{ #category : #'examples - null ptr' }
GtBoxerUint128Examples >> setLowFromReleased [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self release.
	aUint128 low: 200.
	self assert: aUint128 low equals: 0.

	^ aUint128
]

{ #category : #accessing }
GtBoxerUint128Examples >> withHigh200 [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self default.
	aUint128 high: 200.

	self assert: aUint128 low isZero.
	self assert: aUint128 high equals: 200.
	self assert: aUint128 asInteger equals: 3689348814741910323200.

	^ aUint128
]

{ #category : #accessing }
GtBoxerUint128Examples >> withLow200 [
	<gtExample>
	<return: #GtBoxerUint128>
	| aUint128 |
	aUint128 := self default.
	aUint128 low: 200.

	self assert: aUint128 high isZero.
	self assert: aUint128 low equals: 200.
	self assert: aUint128 asInteger equals: 200.

	^ aUint128
]
