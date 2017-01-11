include:
  - users.www
nginx_install:
  file.managed:
    - name: /usr/local/src/nginx-1.10.2.tar.gz
    - source: salt://nginx/files/nginx-1.10.2.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf pcre-8.39.tar.gz  && tar -xvzf nginx-1.10.2.tar.gz && cd nginx-1.10.2 && ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module  --with-http_gzip_static_module --with-ipv6 --with-http_sub_module --with-http_realip_module  --with-http_addition_module  --with-pcre=/usr/local/src/pcre-8.39 && make && make install &&  mkdir -p /usr/local/nginx/conf/vhost
    - unless: test -d  /usr/local/nginx
    - require:
      - file: nginx_install
      - file: nginx_else1
      - user: www
