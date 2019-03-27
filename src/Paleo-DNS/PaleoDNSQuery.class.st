"
I am a query for a qname
"
Class {
	#name : #PaleoDNSQuery,
	#superclass : #PaleoDNSMessage,
	#instVars : [
		'ad'
	],
	#category : #'Paleo-DNS-Message'
}

{ #category : #accessing }
PaleoDNSQuery >> ad: aBoolean [
	ad := aBoolean
]

{ #category : #'as yet unclassified' }
PaleoDNSQuery >> flagsAsUint16 [
	^
		(((((
		(0 << 15) bitOr: "This is a request"
		(opcode << 11)) bitOr:
		(truncated asBit << 9)) bitOr:
		(recursionDesired asBit << 8)) bitOr:
		(z << 6)) bitOr:
		(ad asBit << 5)) bitOr:
		(nonAuthenticatedData asBit << 4)
		
]

{ #category : #'as yet unclassified' }
PaleoDNSQuery >> flagsFromUint16: anInteger [ 
	(anInteger >> 15) = 0 ifFalse: [ ^self error: 'This is not a query' ].
	opcode := (anInteger >> 11) & 2r1111.
	truncated := ((anInteger >> 9) & 2r1) = 1.
	recursionDesired := ((anInteger >> 8) & 2r1) = 1.
	z := (anInteger >> 6) & 2r1.
	ad := ((anInteger >> 5) & 2r1) = 1.
	nonAuthenticatedData := ((anInteger >> 4) & 2r1) = 1.
]

{ #category : #initialization }
PaleoDNSQuery >> initialize [
	super initialize.
	z := 0.
	ad := false.
]

{ #category : #'as yet unclassified' }
PaleoDNSQuery >> isQuery [
	^true
]
