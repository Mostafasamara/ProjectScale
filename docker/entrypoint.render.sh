@'
#!/usr/bin/env bash
set -e

python manage.py collectstatic --noinput || true
python manage.py migrate --noinput

# Render provides $PORT; default to 8000 if not set
exec gunicorn config.wsgi:application --bind 0.0.0.0:${PORT:-8000} --workers 3 --timeout 60
'@ | Out-File -Encoding ascii docker/entrypoint.render.sh
