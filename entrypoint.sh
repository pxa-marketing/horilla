#!/bin/bash

set -e

echo "Running migrations..."
python3 manage.py makemigrations --noinput
python3 manage.py migrate --noinput

echo "Compiling translation files..."
python3 manage.py compilemessages || echo "Warning: Some translation files may not have compiled"

echo "Collecting static files..."
python3 manage.py collectstatic --noinput

echo "Creating default admin user..."
python3 manage.py createhorillauser --first_name Admin --last_name User --username admin --password ylS8-DdBr-ivn-iXwR --email development@pxa.agency --phone 1234567890 || echo "Admin user may already exist, skipping..."

echo "Starting server..."
gunicorn --bind 0.0.0.0:8000 horilla.wsgi:application