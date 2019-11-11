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
GtBoxerArrayF32 class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_f32_create_from_data(void* anExternalAddress, size_t aSize))
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

{ #category : #'instance creation' }
GtBoxerArrayF32 class >> withAll: aCollectionOfFloats [
	| theBoxedFloats |
	
	theBoxedFloats := self new: aCollectionOfFloats size withAll: 0.0.
	aCollectionOfFloats withIndexDo: [ :eachPosition :eachIndex | theBoxedFloats at: eachIndex put: eachPosition ].
	
	^ theBoxedFloats
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 >> externalType [
	^ FFIFloat32 externalType
]

{ #category : #'private - ffi' }
GtBoxerArrayF32 >> primAt: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_f32_at_put(self, size_t anIndex, float32 anItem))
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
