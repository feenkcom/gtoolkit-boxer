Class {
	#name : #GtBoxerLibrary,
	#superclass : #FFILibrary,
	#category : #'GToolkit-Boxer-Library'
}

{ #category : #'accessing platform' }
GtBoxerLibrary >> hasModule [
	"Return if there is a loadable and working Boxer library installed, false otherwise"
	<return: #Boolean>
	| aResult |

	aResult := nil.
	
	[ aResult := self primTest ]
		on: Error
		do: [ :e | aResult := false ].

	^ aResult ifNil: [ false ]
]

{ #category : #accessing }
GtBoxerLibrary >> macLibraryName [
	^ FFIMacLibraryFinder findLibrary: 'libBoxer.dylib'
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> primTest [
	^ self ffiCall: #(bool boxer_test())
]

{ #category : #accessing }
GtBoxerLibrary >> unix32LibraryName [
	^ FFIUnix32LibraryFinder findLibrary: 'libBoxer.so'
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> unix64LibraryName [
	^ FFIUnix64LibraryFinder findLibrary: 'libBoxer.so'
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> win32LibraryName [
	^ FFIWindowsLibraryFinder findLibrary: 'Boxer.dll'
]
