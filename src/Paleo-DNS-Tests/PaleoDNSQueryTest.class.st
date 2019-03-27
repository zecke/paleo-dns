"
A PaleoDNSQueryTest is a test class for testing the behavior of PaleoDNSQuery
"
Class {
	#name : #PaleoDNSQueryTest,
	#superclass : #TestCase,
	#category : #'Paleo-DNS-Tests-Message'
}

{ #category : #test }
PaleoDNSQueryTest >> testFlagsAsUint16 [
	| query |
	query := PaleoDNSQuery new
					opcode: 0;
					truncated: false;
					recursionDesired: true;
					z: 0;
					ad: true;
					nonAuthenticatedData: false.

	self assert: query flagsAsUint16 equals: 16r0120.
]

{ #category : #tests }
PaleoDNSQueryTest >> testParse [
	| query |
	query := PaleoDNSQuery parse: (ByteArray readHexFrom: '5ad0012000010000000000010377777706676f6f676c6503636f6d00000100010000291000000000000000') readStream.

	self assert: query transactionId equals: 16r5ad0.
	self assert: query isQuery.
	self deny: query isTruncated.
	self assert: query recursionDesired.
	self deny: query nonAuthenticatedData.
	self assert: query questions size equals: 1.
	self assert: query additionals size equals: 1.
	
	self flag: #todo. "Do we have something like GMock to fuzzily compare objects?"
]
