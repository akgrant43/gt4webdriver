Class {
	#name : #GtWebDriverSession,
	#superclass : #Object,
	#instVars : [
		'sessionId',
		'driver'
	],
	#category : #'GToolkit4WebDriver-Model'
}

{ #category : #management }
GtWebDriverSession >> close [
	"Close the current session / window"
	| client result |

	client:= ZnClient new
		url: self driverUrl;
		addPath: 'session';
		addPath: sessionId;
		addPath: 'window'.
	result := client delete.
	((STONJSON fromString: result) at: 'value') ifNotEmpty:
		[ self error: 'ERROR closing: ', sessionId ].
	sessionId := nil.
]

{ #category : #accessing }
GtWebDriverSession >> driver [
	^ driver
]

{ #category : #accessing }
GtWebDriverSession >> driver: anObject [
	driver := anObject
]

{ #category : #'as yet unclassified' }
GtWebDriverSession >> driverUrl [

	^ driver driverUrl
]

{ #category : #navigating }
GtWebDriverSession >> get: aUrl [
	"Instruct the session to navigate to the supplied url"
	| znUrl client result |

	"Convert to a znUrl, which also validates the Url structure"
	znUrl := aUrl asZnUrl.
	client:= ZnClient new
		url: self driverUrl;
		addPath: 'session';
		addPath: sessionId;
		addPath: 'url';
		entity: (ZnEntity json: (STONJSON toString:
			{ 'url' -> znUrl asString } asDictionary)).
	result := client post.
	((STONJSON fromString: result) at: 'value') ifNotNil:
		[ self error: 'Unable to navigate to: ', znUrl asString ].
]

{ #category : #accessing }
GtWebDriverSession >> sessionId [
	^ sessionId
]

{ #category : #accessing }
GtWebDriverSession >> sessionId: anObject [
	sessionId := anObject
]

{ #category : #accessing }
GtWebDriverSession >> source [
	"Answer the current page source"
	| client result |

	client:= ZnClient new
		url: self driverUrl;
		addPath: 'session';
		addPath: sessionId;
		addPath: 'source'.
	result := client get.
	^ (STONJSON fromString: result) at: 'value'.
]
