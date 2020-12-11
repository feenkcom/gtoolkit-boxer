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
				spec repository: 'github://feenkcom/gtoolkit-boxer:v0.8.6/src' ];
			baseline: 'GToolkitInstaller' with: [
				spec repository: 'github://feenkcom/gtoolkit-installer:v0.8.1/src' ].
		spec package: 'GToolkit-Boxer' with: [
				spec requires: #('GToolkitInstaller' 'GToolkitBoxerBindings' ). ]. ].

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
