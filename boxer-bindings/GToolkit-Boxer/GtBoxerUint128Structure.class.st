"
I am a structure variant of ${GtBoxerUint128}$
"
Class {
	#name : #GtBoxerUint128Structure,
	#superclass : #GtBoxerExternalStructure,
	#classVars : [
		'OFFSET_HIGH',
		'OFFSET_LOW'
	],
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'field definition' }
GtBoxerUint128Structure class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"
	^ #(
		uint64 high
		uint64 low
 	)
]

{ #category : #converting }
GtBoxerUint128Structure >> asInteger [
	^ (self high << 64) + self low
]

{ #category : #'accessing structure variables' }
GtBoxerUint128Structure >> high [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_HIGH
]

{ #category : #'accessing structure variables' }
GtBoxerUint128Structure >> high: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_HIGH put: anObject
]

{ #category : #'accessing structure variables' }
GtBoxerUint128Structure >> low [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_LOW
]

{ #category : #'accessing structure variables' }
GtBoxerUint128Structure >> low: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_LOW put: anObject
]
