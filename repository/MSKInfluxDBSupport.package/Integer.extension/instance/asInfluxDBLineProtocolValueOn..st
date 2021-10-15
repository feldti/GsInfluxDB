*MSKInfluxDBSupport-extensions
asInfluxDBLineProtocolValueOn: aStream

	self printOn: aStream.
	aStream nextPut: $i
