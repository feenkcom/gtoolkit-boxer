Class {
	#name : #GtBoxerSizeI32,
	#superclass : #GtBoxerSize,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerSizeI32 class >> primCreate [
	^ self ffiCall: #(void* boxer_size_i32_create())
]

{ #category : #'private - ffi' }
GtBoxerSizeI32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_size_i32_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerSizeI32 >> primGetHeight [
	^ self ffiCall: #(int32 boxer_size_i32_get_height(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeI32 >> primGetWidth [
	^ self ffiCall: #(int32 boxer_size_i32_get_width(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeI32 >> primSetHeight: aNumber [
	self ffiCall: #(void boxer_size_i32_set_height(self, int32 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerSizeI32 >> primSetWidth: aNumber [
	self ffiCall: #(void boxer_size_i32_set_width(self, int32 aNumber))
]
