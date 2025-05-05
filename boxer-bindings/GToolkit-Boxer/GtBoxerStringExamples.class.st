Class {
	#name : #GtBoxerStringExamples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #accessing }
GtBoxerStringExamples >> default [
	<gtExample>
	<return: #GtBoxerString>
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

{ #category : #'instance creation' }
GtBoxerStringExamples >> fromByteArray [
	<gtExample>
	<return: #GtBoxerString>
	| aBoxerString |
	aBoxerString := GtBoxerString fromByteArray: #[72 101 108 108 111 0].
	self assert: aBoxerString string equals: 'Hello'.

	^ aBoxerString
]

{ #category : #'instance creation' }
GtBoxerStringExamples >> fromByteArrayDuring [
	<gtExample>
	<return: #GtBoxerStringExamples>
	self
		assert: (GtBoxerString
				fromByteArray: #[72 101 108 108 111 0]
				during: [ :aGtBoxerString | aGtBoxerString string ])
		equals: 'Hello'
]

{ #category : #'instance creation' }
GtBoxerStringExamples >> fromEmptyByteArray [
	<gtExample>
	<return: #GtBoxerString>
	| aBoxerString |
	aBoxerString := GtBoxerString fromByteArray: #[0].
	self assert: aBoxerString string equals: ''.

	^ aBoxerString
]

{ #category : #'instance creation' }
GtBoxerStringExamples >> fromEmptyString [
	<gtExample>
	<return: #GtBoxerString>
	| aBoxerString |
	aBoxerString := GtBoxerString fromString: ''.
	self assert: aBoxerString string equals: ''.

	^ aBoxerString
]

{ #category : #'instance creation' }
GtBoxerStringExamples >> fromString [
	<gtExample>
	<return: #GtBoxerString>
	| aBoxerString |
	aBoxerString := GtBoxerString fromString: 'Hello'.
	self assert: aBoxerString string equals: 'Hello'.

	^ aBoxerString
]

{ #category : #'instance creation' }
GtBoxerStringExamples >> fromStringDuring [
	<gtExample>
	<return: #GtBoxerStringExamples>
	self
		assert: (GtBoxerString
				fromString: 'Hello'
				during: [ :aGtBoxerString | aGtBoxerString string ])
		equals: 'Hello'
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> getLengthFromReleased [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := self release.
	self assert: aString length isZero.

	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> getSizeFromReleased [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := self release.
	self assert: aString size isZero.

	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> getStringFromReleased [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := self release.
	self assert: aString string isEmpty.

	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> release [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := self default.
	aString release.

	self assert: aString isNull.

	^ aString
]

{ #category : #'examples - null ptr' }
GtBoxerStringExamples >> releaseTwice [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := self release.
	aString release.
	self assert: aString isNull.

	^ aString
]

{ #category : #accessing }
GtBoxerStringExamples >> withStringEmpty [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := GtBoxerString fromString: ''.

	self assert: aString size equals: 0.
	self assert: aString length equals: 0.
	self assert: aString string equals: ''.

	^ aString
]

{ #category : #accessing }
GtBoxerStringExamples >> withStringGerman [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := GtBoxerString fromString: 'Grüße'.

	self assert: aString size equals: 5.
	self assert: aString length equals: 5 + 2.	"ü and ß occupy two bytes"
	self assert: aString string equals: 'Grüße'.

	^ aString
]

{ #category : #accessing }
GtBoxerStringExamples >> withStringLatin [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := GtBoxerString fromString: 'Hello'.

	self assert: aString size equals: 5.
	self assert: aString length equals: 5.
	self assert: aString string equals: 'Hello'.

	^ aString
]

{ #category : #accessing }
GtBoxerStringExamples >> withStringRussian [
	<gtExample>
	<return: #GtBoxerString>
	| aString |
	aString := GtBoxerString fromString: 'Привет'.

	self assert: aString size equals: 6.
	self assert: aString length equals: 6 * 2.	"each russian letter is 2 bytes"
	self assert: aString string equals: 'Привет'.

	^ aString
]
