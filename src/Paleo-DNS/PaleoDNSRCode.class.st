"
Defined error codes for DNS
"
Class {
	#name : #PaleoDNSRCode,
	#superclass : #Object,
	#category : #'Paleo-DNS-Errors'
}

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> BADALG [
	^21
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> BADKEY [
	^17
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> BADMODE [
	^19
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> BADNAME [
	^20
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> BADTIME [
	^18
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> BADTRUC [
	^22
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> BADVERS [
	^16 "Conflicts with TSIG"
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> FormErr [
	^1
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> NXDomain [
	^3
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> NXRRSet [
	^8
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> NoError [
	^0
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> NotAuth [
	^9
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> NotImp [
	^4
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> NotZone [
	^10
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> Refused [
	^5
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> ServFail [
	^2
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> YXDomain [
	^6
]

{ #category : #'as yet unclassified' }
PaleoDNSRCode class >> YXRRSet [
	^7
]
