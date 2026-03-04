Class {
	#name : #GtExternalEnumeration,
	#superclass : #FFIExternalEnumeration,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'enum declaration' }
GtExternalEnumeration class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	self = GtExternalEnumeration
		ifTrue: [ ^ #() ].

	^ self parseDeclaration: self externalDeclaration.
]

{ #category : #'enum declaration' }
GtExternalEnumeration class >> externalDeclaration [
	"
	self rebuildEnumAccessors
	"

	^ self subclassResponsibility
]

{ #category : #'enum declaration' }
GtExternalEnumeration class >> externalType [
	^ self subclassResponsibility
]

{ #category : #'class initialization' }
GtExternalEnumeration class >> initialize [
	
	"Skip initialization of root class"
	self = GtExternalEnumeration
		ifTrue: [ ^ self ].

	self initializeEnumeration.
	representationType := self externalType.
	
	Author
		useAuthor: 'UFFI'
		during: [ self rebuildEnumAccessors ]
]

{ #category : #'enum declaration' }
GtExternalEnumeration class >> parseDeclaration: aLiteralArray [
	| previousValue |
	
	previousValue := -1.
	
	^ ((aLiteralArray splitOn: #(,)) select: [ :each | each isNotEmpty ]) flatCollect: [ :eachArray |
		| assoc |
		
		 assoc := self parseVariant: eachArray previousValue: previousValue.
		 previousValue := assoc value.
		 { assoc key . assoc value } ]
]

{ #category : #'enum declaration' }
GtExternalEnumeration class >> parseVariant: anArray previousValue: aNumber [
	| variantName variantValue |
	
	self
		assert: [ anArray isNotEmpty ]
		description: [ 'Must not be empty' ].
	
	variantName := anArray first.
	variantValue := anArray size = 1
			ifTrue: [ aNumber + 1 ]
			ifFalse: [ self
					assert: [ anArray size = 3 ]
					description: [ 'Expected `Name = {number}`' ].

				self assert: [ anArray second = #= ] description: [ 'Expected `=`' ].

				self assert: [ anArray third isNumber ] description: [ 'Expected a number' ].
				
				anArray third ].

	^ variantName -> variantValue
]

{ #category : #'class initialization' }
GtExternalEnumeration class >> rebuildEnumAccessors [

	"Skip initialization of root class"
	self = GtExternalEnumeration
		ifTrue: [ ^ self ].

	self initializeEnumeration.
	representationType := self externalType.

	super rebuildEnumAccessors.
]

{ #category : #converting }
GtExternalEnumeration >> asInteger [
	^ self value
]
