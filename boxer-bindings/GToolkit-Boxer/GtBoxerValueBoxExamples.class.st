Class {
	#name : #GtBoxerValueBoxExamples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #examples }
GtBoxerValueBoxExamples >> drop_not_null [
	<gtExample>	
	| aNew |
	
	aNew := GtBoxerSizeU32 new.
	GtBoxerSizeU32 primRelease: aNew getHandle.
	self assert: aNew isNull. 

	^ aNew
]

{ #category : #examples }
GtBoxerValueBoxExamples >> isValid_not_null [
	<gtExample>	
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
	| aNull |
	
	aNull := GtBoxerSizeU32 null.
	self assert: aNull isNull.
	self assert: aNull isValid not.
	
	^ aNull
]
