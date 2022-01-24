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
