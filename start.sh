#!/bin/sh
set -eu
cp db/production.sqlite3 /var/db.sqlite3
mkdir -p /var/migrations
touch /var/migrations/20161031003402
exec ./continue.sh
