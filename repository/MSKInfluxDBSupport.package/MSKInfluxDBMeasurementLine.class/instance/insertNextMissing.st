insertion
insertNextMissing
	"Adds one measure point from the input queue in the set of known measure points"

	| measurePoint |

	measurePoint := self inputQueue remove.

	self points add: measurePoint.

	self aggregationLines do: [ :each | each addMeasurePoint: measurePoint ]
