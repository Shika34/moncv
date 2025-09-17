#Définir l'os
FROM debian:bullseye-slim
#installation du serveur apache2
RUN apt-get update && apt-get install -y apache2 && rm -rf /var/lib/lists/*
RUN mkdir /var/www/moncv/
COPY ./site /var/www/moncv/
#Définir les permissions
RUN chown -R www-data:www-data /var/www/moncv
COPY ./moncv.conf /etc/apache2/sites-available/moncv.conf
COPY ./apache2.conf /etc/apache2/apache2.conf
RUN a2dissite 000-default.conf && a2ensite moncv.conf && a2enmod rewrite
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"] 
