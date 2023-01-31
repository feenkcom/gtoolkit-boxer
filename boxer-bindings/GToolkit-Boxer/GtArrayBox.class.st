Class {
	#name : #GtArrayBox,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #converting }
GtArrayBox >> asArray [
	<return: #Array>

	^ self dataDuring: [ :anExternalArray | anExternalArray asArray ]
]

{ #category : #accessing }
GtArrayBox >> at: anIndex [
	^ self primAt: anIndex - 1
]

{ #category : #accessing }
GtArrayBox >> at: anIndex put: anItem [
	self primAt: anIndex - 1 put: anItem
]

{ #category : #accessing }
GtArrayBox >> atAll: indexArray putAll: valueArray [
	"Store the elements of valueArray into the slots
	of this collection selected by indexArray."

	indexArray with: valueArray do: [ :index :value | self at: index put: value ]
]

{ #category : #accessing }
GtArrayBox >> capacity [
	<return: #Number>
	
	^ self primGetCapacity
]

{ #category : #copying }
GtArrayBox >> copyInto: anotherGtBoxerArray [
	self
		assert: [ self class == anotherGtBoxerArray class ]
		description: [ 'Can only copy between similar arrays' ].
		
	self
		assert: [ self size = anotherGtBoxerArray size ]
		description: [ 'Can only copy between arrays of same length' ].
		
	self primCopyInto: anotherGtBoxerArray
]

{ #category : #accessing }
GtArrayBox >> data [
	| anExternalHandle |
	
	anExternalHandle := self primGetData getHandle.
	anExternalHandle isNull
		ifTrue: [ ^ (GtBoxer externalArrayNewType: self externalType size: 0) autoRelease ].

	"the memory is managed by external library, we should not auto-release it"
	^ GtBoxer
		externalArrayFromHandle: anExternalHandle
		type: self externalType
		size: self size
]

{ #category : #accessing }
GtArrayBox >> dataDuring: aBlock [
	| anExternalHandle |
	
	anExternalHandle := self primGetData getHandle.
	anExternalHandle isNull
		ifTrue: [ ^ GtBoxer externalArrayNewType: self externalType size: 0 during: aBlock ].

	^ GtBoxer
		externalArrayFromHandle: anExternalHandle
		type: self externalType
		size: self size
		during: aBlock
]

{ #category : #'private - array' }
GtArrayBox >> externalType [
	<return: #'FFIExternalType class'>

	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtArrayBox >> gtInfoFor: aView [
	<gtView>

	^ ({ 
		#capacity -> self capacity.
		#size -> self size
	 } asOrderedDictionary gtItemsFor: aView)
			title: 'Info';
			priority: 3
]

{ #category : #'gt-extension' }
GtArrayBox >> gtItemsFor: aView [
	<gtView>

	^ aView list
		title: 'Items';
		priority: 2;
		items: [ self asArray ]
]

{ #category : #enumerating }
GtArrayBox >> pairsDo: aBlock [
	"Evaluate aBlock with my elements taken two at a time.  If there's an odd number of items, ignore the last one.  Allows use of a flattened array for things that naturally group into pairs.  See also pairsCollect:"

	1 to: self size // 2 do: [ :index |
		aBlock
			value: (self at: 2 * index - 1)
			value: (self at: 2 * index) ]
]

{ #category : #'private - array' }
GtArrayBox >> primAt: anIndex [
	^ self subclassResponsibility
]

{ #category : #'private - array' }
GtArrayBox >> primAt: anIndex put: anItem [
	^ self subclassResponsibility
]

{ #category : #'private - array' }
GtArrayBox >> primCopyInto: aGtBoxerArray [
	^ self subclassResponsibility
]

{ #category : #'private - array' }
GtArrayBox >> primGetCapacity [
	^ self subclassResponsibility
]

{ #category : #'private - array' }
GtArrayBox >> primGetData [
	^ self subclassResponsibility
]

{ #category : #'private - array' }
GtArrayBox >> primGetLength [
	^ self subclassResponsibility
]

{ #category : #enumerating }
GtArrayBox >> quartetsDo: aBlock [
	"Evaluate aBlock with my elements taken four at a time. Allows use of a flattened array for things that naturally group into quartets"

	1 to: self size // 4 do: [ :index |
		aBlock
			value: (self at: 4 * index - 3)
			value: (self at: 4 * index - 2)
			value: (self at: 4 * index - 1)
			value: (self at: 4 * index) ]
]

{ #category : #accessing }
GtArrayBox >> size [
	"An amount of items in the array"
	<return: #Number>
	
	^ self primGetLength
]
