Class {
	#name : #GtBoxerArrayU8Examples,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Examples'
}

{ #category : #'instance creation' }
GtBoxerArrayU8Examples >> default [
	<gtExample>
	<return: #GtBoxerArrayU8>
	| anArray |
	anArray := GtBoxerArrayU8 new.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero.
	self assert: anArray data isEmpty.

	^ anArray
]

{ #category : #'instance creation' }
GtBoxerArrayU8Examples >> fromByteArray [
	<gtExample>
	<return: #ByteArray>
	| aByteArray |
	aByteArray := #[0 16 32 64 128 255].

	GtBoxerArrayU8
		fromByteArray: aByteArray
		during: [ :aBoxerArray | 
			self assert: aBoxerArray size equals: aByteArray size.
			self assert: aBoxerArray capacity >= aByteArray size.
			self assert: aBoxerArray asArray equals: aByteArray asArray.
			self assert: aBoxerArray asByteArray equals: aByteArray ].

	self assert: aByteArray equals: #[0 16 32 64 128 255].

	^ aByteArray
]

{ #category : #'instance creation' }
GtBoxerArrayU8Examples >> fromData [
	<gtExample>
	<return: #FFIExternalArray>
	| anFFIExternalArray anArray |
	anFFIExternalArray := FFIExternalArray
			externalNewType: FFIUInt8 externalType
			size: 100.
	anFFIExternalArray atAll: (1 to: 100) putAll: (1 to: 100).
	anFFIExternalArray autoRelease.

	anArray := GtBoxerArrayU8 fromHandle: anFFIExternalArray getHandle size: 100.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (1 to: 100) asArray.	"anFFIExternalArray is the owner of data"
	anArray release.

	self assert: anFFIExternalArray asArray equals: (1 to: 100) asArray.

	^ anFFIExternalArray
]

{ #category : #'examples - null ptr' }
GtBoxerArrayU8Examples >> release [
	<gtExample>
	<return: #GtBoxerArrayU8>
	| anArray |
	anArray := self default.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero.
	self assert: anArray data isEmpty.

	^ anArray
]

{ #category : #accessing }
GtBoxerArrayU8Examples >> setElement [
	<gtExample>
	<return: #GtBoxerArrayU8>
	| anArray |
	anArray := GtBoxerArrayU8 new: 2 withAll: 0.
	self assert: anArray size equals: 2.
	self assert: anArray capacity >= 2.

	self assert: anArray asArray equals: #(0 0).

	anArray at: 1 put: 1.
	anArray at: 2 put: 2.

	self assert: anArray asArray equals: #(1 2).

	^ anArray
]

{ #category : #'instance creation' }
GtBoxerArrayU8Examples >> withElement [
	<gtExample>
	<return: #GtBoxerArrayU8>
	| anArray |
	anArray := GtBoxerArrayU8 new: 100 withAll: 0.
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.

	self assert: anArray asArray equals: (Array new: 100 withAll: 0).

	^ anArray
]
