FROM debian:buster
MAINTAINER cwindom "cwindom@student.21-school.ru"

#add files
COPY ./srcs/autoindex.sh /work_dir/
COPY ./srcs/all_conf.sh /work_dir/
COPY ./srcs/wp-config.php /work_dir/
COPY ./srcs/nginx.conf /work_dir/
COPY ./srcs/start.sh /work_dir/

#instal
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install nginx wget mariadb-server php php-mysql php-fpm php-cli php-mbstring php-zip php-gd

#all conf
RUN bash ./work_dir/all_conf.sh

#index
RUN mv phpMyAdmin-4.9.0.1-all-languages/ var/www/html/phpmyadmin
RUN mkdir /var/www/html/hello-nginx
RUN mv /var/www/html/index.nginx-debian.html /var/www/html/hello-nginx/
RUN mv wordpress /var/www/html
RUN chmod +x ./work_dir/autoindex.sh
CMD bash ./work_dir/start.sh

#sert
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=School21/CN=Cwindom"

EXPOSE 80 443
