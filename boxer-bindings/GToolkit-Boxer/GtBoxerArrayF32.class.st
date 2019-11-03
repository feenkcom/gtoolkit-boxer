Class {
	#name : #GtBoxerArrayF32,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerArrayF32 class >> primCreate [
	^ self ffiCall: #(void* boxer_array_f32_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_f32_create_with(float32 aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_f32_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 >> externalType [
	^ FFIFloat32 externalType
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_f32_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 >> primGetData [
	^ self ffiCall: #(void* boxer_array_f32_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_f32_get_length(self))
]
