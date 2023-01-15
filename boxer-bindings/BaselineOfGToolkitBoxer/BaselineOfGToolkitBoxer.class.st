Class {
	#name : #BaselineOfGToolkitBoxer,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfGToolkitBoxer
}

{ #category : #baseline }
BaselineOfGToolkitBoxer >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoadBoxer:'.
		spec
			baseline: 'GToolkitBoxerBindings' with: [
				spec repository: 'github://feenkcom/gtoolkit-boxer:v0.8.43/boxer-bindings' ].
		spec
			baseline: 'GToolkitInstaller' with: [
				spec repository: 'github://feenkcom/gtoolkit-installer:v0.8.23/src' ].
	]
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
