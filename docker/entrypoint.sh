#!/bin/sh
set -e

mkdir -p database storage/framework/cache storage/framework/sessions storage/framework/views bootstrap/cache

if [ ! -f database/database.sqlite ]; then
    touch database/database.sqlite
fi

chown -R www-data:www-data database storage bootstrap/cache

php artisan migrate --force
php artisan storage:link || true
php artisan config:cache
php artisan route:cache
php artisan view:cache

exec "$@"
