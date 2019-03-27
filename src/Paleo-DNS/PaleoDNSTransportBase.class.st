Class {
	#name : #PaleoDNSTransportBase,
	#superclass : #Object,
	#instVars : [
		'destHost',
		'destPort',
		'timeout'
	],
	#category : #'Paleo-DNS-Transport'
}

{ #category : #'as yet unclassified' }
PaleoDNSTransportBase >> destAddress: anAddress port: aPort [ 
	destHost := anAddress asSocketAddress.
	destPort := aPort
]

{ #category : #'as yet unclassified' }
PaleoDNSTransportBase >> timeout: aDuration [
	timeout := aDuration asSeconds.
]
