Class {
	#name : #PaleoDNSTLSTransport,
	#superclass : #PaleoDNSTCPTransport,
	#category : #'Paleo-DNS-Transport'
}

{ #category : #'as yet unclassified' }
PaleoDNSTLSTransport >> newSocketStream [
	^(ZdcSecureSocketStream openConnectionToHost: destHost port: destPort timeout: timeout)
		connect;
		yourself
]
