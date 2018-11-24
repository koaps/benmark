Benmark
=======

Apache Benchmarks against various JRuby and MRI Servers running Camping or Webmachine.

This is my attempt to benchmark some ruby based http servers to use for some projects.

The end goal wasn't to find the fastest server per say, but to see how the various JRuby servers act and compare them against MRI versions.

Mainly I wanted to see how Reel is, I'm a fan of Erlang's actor model and Celluloid and Reel-Rack are pretty interesting to me.

See here --> http://celluloid.io/

While it wasn't the fastest at serving simple content, it felt very robust to test with, it threw the least amount errors, and recovered when crashed.

Use
===

If you wish to use these scripts you might have to tweak a few things, since I jumped around between JRuby and MRI some files are setup for the system they were run last on, for instance jdbc:postgresql adapter on JRuby or postgres adapter on MRI.

The code is fairly basic so it should be easy to change as needed.

Gnuplot
=======

I made a script to generate graphs from Apache Benchmark (ab) gnuplot data files.

The graphs are showing you the number of requests that completed within a certain time (ms).

So for instance you might see 500 requests completed at 40ms.

I put in a cutoff filter because there's a lot of requests that take a while to complete and it throws the scale of the graph so far out that it's hard to see the interest parts.

I defaulted the cutoff at 500ms, feel free to play with the number, or disable the filter by commenting out the block.

The plotter.rb script can be passed multiple files on the command line and it will plot them all on the same graph.

DB
==

I used Sequel for the database connections, the migrate files can be used with the sequel command and the -m and -M flags.

It's a pretty straightforward migration setup.

Specs
=====

My tests were all done on a single machine running SmartOS with 4 VMs.

* JRuby - Zone (base64 13.2.1)
* MRI - KVM (centos 6.4 2.5.0)
* PostgreSQL - Zone (base64 13.2.1)
* AB tester - KVM (centos 6.4 2.5.0)
* Global - Intel Core i5-3570K Ivy Bridge 3.4GHz, 4GB DDR3 1600, 128GB SSD

Servers tested
==============
###JRuby Servers
* reel
* reel-rack
* thick
* trinidad
* puma

###MRI Servers
* thin
* webrick
* puma

Notes
=====
Camping was mostly used, but webmachine was also tested.

A simple config.ru was needed for some of the servers, it could be as simple as:

        ## config.ru 
        require 'camping'

        require './hello.rb'
        Hello.create if Hello.respond_to? :create
        run Hello

