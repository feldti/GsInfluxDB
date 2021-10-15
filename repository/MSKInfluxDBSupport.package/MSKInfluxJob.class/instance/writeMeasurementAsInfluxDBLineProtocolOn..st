execution
writeMeasurementAsInfluxDBLineProtocolOn: aStream

	aStream
		nextPutAll: self measurementName
