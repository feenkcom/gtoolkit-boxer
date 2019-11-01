Class {
	#name : #GtBoxerPointF32Structure,
	#superclass : #GtBoxerExternalStructure,
	#classVars : [
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'field definition' }
GtBoxerPointF32Structure class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"
	^ #(
		float32 x
		float32 y
 	)
]

{ #category : #converting }
GtBoxerPointF32Structure >> asPoint [
	^ self x @ self y
]

{ #category : #'accessing structure variables' }
GtBoxerPointF32Structure >> x [
	"This method was automatically generated"
	^handle floatAt: OFFSET_X
]

{ #category : #'accessing structure variables' }
GtBoxerPointF32Structure >> x: anObject [
	"This method was automatically generated"
	handle floatAt: OFFSET_X put: anObject
]

{ #category : #'accessing structure variables' }
GtBoxerPointF32Structure >> y [
	"This method was automatically generated"
	^handle floatAt: OFFSET_Y
]

{ #category : #'accessing structure variables' }
GtBoxerPointF32Structure >> y: anObject [
	"This method was automatically generated"
	handle floatAt: OFFSET_Y put: anObject
]
