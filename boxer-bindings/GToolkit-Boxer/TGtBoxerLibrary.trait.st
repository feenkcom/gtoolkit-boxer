Trait {
	#name : #TGtBoxerLibrary,
	#category : #'GToolkit-Boxer'
}

{ #category : #'library path' }
TGtBoxerLibrary classSide >> ffiLibraryName [
	^ GtBoxerLibrary
]

{ #category : #'library path' }
TGtBoxerLibrary >> ffiLibraryName [
	^ self class ffiLibraryName
]
