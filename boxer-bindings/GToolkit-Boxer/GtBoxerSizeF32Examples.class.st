"
I am a copy of class GtBoxerSizeF64Examples. This comment is copied from there, and might not be entirely accurate

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
	#name : #GtBoxerSizeF32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerSizeF32Examples >> default [
	<gtExample>
	| aSize |
	
	aSize := GtBoxerSizeF32 new.
	self assert: aSize width isFloat.
	self assert: aSize height isFloat.
	self assert: aSize width isZero.
	self assert: aSize height isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> getHeightFromReleased [
	<gtExample>
	| aSize |
	
	aSize := self release.
	self assert: aSize height isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> getWidthFromReleased [
	<gtExample>
	| aSize |
	
	aSize := self release.
	self assert: aSize width isZero.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> release [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize release.
	
	self assert: aSize isNull.
	
	^ aSize
]

{ #category : #'examples - null ptr' }
GtBoxerSizeF32Examples >> releaseTwice [
	<gtExample>
	| aSize |
	
	aSize := self release.
	aSize release.
	self assert: aSize isNull.

	^ aSize
]

{ #category : #accessing }
GtBoxerSizeF32Examples >> withHeight200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize height: 200.0.
	
	self assert: aSize height equals: 200.0.
	self assert: aSize width isZero.
	
	^ aSize
]

{ #category : #accessing }
GtBoxerSizeF32Examples >> withWidth200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize width: 200.0.
	
	self assert: aSize width equals: 200.0.
	self assert: aSize height isZero.
	
	^ aSize
]
