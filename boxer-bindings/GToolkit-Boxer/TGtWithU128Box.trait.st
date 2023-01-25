Trait {
	#name : #TGtWithU128Box,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'api - u128' }
TGtWithU128Box >> getU128From: aBlock [
	<return: #Number>
	
	^ self newU128During: [ :anU128 |
		aBlock value: anU128.
		anU128 asInteger ]
]

{ #category : #'api - u128' }
TGtWithU128Box >> newMaxU128 [
	^ self newU128 initializeMax
]

{ #category : #'api - u128' }
TGtWithU128Box >> newMinU128 [
	^ self newU128 initializeMin
]

{ #category : #'api - u128' }
TGtWithU128Box >> newU128 [
	^ GtU128Box
		fromNativeHandle: self primU128Create
		library: self
]

{ #category : #'api - u128' }
TGtWithU128Box >> newU128During: aBlock [
	^ GtU128Box
		fromNativeHandle: self primU128Create
		library: self
		during: aBlock
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128: aU128Box setHigh: aNumber [
	^ self ffiCall: #(void boxer_number_uint128_set_high(GtU128Box aU128Box, uint64 aNumber))
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128: aU128Box setLow: aNumber [
	^ self ffiCall: #(void boxer_number_uint128_set_low(GtU128Box aU128Box, uint64 aNumber))
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128Create [
	^ self ffiCall: #(void* boxer_number_uint128_create())
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128GetHigh: aU128Box [
	^ self ffiCall: #(uint64 boxer_number_uint128_get_high(GtU128Box aU128Box))
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128GetLow: aU128Box [
	^ self ffiCall: #(uint64 boxer_number_uint128_get_low(GtU128Box aU128Box))
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128Release: aHandle [
	self ffiCall: #(void boxer_number_uint128_drop(void* aHandle))
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128SetMax: aU128Box [
	^ self ffiCall: #(void boxer_number_uint128_set_max(GtU128Box aU128Box))
]

{ #category : #'private - u128' }
TGtWithU128Box >> primU128SetMin: aU128Box [
	^ self ffiCall: #(void boxer_number_uint128_set_min(GtU128Box aU128Box))
]
