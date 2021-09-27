FROM ubuntu:latest
WORKDIR /myapp
COPY requirements.txt .

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Prague

RUN apt-get update && apt-get -y upgrade && apt-get -y install python3 python3-pip nginx
RUN pip3 install -r requirements.txt
RUN pip3 install gunicorn
RUN apt-get clean

COPY * /myapp/

#use daemon off directive:
RUN mv /myapp/nginx.conf /etc/nginx/nginx.conf
RUN mv /myapp/app.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf
RUN rm /etc/nginx/sites-enabled/default

RUN ln -s /myapp /usr/local/lib/python3.8/dist-packages/myapp

#RUN sed -e 's|/var/www|/app|' </etc/apache2/apache2.conf > /etc/apache2/apache2.conf
#RUN sed -e 's|/var/www/html|/app|' </etc/apache2/sites-enabled/000-default.conf > /etc/apache2/sites-enabled/000-default.conf

#RUN gunicorn --bind 0.0.0.0:80 --chdir /myapp/wsgi:application
#RUN gunicorn --bind 0.0.0.0:80 /myapp/wsgi:application

#CMD ["RUN gunicorn --bind 0.0.0.0:80 wsgi:application"]
CMD ["gunicorn", "--bind", "0.0.0.0:80", "wsgi:application"]
#CMD ["nginx"]
#CMD ["bash"]
EXPOSE 80
