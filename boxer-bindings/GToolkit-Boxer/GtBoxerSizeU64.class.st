Class {
	#name : #GtBoxerSizeU64,
	#superclass : #GtBoxerSize,
	#category : #'GToolkit-Boxer'
}

{ #category : #'private - ffi' }
GtBoxerSizeU64 class >> primCreate [
	^ self ffiCall: #(void* boxer_size_u64_create())
]

{ #category : #'private - ffi' }
GtBoxerSizeU64 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_size_u64_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerSizeU64 >> primGetHeight [
	^ self ffiCall: #(uint64 boxer_size_u64_get_height(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeU64 >> primGetWidth [
	^ self ffiCall: #(uint64 boxer_size_u64_get_width(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeU64 >> primSetHeight: aNumber [
	self ffiCall: #(void boxer_size_u64_set_height(self, uint64 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerSizeU64 >> primSetWidth: aNumber [
	self ffiCall: #(void boxer_size_u64_set_width(self, uint64 aNumber))
]
