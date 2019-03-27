"
A PaleoDNSResponseTest is a test class for testing the behavior of PaleoDNSResponse
"
Class {
	#name : #PaleoDNSResponseTest,
	#superclass : #TestCase,
	#category : #'Paleo-DNS-Tests-Message'
}

{ #category : #tests }
PaleoDNSResponseTest >> testFlagsAsUint16 [
	| query |
	query := PaleoDNSResponse new
					opcode: 0;
					authoriativeServer: false;
					truncated: false;
					recursionDesired: true;
					recursionAvailable: true;
					z: 0;
					answerAuthenticated: false;
					nonAuthenticatedData: false;
					replyCode: 0;
					yourself.

	self assert: query flagsAsUint16 equals: 16r8180.
]

{ #category : #tests }
PaleoDNSResponseTest >> testParse [
	| query |
	query := PaleoDNSResponse parse: (ByteArray readHexFrom: '5ad0818000010001000000010377777706676f6f676c6503636f6d0000010001c00c00010001000000af0004d83ac5640000290200000000000000') readStream.

	self assert: query transactionId equals: 16r5ad0.
	self assert: query isResponse.
	self deny: query isAuthority.
	self deny: query isTruncated.
	self assert: query recursionDesired.
	self assert: query recursionAvailable.
	self deny: query answerAuthenticated.
	self deny: query nonAuthenticatedData.
	self assert: query questions size equals: 1.
	self assert: query additionals size equals: 1.
	
	self flag: #todo. "Do we have something like GMock to fuzzily compare objects?"
]
