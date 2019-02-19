FROM python:3.6-stretch

RUN apt update && apt install -y firefox-esr && \
    wget -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz && \
    tar -xvzf /tmp/geckodriver.tar.gz  -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    mkdir /app

COPY . /app

WORKDIR /app

RUN  pip install --upgrade pip && \
     pip install pipenv && \
     pipenv install --system


ENTRYPOINT ["gunicorn", "--config", "/app/gunicorn_config.py", "egscraper:app"]
