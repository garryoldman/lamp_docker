>ARG APACHE_VERSION=""
FROM httpd:${APACHE_VERSION:+${APACHE_VERSION}-}alpine

RUN apk update; \
    apk upgrade;
    
COPY apache.conf /usr/local/apache2/conf/pizza.apache.conf
RUN echo "Include /usr/local/apache2/conf/pizza.apache.conf" \
    >> /usr/local/apache2/conf/httpd.conf
