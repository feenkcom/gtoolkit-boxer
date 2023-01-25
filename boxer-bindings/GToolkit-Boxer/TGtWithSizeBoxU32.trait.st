Trait {
	#name : #TGtWithSizeBoxU32,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'api - size u32' }
TGtWithSizeBoxU32 >> getSizeU32From: aBlock [
	<return: #Point>

	^ self newSizeU32During: [ :aPointU32 |
		aBlock value: aPointU32.
		aPointU32 asPoint ]
]

{ #category : #'api - size u32' }
TGtWithSizeBoxU32 >> newSizeU32 [
	^ GtSizeBoxU32
		fromNativeHandle: (self primSizeU32Create)
		library: self
]

{ #category : #'api - size u32' }
TGtWithSizeBoxU32 >> newSizeU32During: aBlock [
	^ GtSizeBoxU32
		fromNativeHandle: (self primSizeU32Create)
		library: self
		during: aBlock
]

{ #category : #'private - size u32' }
TGtWithSizeBoxU32 >> primSizeU32: aSizeBoxU32 setHeight: aHeight [
	^ self ffiCall: #(void boxer_size_u32_set_height(GtSizeBoxU32 aSizeBoxU32, uint32 aHeight))
]

{ #category : #'private - size u32' }
TGtWithSizeBoxU32 >> primSizeU32: aSizeBoxU32 setWidth: aWidth [
	^ self ffiCall: #(void boxer_size_u32_set_width(GtSizeBoxU32 aSizeBoxU32, uint32 aWidth))
]

{ #category : #'private - size u32' }
TGtWithSizeBoxU32 >> primSizeU32Create [
	^ self ffiCall: #(void* boxer_size_u32_create())
]

{ #category : #'private - size u32' }
TGtWithSizeBoxU32 >> primSizeU32GetHeight: aSizeBoxU32 [
	^ self ffiCall: #(uint32 boxer_size_u32_get_height(GtSizeBoxU32 aSizeBoxU32))
]

{ #category : #'private - size u32' }
TGtWithSizeBoxU32 >> primSizeU32GetWidth: aSizeBoxU32 [
	^ self ffiCall: #(uint32 boxer_size_u32_get_width(GtSizeBoxU32 aSizeBoxU32))
]

{ #category : #'private - size u32' }
TGtWithSizeBoxU32 >> primSizeU32Release: aHandle [
	self ffiCall: #(void boxer_size_u32_drop(void* aHandle))
]
