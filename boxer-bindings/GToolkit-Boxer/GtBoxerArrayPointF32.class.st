Class {
	#name : #GtBoxerArrayPointF32,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 class >> primCreate [
	^ self ffiCall: #(void* boxer_array_point_f32_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_point_f32_create_from_data(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_point_f32_create_with(GtBoxerPointF32 aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_point_f32_drop(void* aHandle))
]

{ #category : #converting }
GtBoxerArrayPointF32 >> asPoints [
	<return: #Collection of: #Point>

	^ self data collect: [ :eachPointF32 | eachPointF32 asPoint ] as: Array
]

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 >> externalType [
	^ FFIExternalStructureType objectClass: GtBoxerPointF32Structure
]

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_point_f32_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 >> primGetData [
	^ self ffiCall: #(void* boxer_array_point_f32_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayPointF32 >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_point_f32_get_length(self))
]
