# ldbc
LDBC Benchmarks for RageDB


LDBC Social Network - Size 10


### Test Server:

	CPU: Intel(R) Core(TM) i7-10700K CPU @ 3.80GHz
    RAM: 64 GB
	Notes: Testing locally on 4 out of 8 cores.

### Interactive Short Query 1

	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is1.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency   183.54us   56.65us   3.90ms   70.18%
	    Req/Sec     5.38k   259.78     5.80k    67.47%
	  Latency Distribution
	     50%  178.00us
	     75%  217.00us
	     90%  256.00us
	     99%  335.00us
	  2575829 requests in 1.00m, 779.40MB read
	Requests/sec:  42859.13
	Transfer/sec:     12.97MB


	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is1-date-formatted.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency   215.75us   64.73us   4.77ms   68.85%
	    Req/Sec     4.59k   189.23     5.64k    66.56%
	  Latency Distribution
	     50%  209.00us
	     75%  255.00us
	     90%  301.00us
	     99%  392.00us
	  2195898 requests in 1.00m, 681.41MB read
	Requests/sec:  36537.49
	Transfer/sec:     11.34MB


### Interactive Short Query 2

	TODO


### Interactive Short Query 3

	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is3.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency   247.19us  101.43us   3.86ms   73.95%
	    Req/Sec     4.04k   169.56     4.45k    65.99%
	  Latency Distribution
	     50%  230.00us
	     75%  296.00us
	     90%  374.00us
	     99%  582.00us
	  1934354 requests in 1.00m, 477.27MB read
	Requests/sec:  32185.85
	Transfer/sec:      7.94MB


	./wrk -c 8 -t 8 -d 60s -s ../ldbc/wrk/is3-date-formatted.lua --latency http://0.0.0.0:7243
	Running 1m test @ http://0.0.0.0:7243
	  8 threads and 8 connections
	  Thread Stats   Avg      Stdev     Max   +/- Stdev
	    Latency   296.82us  124.55us   2.32ms   74.28%
	    Req/Sec     3.38k   134.75     3.74k    68.12%
	  Latency Distribution
	     50%  275.00us
	     75%  356.00us
	     90%  452.00us
	     99%  716.00us
	  1617719 requests in 1.00m, 417.84MB read
	Requests/sec:  26917.33
	Transfer/sec:      6.95MB



### Import Tweaks

Change person_knows_person_0_0.csv header from:

	Person.id|Person.id|creationDate

to

	Person1.id|Person2.id|creationDate

Change tagclass_isSubclassOf_tagclass_0_0.csv header from:

	TagClass.id|TagClass.id

to

	TagClass1.id|TagClass2.id

Change place_isPartOf_place_0_0.csv header from:

	Place.id|Place.id

to

	Place1.id|Place2.id
