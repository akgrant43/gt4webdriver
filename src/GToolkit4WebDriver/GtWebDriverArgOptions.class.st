Class {
	#name : #GtWebDriverArgOptions,
	#superclass : #GtWebDriverBaseOptions,
	#instVars : [
		'arguments',
		'capabilities'
	],
	#category : #'GToolkit4WebDriver-Options'
}

{ #category : #accessing }
GtWebDriverArgOptions >> addArgument: aString [

	aString isString ifFalse:
		[ self error: 'Argument must be a string' ].
	arguments add: aString.
]

{ #category : #accessing }
GtWebDriverArgOptions >> arguments [
	^ arguments
]

{ #category : #accessing }
GtWebDriverArgOptions >> capabilities [
	| alwaysMatch mozFirefox capCaps |

	capCaps := capabilities at: 'capabilities'
		ifAbsentPut: [ Dictionary new ].
	alwaysMatch := capCaps at: 'alwaysMatch'
		ifAbsentPut: [ Dictionary new ].
	mozFirefox := alwaysMatch at: 'moz:firefoxOptions'
		ifAbsentPut: [ Dictionary new ].
	mozFirefox at: 'args' put: self finalArguments.
	^ capabilities
]

{ #category : #accessing }
GtWebDriverArgOptions >> finalArguments [

	^ arguments asArray
]

{ #category : #'as yet unclassified' }
GtWebDriverArgOptions >> initialize [

	super initialize.
	arguments := OrderedCollection new.
	capabilities := Dictionary new.
]
