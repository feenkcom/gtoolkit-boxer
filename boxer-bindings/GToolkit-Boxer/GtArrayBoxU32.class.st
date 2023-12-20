Class {
	#name : #GtArrayBoxU32,
	#superclass : #GtArrayBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtArrayBoxU32 class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primArrayU32Release: aHandle
]

{ #category : #'private - array' }
GtArrayBoxU32 >> externalType [
	^ FFIUInt32
]

{ #category : #'private - array' }
GtArrayBoxU32 >> primAt: anIndex [
	^ self ffiLibrary
		primArrayU32: self
		at: anIndex
]

{ #category : #'private - array' }
GtArrayBoxU32 >> primAt: anIndex put: anItem [
	^ self ffiLibrary
		primArrayU32: self
		at: anIndex
		put: anItem
]

{ #category : #'private - array' }
GtArrayBoxU32 >> primCopyInto: anArrayBoxU32 [
	self ffiLibrary
		primArrayU32: self
		copyInto: anArrayBoxU32
]

{ #category : #'private - array' }
GtArrayBoxU32 >> primGetCapacity [
	^ self ffiLibrary
		primArrayU32GetCapacity: self
]

{ #category : #'private - array' }
GtArrayBoxU32 >> primGetData [
	^ self ffiLibrary
		primArrayU32GetData: self
]

{ #category : #'private - array' }
GtArrayBoxU32 >> primGetLength [
	^ self ffiLibrary
		primArrayU32GetLength: self
]
