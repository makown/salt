include:
  - users.www
http_install:
  file.managed:
    - name: /usr/local/src/httpd-2.4.20.tar.gz
    - source: salt://http/files/httpd-2.4.20.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: yum -y install gcc autoconf  automake make pcre pcre-devel openssl openssl-devel && cd /usr/local/src && tar -xvzf httpd-2.4.20.tar.gz && cp apr-1.5.2.tar.gz httpd-2.4.20/srclib  &&  cp  apr-util-1.5.4.tar.gz  httpd-2.4.20/srclib && cd httpd-2.4.20/srclib && tar -xvzf apr-1.5.2.tar.gz && mv apr-1.5.2 apr && tar -xvzf apr-util-1.5.4.tar.gz && mv apr-util-1.5.4 apr-util && cd .. &&  ./configure --prefix=/usr/local/apache --enable-mods-shared=most --enable-headers --enable-mime-magic --enable-proxy --enable-so --enable-rewrite --with-ssl --enable-ssl --enable-deflate --with-pcre --with-included-apr --with-apr-util --enable-mpms-shared=all --with-mpm=prefork --enable-remoteip && make && make install
    - unless: test -d  /usr/local/apache
    - require:
      - file: http_install
      - file: http_else1
      - file: http_else2
      - file: http_else3
      - file: http_else4
