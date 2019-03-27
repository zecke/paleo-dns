"
A PaleoRRGenericTest is a test class for testing the behavior of PaleoRRGeneric
"
Class {
	#name : #PaleoRRGenericTest,
	#superclass : #TestCase,
	#category : #'Paleo-DNS-Tests-Records'
}

{ #category : #tests }
PaleoRRGenericTest >> test_decoding_success [
	| generic stream |
	stream := (ByteArray readHexFrom: '0000291000000000000000') readStream.
	generic := PaleoRRGeneric parse: stream.

	"Verify all of it has been consumed."
	self assert: stream atEnd.
	self assert: generic rr_name equals: '.'.
	self assert: generic rr_type equals: PaleoRROpt rrType.
	self assert: generic rr_class equals: 4096.
	self assert: generic rr_ttl equals: 0.
	self assert: generic rr_data equals: #[].
]

{ #category : #tests }
PaleoRRGenericTest >> test_encoding_success [
	| data |
	data := PaleoRRGeneric new
				rr_name: '.';
				rr_type: PaleoRROpt rrType;
				rr_class: 4096;
				rr_ttl: 0;
				rr_data: #[1 2 3];
				serialize.

	self assert: data equals: #[0 0 41 16 0 0 0 0 0 0 3 1 2 3].
]
