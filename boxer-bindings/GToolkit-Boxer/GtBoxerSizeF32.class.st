"
I am a copy of class GtBoxerSizeF64. This comment is copied from there, and might not be entirely accurate

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points


"
Class {
	#name : #GtBoxerSizeF32,
	#superclass : #GtBoxerSize,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerSizeF32 class >> primCreate [
	^ self ffiCall: #(void* boxer_size_f32_create())
]

{ #category : #'private - ffi' }
GtBoxerSizeF32 class >> primRelease: aHandle [
	
	"Plain pointers must be deleted using delete(), all users must implement a specific method"
	self ffiCall: #(void boxer_size_f32_drop(void* aHandle))
]

{ #category : #'private - ffi' }
GtBoxerSizeF32 >> primGetHeight [
	^ self ffiCall: #(float32 boxer_size_f32_get_height(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeF32 >> primGetWidth [
	^ self ffiCall: #(float32 boxer_size_f32_get_width(self))
]

{ #category : #'private - ffi' }
GtBoxerSizeF32 >> primSetHeight: aNumber [
	self ffiCall: #(void boxer_size_f32_set_height(self, float32 aNumber))
]

{ #category : #'private - ffi' }
GtBoxerSizeF32 >> primSetWidth: aNumber [
	self ffiCall: #(void boxer_size_f32_set_width(self, float32 aNumber))
]
