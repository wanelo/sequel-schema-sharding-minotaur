sequel-schema-sharding-minotaur
===============================

This is a monitoring service for Ruby micro-services that shard data using
the `sequel-schema-sharding` plugin to `sequel`. It uses dTrace to collect
information from the service, stores the data temporarily in Redis, and
regularly pushes the aggregated data to Circonus.

## Dependencies

* ruby
* dtrace

## Setup

* Create an HTTPTrap in Circonus, and record its URL

## Usage

On every host running the microservice, run a monitor service.

```bash
bundle exec bin/monitor --redis redis://1.1.1.1/12
```

On another host, run a reporter. There should only be one reporter process running
for the entire microservice.

```bash
bundle exec bin/reporter --redis redis://1.1.1.1/12 --circonus http://circonus/trap/url
```
