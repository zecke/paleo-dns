"
I am an A record (IPv4 address)
"
Class {
	#name : #PaleoRRA,
	#superclass : #PaleoRR,
	#instVars : [
		'rr_address'
	],
	#category : #'Paleo-DNS-Records'
}

{ #category : #'as yet unclassified' }
PaleoRRA class >> parse: aReadStream [ 
	^self basicNew
		parseHeader: aReadStream;
		parseAddress: aReadStream;
		yourself
]

{ #category : #'as yet unclassified' }
PaleoRRA class >> rrType [
	^1
]

{ #category : #'as yet unclassified' }
PaleoRRA >> initialize [
	super initialize.
	rr_class := self class classIN.
]

{ #category : #'as yet unclassified' }
PaleoRRA >> parseAddress: aReadStream [ 
	| len |
	len := aReadStream uint16.
	len = 4 ifFalse: [ ^self error: 'IPv4 address should be 4 bytes' ].
	rr_address := (aReadStream next: 4) asSocketAddress
]

{ #category : #parsing }
PaleoRRA >> parseRData: aReadStream [
	self parseAddress: aReadStream.
]

{ #category : #'as yet unclassified' }
PaleoRRA >> rr_address [
	^rr_address
]

{ #category : #'as yet unclassified' }
PaleoRRA >> rr_address: aCollection [ 
	rr_address := aCollection
]

{ #category : #'as yet unclassified' }
PaleoRRA >> serializeAddressTo: aWriteStream [ 
	aWriteStream uint16: rr_address size.
	aWriteStream nextPutAll: rr_address
]

{ #category : #'as yet unclassified' }
PaleoRRA >> serializeTo: aWriteStream [ 
	self
		serializeHeaderTo: aWriteStream;
		serializeAddressTo: aWriteStream.
]
