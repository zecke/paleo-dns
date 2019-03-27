Class {
	#name : #PaleoRRGeneric,
	#superclass : #PaleoRR,
	#instVars : [
		'rr_data'
	],
	#category : #'Paleo-DNS-Records'
}

{ #category : #parsing }
PaleoRRGeneric >> parseRData: aReadStream [
	| len |
	len := aReadStream uint16.
	rr_data := aReadStream next: len.
]

{ #category : #'as yet unclassified' }
PaleoRRGeneric >> readFromBase: aPaleoRR [
	super readFromBase: aPaleoRR.
	rr_type := aPaleoRR rr_type.

]

{ #category : #'as yet unclassified' }
PaleoRRGeneric >> rr_data [
	^ rr_data
]

{ #category : #'as yet unclassified' }
PaleoRRGeneric >> rr_data: aCollection [ 
	rr_data := aCollection
]

{ #category : #'as yet unclassified' }
PaleoRRGeneric >> rr_type: anInteger [ 
	rr_type := anInteger
]

{ #category : #'as yet unclassified' }
PaleoRRGeneric >> serializeBaseTo: aWriteStream [ 
	self serializeNameTo: aWriteStream.
	aWriteStream uint16: rr_type.
	aWriteStream uint16: rr_class.
]

{ #category : #'as yet unclassified' }
PaleoRRGeneric >> serializeRDataTo: aWriteStream [ 
	aWriteStream
		uint16: rr_data size;
		nextPutAll: rr_data
]

{ #category : #'as yet unclassified' }
PaleoRRGeneric >> serializeTo: aWriteStream [ 
	self
		serializeHeaderTo: aWriteStream;
		serializeRDataTo: aWriteStream.
]
