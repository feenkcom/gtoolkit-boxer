Class {
	#name : #GtBoxerArray,
	#superclass : #GtBoxerExternalObject,
	#category : #'GToolkit-Boxer-Core'
}

{ #category : #'instance creation' }
GtBoxerArray class >> new: aSize withAll: aValue [
	^ (self fromHandle: ((self primCreateNew: aSize withAll: aValue) getHandle)) autoRelease
]

{ #category : #'private - ffi' }
GtBoxerArray class >> primCreateNew: aSize withAll: aValue [
	^ self subclassResponsibility
]

{ #category : #converting }
GtBoxerArray >> asArray [
	^ self data asArray
]

{ #category : #accessing }
GtBoxerArray >> at: anIndex [
	^ self data at: anIndex
]

{ #category : #accessing }
GtBoxerArray >> capacity [
	<return: #Number>
	
	^ self primGetCapacity
]

{ #category : #accessing }
GtBoxerArray >> data [
	| anExternalHandle |
	
	anExternalHandle := self primGetData getHandle.
	anExternalHandle isNull
		ifTrue: [
			^ (FFIExternalArray
				externalNewType: self externalType
				size: 0) autoRelease ].

	^ FFIExternalArray
		fromHandle: self primGetData getHandle
		type: self externalType
		size: self size
]

{ #category : #'private - ffi' }
GtBoxerArray >> externalType [
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
