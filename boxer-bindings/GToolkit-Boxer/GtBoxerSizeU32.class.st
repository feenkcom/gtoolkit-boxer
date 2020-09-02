Class {
	#name : #GtBoxerSizeU32,
	#superclass : #GtBoxerSize,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerSizeU32 class >> primCreate [
	^ self ffiCall: #(void* boxer_size_u32_create())
]

{ #category : #'private - ffi' }
GtBoxerSizeU32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_size_u32_drop(void** aHandle))
]

{ #category : #'private - ffi' }
GtBoxerSizeU32 >> primGetHeight [
	^ self ffiCall: #(uint32 boxer_size_u32_get_height(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeU32 >> primGetWidth [
	^ self ffiCall: #(uint32 boxer_size_u32_get_width(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeU32 >> primSetHeight: aNumber [
	self ffiCall: #(void boxer_size_u32_set_height(self, uint32 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerSizeU32 >> primSetWidth: aNumber [
	self ffiCall: #(void boxer_size_u32_set_width(self, uint32 aNumber))
]
