Trait {
	#name : #TGtWithPointBoxI32,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #'api - point i32' }
TGtWithPointBoxI32 >> getPointI32From: aBlock [
	<return: #Point>
	
	^ self newPointI32During: [ :aPointI32 |
		aBlock value: aPointI32.
		aPointI32 asPoint ]
]

{ #category : #'api - point i32' }
TGtWithPointBoxI32 >> newPointI32 [
	^ GtPointBoxI32
		fromNativeHandle: (self primPointI32Create)
		library: self
]

{ #category : #'api - point i32' }
TGtWithPointBoxI32 >> newPointI32: aPoint [
	^ GtPointBoxI32
		fromNativeHandle: (self primPointI32CreateX: aPoint x y: aPoint y)
		library: self
]

{ #category : #'api - point i32' }
TGtWithPointBoxI32 >> newPointI32: aPoint during: aBlock [
	^ GtPointBoxI32
		fromNativeHandle: (self primPointI32CreateX: aPoint x y: aPoint y)
		library: self
		during: aBlock
]

{ #category : #'api - point i32' }
TGtWithPointBoxI32 >> newPointI32During: aBlock [
	^ GtPointBoxI32
		fromNativeHandle: (self primPointI32Create)
		library: self
		during: aBlock
]

{ #category : #'private - point i32' }
TGtWithPointBoxI32 >> primPointI32: aPointBoxI32 setX: aX [
	^ self ffiCall: #(void boxer_point_i32_set_x(GtPointBoxI32 aPointBoxI32, int32 aX))
]

{ #category : #'private - point i32' }
TGtWithPointBoxI32 >> primPointI32: aPointBoxI32 setY: aY [
	^ self ffiCall: #(void boxer_point_i32_set_y(GtPointBoxI32 aPointBoxI32, int32 aY))
]

{ #category : #'private - point i32' }
TGtWithPointBoxI32 >> primPointI32Create [
	^ self ffiCall: #(void* boxer_point_i32_default())
]

{ #category : #'private - point i32' }
TGtWithPointBoxI32 >> primPointI32CreateX: aX y: aY [
	^ self ffiCall: #(void* boxer_point_i32_create(int32 aX, int32 aY))
]

{ #category : #'private - point i32' }
TGtWithPointBoxI32 >> primPointI32GetX: aPointBoxI32 [
	^ self ffiCall: #(int32 boxer_point_i32_get_x(GtPointBoxI32 aPointBoxI32))
]

{ #category : #'private - point i32' }
TGtWithPointBoxI32 >> primPointI32GetY: aPointBoxI32 [
	^ self ffiCall: #(int32 boxer_point_i32_get_y(GtPointBoxI32 aPointBoxI32))
]

{ #category : #'private - point i32' }
TGtWithPointBoxI32 >> primPointI32Release: aHandle [
	self ffiCall: #(void boxer_point_i32_drop(void* aHandle))
]
