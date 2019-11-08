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

{ #category : #'private - ffi' }
GtBoxerValueBox class >> primGetBoxedPointer: aHandle [
	^ self ffiCall: #(void* boxer_value_box_get_pointer(void* aHandle)) library: GtBoxerLibrary uniqueInstance
]

{ #category : #accessing }
GtBoxerValueBox >> boxedPointer [
	<return: #ExternalAddress>

	^ self class boxedPointerOf: self
]
