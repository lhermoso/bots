# syntax=docker/dockerfile:1
FROM debian:buster
LABEL authors="leonardo"
RUN apt-get update && apt install -y git python3 python3-pip cron

WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN crontab -l | { cat; echo "*/30 * * * * python /app/manage.py run_vol_opt"; } | crontab -
COPY . .
#RUN pip install forexconnect
CMD cron
CMD [ "python3", "manage.py" , "run_vol"]