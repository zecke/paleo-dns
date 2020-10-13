Class {
	#name : #IPMREQMacos,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_IMR_INTERFACE',
		'OFFSET_IMR_MULTIADDR'
	],
	#category : #'Paleo-DNS-Server-Structs'
}

{ #category : #'field definition' }
IPMREQMacos class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(uint32 imr_multiaddr #';' uint32 imr_interface #';')
]

{ #category : #'field definition' }
IPMREQMacos class >> initWith: anAddress [
	^ self new
		imr_interface: 0;
		imr_multiaddr: (anAddress unsignedLongAt: 1 bigEndian: true);
		yourself.
]

{ #category : #'accessing structure variables' }
IPMREQMacos >> imr_interface [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_IMR_INTERFACE
]

{ #category : #'accessing structure variables' }
IPMREQMacos >> imr_interface: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_IMR_INTERFACE put: anObject
]

{ #category : #'accessing structure variables' }
IPMREQMacos >> imr_multiaddr [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_IMR_MULTIADDR
]

{ #category : #'accessing structure variables' }
IPMREQMacos >> imr_multiaddr: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_IMR_MULTIADDR put: anObject
]
