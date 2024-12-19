Class {
	#name : #GtFirefoxWebDriver,
	#superclass : #GtWebDriver,
	#category : #'GToolkit4WebDriver-Model'
}

{ #category : #'as yet unclassified' }
GtFirefoxWebDriver >> akgdSession [
	| options |

	options := GtWebDriverFirefoxOptions new
		profile: '/home/alistair/.mozilla/firefox/walc6jsq.GToperations'.
	^ self newSessionWithOptions: options.
]

{ #category : #private }
GtFirefoxWebDriver >> driverArguments [

	^ { '-p'. port asString. }
]

{ #category : #private }
GtFirefoxWebDriver >> driverCommand [

	^ 'geckodriver'
]

{ #category : #'as yet unclassified' }
GtFirefoxWebDriver >> driverUrl [

	^ 'http://localhost:', port asString
]

{ #category : #private }
GtFirefoxWebDriver >> updatePort [
	| stdout output count |

	1 second wait.
	stdout := driverProcess asynchronousStdout.
	output := stdout upToEnd.
	count := 0.
	[ | index |
	output lines do: [ :line |
		driverProcess isRunning ifFalse: [ self error: 'Lost web-driver process' ].
		index := line indexOfSubCollection: '127.0.0.1:'.
		index > 0 ifTrue:
			[ ^ port := (line copyFrom: index+10 to: line size) trimRight asNumber ].
			output := output, stdout upToEnd ].
	count := count + 1.
	1 second wait ] doWhileTrue:
		[ count < 15 ].
	self error: 'Couldn''t find port'.
]
