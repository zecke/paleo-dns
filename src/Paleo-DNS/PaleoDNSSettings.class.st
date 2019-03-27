"
I represent the settings of the stub resolver.

TODO(zecke): Call it PaleoDnsStubSettings?
"
Class {
	#name : #PaleoDNSSettings,
	#superclass : #Object,
	#instVars : [
		'resolverAddresses',
		'randomNumberGenerator'
	],
	#category : #'Paleo-DNS-Settings'
}

{ #category : #'instance creation' }
PaleoDNSSettings class >> fromSystemSettings [
	^self error: 'I owe you!'
]

{ #category : #'instance creation' }
PaleoDNSSettings class >> withAddresses: aCollection [
	^self new
		resolverAddresses: aCollection;
		yourself
]

{ #category : #accessing }
PaleoDNSSettings >> resolverAddresses [
	^resolverAddresses
]

{ #category : #accessing }
PaleoDNSSettings >> resolverAddresses: aCollection [
	resolverAddresses := aCollection
]

{ #category : #'as yet unclassified' }
PaleoDNSSettings >> use0x20Randomization [
	"Randomize capitalization of the query name to add extra entropy"
	^false
]
