other
executeJob: jobManager on: aStream
	"
		| job writeStream |

		job := MSKInfluxStoneStatistics new initialize.
		writeStream := WriteStream on: String new.
		job executeJob: nil on: writeStream.
		writeStream


	"
	|  tagDictionary fieldDictionary statNames statValues indexFound |

	statNames  := System cacheStatisticsDescriptionForStone.
	statValues := System stoneCacheStatistics.	

	self updateCurrentJobTS.

	tagDictionary := Dictionary new.
	(indexFound := statNames indexOf:  'LocalPageCacheMisses'  ifAbsent: [ 0 ]) = 0 ifTrue:[ ^self ].
	tagDictionary 
		at: 'LocalPageCacheMisses' put: (statValues at:  indexFound) .

	(indexFound := statNames indexOf:  'PageWrites'  ifAbsent: [ 0 ]) = 0 ifTrue:[ ^self ].
	tagDictionary 
		at: 'PageWrites' put: (statValues at:  indexFound) .


	(indexFound := statNames indexOf:  'PageReads'  ifAbsent: [ 0 ]) = 0 ifTrue:[ ^self ].
	tagDictionary 
		at: 'PageReads' put: (statValues at:  indexFound) .


	fieldDictionary := Dictionary new.
	1 to: statNames size do: [ :anIndex |
		| eachName eachValue |
		eachName := statNames at: anIndex.
		eachValue := statValues at: anIndex.
		(eachValue isEmpty not and:[ (eachName ~=  'PageWrites' and:[  eachName ~=  'PageReads' and:[  eachName ~=  'LocalPageCacheMisses' ] ]) ])
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
