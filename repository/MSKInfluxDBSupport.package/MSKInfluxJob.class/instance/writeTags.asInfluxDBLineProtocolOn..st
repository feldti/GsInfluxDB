writing
writeTags: aDictionary asInfluxDBLineProtocolOn: aStream

	aDictionary isEmpty
		ifFalse:[
			| sortedCollection |
			"for best performance you should sort tags by key before sending them to the database - https://docs.influxdata.com/influxdb/v1.7/write_protocols/line_protocol_tutorial/"
			sortedCollection := SortedCollection sortBlock: [ :assocA :assocB | assocA key < assocB key ].
			sortedCollection addAll: aDictionary associations.
			sortedCollection do: [ :eachAssociation |
				aStream
					nextPut: $, .
				eachAssociation key asInfluxDBLineProtocolKeyOn: aStream.
				aStream	
					nextPut: $= .
				eachAssociation value asInfluxDBLineProtocolValueOn: aStream
			]
		]
