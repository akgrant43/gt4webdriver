Class {
	#name : #BaselineOfGt4webdriver,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4webdriver
}

{ #category : #baseline }
BaselineOfGt4webdriver >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Gt4webdriver'
		]
]
