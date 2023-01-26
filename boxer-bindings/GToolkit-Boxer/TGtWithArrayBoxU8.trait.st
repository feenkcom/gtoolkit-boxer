Trait {
	#name : #TGtWithArrayBoxU8,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8GetCapacity: anArrayBoxU8 [
	^ self ffiCall: #(size_t boxer_array_u8_get_capacity(GtArrayBoxU8 anArrayBoxU8))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8GetData: anArrayBoxU8 [
	^ self ffiCall: #(void* boxer_array_u8_get_data(GtArrayBoxU8 anArrayBoxU8))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8GetLength: anArrayBoxU8 [
	^ self ffiCall: #(size_t boxer_array_u8_get_length(GtArrayBoxU8 anArrayBoxU8))
]

{ #category : #'private - array u8' }
TGtWithArrayBoxU8 >> primArrayU8Release: aHandle [
	self ffiCall: #(void boxer_array_u8_drop(void* aHandle))
]
