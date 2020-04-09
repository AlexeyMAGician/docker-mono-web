FROM mono:latest

LABEL maintainer="Alexey MAGician <alexey@spaty.ru>"

RUN apt-get update -qq \
  && apt-get install -y \
      iproute2 supervisor ca-certificates-mono fsharp mono-vbnc nuget \
      referenceassemblies-pcl mono-fastcgi-server4 nginx nginx-extras \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && echo "daemon off;" | cat - /etc/nginx/nginx.conf > temp && mv temp /etc/nginx/nginx.conf \
  && sed -i -e 's/www-data/root/g' /etc/nginx/nginx.conf

COPY nginx/ /etc/nginx/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
 
EXPOSE 80

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]
