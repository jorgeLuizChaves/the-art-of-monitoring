## Alternatives to Collectd

### Commercial Tools
New Relic — Commercial Application Performance Management tool. It also includes some support for host, service, and availability monitoring.
Circonus — Commercial Software-as-a-Service (SaaS) monitoring solution.
DataDog — A SaaS console and collection center for monitoring and metrics data.
Librato — A SaaS console and collection center, primarily focused on metrics data.

### Open Source
Square's Cube and Cubism — Cube allows the collection of time-series events and Cubism is a D3-based visualization tool for those collected metrics.
Ganglia — A monitoring tool with a focus on clusters and grids.
Munin — A popular metric and monitoring tool that uses RRDTool.
StatsD — A network daemon that listens for statistics sent over the network and sends aggregates to one or more pluggable back-end services, including Graphite. We'll see more of StatsD in Chapter 9 of the book.
Diamond — An open-source metrics collector originally written by Brightcove but now maintained by a wider community.
Fullerite — An open-source metrics collector written by the Yelp Engineering team. It's written in Go and designed for large scale metrics collection.
PCP and Vector — Used by Netflix this combination provides high resolution on host performance metrics suitable for diagnostics.
sumd — A lightweight Python collector that allows you to run processes, for example Nagios plugins, locally and send the results to Riemann.
fluentd
ELK - beats family