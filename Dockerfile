FROM python:3.8-slim

WORKDIR /usr/src/app

COPY backend/requirements.txt /usr/src/app
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt && rm /usr/src/app/requirements.txt

COPY backend/*.py /usr/src/app/
COPY frontend/public/build/index.html /usr/src/app/static/
COPY frontend/public/build/assets /usr/src/app/static/assets

CMD [ "python", "/usr/src/app/main.py" ]
