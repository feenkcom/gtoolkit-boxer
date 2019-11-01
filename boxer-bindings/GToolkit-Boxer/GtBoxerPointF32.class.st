Class {
	#name : #GtBoxerPointF32,
	#superclass : #GtBoxerPoint,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #converting }
GtBoxerPointF32 class >> asExternalTypeOn: generator [
	^ FFIExternalObjectType objectClass: self
]

{ #category : #'private - ffi' }
GtBoxerPointF32 class >> primCreate [
	^ self ffiCall: #(void* boxer_point_f32_create())
]

{ #category : #'private - ffi' }
GtBoxerPointF32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_point_f32_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerPointF32 >> primGetX [
	^ self ffiCall: #(float32 boxer_point_f32_get_x(self))
]

{ #category : #'private - ffi' }
GtBoxerPointF32 >> primGetY [
	^ self ffiCall: #(float32 boxer_point_f32_get_y(self))
]

{ #category : #'private - ffi' }
GtBoxerPointF32 >> primSetX: aNumber [
	self ffiCall: #(void boxer_point_f32_set_x(self, float32 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerPointF32 >> primSetY: aNumber [
	self ffiCall: #(void boxer_point_f32_set_y(self, float32 aNumber))
]
