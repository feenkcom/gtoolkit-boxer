"
Just bindings to the boxer library


"
Class {
	#name : #BaselineOfGToolkitBoxerBindings,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitBoxerBindings
}

{ #category : #baselines }
BaselineOfGToolkitBoxerBindings >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec package: 'GToolkit-Boxer' ]
]
