insertion
insertAllMissings

	[ self inputQueue isEmpty ] whileFalse:[ self insertNextMissing ]
