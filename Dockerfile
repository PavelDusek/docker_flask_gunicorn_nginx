FROM ubuntu:latest
WORKDIR /app
COPY requirements.txt .

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Prague

RUN apt-get update && apt-get -y upgrade && apt-get -y install python3 python3-pip nginx
RUN pip3 install -r requirements.txt
RUN pip3 install gunicorn
RUN apt-get clean

COPY * /app/

#use daemon off directive:
RUN mv /app/nginx.conf /etc/nginx/nginx.conf
RUN mv /app/app.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf
RUN rm /etc/nginx/sites-enabled/default

RUN ln -s /app /usr/local/lib/python3.8/dist-packages/app

#RUN sed -e 's|/var/www|/app|' </etc/apache2/apache2.conf > /etc/apache2/apache2.conf
#RUN sed -e 's|/var/www/html|/app|' </etc/apache2/sites-enabled/000-default.conf > /etc/apache2/sites-enabled/000-default.conf

CMD ["nginx"]
EXPOSE 80
