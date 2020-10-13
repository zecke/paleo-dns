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
	self flag: #TODO. "This should behave like a stub resolver. In the long term
	we should:
		* Prepare the query name
		* Check the cache and use it if the TTL has not expired.
		* Start with a UDP transport
		* Verify the response (right qname, id's...)
		* If truncated retry on TCP."
	qname := self prepareName: aName
]
