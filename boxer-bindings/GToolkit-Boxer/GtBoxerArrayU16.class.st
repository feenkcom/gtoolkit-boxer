Class {
	#name : #GtBoxerArrayU16,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerArrayU16 class >> primCreate [
	^ self ffiCall: #(void* boxer_array_u16_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_u16_create_with(uint8 aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_u16_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> externalType [
	^ FFIUInt16 externalType
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_u16_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> primGetData [
	^ self ffiCall: #(void* boxer_array_u16_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayU16 >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_u16_get_length(self))
]
