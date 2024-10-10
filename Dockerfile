FROM python:3.11

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y \
  vim-tiny \
  binutils \
  libproj-dev \
  gdal-bin \
  python3-gdal \
  && rm -rf /var/lib/apt/lists/* && pip install pip-tools

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

CMD ["gunicorn", "--reload", "--workers=2", "--worker-tmp-dir", "/dev/shm", "--bind=0.0.0.0:80", "--chdir", "/app/backend", "backend.wsgi"]
