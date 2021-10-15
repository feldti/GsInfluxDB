*MSKInfluxDBSupport-extensions
asInfluxDBLineProtocolValueOn: aStream

	aStream nextPutAll: (self ifTrue:[ 't' ] ifFalse:[ 'f' ])
