Class {
	#name : #BaselineOfPaleoDNS,
	#superclass : #BaselineOf,
	#category : #BaselineOfPaleoDNS
}

{ #category : #baselines }
BaselineOfPaleoDNS >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec
			package: 'Paleo-DNS';
			package: 'Paleo-DNS-Tests' with: [ spec requires: #('Paleo-DNS') ].
		spec
			group: 'default' with: #('Core' 'Tests');
			group: 'Core' with: 'Paleo-DNS';
			group: 'Tests' with: 'Paleo-DNS-Tests']
]
