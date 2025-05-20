FROM debian:bullseye

RUN apt update -y && \
	apt install -y \
	nginx openssl

# -p will create parent folders if they do not exist
RUN mkdir -p /etc/nginx/ssl
# -x509 option tells openssl to create a self-signed certificate instead of a certificate signing request
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/selfsigned.key \
    -out /etc/nginx/ssl/selfsigned.crt \
    -subj "/C=DE/ST=BW/L=Heilbronn/O=42/OU=student/CN=$DOMAIN_NAME"

COPY default /etc/nginx/sites-available/.

CMD ["nginx", "-g", "daemon off;"]
