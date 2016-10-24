#!/bin/sh
set -eu

bundle install --path .bundle
rm -rf public/assets
RAILS_ENV=production bin/rails assets:precompile
