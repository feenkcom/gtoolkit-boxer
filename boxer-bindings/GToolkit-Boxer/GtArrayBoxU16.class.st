Class {
	#name : #GtArrayBoxU16,
	#superclass : #GtArrayBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtArrayBoxU16 class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primArrayU16Release: aHandle
]

{ #category : #converting }
GtArrayBoxU16 >> asByteArray [
	"Return an in-image allocated byte array that contains a copy of the bytes"
	<return: #ByteArray>
	| aByteArray |
	
	aByteArray := ByteArray new: self size * 2.
	self copyIntoByteArray: aByteArray.
	^ aByteArray
]

{ #category : #copying }
GtArrayBoxU16 >> copyIntoByteArray: aByteArray [
	| wasPinned |
	
	wasPinned := aByteArray isPinnedInMemory.
	
	[ self ffiLibrary
		primArrayU16: self
		copyIntoData: aByteArray
		length: aByteArray size // 2 ]
	ensure: [ aByteArray setPinnedInMemory: wasPinned ]
]

{ #category : #accessing }
GtArrayBoxU16 >> externalType [
	^ FFIUInt16
]

{ #category : #'private - array' }
GtArrayBoxU16 >> primAt: anIndex [
	^ self ffiLibrary
		primArrayU16: self
		at: anIndex
]

{ #category : #'private - array' }
GtArrayBoxU16 >> primAt: anIndex put: anItem [
	^ self ffiLibrary
		primArrayU16: self
		at: anIndex
		put: anItem
]

{ #category : #'private - array' }
GtArrayBoxU16 >> primCopyInto: anArrayBoxU16 [
	self ffiLibrary
		primArrayU16: self
		copyInto: anArrayBoxU16
]

{ #category : #'private - array' }
GtArrayBoxU16 >> primGetCapacity [
	^ self ffiLibrary
		primArrayU16GetCapacity: self
]

{ #category : #'private - array' }
GtArrayBoxU16 >> primGetData [
	^ self ffiLibrary
		primArrayU16GetData: self
]

{ #category : #'private - array' }
GtArrayBoxU16 >> primGetLength [
	^ self ffiLibrary
		primArrayU16GetLength: self
]
