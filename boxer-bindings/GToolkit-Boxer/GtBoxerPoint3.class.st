"
I am a copy of class GtBoxerPoint. This comment is copied from there, and might not be entirely accurate

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
	#name : #GtBoxerPoint3,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'private - ffi' }
GtBoxerPoint3 class >> primCreateX: aX y: aY z: aZ [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtBoxerPoint3 class >> x: aX y: aY z: aZ [
	^ self fromNativeHandle: (self primCreateX: aX y: aY z: aZ)
]

{ #category : #'private - ffi' }
GtBoxerPoint3 >> primGetX [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint3 >> primGetY [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint3 >> primGetZ [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint3 >> primSetX: aNumber [
	self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint3 >> primSetY: aNumber [
	self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerPoint3 >> primSetZ: aNumber [
	self subclassResponsibility
]

{ #category : #printing }
GtBoxerPoint3 >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream nextPut: ${; space.

	aStream
		nextPutAll: 'x: ';
		print: self x.
	aStream
		nextPutAll: ' y: ';
		print: self y.
	aStream
		nextPutAll: ' z: ';
		print: self z.
		
	aStream space; nextPut: $}.
]

{ #category : #'accessing structure variables' }
GtBoxerPoint3 >> x [
	^ self primGetX
]

{ #category : #'accessing structure variables' }
GtBoxerPoint3 >> x: aNumber [
	self primSetX: aNumber
]

{ #category : #'accessing structure variables' }
GtBoxerPoint3 >> y [
	^ self primGetY
]

{ #category : #'accessing structure variables' }
GtBoxerPoint3 >> y: aNumber [
	self primSetY: aNumber
]

{ #category : #'accessing structure variables' }
GtBoxerPoint3 >> z [
	^ self primGetZ
]

{ #category : #'accessing structure variables' }
GtBoxerPoint3 >> z: aNumber [
	self primSetZ: aNumber
]
