"
I represent a response with a header and the sections
"
Class {
	#name : #PaleoDNSResponse,
	#superclass : #PaleoDNSMessage,
	#instVars : [
		'recursionAvailable',
		'answerAuthenticated',
		'replyCode',
		'authoriativeServer'
	],
	#category : #'Paleo-DNS-Message'
}

{ #category : #'as yet unclassified' }
PaleoDNSResponse >> answerAuthenticated [
	^ answerAuthenticated
]

{ #category : #accessing }
PaleoDNSResponse >> answerAuthenticated: aBoolean [
	answerAuthenticated := aBoolean
]

{ #category : #accessing }
PaleoDNSResponse >> authoriativeServer: aBoolean [
	authoriativeServer := aBoolean
]

{ #category : #accessing }
PaleoDNSResponse >> flagsAsUint16 [
	^
		((((((((
		(1 << 15) bitOr: "This is a response"
		(opcode << 11)) bitOr:
		(authoriativeServer asBit << 10)) bitOr:
		(truncated asBit << 9)) bitOr:
		(recursionDesired asBit << 8)) bitOr:
		(recursionAvailable asBit << 7)) bitOr:
		(z << 6)) bitOr:
		(answerAuthenticated asBit << 5)) bitOr:
		(nonAuthenticatedData asBit << 4)) bitOr:
		(replyCode << 0)
]

{ #category : #'as yet unclassified' }
PaleoDNSResponse >> flagsFromUint16: anInteger [ 
	(anInteger >> 15) = 1 ifFalse: [ ^self error: 'This is not a query' ].
	opcode := (anInteger >> 11) & 2r1111.
	authoriativeServer := ((anInteger >> 10) & 2r1) = 1.
	truncated := ((anInteger >> 9) & 2r1) = 1.
	recursionDesired := ((anInteger >> 8) & 2r1) = 1.
	recursionAvailable := ((anInteger >> 7) & 2r1) = 1.
	z := (anInteger >> 6) & 2r1.
	answerAuthenticated := ((anInteger >> 5) & 2r1) = 1.
	nonAuthenticatedData := ((anInteger >> 4) & 2r1) = 1.
	replyCode := anInteger & 2r1111.
]

{ #category : #'as yet unclassified' }
PaleoDNSResponse >> isAuthority [
	^authoriativeServer
]

{ #category : #'as yet unclassified' }
PaleoDNSResponse >> isResponse [
	^true
]

{ #category : #'as yet unclassified' }
PaleoDNSResponse >> recursionAvailable [
	^ recursionAvailable
]

{ #category : #accessing }
PaleoDNSResponse >> recursionAvailable: aBoolean [
	recursionAvailable := aBoolean
]

{ #category : #accessing }
PaleoDNSResponse >> replyCode: aCode [
	aCode > 2r1111 ifTrue: [ self error: 'Code must only be four bits' ].
	replyCode := aCode
]
