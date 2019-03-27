"
I represent a transport over TCP.

TODO(zecke): Actually implement it. If a DNS response is truncated we will retry with TCP.
"
Class {
	#name : #PaleoDNSTCPTransport,
	#superclass : #PaleoDNSTransportBase,
	#category : #'Paleo-DNS-Transport'
}

{ #category : #'as yet unclassified' }
PaleoDNSTCPTransport >> newSocketStream [
	^ZdcSocketStream openConnectionToHost: destHost port: destPort timeout: timeout.
]

{ #category : #'as yet unclassified' }
PaleoDNSTCPTransport >> query: aDnsQuery [
	| socket |
	socket := self newSocketStream.
	^[
		| serialized buffer len |
		self flag: #todo. "Make sure the query is not marked as truncated!"
		serialized := aDnsQuery serialize.
		socket nextPutAll: ((ByteArray new: 2)
									unsignedShortAt: 1 put: serialized size bigEndian: true; yourself).
		socket nextPutAll: serialized.
		socket flushWriteBuffer.

		len := socket next: 2.
		PaleoDNSResponse parse: (socket next: (len unsignedShortAt: 1 bigEndian: true)) readStream.
	] ensure: [ socket socketClose ].
]
