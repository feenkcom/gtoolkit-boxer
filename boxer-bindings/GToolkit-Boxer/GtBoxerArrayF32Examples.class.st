Class {
	#name : #GtBoxerArrayF32Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerArrayF32Examples >> default [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayF32 new.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - null ptr' }
GtBoxerArrayF32Examples >> release [
	<gtExample>
	| anArray |
	
	anArray := self default.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #accessing }
GtBoxerArrayF32Examples >> setElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayF32 new: 2 withAll: 0.0.
	self assert: anArray size equals: 2.
	self assert: anArray capacity >= 2. 

	self assert: anArray asArray equals: #(0.0 0.0).
	
	anArray at: 1 put: 1.0.
	anArray at: 2 put: 2.0.
	
	self assert: anArray asArray equals: #(1.0 2.0).
	
	^ anArray
]

{ #category : #accessing }
GtBoxerArrayF32Examples >> withElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayF32 new: 100 withAll: 0.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100. 
	self assert: anArray data asArray equals: (Array new: 100 withAll: 0). 
	
	^ anArray
]
