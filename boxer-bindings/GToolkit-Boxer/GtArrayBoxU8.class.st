Class {
	#name : #GtArrayBoxU8,
	#superclass : #GtArrayBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'instance creation' }
GtArrayBoxU8 class >> fromBitmap: aBitmap during: aBlock [
	"I create a boxer array that does not own a given data for duration of a block"
	| wasPinned |
	
	wasPinned := aBitmap pinInMemory.
	^ [ self fromHandle: aBitmap size: aBitmap size * 4 during: aBlock ]
		ensure: [ aBitmap setPinnedInMemory: wasPinned ]
]

{ #category : #'private - ffi' }
GtArrayBoxU8 class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primArrayU8Release: aHandle
]

{ #category : #converting }
GtArrayBoxU8 >> argbToRgba [
	"in place transform me from argb to rgba"
	
	self primArgbToRgba
]

{ #category : #converting }
GtArrayBoxU8 >> asBitmap [
	| aBitmap |
	"The data must be in ARGB8888 format"
	
	aBitmap := Bitmap new: self size // 4.
	aBitmap copyFromByteArray: self asByteArray.

	^ aBitmap
]

{ #category : #converting }
GtArrayBoxU8 >> asByteArray [
	<return: #ByteArray>
	| aByteArray |
	
	aByteArray := ByteArray new: self size.
	self copyIntoByteArray: aByteArray.
	^ aByteArray
]

{ #category : #converting }
GtArrayBoxU8 >> bgraToArgb [
	"in place transform me from bgra to argb"
	
	self primBgraToArgb
]

{ #category : #copying }
GtArrayBoxU8 >> copyIntoByteArray: aByteArray [
	self ffiLibrary
		primArrayU8: self
		copyIntoData: aByteArray
		length: aByteArray size
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> externalType [
	^ FFIUInt8
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primArgbToRgba [
	^ self ffiCall: #(void boxer_array_u8_argb_to_rgba(self))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primAt: anIndex [
	^ self ffiLibrary 
		primArrayU8: self
		at: anIndex
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primAt: anIndex put: anItem [
	self ffiLibrary
		primArrayU8: self
		at: anIndex
		put: anItem
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primBgraToArgb [
	^ self ffiCall: #(void boxer_array_u8_bgra_to_argb(self))
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primCopyInto: anArrayBoxU8 [
	self ffiLibrary
		primArrayU8: self
		copyInto: anArrayBoxU8
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primGetCapacity [
	^ self ffiLibrary primArrayU8GetCapacity: self
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primGetData [
	^ self ffiLibrary primArrayU8GetData: self
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primGetLength [
	^ self ffiLibrary primArrayU8GetLength: self
]

{ #category : #'private - ffi' }
GtArrayBoxU8 >> primRgbaToArgb [
	^ self ffiCall: #(void boxer_array_u8_rgba_to_argb(self))
]

{ #category : #converting }
GtArrayBoxU8 >> rgbaToArgb [
	"in place transform me from rgba to argb"
	
	self primRgbaToArgb
]
