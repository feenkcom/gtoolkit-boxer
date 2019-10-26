Class {
	#name : #GtBoxerUint128Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer'
}

{ #category : #accessing }
GtBoxerUint128Examples >> default [
	<gtExample>
	| aNumber |
	
	aNumber := GtBoxerUint128 new.
	self assert: aNumber low isInteger.
	self assert: aNumber high isInteger.
	self assert: aNumber low isZero.
	self assert: aNumber high isZero.
	^ aNumber
]

{ #category : #accessing }
GtBoxerUint128Examples >> max [
	<gtExample>
	| aNumber |
	
	aNumber := GtBoxerUint128 max.
	self assert: aNumber asInteger equals: GtBoxerUint128 maxValue.

	^ aNumber
]

{ #category : #accessing }
GtBoxerUint128Examples >> min [
	<gtExample>
	| aNumber |
	
	aNumber := GtBoxerUint128 min.
	self assert: aNumber asInteger equals: GtBoxerUint128 minValue.

	^ aNumber
]
