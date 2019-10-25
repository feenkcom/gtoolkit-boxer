Class {
	#name : #GtBoxerSizeF64,
	#superclass : #GtBoxerSize,
	#category : #'GToolkit-Boxer'
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
