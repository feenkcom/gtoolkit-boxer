Class {
	#name : #GtBoxerPointF64,
	#superclass : #GtBoxerPoint,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerPointF64 class >> primCreate [
	^ self ffiCall: #(void* boxer_point_f64_default())
]

{ #category : #'private - ffi' }
GtBoxerPointF64 class >> primCreateX: aX y: aY [
	^ self ffiCall: #(void* boxer_point_f64_create(float64 aX, float64 aY))
]

{ #category : #'private - ffi' }
GtBoxerPointF64 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_point_f64_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerPointF64 >> primGetX [
	^ self ffiCall: #(float64 boxer_point_f64_get_x(self))
]

{ #category : #'private - ffi' }
GtBoxerPointF64 >> primGetY [
	^ self ffiCall: #(float64 boxer_point_f64_get_y(self))
]

{ #category : #'private - ffi' }
GtBoxerPointF64 >> primSetX: aNumber [
	self ffiCall: #(void boxer_point_f64_set_x(self, float64 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerPointF64 >> primSetY: aNumber [
	self ffiCall: #(void boxer_point_f64_set_y(self, float64 aNumber))
]
