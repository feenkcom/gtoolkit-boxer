Class {
	#name : #GtBoxerSizeF64,
	#superclass : #GtBoxerSize,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerSizeF64 class >> primCreate [
	^ self ffiCall: #(void* boxer_size_f64_create())
]

{ #category : #'private - ffi' }
GtBoxerSizeF64 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_size_f64_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerSizeF64 >> primGetHeight [
	^ self ffiCall: #(float64 boxer_size_f64_get_height(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeF64 >> primGetWidth [
	^ self ffiCall: #(float64 boxer_size_f64_get_width(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeF64 >> primSetHeight: aNumber [
	self ffiCall: #(void boxer_size_f64_set_height(self, float64 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerSizeF64 >> primSetWidth: aNumber [
	self ffiCall: #(void boxer_size_f64_set_width(self, float64 aNumber))
]
