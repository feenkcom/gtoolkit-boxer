Trait {
	#name : #TGtWithPointBoxF32,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'api - point f32' }
TGtWithPointBoxF32 >> newPointF32 [
	^ GtPointBoxF32
		fromNativeHandle: (self primPointF32Create)
		library: self
]

{ #category : #'api - point f32' }
TGtWithPointBoxF32 >> newPointF32: aPoint [
	^ GtPointBoxF32
		fromNativeHandle: (self primPointF32CreateX: aPoint x y: aPoint y)
		library: self
]

{ #category : #'api - point f32' }
TGtWithPointBoxF32 >> newPointF32: aPoint during: aBlock [
	^ GtPointBoxF32
		fromNativeHandle: (self primPointF32CreateX: aPoint x y: aPoint y)
		library: self
		during: aBlock
]

{ #category : #'api - point f32' }
TGtWithPointBoxF32 >> newPointF32During: aBlock [
	^ GtPointBoxF32
		fromNativeHandle: (self primPointF32Create)
		library: self
		during: aBlock
]

{ #category : #'private - point f32' }
TGtWithPointBoxF32 >> primPointF32: aPointBoxF32 setX: aX [
	^ self ffiCall: #(void boxer_point_f32_set_x(GtPointBoxF32 aPointBoxF32, float32 aX))
]

{ #category : #'private - point f32' }
TGtWithPointBoxF32 >> primPointF32: aPointBoxF32 setY: aY [
	^ self ffiCall: #(void boxer_point_f32_set_y(GtPointBoxF32 aPointBoxF32, float32 aY))
]

{ #category : #'private - point f32' }
TGtWithPointBoxF32 >> primPointF32Create [
	^ self ffiCall: #(void* boxer_point_f32_default())
]

{ #category : #'private - point f32' }
TGtWithPointBoxF32 >> primPointF32CreateX: aX y: aY [
	^ self ffiCall: #(void* boxer_point_f32_create(float32 aX, float32 aY))
]

{ #category : #'private - point f32' }
TGtWithPointBoxF32 >> primPointF32GetX: aPointBoxF32 [
	^ self ffiCall: #(float32 boxer_point_f32_get_x(GtPointBoxF32 aPointBoxF32))
]

{ #category : #'private - point f32' }
TGtWithPointBoxF32 >> primPointF32GetY: aPointBoxF32 [
	^ self ffiCall: #(float32 boxer_point_f32_get_y(GtPointBoxF32 aPointBoxF32))
]

{ #category : #'private - point f32' }
TGtWithPointBoxF32 >> primPointF32Release: aHandle [
	self ffiCall: #(void boxer_point_f32_drop(void* aHandle))
]
