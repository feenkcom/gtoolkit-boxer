Class {
	#name : #GtBoxerPoint3F32,
	#superclass : #GtBoxerPoint3,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerPoint3F32 class >> primCreate [
	^ self ffiCall: #(void* boxer_point3_f32_default())
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 class >> primCreateX: aX y: aY z: aZ [
	^ self ffiCall: #(void* boxer_point3_f32_create(float32 aX, float32 aY, float32 aZ))
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_point3_f32_drop(void** aHandle))
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 >> primGetX [
	^ self ffiCall: #(float32 boxer_point3_f32_get_x(self))
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 >> primGetY [
	^ self ffiCall: #(float32 boxer_point3_f32_get_y(self))
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 >> primGetZ [
	^ self ffiCall: #(float32 boxer_point3_f32_get_z(self))
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 >> primSetX: aNumber [
	self ffiCall: #(void boxer_point3_f32_set_x(self, float32 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 >> primSetY: aNumber [
	self ffiCall: #(void boxer_point3_f32_set_y(self, float32 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerPoint3F32 >> primSetZ: aNumber [
	self ffiCall: #(void boxer_point3_f32_set_z(self, float32 aNumber))
]
