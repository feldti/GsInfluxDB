other
executeJob: jobManager on: aStream
	"
		| job writeStream |

		job := MSKInfluxSystemStatistics new initialize.
		writeStream := WriteStream on: String new.
		job executeJob: nil on: writeStream.
		writeStream contents

	"
	|  tagDictionary fieldDictionary statNames statValues indexFound |

	statNames  := System fetchSystemStatNames.
	statValues := System fetchSystemStats.	self updateCurrentJobTS.

	tagDictionary := Dictionary new.
	(indexFound := statNames indexOf:  'PercentCpuActive'  ifAbsent: [ 0 ]) = 0 ifTrue:[ ^self ].

	tagDictionary 
		at: 'PercentCpuActive' put: (statValues at:  indexFound) .
	(indexFound := statNames indexOf:  'PercentCpuIOWait'  ifAbsent: [ 0 ]) = 0 ifTrue:[ ^self ].
	tagDictionary 
		at: 'PercentCpuIOWait' put: (statValues at:  indexFound) .



	fieldDictionary := Dictionary new.
	1 to: statNames size do: [ :anIndex |
		| eachName eachValue |
		eachName := statNames at: anIndex.
		eachValue := statValues at: anIndex.
		(eachValue isEmpty not and:[ (eachName ~=  'PercentCpuActive' and:[  eachName ~=  'PercentCpuIOWait' ]) ])
			ifTrue:[ 
				fieldDictionary 
					at: eachName put: eachValue 	
			]
	].

	self 
		writeMeasurementAsInfluxDBLineProtocolOn: aStream ;
		writeTags: tagDictionary asInfluxDBLineProtocolOn: aStream ;
		writeFields: fieldDictionary asInfluxDBLineProtocolOn: aStream ;
		writeTimestampAsInfluxDBLineProtocolOn: aStream ;
		writeLineEndingAsInfluxDBLineProtocolOn: aStream.


	self updateNextJobTS
