Class {
	#name : #GtBoxerPointI32,
	#superclass : #GtBoxerPoint,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #converting }
GtBoxerPointI32 class >> asExternalTypeOn: generator [
	^ FFIExternalObjectType objectClass: self
]

{ #category : #'private - ffi' }
GtBoxerPointI32 class >> primCreate [
	^ self ffiCall: #(void* boxer_point_i32_default())
]

{ #category : #'private - ffi' }
GtBoxerPointI32 class >> primCreateX: aX y: aY [
	^ self ffiCall: #(void* boxer_point_i32_create(int32 aX, int32 aY))
]

{ #category : #'private - ffi' }
GtBoxerPointI32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_point_i32_drop(void** aHandle))
]

{ #category : #'private - ffi' }
GtBoxerPointI32 >> primGetX [
	^ self ffiCall: #(int32 boxer_point_i32_get_x(self))
]

{ #category : #'private - ffi' }
GtBoxerPointI32 >> primGetY [
	^ self ffiCall: #(int32 boxer_point_i32_get_y(self))
]

{ #category : #'private - ffi' }
GtBoxerPointI32 >> primSetX: aNumber [
	self ffiCall: #(void boxer_point_i32_set_x(self, int32 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerPointI32 >> primSetY: aNumber [
	self ffiCall: #(void boxer_point_i32_set_y(self, int32 aNumber))
]
