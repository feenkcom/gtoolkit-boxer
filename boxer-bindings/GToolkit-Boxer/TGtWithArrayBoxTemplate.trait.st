"
Generating api traits for a given type:
```
GtRobocoderTraitGenerator new
	templateTrait: TGtWithArrayBoxTemplate;
	mappings: {
		#type -> 'uint' .
		#capitalType -> 'UInt'.
		#ffiType -> 'uint' };
	doNotEmbedGeneratedFromPragma;
	generateChanges
```
"
Trait {
	#name : #TGtWithArrayBoxTemplate,
	#category : #'GToolkit-Boxer-Templates'
}

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayFromHandleDuringTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'newArray{{capitalType}}FromHandle: anExternalAddress during: aBlock
	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: anExternalAddress
		library: self
		during: aBlock';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'newArray{{capitalType}}
	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: self primArray{{capitalType}}Create
		library: self';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayWithAllDuringTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'newArray{{capitalType}}WithAll: aCollectionOfNumbers during: aBlock
	"Create a new {{type}} array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: (self primArray{{capitalType}}CreateNew: aCollectionOfNumbers size withAll: 0)
		library: self
		during: [ :anArrayBox |
			aCollectionOfNumbers withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayWithAllTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'newArray{{capitalType}}: aSize withAll: aValue
	"Answer an array of type `{{type}}` with aSize of aValue elements"

	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: (self primArray{{capitalType}}CreateNew: aSize withAll: aValue)
		library: self';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayAtPutTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}: anArrayBox{{capitalType}} at: anIndex put: anItem
	^ self ffiCall: #(void boxer_array_{{type}}_at(
		GtArrayBox{{capitalType}} anArrayBox{{capitalType}},
		size_t anIndex,
		{{ffiType}} anItem))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayAtTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}: anArrayBox{{capitalType}} at: anIndex
	^ self ffiCall: #(void boxer_array_{{type}}_at(
		GtArrayBox{{capitalType}} anArrayBox{{capitalType}},
		size_t anIndex))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayCopyIntoTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}: anArrayBox{{capitalType}} copyInto: anotherArrayBox{{capitalType}}
	^ self ffiCall: #(void boxer_array_{{type}}_copy_into(
		GtArrayBox{{capitalType}} anArrayBox{{capitalType}},
		GtArrayBox{{capitalType}} anotherArrayBox{{capitalType}}))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayCreateNewWithAllTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}CreateNew: aSize withAll: aValue
	^ self ffiCall: #(void* boxer_array_{{type}}_create_with({{ffiType}} aValue, size_t aSize))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayCreateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}Create
	^ self ffiCall: #(void* boxer_array_{{type}}_create())';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayGetCapacityTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}GetCapacity: anArrayBox{{capitalType}}
	^ self ffiCall: #(size_t boxer_array_{{type}}_get_capacity(GtArrayBox{{capitalType}} anArrayBox{{capitalType}}))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayGetDataTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}GetData: anArrayBox{{capitalType}}
	^ self ffiCall: #(void* boxer_array_{{type}}_get_data(GtArrayBox{{capitalType}} anArrayBox{{capitalType}}))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayGetLengthTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}GetLength: anArrayBox{{capitalType}}
	^ self ffiCall: #(size_t boxer_array_{{type}}_get_length(GtArrayBox{{capitalType}} anArrayBox{{capitalType}}))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> primArrayReleaseTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}Release: aHandle
	self ffiCall: #(void boxer_array_{{type}}_drop(void* aHandle))';
		protocol: 'private - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateTrait asClass new
		json: '{
			"name" : "TGtWithArrayBox{{capitalType}}",
			"package" : "GToolkit-Boxer",
			"tag" : "New"
		}';
		storageMethod: thisContext method
]
