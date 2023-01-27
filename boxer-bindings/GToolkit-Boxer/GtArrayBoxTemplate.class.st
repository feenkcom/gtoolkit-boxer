Class {
	#name : #GtArrayBoxTemplate,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-New'
}

{ #category : #templates }
GtArrayBoxTemplate >> classTemplate [
	<gtClassTemplate>
	<generatedFrom: #'GtRobocoderTemplateClass class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateClass asClass new
		json: '{
			"name" : "GtArrayBox{{capitalType}}",
			"superclassName" : "GtArrayBox",
			"package" : "GToolkit-Boxer",
			"tag" : "New"
		}';
		storageMethod: thisContext method
]
