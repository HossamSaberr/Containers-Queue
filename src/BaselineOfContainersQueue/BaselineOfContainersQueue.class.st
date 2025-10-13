"
I represent the baseline for Queue DS Implementation
"
Class {
	#name : 'BaselineOfContainersQueue',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfContainersQueue',
	#package : 'BaselineOfContainersQueue'
}

{ #category : 'baselines' }
BaselineOfContainersQueue >> baseline: spec [
	<baseline>

	spec for: #pharo do: [		
		spec package: 'Containers-Queue'.
		spec package: 'Containers-Queue-Tests' with: [ spec requires: #('Containers-Queue') ]
	]
]
