Class {
	#name : #GtBoxerArrayInt,
	#superclass : #GtBoxerArray,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerArrayInt class >> primCreate [
	^ self ffiCall: #(void* boxer_array_int_create())
]

{ #category : #'private - ffi' }
GtBoxerArrayInt class >> primCreateFromData: anExternalAddress size: aSize [
	^ self ffiCall: #(void* boxer_array_int_create_from_data(void* anExternalAddress, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayInt class >> primCreateNew: aSize withAll: aValue [
	^ self ffiCall: #(void* boxer_array_int_create_with(int aValue, size_t aSize))
]

{ #category : #'private - ffi' }
GtBoxerArrayInt class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_array_int_drop(void** aHandle))
]

{ #category : #'instance creation' }
GtBoxerArrayInt class >> withAll: aCollectionOfNumbers during: aBlock [	
	^ self
		fromNativeHandle: (self primCreateNew: aCollectionOfNumbers size withAll: 0)
		during: [ :aGtBoxerArray |
			aCollectionOfNumbers withIndexDo: [ :eachNumber :eachIndex | aGtBoxerArray at: eachIndex put: eachNumber ].
			aBlock value: aGtBoxerArray ]
]

{ #category : #accessing }
GtBoxerArrayInt >> at: anIndex [
	^ self primAt: anIndex - 1
]

{ #category : #'private - ffi' }
GtBoxerArrayInt >> externalType [
	^ FFIExternalType resolveType: 'int'
]

{ #category : #'private - ffi' }
GtBoxerArrayInt >> primAt: anIndex [
	^ self ffiCall: #(int boxer_array_int_at(self, size_t anIndex))
]

{ #category : #'private - ffi' }
GtBoxerArrayInt >> primAt: anIndex put: anItem [
	^ self ffiCall: #(void boxer_array_int_at_put(self, size_t anIndex, int anItem))
]

{ #category : #'private - ffi' }
GtBoxerArrayInt >> primGetCapacity [
	^ self ffiCall: #(size_t boxer_array_int_get_capacity(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayInt >> primGetData [
	^ self ffiCall: #(void* boxer_array_int_get_data(self))
]

{ #category : #'private - ffi' }
GtBoxerArrayInt >> primGetLength [
	^ self ffiCall: #(size_t boxer_array_int_get_length(self))
]
