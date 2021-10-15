writing
writeTimestampAsInfluxDBLineProtocolOn: aStream

	aStream
		space.

	self currentJobTS asInfluxDBLineProtocolValueOn: aStream
