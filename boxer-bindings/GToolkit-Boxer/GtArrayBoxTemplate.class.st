"
Generating an array box class for a given type:
```
GtRobocoderClassGenerator new
	templateClass: GtArrayBoxTemplate;
	mappings: {
		#type -> 'uint' .
		#capitalType -> 'UInt'.
		#ffiType -> 'uint' };
	doNotEmbedGeneratedFromPragma;
	generateChanges
```
"
Class {
	#name : #GtArrayBoxTemplate,
	#superclass : #Object,
	#category : #'GToolkit-Boxer-Templates'
}

{ #category : #templates }
GtArrayBoxTemplate class >> primReleaseTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primRelease: aHandle library: anFFILibrary
	anFFILibrary primArray{{capitalType}}Release: aHandle';
		protocol: 'private - ffi';
		storageMethod: thisContext method
]

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

{ #category : #templates }
GtArrayBoxTemplate >> primAtPutTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primAt: anIndex put: anItem
	^ self ffiLibrary
		primArray{{capitalType}}: self
		at: anIndex
		put: anItem';
		protocol: 'private - array';
		storageMethod: thisContext method
]

{ #category : #templates }
GtArrayBoxTemplate >> primAtTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primAt: anIndex
	^ self ffiLibrary
		primArray{{capitalType}}: self
		at: anIndex';
		protocol: 'private - array';
		storageMethod: thisContext method
]

{ #category : #templates }
GtArrayBoxTemplate >> primCopyIntoTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primCopyInto: anArrayBox{{capitalType}}
	self ffiLibrary
		primArray{{capitalType}}: self
		copyInto: anArrayBox{{capitalType}}';
		protocol: 'private - array';
		storageMethod: thisContext method
]

{ #category : #templates }
GtArrayBoxTemplate >> primGetCapacityTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primGetCapacity
	^ self ffiLibrary
		primArray{{capitalType}}GetCapacity: self';
		protocol: 'private - array';
		storageMethod: thisContext method
]

{ #category : #templates }
GtArrayBoxTemplate >> primGetDataTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primGetData
	^ self ffiLibrary
		primArray{{capitalType}}GetData: self';
		protocol: 'private - array';
		storageMethod: thisContext method
]

{ #category : #templates }
GtArrayBoxTemplate >> primGetLengthTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primGetLength
	^ self ffiLibrary
		primArray{{capitalType}}GetLength: self';
		protocol: 'private - array';
		storageMethod: thisContext method
]
