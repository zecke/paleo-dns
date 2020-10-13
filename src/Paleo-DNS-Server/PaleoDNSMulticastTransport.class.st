Class {
	#name : #PaleoDNSMulticastTransport,
	#superclass : #Object,
	#instVars : [
		'quit',
		'unicastIP',
		'unicastPort',
		'multicastPort',
		'multicastIP',
		'multicastSocket',
		'onRequest'
	],
	#category : #'Paleo-DNS-Server'
}

{ #category : #accessing }
PaleoDNSMulticastTransport >> buildIpMreq [
	^ (IPMREQMacos
		initWith: (SocketAddress fromDottedString: multicastIP)) getHandle
]

{ #category : #accessing }
PaleoDNSMulticastTransport >> dispatchRequest [
	| data res |
	data := ByteArray new: 4096.
	multicastSocket waitForData.
	res := multicastSocket receiveUDPDataInto: data.

	"Skip processing if no data was returned"
	res first == 0
		ifTrue: [ ^ self ].

	"Parse the message and ignore responses that we might have caught"
	[ [ | dns |
	dns := PaleoDNSQuery parse: data readStream.
	onRequest cull: res second cull: res third cull: dns ]
		on: PaleoDNSNotAQuery
		do: [ Transcript nextPutAll: 'Ignoring not a query'; cr. ] ]
		on: Error
		do: [ :e | 
			Transcript
				nextPutAll: 'Error';
				nextPutAll: e displayString;
				cr ]
]

{ #category : #initialization }
PaleoDNSMulticastTransport >> initialize [
	super initialize.
	unicastIP := '0.0.0.0'.
	unicastPort := 0.
	multicastPort := 5353.
	multicastIP := '224.0.0.251'.
	
	onRequest := [ ].
]

{ #category : #accessing }
PaleoDNSMulticastTransport >> onData: aBlock [
	onRequest := aBlock
]

{ #category : #accessing }
PaleoDNSMulticastTransport >> onRequest: aBlock [
	onRequest := aBlock
]

{ #category : #accessing }
PaleoDNSMulticastTransport >> start [
	multicastSocket := Socket newUDP.
	multicastSocket setOption: 'SO_REUSEADDR' value: 1.
	multicastSocket setOption: 'IP_MULTICAST_LOOP' value: 1.
	multicastSocket
		setOption: 'IP_ADD_MEMBERSHIP'
		value: self buildIpMreq.
	multicastSocket
		bindTo: (SocketAddress fromDottedString: multicastIP)
		port: 5353.


	"Now spawn the process"
	quit := false.
	[ [ quit ] whileFalse: [ self dispatchRequest ] ]
		forkNamed: 'Paleo Multicast'
]

{ #category : #accessing }
PaleoDNSMulticastTransport >> stop [
	quit := true.
	multicastSocket ifNotNil: [:s | s closeAndDestroy. ].
]
