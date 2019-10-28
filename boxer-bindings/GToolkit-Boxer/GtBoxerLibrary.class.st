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
	"Return if there is a loadable and working Glutin library installed, false otherwise"
	<return: #Boolean>
	| aResult |

	aResult := nil.
	
	[ aResult := self primTest ]
		on: Error
		do: [ :e | aResult := false ].

	^ aResult ifNil: [ false ]
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> macModuleName [
	^ self detectLibrary: 'libBoxer.dylib'
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> primTest [
	^ self ffiCall: #(bool boxer_test())
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> unixModuleName [
	^ self detectLibrary: 'libBoxer.so'
]

{ #category : #'accessing platform' }
GtBoxerLibrary >> win32ModuleName [
	^ self detectLibrary: 'libBoxer.dll'
]
