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

{ #category : #initialization }
PaleoRR >> initialize [
	rr_class := rr_ttl := 0.
]

{ #category : #'as yet unclassified' }
PaleoRR >> parseHeader: aReadStream [ 
	rr_name := self parseName: aReadStream.
	rr_type := aReadStream uint16.
	rr_class := aReadStream uint16.
	rr_ttl := aReadStream uint32.
]

{ #category : #'as yet unclassified' }
PaleoRR >> parseName: aReadStream [
	| len names |
	len := 0.
	names := OrderedCollection new.
	[ len := aReadStream next. len > 0 ] whileTrue: [
		names add: (aReadStream next: len) asString.
		self flag: #todo. "Implement compression"
	].
	^names joinUsing: '.'
]

{ #category : #'as yet unclassified' }
PaleoRR >> serializeHeaderTo: aWriteStream [ 
	self serializeNameTo: aWriteStream.
	aWriteStream uint16: self class rrType.
	aWriteStream uint16: rr_class.
	aWriteStream uint32: rr_ttl.
]
