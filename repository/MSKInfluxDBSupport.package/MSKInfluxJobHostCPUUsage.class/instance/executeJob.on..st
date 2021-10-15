execution
executeJob: jobManager on: aStream
	"
		| job writeStream |

		job := MSKInfluxJobHostCPUUsage new initialize.


			writeStream := WriteStream on: String new.
			job executeJob: nil on: writeStream.
			Transcript cr ; show: writeStream contents


	"
	| tmpStatistics tagDictionary fieldDictionary |

	(tmpStatistics :=  System  hostCpuUsage) == nil ifTrue:[ ^self ].	
	(tmpStatistics := System  hostCpuUsage) == nil ifTrue:[ ^self ].

	self updateCurrentJobTS.

	tagDictionary := Dictionary new.
	tagDictionary 
		at: 'activecpu' put: (tmpStatistics at: 1) asInteger ;
		at: 'iowait' put: (tmpStatistics at: 5) asInteger.

	fieldDictionary := Dictionary new.
	fieldDictionary 
		at: 'idlecpu' put: (tmpStatistics at: 2) asInteger ;
		at: 'usercpu' put: (tmpStatistics at: 3) asInteger ;
		at: 'kernelcpu' put: (tmpStatistics at: 4) asInteger.

	self 
		writeMeasurementAsInfluxDBLineProtocolOn: aStream ;
		writeTags: tagDictionary asInfluxDBLineProtocolOn: aStream ;
		writeFields: fieldDictionary asInfluxDBLineProtocolOn: aStream ;
		writeTimestampAsInfluxDBLineProtocolOn: aStream ;
		writeLineEndingAsInfluxDBLineProtocolOn: aStream.


	self updateNextJobTS
