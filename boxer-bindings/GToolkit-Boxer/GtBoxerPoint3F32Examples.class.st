"
I am a copy of class GtBoxerPointF32Examples. This comment is copied from there, and might not be entirely accurate

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
	#name : #GtBoxerPoint3F32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerPoint3F32Examples >> createFromXYZ [
	<gtExample>
	| aPoint |
	
	aPoint := GtBoxerPoint3F32 x: 2.0 y: 3.0 z: 4.0.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint z isFloat.
	self assert: aPoint x equals: 2.0.
	self assert: aPoint y equals: 3.0.
	self assert: aPoint z equals: 4.0.
	
	^ aPoint
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> default [
	<gtExample>
	| aPoint |
	
	aPoint := GtBoxerPoint3F32 new.
	self assert: aPoint x isFloat.
	self assert: aPoint y isFloat.
	self assert: aPoint z isFloat.
	self assert: aPoint x isZero.
	self assert: aPoint y isZero.
	self assert: aPoint z isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> getXFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint x isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> getYFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint y isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> getZFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	self assert: aPoint z isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> release [
	<gtExample>
	| aPoint |
	
	aPoint := self default.
	aPoint release.
	
	self assert: aPoint isNull.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> releaseTwice [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint release.
	self assert: aPoint isNull.

	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> setXFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint x: 200.0.
	self assert: aPoint x isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> setYFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint y: 200.0.
	self assert: aPoint y isZero.
	
	^ aPoint
]

{ #category : #'examples - null ptr' }
GtBoxerPoint3F32Examples >> setZFromReleased [
	<gtExample>
	| aPoint |
	
	aPoint := self release.
	aPoint z: 200.0.
	self assert: aPoint z isZero.
	
	^ aPoint
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> withX200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize x: 200.0.
	
	self assert: aSize x equals: 200.0.
	self assert: aSize y isZero.
	self assert: aSize z isZero.
	
	^ aSize
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> withY200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize y: 200.0.
	
	self assert: aSize x isZero.
	self assert: aSize y equals: 200.0.
	self assert: aSize z isZero.
	
	^ aSize
]

{ #category : #accessing }
GtBoxerPoint3F32Examples >> withZ200 [
	<gtExample>
	| aSize |
	
	aSize := self default.
	aSize z: 200.0.
	
	self assert: aSize x isZero.
	self assert: aSize y isZero.
	self assert: aSize z equals: 200.0.
	
	^ aSize
]
