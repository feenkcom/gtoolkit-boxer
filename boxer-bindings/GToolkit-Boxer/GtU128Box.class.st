Class {
	#name : #GtU128Box,
	#superclass : #GtExternalLibraryBox,
	#classVars : [
		'MAX',
		'MIN'
	],
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'class initialization' }
GtU128Box class >> initialize [
	MIN := 0.
	MAX := 340282366920938463463374607431768211455
]

{ #category : #accessing }
GtU128Box class >> maxValue [
	^ MAX
]

{ #category : #accessing }
GtU128Box class >> minValue [
	^ MIN
]

{ #category : #'private - ffi' }
GtU128Box class >> primRelease: aHandle library: anFFILibrary [
	anFFILibrary primU128Release: aHandle
]

{ #category : #converting }
GtU128Box >> asInteger [
	^ (self high << 64) + self low
]

{ #category : #accessing }
GtU128Box >> high [
	^ self ffiLibrary primU128GetHigh: self
]

{ #category : #accessing }
GtU128Box >> high: aNumber [
	self ffiLibrary
		primU128: self setHigh: aNumber
]

{ #category : #initialization }
GtU128Box >> initializeMax [
	self ffiLibrary primU128SetMax: self
]

{ #category : #initialization }
GtU128Box >> initializeMin [
	self ffiLibrary primU128SetMin: self
]

{ #category : #accessing }
GtU128Box >> low [
	^ self ffiLibrary primU128GetLow: self
]

{ #category : #accessing }
GtU128Box >> low: aNumber [
	self ffiLibrary
		primU128: self setLow: aNumber
]

{ #category : #printing }
GtU128Box >> printOn: aStream [
	aStream print: self asInteger
]
