"
Generating api traits for a given type:
```
GtRobocoderTraitGenerator new
	templateTrait: TGtWithArrayBoxTemplate;
	mappings: {
		#type -> 'uint' .
		#capitalType -> 'UInt'.
		#ffiType -> 'uint'.
		#defaultValue -> '0' };
	doNotEmbedGeneratedFromPragma;
	generateChanges
```
"
Trait {
	#name : #TGtWithArrayBoxTemplate,
	#category : #'GToolkit-Boxer-Templates'
}

{ #category : #templates }
TGtWithArrayBoxTemplate classSide >> exampleAtPutTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'exampleArray{{capitalType}}AtPut
	<gtExample>
	| anArray aNewValue |
	
	aNewValue := self exampleArray{{capitalType}}DefaultValue.
	
	anArray := self exampleArray{{capitalType}}NewOfSizeWithAll.
	anArray at: 1 put: aNewValue.
	self assert: (anArray at: 1) equals: aNewValue.
	^ anArray';
		protocol: 'examples - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate classSide >> exampleAtTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'exampleArray{{capitalType}}At
	<gtExample>
	| anArray |
	
	anArray := self exampleArray{{capitalType}}NewOfSizeWithAll.
	self assert: (anArray at: 1) equals: self exampleArray{{capitalType}}DefaultValue.
	^ anArray';
		protocol: 'examples - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate classSide >> exampleDefaultValueTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'exampleArray{{capitalType}}DefaultValue
	<gtExample>
	
	^ {{defaultValue ifNil: [ ''0'' ]}}';
		protocol: 'examples - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate classSide >> exampleLengthOfNullTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'exampleArray{{capitalType}}LengthOfNull
	"Make sure that the array api accepts and survives null address as an argument"
	<gtExample>
	| aLength |
	
	aLength := self uniqueInstance primArray{{capitalType}}GetLength: ExternalAddress null.
	self
		assert: aLength
		equals: 0.

	^ aLength';
		protocol: 'examples - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate classSide >> exampleNewArraySizeWithAllTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'exampleArray{{capitalType}}NewOfSizeWithAll
	<gtExample>
	| aDefaultValue anArray |
	
	aDefaultValue := self exampleArray{{capitalType}}DefaultValue.
	anArray := self uniqueInstance
		newArray{{capitalType}}: 100
		withAll: aDefaultValue.
		
	self assert: anArray size equals: 100.
	self assert: anArray capacity >= 100.
	self assert: anArray asArray equals: (Array new: 100 withAll: aDefaultValue). 
	
	^ anArray';
		protocol: 'examples - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate classSide >> exampleNewTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'exampleArray{{capitalType}}New
	<gtExample>
	| anArray |

	anArray := self uniqueInstance newArray{{capitalType}}.
	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray';
		protocol: 'examples - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate classSide >> exampleReleaseTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'exampleArray{{capitalType}}Release
	<gtExample>
	| anArray |
	
	anArray := self exampleArray{{capitalType}}New.
	anArray release.

	self assert: anArray size isZero.
	self assert: anArray capacity isZero. 
	self assert: anArray data isEmpty. 
	
	^ anArray';
		protocol: 'examples - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayDuringTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'newArray{{capitalType}}During: aBlock
	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: self primArray{{capitalType}}Create
		library: self
		during: aBlock';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayFromDataDuringTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'unsafeNewArray{{capitalType}}FromData: anExternalAddress length: aLength during: aBlock
	"Unsafe. Create an array from a given raw pointer to the data
	of given length for the duration of aBlock.
	aLength is an amount of {{type}} elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: (self primArray{{capitalType}}CreateFromData: anExternalAddress length: aLength)
		library: self
		during: aBlock';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayFromDataTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'unsafeNewArray{{capitalType}}FromData: anExternalAddress length: aLength
	"Unsafe. Create an array from a given raw pointer to the data of given length.
	aLength is an amount of {{type}} elements in the data.
	Make sure that the allocated data overlives the returned array.
	Data will not be freed when the array is dropped."
	
	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: (self primArray{{capitalType}}CreateFromData: anExternalAddress length: aLength)
		library: self';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

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
		sourceCode: 'newArray{{capitalType}}WithAll: aCollectionOfItems during: aBlock
	"Create a new {{type}} array containing all the elements from aCollectionOfNumbers for the duration of aBlock."
	
	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: (self primArray{{capitalType}}CreateNew: aCollectionOfItems size withAll: {{defaultValue ifNil: [ ''0'' ]}})
		library: self
		during: [ :anArrayBox |
			aCollectionOfItems withIndexDo: [ :eachNumber :eachIndex |
				anArrayBox at: eachIndex put: eachNumber ].
			aBlock value: anArrayBox ]';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayWithSizeAllDuringTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'newArray{{capitalType}}: aSize withAll: aValue during: aBlock
	"Create an array of type `{{type}}` with aSize of aValue elements for the duration of aBlock"

	^ GtArrayBox{{capitalType}}
		fromOwnedHandle: (self primArray{{capitalType}}CreateNew: aSize withAll: aValue)
		library: self
		during: aBlock';
		protocol: 'api - array {{type}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtWithArrayBoxTemplate >> newArrayWithSizeAllTemplate [
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
	^ self ffiCall: #(void boxer_array_{{type}}_at_put(
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
	^ self ffiCall: #({{ffiType}} boxer_array_{{type}}_at(
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
TGtWithArrayBoxTemplate >> primArrayCreateFromDataTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: 'primArray{{capitalType}}CreateFromData: anExternalAddress length: aSize
	^ self ffiCall: #(void* boxer_array_{{type}}_create_from_data(
		void* anExternalAddress,
		size_t aSize))';
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
