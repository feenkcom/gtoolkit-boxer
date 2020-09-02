Class {
	#name : #GtBoxerValueBox,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #accessing }
GtBoxerValueBox class >> boxedPointerOf: anExternalObject [
	<return: #ExternalAddress>

	^ (self primGetBoxedPointer: anExternalObject getHandle) getHandle
]

{ #category : #accessing }
GtBoxerValueBox class >> isValid: aValueBox [
	<return: #Boolean>

	^ self primIsValid: aValueBox getHandle
]

{ #category : #'private - ffi' }
GtBoxerValueBox class >> primGetBoxedPointer: aHandle [
	^ self ffiCall: #(void* boxer_value_box_get_pointer(void* aHandle)) library: GtBoxerLibrary uniqueInstance
]

{ #category : #'private - ffi' }
GtBoxerValueBox class >> primIsValid: aHandle [
	^ self ffiCall: #(bool boxer_value_box_is_valid(void* aHandle)) library: GtBoxerLibrary uniqueInstance
]

{ #category : #accessing }
GtBoxerValueBox >> boxedPointer [
	<return: #ExternalAddress>

	^ self class boxedPointerOf: self
]

{ #category : #accessing }
GtBoxerValueBox >> isValid [
	<return: #Boolean>

	^ self class isValid: self
]
