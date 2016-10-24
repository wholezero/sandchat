#!/bin/sh
set -eu
DATABASE_URL=/var/db.sqlite3 RAILS_ENV=production exec bin/rails s --port 8000 --binding 0.0.0.0
