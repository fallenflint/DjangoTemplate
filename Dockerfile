FROM python:3.12-slim

WORKDIR /app

RUN apt-get update \
  && apt-get install -y build-essential curl libpq-dev --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home python \
  && mkdir -p /public_collected public \
  && chown python:python -R /public_collected /app

USER python

COPY --chown=python:python requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH="." \
    PYTHONUNBUFFERED=1 \
    PATH="${PATH}:/home/python/.local/bin" \
    USER="python"

COPY --chown=python:python . .

RUN python3 manage.py collectstatic --no-input

EXPOSE 8000

CMD ["gunicorn","-b", "0.0.0.0:8000", "-w", "4", "-k", "gevent", "--worker-tmp-dir", "/dev/shm", "app:app"]
