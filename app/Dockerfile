FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . .

# Postgresql
RUN ./scripts/psql.sh

EXPOSE 5000

CMD ["/bin/bash", "./scripts/migrate_execute.sh"]