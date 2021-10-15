*MSKInfluxDBSupport-extensions
asInfluxDBLineProtocolValueOn: aStream

	(self asUTC asPosixSeconds * 1000000000) truncated printOn: aStream
