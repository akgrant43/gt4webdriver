Class {
	#name : #GtWebDriverFirefoxOptions,
	#superclass : #GtWebDriverArgOptions,
	#instVars : [
		'preferences',
		'profile'
	],
	#category : #'GToolkit4WebDriver-Options'
}

{ #category : #'as yet unclassified' }
GtWebDriverFirefoxOptions >> finalArguments [
	"Answer the arguments to be passed to the driver"
	<return: #Array>

	^ profile
		ifNil: [ arguments asArray ]
		ifNotNil: [ arguments asArray, { '-profile'. profile. } ]
]

{ #category : #'as yet unclassified' }
GtWebDriverFirefoxOptions >> initialize [

	super initialize.
	preferences := Dictionary new.
]

{ #category : #'as yet unclassified' }
GtWebDriverFirefoxOptions >> preferenceAt: aKey put: aValue [

	aKey isString ifFalse:
		[ self error: 'Preference keys must be strings' ].
	(aValue isString or: [ aValue isInteger or: [ aValue isBoolean ] ]) ifFalse:
		[ self error: 'Preference values must be one of: string, integer, boolean' ].
	preferences at: aKey put: aValue.
]

{ #category : #accessing }
GtWebDriverFirefoxOptions >> preferences [
	^ preferences
]

{ #category : #accessing }
GtWebDriverFirefoxOptions >> profile [
	^ profile
]

{ #category : #accessing }
GtWebDriverFirefoxOptions >> profile: aString [
	"Set the location of the profile.  Currently a String."

	profile := aString
]
