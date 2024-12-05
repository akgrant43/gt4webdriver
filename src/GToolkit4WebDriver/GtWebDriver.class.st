Class {
	#name : #GtWebDriver,
	#superclass : #Object,
	#instVars : [
		'driverProcess',
		'port',
		'host'
	],
	#category : #'GToolkit4WebDriver-Model'
}

{ #category : #'instance creation' }
GtWebDriver class >> firefox [

	^ GtFirefoxWebDriver new
]

{ #category : #private }
GtWebDriver >> driverArguments [

	^ self subclassResponsibility
]

{ #category : #private }
GtWebDriver >> driverCommand [

	^ self subclassResponsibility
]

{ #category : #private }
GtWebDriver >> driverUrl [

	^ String new: 100 streamContents: [ :stream |
		stream
			<< 'http://';
			<< host;
			<< ':';
			print: port ]
]

{ #category : #accessing }
GtWebDriver >> host [
	^ host
]

{ #category : #accessing }
GtWebDriver >> host: anObject [
	host := anObject
]

{ #category : #'as yet unclassified' }
GtWebDriver >> initialize [

	super initialize.
	host := 'localhost'.
	port := 0.
]

{ #category : #'as yet unclassified' }
GtWebDriver >> newSession [
	| response |

	response := ZnClient new
		url: self driverUrl;
		addPath: 'session';
		entity: (ZnEntity json: '{
			"capabilities" : {} }');
		post.
	^ ((STONJSON fromString: response)
		at: 'value')
		at: 'sessionId'.
]

{ #category : #accessing }
GtWebDriver >> port [
	^ port
]

{ #category : #accessing }
GtWebDriver >> port: anInteger [
	port := anInteger
]

{ #category : #'start-stop' }
GtWebDriver >> startDriver [

	driverProcess ifNotNil: 
		[ self error: 'Driver already started' ].
	driverProcess := GtExternalProcessBuilder new
		command: self driverCommand;
		arguments: self driverArguments;
		pipeStdout;
		spawn.
	driverProcess isRunning ifFalse:
		[ self error: 'Unable to start driver' ].
	driverProcess stdout
]
