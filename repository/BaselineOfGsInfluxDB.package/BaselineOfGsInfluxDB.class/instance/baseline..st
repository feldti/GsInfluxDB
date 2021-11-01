other
baseline: spec 
	<baseline>
	spec
		for: #'gemstone'
		do: [
			"Now the actual delivered packages"
			spec
				package: 'MSKInfluxDBSupport';
				yourself.

			"Now the names for more specific loading"
			spec
				group: 'default' with: #('MSKInfluxDBSupport');
				yourself
		]