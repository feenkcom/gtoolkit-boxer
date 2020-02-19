Class {
	#name : #GtBoxerArray,
	#superclass : #GtBoxerValueBox,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerArray class >> fromHandle: anExternalAddress size: aSize [
	"This is unsafe, you must make sure that the data will overlive boxer array"
	
	^ self fromNativeHandle: (self primCreateFromData: anExternalAddress size: aSize)
]

{ #category : #'instance creation' }
GtBoxerArray class >> fromHandle: anExternalAddress size: aSize during: aBlock [
	"This is unsafe, you must make sure that the data will live during evaluation of a block"

	^ self fromNativeHandle: (self primCreateFromData: anExternalAddress size: aSize) during: aBlock
]

{ #category : #'instance creation' }
GtBoxerArray class >> new: aSize withAll: aValue [
	^ self fromNativeHandle: (self primCreateNew: aSize withAll: aValue)
]

{ #category : #'instance creation' }
GtBoxerArray class >> new: aSize withAll: aValue during: aBlock [
	^ self fromNativeHandle: (self primCreateNew: aSize withAll: aValue) during: aBlock
]

{ #category : #'private - ffi' }
GtBoxerArray class >> primCreateFromData: anExternalAddress size: aSize [
	"
	^ self ffiCall: #(void* boxer_array_point_f32_create_from_data(void* anExternalAddress, size_t aSize))
	"
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerArray class >> primCreateNew: aSize withAll: aValue [
	^ self subclassResponsibility
]

{ #category : #converting }
GtBoxerArray >> asArray [
	<return: #Array>

	^ self dataDuring: [ :anExternalArray | anExternalArray asArray ]
]

{ #category : #accessing }
GtBoxerArray >> at: anIndex [
	^ self data at: anIndex
]

{ #category : #accessing }
GtBoxerArray >> at: anIndex put: anItem [
	self primAt: anIndex - 1 put: anItem
]

{ #category : #accessing }
GtBoxerArray >> atAll: indexArray putAll: valueArray [
	"Store the elements of valueArray into the slots
	of this collection selected by indexArray."

	indexArray with: valueArray do: [:index :value | self at: index put: value]
]

{ #category : #accessing }
GtBoxerArray >> capacity [
	<return: #Number>
	
	^ self primGetCapacity
]

{ #category : #copying }
GtBoxerArray >> copyInto: anotherGtBoxerArray [
	self
		assert: [ self class == anotherGtBoxerArray class ]
		description: [ 'Can only copy between similar arrays' ].
		
	self
		assert: [ self size = anotherGtBoxerArray size ]
		description: [ 'Can only copy between arrays of same length' ].
		
	self primCopyInto: anotherGtBoxerArray
]

{ #category : #accessing }
GtBoxerArray >> data [
	| anExternalHandle |
	
	anExternalHandle := self primGetData getHandle.
	anExternalHandle isNull
		ifTrue: [ ^ (GtBoxer externalArrayNewType: self externalType size: 0) autoRelease ].

	"the memory is managed by external library, we should not auto-release it"
	^ GtBoxer
		externalArrayFromHandle: self primGetData getHandle
		type: self externalType
		size: self size
]

{ #category : #accessing }
GtBoxerArray >> dataDuring: aBlock [
	| anExternalHandle |
	
	anExternalHandle := self primGetData getHandle.
	anExternalHandle isNull
		ifTrue: [ ^ GtBoxer externalArrayNewType: self externalType size: 0 during: aBlock ].

	^ GtBoxer
		externalArrayFromHandle: self primGetData getHandle
		type: self externalType
		size: self size
		during: aBlock
]

{ #category : #'private - ffi' }
GtBoxerArray >> externalType [
	<return: #'FFIExternalType class'>

	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
GtBoxerArray >> gtInfoFor: aView [
	<gtView>

	^ ({ 
		#capacity -> self capacity.
		#size -> self size
	 } asOrderedDictionary gtItemsFor: aView)
			title: 'Info';
			priority: 3
]

{ #category : #'gt-extension' }
GtBoxerArray >> gtItemsFor: aView [
	<gtView>

	^ aView list
		title: 'Items';
		priority: 2;
		items: [ self asArray ]
]

{ #category : #'private - ffi' }
GtBoxerArray >> primAt: anIndex put: anItem [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerArray >> primCopyInto: aGtBoxerArray [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerArray >> primGetCapacity [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerArray >> primGetData [
	^ self subclassResponsibility
]

{ #category : #'private - ffi' }
GtBoxerArray >> primGetLength [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtBoxerArray >> size [
	"An amount of items in the array"
	<return: #Number>
	
	^ self primGetLength
]
