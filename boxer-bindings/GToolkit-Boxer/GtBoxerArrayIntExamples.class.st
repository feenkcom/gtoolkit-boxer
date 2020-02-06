Class {
	#name : #GtBoxerArrayIntExamples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #'instance creation' }
GtBoxerArrayIntExamples >> default [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayInt new.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'instance creation' }
GtBoxerArrayIntExamples >> fromData [
	<gtExample>
	| anFFIExternalArray anArray |
	
	anFFIExternalArray := FFIExternalArray externalNewType: 'int' size: 201.
	anFFIExternalArray atAll: (1 to: 201) putAll: (-100 to: 100).
	anFFIExternalArray autoRelease.
	
	anArray := GtBoxerArrayInt fromHandle: anFFIExternalArray getHandle size: 201.
	self assert: anArray size equals: 201.
	self assert: anArray capacity >= 201.
	self assert: anArray asArray equals: (-100 to: 100) asArray.
	
	"anFFIExternalArray is the owner of data"
	anArray release.
	
	self assert: anFFIExternalArray asArray equals: (-100 to: 100) asArray. 
	
	^ anFFIExternalArray
]

{ #category : #'examples - null ptr' }
GtBoxerArrayIntExamples >> release [
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
GtBoxerArrayIntExamples >> setElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayInt new: 2 withAll: 0.
	self assert: anArray size equals: 2.
	self assert: anArray capacity >= 2. 

	self assert: anArray asArray equals: #(0 0).
	
	anArray at: 1 put: 1.
	anArray at: 2 put: 2.
	
	self assert: (anArray at: 1) equals: 1.
	self assert: (anArray at: 2) equals: 2.
	self assert: anArray asArray equals: #(1 2).
	
	^ anArray
]

{ #category : #'instance creation' }
GtBoxerArrayIntExamples >> withElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayInt new: 100 withAll: 0.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.

	self assert: anArray asArray equals: (Array new: 100 withAll: 0). 
	
	^ anArray
]
