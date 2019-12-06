Class {
	#name : #GtBoxerArrayUInt,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerArrayUInt class >> primCreate [
	^ self ffiCall: #(void* boxer_array_uint_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_uint_create_from_data(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_uint_create_with(uint aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_uint_drop(void* aHandle))
]

{ #category : #accessing }
GtBoxerArrayUInt >> at: anIndex [
	^ self primAt: anIndex - 1
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt >> externalType [
	^ FFIExternalType resolveType: 'uint'
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt >> primAt: anIndex [
	^ self ffiCall: #(uint boxer_array_uint_at(self, size_t anIndex))
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt >> primAt: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_uint_at_put(self, size_t anIndex, uint anItem))
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_uint_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt >> primGetData [
	^ self ffiCall: #(void* boxer_array_uint_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayUInt >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_uint_get_length(self))
]
