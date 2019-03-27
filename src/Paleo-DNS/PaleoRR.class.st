"
I am the baseclass of all Resource Records.
"
Class {
	#name : #PaleoRR,
	#superclass : #Object,
	#instVars : [
		'rr_name',
		'rr_type',
		'rr_class',
		'rr_ttl'
	],
	#category : #'Paleo-DNS-Records'
}

{ #category : #'as yet unclassified' }
PaleoRR class >> classIN [
	^16r0001
]

{ #category : #'as yet unclassified' }
PaleoRR class >> parse: aReadStream [
	^(self parseBase: aReadStream)
		parseTTL: aReadStream;
		parseRData: aReadStream;
		yourself.
]

{ #category : #'as yet unclassified' }
PaleoRR class >> parseBase: aReadStream [
	"Parses the RR header from the stream and returns the matching RR class
	with the header parsed" 
	| hdr |
	"Get the"
	hdr := PaleoRR new parseBase: aReadStream.
	^(self typeFor: hdr rr_type) basicNew
		readFromBase: hdr;
		yourself.
]

{ #category : #'as yet unclassified' }
PaleoRR class >> typeFor: anInteger [ 
	self subclassesDo: [:each |
		each rrType = anInteger ifTrue: [ ^each ] ].
	self flag: #todo. "Or handle this somewhere else?"
	^PaleoRRGeneric
]

{ #category : #initialization }
PaleoRR >> initialize [
	rr_class := rr_ttl := 0.
]

{ #category : #'as yet unclassified' }
PaleoRR >> parseBase: aReadStream [
	rr_name := self parseName: aReadStream.
	rr_type := aReadStream uint16.
	rr_class := aReadStream uint16.
]

{ #category : #'as yet unclassified' }
PaleoRR >> parseHeader: aReadStream [
	self parseBase: aReadStream.
	self parseTTL: aReadStream.
]

{ #category : #'as yet unclassified' }
PaleoRR >> parseLabel: aReadStream offset: anOffset [
	"Parses one label of a domain name and returns it as string"
	| oldPosition |
	oldPosition := aReadStream position.
	^[
		aReadStream position: anOffset.
		self parseName: aReadStream
	] ensure: [ aReadStream position: oldPosition ].

]

{ #category : #'as yet unclassified' }
PaleoRR >> parseName: aReadStream [
	| len names |
	len := 0.
	names := OrderedCollection new.
	[ len := aReadStream next. len > 0 ] whileTrue: [
		(len bitAnd: 16rC0) = 16rC0
			ifTrue: [ 
				| offset |
				offset := ((len & 16r3F) bitShift: 8) | aReadStream next.
				names add: (self parseLabel: aReadStream offset: offset).
				^names joinUsing: '.' ]
			ifFalse: [ names add: (aReadStream next: len) asString ].
	].
	^(names joinUsing: '.'), '.'
]

{ #category : #parsing }
PaleoRR >> parseRData: aReadStream [
	^self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PaleoRR >> parseTTL: aReadStream [
	rr_ttl := aReadStream uint32.
]

{ #category : #'as yet unclassified' }
PaleoRR >> readFromBase: aPaleoRR [ 
	rr_class := aPaleoRR rr_class.
	rr_name := aPaleoRR rr_name.
]

{ #category : #'as yet unclassified' }
PaleoRR >> rr_class [
	^ rr_class
]

{ #category : #'as yet unclassified' }
PaleoRR >> rr_class: anInteger [ 
	rr_class := anInteger
]

{ #category : #'as yet unclassified' }
PaleoRR >> rr_name [
	^ rr_name
]

{ #category : #'as yet unclassified' }
PaleoRR >> rr_name: aString [ 
	rr_name := aString
]

{ #category : #'as yet unclassified' }
PaleoRR >> rr_ttl [
	^ rr_ttl
]

{ #category : #'as yet unclassified' }
PaleoRR >> rr_ttl: anInteger [ 
	rr_ttl := anInteger
]

{ #category : #'as yet unclassified' }
PaleoRR >> rr_type [
	^ rr_type
]

{ #category : #'as yet unclassified' }
PaleoRR >> serialize [
	^ByteArray streamContents: [:stream |
		self serializeTo: stream]
]

{ #category : #'as yet unclassified' }
PaleoRR >> serializeBaseTo: aWriteStream [ 
	self serializeNameTo: aWriteStream.
	aWriteStream uint16: self class rrType.
	aWriteStream uint16: rr_class.
]

{ #category : #'as yet unclassified' }
PaleoRR >> serializeHeaderTo: aWriteStream [ 
	self serializeBaseTo: aWriteStream.
	aWriteStream uint32: rr_ttl.
]

{ #category : #'as yet unclassified' }
PaleoRR >> serializeNameTo: aWriteStream [
	rr_name ifNil: [
		aWriteStream nextPut: 0.
		^self].

	self flag: #todo. "Header compression but then we need to keep a table."
	(rr_name substrings: '.') do: [:label |
		aWriteStream
			nextPut: label size;
			nextPutAll: label asByteArray.
	].
	aWriteStream nextPut: 0.
]
