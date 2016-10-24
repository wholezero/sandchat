#!/bin/sh
set -eu
cp initdb.sqlite3 /var/db.sqlite3
exec ./continue.sh
