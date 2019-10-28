Class {
	#name : #BaselineOfGToolkitBoxer,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfGToolkitBoxer
}

{ #category : #baselines }
BaselineOfGToolkitBoxer >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			baseline: 'GToolkitInstaller' with: [ spec repository: 'github://feenkcom/gtoolkit-installer/src' ].
		spec
			postLoadDoIt: #'postLoadBoxer:';
			package: 'GToolkit-Boxer' with: [ spec requires: #(GToolkitInstaller) ] ]
]

{ #category : #baselines }
BaselineOfGToolkitBoxer >> postLoadBoxer: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].

	PostLoaded := true.
	self postLoadInstallBoxerBinary: spec
]

{ #category : #baselines }
BaselineOfGToolkitBoxer >> postLoadInstallBoxerBinary: aSpec [
	(self class environment at: #GtBoxerLibrary) install
]
