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
	    Latency     0.97ms  405.22us   4.76ms   72.30%
	    Req/Sec     1.05k    55.17     1.25k    69.90%
	  Latency Distribution
	     50%    0.90ms
	     75%    1.18ms
	     90%    1.49ms
	     99%    2.23ms
	  499328 requests in 1.00m, 509.07MB read
	Requests/sec:   8319.84
	Transfer/sec:      8.48MB


	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is3-date-formatted.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency     1.28ms  604.89us  35.16ms   80.96%
	    Req/Sec   789.67     50.99     0.98k    73.21%
	  Latency Distribution
	     50%    1.20ms
	     75%    1.55ms
	     90%    1.93ms
	     99%    2.87ms
	  377387 requests in 1.00m, 418.59MB read
	Requests/sec:   6287.42
	Transfer/sec:      6.97MB


### Import Tweaks

Change person_knows_person_0_0.csv header from:

	Person.id|Person.id|creationDate

to

	Person1.id|Person2.id|creationDate

