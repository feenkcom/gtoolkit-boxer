Class {
	#name : #GtArrayBoxUInt,
	#superclass : #GtArrayBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtArrayBoxUInt class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primArrayUIntRelease: aHandle
]

{ #category : #accessing }
GtArrayBoxUInt >> externalType [
	^ FFIExternalType resolveType: 'uint'
]

{ #category : #'private - array' }
GtArrayBoxUInt >> primAt: anIndex [
	^ self ffiLibrary
		primArrayUInt: self
		at: anIndex
]

{ #category : #'private - array' }
GtArrayBoxUInt >> primAt: anIndex put: anItem [
	^ self ffiLibrary
		primArrayUInt: self
		at: anIndex
		put: anItem
]

{ #category : #'private - array' }
GtArrayBoxUInt >> primCopyInto: anArrayBoxUInt [
	self ffiLibrary
		primArrayUInt: self
		copyInto: anArrayBoxUInt
]

{ #category : #'private - array' }
GtArrayBoxUInt >> primGetCapacity [
	^ self ffiLibrary
		primArrayUIntGetCapacity: self
]

{ #category : #'private - array' }
GtArrayBoxUInt >> primGetData [
	^ self ffiLibrary
		primArrayUIntGetData: self
]

{ #category : #'private - array' }
GtArrayBoxUInt >> primGetLength [
	^ self ffiLibrary
		primArrayUIntGetLength: self
]
