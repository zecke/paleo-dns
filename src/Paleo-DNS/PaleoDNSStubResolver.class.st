Class {
	#name : #PaleoDNSStubResolver,
	#superclass : #Object,
	#instVars : [
		'dnsSetting'
	],
	#category : #'Paleo-DNS-Resolver'
}

{ #category : #'as yet unclassified' }
PaleoDNSStubResolver class >> initWith: aSetting [
	self new
		dnsSettings: aSetting;
		yourself
]

{ #category : #'as yet unclassified' }
PaleoDNSStubResolver >> resolve: aName type: anRR [
	| qname |
	qname := self prepareName: aName.
]
