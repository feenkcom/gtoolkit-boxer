Class {
	#name : #GtBoxerArrayUIntExamples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #'instance creation' }
GtBoxerArrayUIntExamples >> default [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayUInt new.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray
]

{ #category : #'instance creation' }
GtBoxerArrayUIntExamples >> fromData [
	<gtExample>
	| anFFIExternalArray anArray |
	
	anFFIExternalArray := FFIExternalArray externalNewType: 'uint' size: 100.
	anFFIExternalArray atAll: (1 to: 100) putAll: (1 to: 100).
	anFFIExternalArray autoRelease.
	
	anArray := GtBoxerArrayUInt fromHandle: anFFIExternalArray getHandle size: 100.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (1 to: 100) asArray.
	
	"anFFIExternalArray is the owner of data"
	anArray release.
	
	self assert: anFFIExternalArray asArray equals: (1 to: 100) asArray. 
	
	^ anFFIExternalArray
]

{ #category : #'examples - null ptr' }
GtBoxerArrayUIntExamples >> release [
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
GtBoxerArrayUIntExamples >> setElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayUInt new: 2 withAll: 0.
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
GtBoxerArrayUIntExamples >> withElement [
	<gtExample>
	| anArray |
	
	anArray := GtBoxerArrayUInt new: 100 withAll: 0.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.

	self assert: anArray asArray equals: (Array new: 100 withAll: 0). 
	
	^ anArray
]
