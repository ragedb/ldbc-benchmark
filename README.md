# ldbc
LDBC Benchmarks for RageDB


LDBC Social Network - Size 01


### Test Server:

	CPU: Intel(R) Core(TM) i7-10700K CPU @ 3.80GHz
    RAM: 64 GB
	Notes: Testing locally on 4 out of 8 cores.

### Interactive Short Query 1

	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is1.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency   185.74us   57.81us   6.42ms   71.40%
	    Req/Sec     5.33k   251.98     8.95k    69.21%
	  Latency Distribution
	     50%  180.00us
	     75%  219.00us
	     90%  257.00us
	     99%  335.00us
	  2549940 requests in 1.00m, 811.53MB read
	Requests/sec:  42428.93
	Transfer/sec:     13.50MB

	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is1-date-formatted.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency   287.64us    2.10ms  92.94ms   99.85%
	    Req/Sec     4.58k   254.34     7.64k    75.54%
	  Latency Distribution
	     50%  210.00us
	     75%  255.00us
	     90%  301.00us
	     99%  398.00us
	  2190175 requests in 1.00m, 680.33MB read
	Requests/sec:  36442.29
	Transfer/sec:     11.32MB


### Interactive Short Query 3

	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is3.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency     0.98ms  398.23us   6.67ms   71.69%
	    Req/Sec     1.03k    54.01     1.22k    69.35%
	  Latency Distribution
	     50%    0.92ms
	     75%    1.20ms
	     90%    1.50ms
	     99%    2.21ms
	  490597 requests in 1.00m, 500.20MB read
	Requests/sec:   8174.47
	Transfer/sec:      8.33MB


	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is3-date-formatted.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency     1.27ms  497.57us   7.69ms   71.51%
	    Req/Sec   790.42     47.60     0.95k    68.15%
	  Latency Distribution
	     50%    1.20ms
	     75%    1.54ms
	     90%    1.92ms
	     99%    2.85ms
	  377751 requests in 1.00m, 419.00MB read
	Requests/sec:   6293.44
	Transfer/sec:      6.98MB


### Import Tweaks

Change person_knows_person_0_0.csv header from:

	Person.id|Person.id|creationDate

to

	Person1.id|Person2.id|creationDate

