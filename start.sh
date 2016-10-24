#!/bin/sh
set -eu
cp initdb.sqlite3 /var/db.sqlite3
mkdir -p /var/migrations
touch /var/migrations/20161023151458
exec ./continue.sh
