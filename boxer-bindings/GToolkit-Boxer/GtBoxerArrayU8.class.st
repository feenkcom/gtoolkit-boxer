Class {
	#name : #GtBoxerArrayU8,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerArrayU8 class >> primCreate [
	^ self ffiCall: #(void* boxer_array_u8_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u8_create_with(uint8 aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_u8_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> externalType [
	^ FFIUInt8 externalType
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_u8_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primGetData [
	^ self ffiCall: #(void* boxer_array_u8_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU8 >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_u8_get_length(self))
]
