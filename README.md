# Docker-HBase

## What is this?

This is a repository to provide HBase with docker image.
Both HBase and Hadoop run in Pseudo-Distributed mode.

Note that this is for test or educational usage since using Pseudo-Distributed mode.

## Getting started.

### Run HBase container

1. `docker pull nikutto/hbase:2.5.5`
2. `docker run nikutto/hbase:2.5.5`
  - You'll see HRegionServer as an output of jps command.
3. Open different terminal. `docker exec -it <CONTAINER ID of hbase image> bash`
4. `hbase shell`
5. Type any commands you'd like to test!
  - `create 'test', 'cf'`
  - `put 'test', 'row1', 'cf:a', 'value1'`
  - `scan 'test'`

### Build HBase image

1. `docker build .`
