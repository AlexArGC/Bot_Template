FROM python:3.10.16-slim

WORKDIR /app

COPY requirements.txt requirements.txt

RUN apt-get update && apt-get install -y --no-install-recommends \
       libqt5websockets5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip setuptools wheel \
    && pip3 install --no-warn-script-location --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -ms /bin/bash appuser
USER appuser

CMD ["python3", "main.py", "-a", "1"]
