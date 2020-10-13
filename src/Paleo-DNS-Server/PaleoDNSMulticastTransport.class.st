Class {
	#name : #PaleoDNSMulticastTransport,
	#superclass : #Object,
	#instVars : [
		'socket',
		'quit'
	],
	#category : #'Paleo-DNS-Server'
}

{ #category : #accessing }
PaleoDNSMulticastTransport >> buildIpMreq [
	^(IPMREQMacos initWith: (SocketAddress fromDottedString: '224.0.0.251')) getHandle
	
]

{ #category : #accessing }
PaleoDNSMulticastTransport >> start [
	| proc |
	socket := Socket newUDP.
	socket setOption: 'SO_REUSEADDR' value: 1.
	socket setOption: 'IP_ADD_MEMBERSHIP' value: self buildIpMreq.
	socket bindTo: (SocketAddress fromDottedString: '0.0.0.0') port: 5353.
	socket inspect.
	quit := false
	"	proc := [ [ quit ] whileFalse: [ self dispatchRequest ] ]
		forkNamed: 'Paleo Multicast'"
]
