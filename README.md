# GsInfluxDB
Experimental Playground for Gemstone/S and InfluxDB. 

## Installation

You can load GsInfluxDB using Metacello

```Smalltalk
Metacello new
  repository: 'github://feldti/GsInfluxDB:main/repository';
  baseline: 'GsInfluxDB';
  onLock: [:ex | ex honor ];
  load 
```
