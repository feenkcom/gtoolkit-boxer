Class {
	#name : #GtBoxerUint128,
	#superclass : #GtBoxerExternalObject,
	#classVars : [
		'MAX',
		'MIN'
	],
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'class initialization' }
GtBoxerUint128 class >> initialize [
	MIN := 0.
	MAX := 340282366920938463463374607431768211455
]

{ #category : #'instance creation' }
GtBoxerUint128 class >> max [
	^ self new initializeMax
]

{ #category : #accessing }
GtBoxerUint128 class >> maxValue [
	^ MAX
]

{ #category : #'instance creation' }
GtBoxerUint128 class >> min [
	^ self new initializeMin
]

{ #category : #accessing }
GtBoxerUint128 class >> minValue [
	^ MIN
]

{ #category : #'private - ffi' }
GtBoxerUint128 class >> primCreate [
	^ self ffiCall: #(void* boxer_number_uint128_create())
]

{ #category : #'private - ffi' }
GtBoxerUint128 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void glutin_number_uint128_drop(void* aHandle))
]

{ #category : #converting }
GtBoxerUint128 >> asInteger [
	^ (self high << 64) + self low
]

{ #category : #accessing }
GtBoxerUint128 >> high [
	^ self primGetHigh
]

{ #category : #accessing }
GtBoxerUint128 >> high: aNumber [
	self primSetHigh: aNumber
]

{ #category : #initialization }
GtBoxerUint128 >> initializeMax [
	self primSetMax
]

{ #category : #initialization }
GtBoxerUint128 >> initializeMin [
	self primSetMin
]

{ #category : #accessing }
GtBoxerUint128 >> low [
	^ self primGetLow
]

{ #category : #accessing }
GtBoxerUint128 >> low: aNumber [
	self primSetLow: aNumber
]

{ #category : #'private - ffi' }
GtBoxerUint128 >> primGetHigh [
	^ self ffiCall: #(uint64 boxer_number_uint128_get_high(self))
]

{ #category : #'private - ffi' }
GtBoxerUint128 >> primGetLow [
	^ self ffiCall: #(uint64 boxer_number_uint128_get_low(self))
]

{ #category : #'private - ffi' }
GtBoxerUint128 >> primSetHigh: aNumber [
	^ self ffiCall: #(void boxer_number_uint128_set_high(self, uint64 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerUint128 >> primSetLow: aNumber [
	^ self ffiCall: #(void boxer_number_uint128_set_low(self, uint64 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerUint128 >> primSetMax [
	^ self ffiCall: #(void boxer_number_uint128_set_max(self))
]

{ #category : #'private - ffi' }
GtBoxerUint128 >> primSetMin [
	^ self ffiCall: #(void boxer_number_uint128_set_min(self))
]

{ #category : #printing }
GtBoxerUint128 >> printOn: aStream [
	aStream print: self asInteger
]
