Class {
	#name : #GtPointBoxI32,
	#superclass : #GtPointBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtPointBoxI32 class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primPointI32Release: aHandle
]

{ #category : #'private - ffi' }
GtPointBoxI32 >> primGetX [
	^ self ffiLibrary primPointI32GetX: self
]

{ #category : #'private - ffi' }
GtPointBoxI32 >> primGetY [
	^ self ffiLibrary primPointI32GetY: self
]

{ #category : #'private - ffi' }
GtPointBoxI32 >> primSetX: aNumber [
	^ self ffiLibrary
		primPointI32: self setX: aNumber
]

{ #category : #'private - ffi' }
GtPointBoxI32 >> primSetY: aNumber [
	^ self ffiLibrary
		primPointI32: self setY: aNumber
]
