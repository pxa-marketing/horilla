#!/bin/bash

set -e

echo "Running migrations..."
python3 manage.py makemigrations --noinput
python3 manage.py migrate --noinput

echo "Compiling translation files..."
python3 manage.py compilemessages || echo "Warning: Some translation files may not have compiled"

echo "Collecting static files..."
python3 manage.py collectstatic --noinput

echo "Starting server..."
gunicorn --bind 0.0.0.0:8000 horilla.wsgi:application