#wordpress

wget https://wordpress.org/latest.tar.gz
tar xvf latest.tar.gz
rm -rf latest.tar.gz
mv ./work_dir/wp-config.php wordpress

#nginx

rm -rf /etc/nginx/sites-enabled/default
cp ./work_dir/nginx.conf /etc/nginx/sites-enabled/localhost

#phpmyadmin

wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz

# start mysql

service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "GRANT ALL ON *.* TO 'user'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
