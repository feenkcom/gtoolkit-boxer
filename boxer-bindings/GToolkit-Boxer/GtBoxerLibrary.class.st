Class {
	#name : #GtBoxerLibrary,
	#superclass : #FFILibrary,
	#category : #'GToolkit-Boxer-Library'
}

{ #category : #installation }
GtBoxerLibrary class >> install [
	<script: 'self install'>
	| installer |

	installer := GtLibraryInstaller new.
	installer library: 'Boxer'.
	installer version: 'development'.
	installer icon: (Form extent: 1@1 depth: 32).
	installer binary: 'libBoxer'.
	installer url: 'https://dl.feenk.com/{library}/{platform}/{version}/{arch}/{binary}.{extension}'.
	installer works: [ GtBoxerLibrary uniqueInstance hasModule ].

	installer run
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> detectLibrary: aFileName [
	^ ({ Smalltalk imageDirectory . Smalltalk vmDirectory . FileSystem workingDirectory }
		collect: [ :aPath | aPath asFileReference / aFileName ])
			detect: #exists
			ifFound: #fullName
			ifNone: [ aFileName ]
]

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
	^ self class environment
		at: #FFIMacLibraryFinder
		ifPresent: [ :aLibraryFinder | aLibraryFinder findLibrary: 'libBoxer.dylib' ]
		ifAbsent: [ self detectLibrary: 'libBoxer.dylib' ]
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> primTest [
	^ self ffiCall: #(bool boxer_test())
]

{ #category : #accessing }
GtBoxerLibrary >> unix32LibraryName [
	^ self class environment
		at: #FFIUnix32LibraryFinder
		ifPresent: [ :aLibraryFinder | aLibraryFinder findLibrary: 'libBoxer.so' ]
		ifAbsent: [ self detectLibrary: 'libBoxer.so' ]
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> unix64LibraryName [
	^ self class environment
		at: #FFIUnix64LibraryFinder
		ifPresent: [ :aLibraryFinder | aLibraryFinder findLibrary: 'libBoxer.so' ]
		ifAbsent: [ self detectLibrary: 'libBoxer.so' ]
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> win32LibraryName [
	^ self class environment
		at: #FFIWindowsLibraryFinder
		ifPresent: [ :aLibraryFinder | aLibraryFinder findAnyLibrary: #('Boxer.dll' 'libBoxer.dll') ]
		ifAbsent: [ self detectLibrary: 'libBoxer.dll' ]
]
