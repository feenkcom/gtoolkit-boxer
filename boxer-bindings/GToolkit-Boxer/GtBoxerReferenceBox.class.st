Class {
	#name : #GtBoxerReferenceBox,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerReferenceBox class >> fromNativeHandle: anExternalData [
	"Do not autoRelease external references"

	^ self fromHandle: (anExternalData getHandle)
]

{ #category : #'private - ffi' }
GtBoxerReferenceBox class >> primCreate [
	"Reference can not be created out of nothing"

	self shouldNotImplement
]

{ #category : #dependencies }
GtBoxerReferenceBox >> release [
	"release is not really needed"

	self class release: self resourceData
]
