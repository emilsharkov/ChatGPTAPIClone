FROM python:3.11-slim-bookworm

WORKDIR /usr/src/app

COPY /app .

RUN apt-get update
RUN apt-get install -y python3-dev gcc-11 g++-11 build-essential
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python","api.py"]