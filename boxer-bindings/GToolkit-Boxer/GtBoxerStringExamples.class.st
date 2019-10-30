Class {
	#name : #GtBoxerStringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerStringExamples >> default [
	<gtExample>
	| aString |
	
	aString := GtBoxerString new.
	self assert: aString length isInteger.
	self assert: aString size isInteger.
	self assert: aString string isString.
	self assert: aString length isZero.
	self assert: aString size isZero.
	self assert: aString string isEmpty.
	
	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> getLengthFromReleased [
	<gtExample>
	| aString |
	
	aString := self release.
	self assert: aString length isZero.
	
	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> getSizeFromReleased [
	<gtExample>
	| aString |
	
	aString := self release.
	self assert: aString size isZero.
	
	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> getStringFromReleased [
	<gtExample>
	| aString |
	
	aString := self release.
	self assert: aString string isEmpty.
	
	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> release [
	<gtExample>
	| aString |
	
	aString := self default.
	aString release.
	
	self assert: aString isNull.
	
	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> releaseTwice [
	<gtExample>
	| aString |
	
	aString := self release.
	aString release.
	self assert: aString isNull.

	^ aString
]

{ #category : #accessing }
GtBoxerStringExamples >> withStringGerman [
	<gtExample>
	| aString |
	
	aString := self default.
	aString string: 'Grüße'.
	
	self assert: aString size equals: 5.
	self assert: aString length equals: 5 + 2. "ü and ß occupy two chars"
	self assert: aString string equals: 'Grüße'.
	
	^ aString
]

{ #category : #accessing }
GtBoxerStringExamples >> withStringLatin [
	<gtExample>
	| aString |
	
	aString := self default.
	aString string: 'Hello'.
	
	self assert: aString size equals: 5.
	self assert: aString length equals: 5.
	self assert: aString string equals: 'Hello'.
	
	^ aString
]

{ #category : #accessing }
GtBoxerStringExamples >> withStringRussian [
	<gtExample>
	| aString |
	
	aString := self default.
	aString string: 'Привет'.
	
	self assert: aString size equals: 6.
	self assert: aString length equals: 6 * 2 "each russian letter is 2 chars".
	self assert: aString string equals: 'Привет'.
	
	^ aString
]
