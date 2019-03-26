"
A PaleoRROptTest is a test class for testing the behavior of PaleoRROpt
"
Class {
	#name : #PaleoRROptTest,
	#superclass : #TestCase,
	#category : #'Paleo-DNS-Tests-Records'
}

{ #category : #tests }
PaleoRROptTest >> test_decoding_success [
	| opt stream |
	stream := (ByteArray readHexFrom: '0000291000000000000000') readStream.
	opt := PaleoRROpt parse: stream.

	"Verify all of it has been consumed."
	self assert: stream atEnd.
	self assert: opt rr_name equals: '.'.
	self assert: opt udpPayloadSize equals: 4096.

	self flag: #todo. "Check RCODE, Do flag, Options"
]

{ #category : #tests }
PaleoRROptTest >> test_encoding_success [
	| data |
	data := PaleoRROpt new
				udpPayloadSize: 4096;
				rcode: 0;
				edns0Version: 0;
				doFlag: false;
				serialize.

	self assert: data equals: #[0 0 41 16 0 0 0 0 0 0 0].
]
