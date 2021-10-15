writing
writeFields: aDictionary asInfluxDBLineProtocolOn: aStream
	| commaNeeded |

	aDictionary isEmpty ifTrue: [ ^self ].

	aStream space.
	commaNeeded := false.
	aDictionary associationsDo: [ :eachAssociation |
		commaNeeded ifTrue:[ aStream nextPut: $, ].
		eachAssociation key asInfluxDBLineProtocolKeyOn: aStream.
		aStream	
			nextPut: $= .
		eachAssociation value asInfluxDBLineProtocolValueOn: aStream.
		commaNeeded := true	].
