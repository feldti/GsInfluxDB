*MSKInfluxDBSupport-extensions
asInfluxDBLineProtocolValueOn: aStream

	aStream nextPut: $" ; nextPutAll: self ; nextPut: $"
