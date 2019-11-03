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
GtBoxerArrayF32Examples >> withElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayF32 new: 100 withAll: 0.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100. 
	self assert: anArray data asArray equals: (Array new: 100 withAll: 0). 
	
	^ anArray
]
