Class {
	#name : #GtArrayBoxF32,
	#superclass : #GtArrayBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - ffi' }
GtArrayBoxF32 class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primArrayF32Release: aHandle
]

{ #category : #converting }
GtArrayBoxF32 >> asPoints [
	| thePoints anIndex |
	
	thePoints := Array new: self size // 2.
	anIndex := 1.

	self pairsDo: [ :x :y |
		thePoints at: anIndex put: (x @ y).
		anIndex := anIndex + 1 ].

	^ thePoints
]

{ #category : #converting }
GtArrayBoxF32 >> asRectangles [
	| theRectangles anIndex |
	
	theRectangles := Array new: self size // 4.
	anIndex := 1.

	self quartetsDo: [ :left :top :right :bottom |
		theRectangles at: anIndex put: (left @ top corner: right @ bottom).
		anIndex := anIndex + 1 ].

	^ theRectangles
]

{ #category : #'private - array' }
GtArrayBoxF32 >> externalType [
	<return: #'FFIExternalType class'>

	^ FFIFloat32
]

{ #category : #'private - array' }
GtArrayBoxF32 >> primAt: anIndex [
	^ self ffiLibrary
		primArrayF32: self
		at: anIndex
]

{ #category : #'private - array' }
GtArrayBoxF32 >> primAt: anIndex put: anItem [
	^ self ffiLibrary
		primArrayF32: self
		at: anIndex
		put: anItem
]

{ #category : #'private - array' }
GtArrayBoxF32 >> primCopyInto: anArrayBoxF32 [
	self ffiLibrary
		primArrayF32: self
		copyInto: anArrayBoxF32
]

{ #category : #'private - array' }
GtArrayBoxF32 >> primGetCapacity [
	^ self ffiLibrary
		primArrayF32GetCapacity: self
]

{ #category : #'private - array' }
GtArrayBoxF32 >> primGetData [
	^ self ffiLibrary
		primArrayF32GetData: self
]

{ #category : #'private - array' }
GtArrayBoxF32 >> primGetLength [
	^ self ffiLibrary
		primArrayF32GetLength: self
]
