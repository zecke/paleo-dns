Class {
	#name : #PaleoRRATest,
	#superclass : #TestCase,
	#category : #'Paleo-DNS-Tests-Records'
}

{ #category : #tests }
PaleoRRATest >> test_decoding_success [
	| rra stream |
	stream := (ByteArray readHexFrom: '5ad0818000010001000000010377777706676f6f676c6503636f6d0000010001c00c00010001000000af0004d83ac564') readStream.
	stream skip: 32.
	rra := PaleoRRA parse: stream.

	"Verify all of it has been consumed."
	self assert: stream atEnd.
	self assert: rra rr_name equals: 'www.google.com.'.
	self assert: rra rr_class equals: PaleoRRA classIN.
	self assert: rra rr_ttl equals: 175.
	self assert: rra rr_address equals: #[216 58 197 100] asSocketAddress.
]

{ #category : #tests }
PaleoRRATest >> test_encoding_success [
	| data |
	data := PaleoRRA new
				rr_name: 'www.google.com.';
				rr_class: PaleoRRA classIN;
				rr_ttl: 175;
				rr_address: #[216 58 197 100] asSocketAddress;
				serialize.

	self assert: data equals: #[3 119 119 119 6 103 111 111 103 108 101 3 99 111 109 0 0 1 0 1 0 0 0 175 0 4 216 58 197 100]
]
