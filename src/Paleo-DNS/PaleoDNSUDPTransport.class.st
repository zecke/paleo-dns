"
I can send a request over UDP and receive a response
"
Class {
	#name : #PaleoDNSUDPTransport,
	#superclass : #PaleoDNSTransportBase,
	#category : #'Paleo-DNS-Transport'
}

{ #category : #'as yet unclassified' }
PaleoDNSUDPTransport >> buildBufferFor: aQuery [ 
	^ByteArray new: (self maxResponseSizeFor: aQuery)
]

{ #category : #'as yet unclassified' }
PaleoDNSUDPTransport >> maxResponseSizeFor: aQuery [
	^aQuery findOPTRecord
					ifNil: [ 512 ]
					ifNotNil: [:opt | opt udpPayloadSize ]
]

{ #category : #accessing }
PaleoDNSUDPTransport >> query: aDnsQuery [
	| socket |
	self flag: #todo. "Probably passing the query serialized+opt record is better. This
	avoids a retry having to re-serialize and multiple look-ups."
	"Pick a random source port to avoid being poisoned."
	socket := Socket newUDP.
	^[
		| serialized buffer result |
		serialized := self serializeQuery: aDnsQuery.
		socket sendUDPData: serialized toHost: destHost port: destPort.

		self flag: #todo. "Check the sender addr/port match to make spoofing a little harder or
		preferable use connect on the socket to let the kernel do it."
		socket waitForDataFor: timeout.
		buffer := self buildBufferFor: aDnsQuery.
		result := socket receiveUDPDataInto: buffer.
		PaleoDNSResponse parse: buffer readStream.
	] ensure: [ socket closeAndDestroy ].
]

{ #category : #'as yet unclassified' }
PaleoDNSUDPTransport >> serializeQuery: aQuery [
	| serialized limit |
	serialized := aQuery serialize.
	limit := self maxResponseSizeFor: aQuery.
	serialized size > limit ifTrue: [ PaleoDNSTruncationError signal: 'Can''t send this on UDP transport' ].
	^serialized
]
