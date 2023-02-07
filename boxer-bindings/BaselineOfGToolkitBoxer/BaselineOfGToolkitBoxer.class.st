Class {
	#name : #BaselineOfGToolkitBoxer,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfGToolkitBoxer
}

{ #category : #accessing }
BaselineOfGToolkitBoxer class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfThreadedFFI
]

{ #category : #baseline }
BaselineOfGToolkitBoxer >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec package: 'GToolkit-Boxer' ]
]
