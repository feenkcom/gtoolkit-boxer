Class {
	#name : #GtBoxerValueBoxExamples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #examples }
GtBoxerValueBoxExamples >> drop_not_null [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aNew |
	aNew := GtBoxerSizeU32 new.
	aNew release.
	self assert: aNew isNull.

	^ aNew
]

{ #category : #examples }
GtBoxerValueBoxExamples >> isValid_not_null [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aNull |
	aNull := GtBoxerSizeU32 new.
	self assert: aNull isNull not.
	self assert: aNull isValid.
	self assert: aNull isNull not.
	self assert: aNull isValid.

	^ aNull
]

{ #category : #examples }
GtBoxerValueBoxExamples >> isValid_null [
	<gtExample>
	<return: #GtBoxerSizeU32>
	| aNull |
	aNull := GtBoxerSizeU32 null.
	self assert: aNull isNull.
	self assert: aNull isValid not.

	^ aNull
]
