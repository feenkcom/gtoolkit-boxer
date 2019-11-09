Class {
	#name : #GtBoxerArrayU8Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerArrayU8Examples >> default [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayU8 new.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'examples - null ptr' }
GtBoxerArrayU8Examples >> release [
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
GtBoxerArrayU8Examples >> setElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayU8 new: 2 withAll: 0.
	self assert: anArray size equals: 2.
	self assert: anArray capacity >= 2. 

	self assert: anArray asArray equals: #(0 0).
	
	anArray at: 1 put: 1.
	anArray at: 2 put: 2.
	
	self assert: anArray asArray equals: #(1 2).
	
	^ anArray
]

{ #category : #accessing }
GtBoxerArrayU8Examples >> withElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayU8 new: 100 withAll: 0.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.

	self assert: anArray asArray equals: (Array new: 100 withAll: 0). 
	
	^ anArray
]
