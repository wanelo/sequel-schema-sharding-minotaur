#!/usr/bin/env bash

TABLE=$1

/usr/sbin/dtrace -n "

# pragma D option quiet

:sequel_schema_sharding::shard_for
/ copyinstr(arg2) == \"${TABLE}\" /
{
  printf(\"%d\n\", arg1)
}
"
