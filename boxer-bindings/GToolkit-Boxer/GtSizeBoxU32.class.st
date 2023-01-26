Class {
	#name : #GtSizeBoxU32,
	#superclass : #GtSizeBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtSizeBoxU32 class >> primRelease: aHandle library: anFFILibrary [
	^ anFFILibrary primSizeU32Release: aHandle
]

{ #category : #'private - ffi' }
GtSizeBoxU32 >> primGetHeight [
	^ self ffiLibrary primSizeU32GetHeight: self
]

{ #category : #'private - ffi' }
GtSizeBoxU32 >> primGetWidth [
	^ self ffiLibrary primSizeU32GetWidth: self
]

{ #category : #'private - ffi' }
GtSizeBoxU32 >> primSetHeight: aNumber [
	self ffiLibrary
		primSizeU32: self setHeight: aNumber
]

{ #category : #'private - ffi' }
GtSizeBoxU32 >> primSetWidth: aNumber [
	self ffiLibrary
		primSizeU32: self setWidth: aNumber
]
