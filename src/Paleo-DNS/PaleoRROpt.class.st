"
I represent an opt record to indicate extensibality.
"
Class {
	#name : #PaleoRROpt,
	#superclass : #PaleoRR,
	#category : #'Paleo-DNS-Records'
}

{ #category : #'as yet unclassified' }
PaleoRROpt class >> parse: aReadStream [
	^PaleoRROpt basicNew
		parseHeader: aReadStream;
		parseOptions: aReadStream;
		yourself.
]

{ #category : #'as yet unclassified' }
PaleoRROpt class >> rrType [
	^41
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> doFlag: aBoolean [
	self flag: #todo. "Actually set the right bits" 
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> edns0Version: anInteger [ 
	self flag: #todo. "Actuall set it"
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> parseOptions: aReadStream [ 
	| len options |
	len := aReadStream uint16.
	options := aReadStream next: len.
	self flag: #todo. "Parse TLV now...

                  +0 (MSB)                            +1 (LSB)
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    0: |                          OPTION-CODE                          |
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    2: |                         OPTION-LENGTH                         |
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
    4: |                                                               |
       /                          OPTION-DATA                          /
       /                                                               /
       +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
	"
]

{ #category : #parsing }
PaleoRROpt >> parseRData: aReadStream [
	self parseOptions: aReadStream.
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> rcode [
	^rr_ttl
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> rcode: anInteger [ 
	self flag: #todo. "Set the high bits"
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> rr_name [
	^rr_name
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> serializeOptionsTo: aWriteStream [ 
	self flag: #todo. "Actually implement it..."
	aWriteStream uint16: 0.
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> serializeTo: aWriteStream [ 
	self
		serializeHeaderTo: aWriteStream;
		serializeOptionsTo: aWriteStream.
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> udpPayloadSize [
	^rr_class
]

{ #category : #'as yet unclassified' }
PaleoRROpt >> udpPayloadSize: anInteger [ 
	rr_class := anInteger
]
