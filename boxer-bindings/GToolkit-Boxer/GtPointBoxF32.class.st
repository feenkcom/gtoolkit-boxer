Class {
	#name : #GtPointBoxF32,
	#superclass : #GtPointBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtPointBoxF32 class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primPointF32Release: aHandle
]

{ #category : #'private - ffi' }
GtPointBoxF32 >> primGetX [
	^ self ffiLibrary primPointF32GetX: self
]

{ #category : #'private - ffi' }
GtPointBoxF32 >> primGetY [
	^ self ffiLibrary primPointF32GetY: self
]

{ #category : #'private - ffi' }
GtPointBoxF32 >> primSetX: aNumber [
	^ self ffiLibrary
		primPointF32: self setX: aNumber
]

{ #category : #'private - ffi' }
GtPointBoxF32 >> primSetY: aNumber [
	^ self ffiLibrary
		primPointF32: self setY: aNumber
]
