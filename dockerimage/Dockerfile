FROM ubuntu:20.04
RUN apt-get update && apt-get install -y nginx && apt-get install -y imagemagick
RUN apt update && apt install -y software-properties-common && add-apt-repository ppa:ondrej/php  && apt update && apt-get install -y php8.1-fpm && apt-get install -y php8.1-intl && apt-get install -y php8.1-xml && apt-get install -y php8.1-curl && apt-get install -y php8.1-gd && apt-get install -y php8.1-mbstring && apt-get install -y php8.1-mysql && apt-get install -y php-apcu && apt-get install -y php8.1-zip
RUN apt-get install -y libmysqlclient-dev && apt-get  install -y python3-pip && apt-get update && apt-get install -y mariadb-server-10.3 && apt-get install mariadb-server-core-10.3 
RUN pip install mysqlclient
#RUN service mysql stop
#EXPOSE 3307
RUN service mysql restart
RUN \
  echo "mysqld &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'CREATE DATABASE mediawiki;'" >> /tmp/config && \
  echo "mysql -e \"CREATE USER 'mediawikiuser'@'localhost' IDENTIFIED BY 'mediawikipassword';\"" >> /tmp/config  && \
  echo "mysql -e 'FLUSH PRIVILEGES;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config
RUN rm /etc/nginx/sites-enabled/default
COPY media.conf /etc/nginx/sites-enabled/media.conf 
RUN chown root:root /etc/nginx/sites-enabled/media.conf && chmod 777 /etc/nginx/sites-enabled/media.conf
WORKDIR /new
ADD https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz .
RUN mv /new/mediawiki-1.39.3.tar.gz  /opt/mediawiki.tar.gz 
RUN tar -xzf /opt/mediawiki.tar.gz && mv /new/mediawiki-1.39.3 /var/www/mediawiki
RUN chown -R www-data:www-data /var/www/mediawiki
RUN service nginx restart && service php8.1-fpm stop && service php8.1-fpm start
EXPOSE 443
CMD ["mysqld"]

#CMD ["sleep","300"]
