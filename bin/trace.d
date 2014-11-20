#!/usr/bin/env bash

TABLE=$1

/usr/sbin/dtrace -q -n "
:sequel_schema_sharding::shard_for
/ copyinstr(arg2) == \"${TABLE}\" /
{
  printf(\"%d\n\", arg1)
}
"
