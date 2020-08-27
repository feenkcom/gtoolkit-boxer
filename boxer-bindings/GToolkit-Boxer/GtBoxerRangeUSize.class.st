Class {
	#name : #GtBoxerRangeUSize,
	#superclass : #GtBoxerRange,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerRangeUSize class >> primCreate [
	^ self ffiCall: #(void* boxer_range_usize_create())
]

{ #category : #'private - ffi' }
GtBoxerRangeUSize class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_range_usize_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerRangeUSize >> primGetEnd [
	^ self ffiCall: #(size_t boxer_range_usize_get_end(self))
]

{ #category : #'private - ffi' }
GtBoxerRangeUSize >> primGetStart [
	^ self ffiCall: #(size_t boxer_range_usize_get_start(self))
]

{ #category : #'private - ffi' }
GtBoxerRangeUSize >> primSetEnd: anEnd [
	^ self ffiCall: #(void boxer_range_usize_set_end(self, size_t anEnd))
]

{ #category : #'private - ffi' }
GtBoxerRangeUSize >> primSetStart: aStart [
	^ self ffiCall: #(void boxer_range_usize_set_start(self, size_t aStart))
]
