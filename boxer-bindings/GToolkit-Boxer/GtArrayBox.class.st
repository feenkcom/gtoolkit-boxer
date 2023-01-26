Class {
	#name : #GtArrayBox,
	#superclass : #GtExternalLibraryBox,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'instance creation' }
GtArrayBox class >> fromHandle: anExternalAddress size: aSize [
	"This is unsafe, you must make sure that the data will overlive boxer array"
	
	^ self fromNativeHandle: (self primCreateFromData: anExternalAddress size: aSize)
]

{ #category : #'instance creation' }
GtArrayBox class >> fromHandle: anExternalAddress size: aSize during: aBlock [
	"This is unsafe, you must make sure that the data will live during evaluation of a block"

	^ self fromNativeHandle: (self primCreateFromData: anExternalAddress size: aSize) during: aBlock
]

{ #category : #'instance creation' }
GtArrayBox class >> new: aSize withAll: aValue [
	^ self fromNativeHandle: (self primCreateNew: aSize withAll: aValue)
]

{ #category : #'instance creation' }
GtArrayBox class >> new: aSize withAll: aValue during: aBlock [
	^ self fromNativeHandle: (self primCreateNew: aSize withAll: aValue) during: aBlock
]

{ #category : #'private - ffi' }
GtArrayBox class >> primCreateFromData: anExternalAddress size: aSize [
	"
	^ self ffiCall: #(void* boxer_array_point_f32_create_from_data(void* anExternalAddress, size_t aSize))
	"
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtArrayBox class >> primCreateNew: aSize withAll: aValue [
	^ self subclassResponsibility
]

{ #category : #converting }
GtArrayBox >> asArray [
	<return: #Array>

	^ self dataDuring: [ :anExternalArray | anExternalArray asArray ]
]

{ #category : #accessing }
GtArrayBox >> at: anIndex [
	^ self data at: anIndex
]

{ #category : #accessing }
GtArrayBox >> at: anIndex put: anItem [
	self primAt: anIndex - 1 put: anItem
]

{ #category : #accessing }
GtArrayBox >> atAll: indexArray putAll: valueArray [
	"Store the elements of valueArray into the slots
	of this collection selected by indexArray."

	indexArray with: valueArray do: [:index :value | self at: index put: value]
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

{ #category : #'private - ffi' }
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

{ #category : #'private - ffi' }
GtArrayBox >> primAt: anIndex put: anItem [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtArrayBox >> primCopyInto: aGtBoxerArray [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtArrayBox >> primGetCapacity [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtArrayBox >> primGetData [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtArrayBox >> primGetLength [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtArrayBox >> size [
	"An amount of items in the array"
	<return: #Number>
	
	^ self primGetLength
]
