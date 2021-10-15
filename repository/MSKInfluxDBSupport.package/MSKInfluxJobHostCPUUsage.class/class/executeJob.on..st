other
executeJob: jobManager on: aStream

	| tmpStatistics |
	System  hostCpuUsage.
	System _sleepMs: 100.
	tmpStatistics := System  hostCpuUsage.
