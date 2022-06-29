FROM python:3.8-slim

WORKDIR /usr/src/app

COPY backend/requirements.txt /usr/src/app
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt && rm /usr/src/app/requirements.txt

COPY backend/*.py /usr/src/app/
COPY frontend/public /usr/src/app/static/

CMD [ "python", "/usr/src/app/main.py" ]
