"
I am the base class for a DNS message as sent on the wire. My specialisations know how to make a query and get a response.
"
Class {
	#name : #PaleoDNSMessage,
	#superclass : #Object,
	#instVars : [
		'questions',
		'answers',
		'auths',
		'additionals',
		'transactionId',
		'truncated',
		'recursionDesired',
		'opcode',
		'nonAuthenticatedData',
		'z'
	],
	#category : #'Paleo-DNS-Message'
}

{ #category : #'as yet unclassified' }
PaleoDNSMessage class >> parse: aReadStream [ 
	^self basicNew
		parseHeader: aReadStream;
		parseQuestions: aReadStream;
		parseAnswers: aReadStream;
		parseAuths: aReadStream;
		parseAdditionals: aReadStream;
		yourself
]

{ #category : #adding }
PaleoDNSMessage >> addAdditional: anAdditional [
	self flag: #todo. "Check if there is only a single opt record and then replace or error?"
	additionals add: anAdditional
]

{ #category : #adding }
PaleoDNSMessage >> addAnswer: anAnswer [
	answers add: anAnswer
]

{ #category : #adding }
PaleoDNSMessage >> addAuthoriative: anAuth [
	auths add: anAuth
]

{ #category : #adding }
PaleoDNSMessage >> addQuestion: aQuestion [
	questions add: aQuestion
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> additionals [
	^ additionals
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> answers [
	^ answers
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> findOPTRecord [
	additionals do: [:each |
		(each isKindOf: PaleoRROpt) ifTrue: [ ^each ] ].
	^nil
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> flagsAsUint16 [
	^self subclassResponsibility
	
]

{ #category : #initialization }
PaleoDNSMessage >> initialize [
	super initialize.
	questions := OrderedCollection new.
	answers := OrderedCollection new.
	auths := OrderedCollection new.
	additionals := OrderedCollection new.


	opcode := 0.
	truncated := false.
	recursionDesired := true.
	nonAuthenticatedData := false.
	"Don't initialize transactionId. We want the caller to randomize it."
	transactionId := nil.
]

{ #category : #testing }
PaleoDNSMessage >> isQuery [
	^false
]

{ #category : #testing }
PaleoDNSMessage >> isResponse [
	^false
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> isTruncated [
	^truncated
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> nonAuthenticatedData [
	^ nonAuthenticatedData
]

{ #category : #accessing }
PaleoDNSMessage >> nonAuthenticatedData: aBoolean [
	nonAuthenticatedData := aBoolean
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> nonauthenticatedData [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> opcode: anOpcode [
	opcode := anOpcode
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> parseAdditionals: aReadStream [ 
	self parseSection: aReadStream into: additionals.
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> parseAnswers: aReadStream [ 
	self parseSection: aReadStream into: answers.
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> parseAuths: aReadStream [ 
	self parseSection: aReadStream into: auths
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> parseHeader: aReadStream [ 
	| hdr |
	transactionId := aReadStream uint16.

	self flag: #todo. "I need a Slot to define bits..."
	hdr := aReadStream uint16.
	self flagsFromUint16: hdr.

	self flag: #todo. "Or keep the parsing state somewhere? What if we want to parse and the modify the query?"
	questions := Array new: aReadStream uint16.
	answers := Array new: aReadStream uint16.
	auths := Array new: aReadStream uint16.
	additionals := Array new: aReadStream uint16.
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> parseQuestions: aReadStream [
	"The question doesn't have the RDATA but only the header."
	questions withIndexCollect: [:val :idx |
		questions at: idx put: (PaleoRR parseBase: aReadStream)
	].
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> parseSection: aReadStream into: aSection [ 
	"The question doesn't have the RDATA but only the header."
	aSection withIndexCollect: [:val :idx |
		aSection at: idx put: (PaleoRR parse: aReadStream)
	].
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> questions [
	^ questions
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> recursionDesired [
	^recursionDesired
]

{ #category : #adding }
PaleoDNSMessage >> recursionDesired: aBoolean [
	recursionDesired := aBoolean
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> serialize [
	^ByteArray streamContents: [:stream |
		self serializeTo: stream].
]

{ #category : #adding }
PaleoDNSMessage >> serializeHeaderTo: aWriteStream [
	aWriteStream
		uint16: transactionId;
		uint16: self flagsAsUint16;
		uint16: questions size;
		uint16: answers size;
		uint16: auths size;
		uint16: additionals size.
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> serializeTo: aWriteStream [ 
	self serializeHeaderTo: aWriteStream.
	questions do: [:each | each serializeBaseTo: aWriteStream ].
	answers do: [:each | each serializeTo: aWriteStream ].
	auths do: [:each | each serializeTo: aWriteStream ].
	additionals do: [:each | each serializeTo: aWriteStream ].
]

{ #category : #'as yet unclassified' }
PaleoDNSMessage >> transactionId [
	^ transactionId
]

{ #category : #adding }
PaleoDNSMessage >> transactionId: anId [
	transactionId := anId
]

{ #category : #adding }
PaleoDNSMessage >> truncated: aBoolean [
	truncated := aBoolean.
]

{ #category : #accessing }
PaleoDNSMessage >> z: aBoolean [
	z := aBoolean
]
