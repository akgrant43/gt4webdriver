Class {
	#name : #GtFirefoxWebDriver,
	#superclass : #GtWebDriver,
	#category : #'GToolkit4WebDriver-Model'
}

{ #category : #'as yet unclassified' }
GtFirefoxWebDriver >> driverArguments [

	^ { '-p'. port asString. }
]

{ #category : #'as yet unclassified' }
GtFirefoxWebDriver >> driverCommand [

	^ 'geckodriver'
]
