#!/bin/sh
echo "⏳ Waiting for frontend (frontend:5173)..."
while ! nc -z frontend 5173; do
  sleep 1
done
echo "✅ Frontend is up — starting NGINX..."
exec nginx -g 'daemon off;'
