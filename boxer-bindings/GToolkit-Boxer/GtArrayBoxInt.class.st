Class {
	#name : #GtArrayBoxInt,
	#superclass : #GtArrayBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtArrayBoxInt class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_int_create_from_data(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtArrayBoxInt class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primArrayIntRelease: aHandle
]

{ #category : #'private - ffi' }
GtArrayBoxInt >> externalType [
	^ FFIExternalType resolveType: 'int'
]

{ #category : #'private - ffi' }
GtArrayBoxInt >> primAt: anIndex [
	^ self ffiLibrary
		primArrayInt: self
		at: anIndex
]

{ #category : #'private - ffi' }
GtArrayBoxInt >> primAt: anIndex put: anItem [
	^ self ffiLibrary
		primArrayInt: self
		at: anIndex
		put: anItem
]

{ #category : #'private - ffi' }
GtArrayBoxInt >> primCopyInto: anArrayBoxInt [
	self ffiLibrary
		primArrayInt: self
		copyInto: anArrayBoxInt
]

{ #category : #'private - ffi' }
GtArrayBoxInt >> primGetCapacity [
	^ self ffiLibrary
		primArrayIntGetCapacity: self
]

{ #category : #'private - ffi' }
GtArrayBoxInt >> primGetData [
	^ self ffiLibrary
		primArrayIntGetData: self
]

{ #category : #'private - ffi' }
GtArrayBoxInt >> primGetLength [
	^ self ffiLibrary
		primArrayIntGetLength: self
]
