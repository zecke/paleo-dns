"
I represent a transport over TCP.

TODO(zecke): Actually implement it. If a DNS response is truncated we will retry with TCP.
"
Class {
	#name : #PaleoDNSTCPTransport,
	#superclass : #PaleoRR,
	#category : #'Paleo-DNS-Transport'
}
