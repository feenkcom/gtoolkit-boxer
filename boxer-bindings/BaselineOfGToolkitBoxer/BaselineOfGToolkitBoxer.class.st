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

	spec for: #common do: [
		spec package: 'GToolkit-Boxer' ]
]
