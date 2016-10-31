#!/bin/sh
set -eu

export SECRET_KEY_BASE=$(base64 /dev/urandom | head -c 30)
export DATABASE_URL=/var/db.sqlite3
export RAILS_ENV=production
export RAILS_SERVE_STATIC_FILES=yes
export RAILS_LOG_TO_STDOUT=yes

LATEST_MIGRATION=20161031003402
if [ ! -f /var/migrations/$LATEST_MIGRATION ]; then
  bin/rails db:migrate
  mkdir -p /var/migrations
  touch /var/migrations/$LATEST_MIGRATION
fi

exec bin/rails s --port 8000 --binding 0.0.0.0
