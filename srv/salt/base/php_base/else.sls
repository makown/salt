php_base_else1:
  cmd.run:
    - name:  yum install  make cmake gcc gcc-c++ gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel patch wget libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel unzip tar bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel libcurl libcurl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap diffutils ca-certificates net-tools libc-client-devel psmisc libXpm-devel git-core c-ares-devel libicu-devel libxslt libxslt-devel  -y
    - unless: test -d /usr/local/php

autoconf:
  file.managed:
    - name: /usr/local/src/autoconf-2.13.tar.gz
    - source: salt://php_base/files/autoconf-2.13.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php_base_else1

  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf autoconf-2.13.tar.gz && cd  autoconf-2.13 && ./configure --prefix=/usr/local/autoconf-2.13 && make && make install
    - unless: test -d  /usr/local/autoconf-2.13
    - require:
      - file: autoconf
      - cmd: php_base_else1


libiconv:
  file.managed:
    - name: /usr/local/src/libiconv-1.14.tar.gz
    - source: salt://php_base/files/libiconv-1.14.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: autoconf

  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf libiconv-1.14.tar.gz && cd  libiconv-1.14  && ./configure --enable-static && make && make install
    - unless: test -f  /usr/local/lib/libiconv.so
    - require:
      - file: libiconv
      - cmd: autoconf

libmcrypt:
  file.managed:
    - name: /usr/local/src/libmcrypt-2.5.8.tar.gz
    - source: salt://php_base/files/libmcrypt-2.5.8.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: libiconv
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf libmcrypt-2.5.8.tar.gz && cd  libmcrypt-2.5.8  && ./configure  && make && make install &&  /sbin/ldconfig && cd libltdl/ && ./configure --enable-ltdl-install && make && make install && ln -sf /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la && ln -sf /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so && ln -sf /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4 && ln -sf /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8 && ldconfig
    - unless:  test -f /usr/local/lib/libltdl.a
    - require:
      - file: libmcrypt
      - cmd: libiconv

mhash:
  file.managed:
    - name: /usr/local/src/mhash-0.9.9.9.tar.gz
    - source: salt://php_base/files/mhash-0.9.9.9.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: libmcrypt
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf mhash-0.9.9.9.tar.gz && cd  mhash-0.9.9.9  && ./configure  && make && make install && ln -sf /usr/local/lib/libmhash.a /usr/lib/libmhash.a && ln -sf /usr/local/lib/libmhash.la /usr/lib/libmhash.la && ln -sf /usr/local/lib/libmhash.so /usr/lib/libmhash.so && ln -sf /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2 && ln -sf /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1 && ldconfig
    - unless:  test -f /usr/local/lib/libmhash.a
    - require:
      - file: mhash
      - cmd: libmcrypt

mcrypt:
  file.managed:
    - name: /usr/local/src/mcrypt-2.6.8.tar.gz
    - source: salt://php_base/files/mcrypt-2.6.8.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: mhash
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf mcrypt-2.6.8.tar.gz && cd  mcrypt-2.6.8  && ./configure  && make && make install 
    - unless: test -f /usr/local/bin/mcrypt
    - require:
      - file: mhash
      - cmd: libmcrypt

freetype:
  file.managed:
    - name: /usr/local/src/freetype-2.4.12.tar.gz
    - source: salt://php_base/files/freetype-2.4.12.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: mcrypt
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf freetype-2.4.12.tar.gz && cd  freetype-2.4.12  &&  ./configure --prefix=/usr/local/freetype && make && make install && ln -sf /usr/local/freetype/include/freetype2 /usr/local/include && ln -sf /usr/local/freetype/include/ft2build.h /usr/local/include
    - unless: test -d  /usr/local/freetype
    - require:
      - file: freetype
      - cmd: mcrypt
freetype_lib:
  file.managed:
    - name: /etc/ld.so.conf.d/freetype.conf
    - source: salt://php_base/files/freetype.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: freetype
  cmd.run:
    - name: ldconfig
    - unless: ldconfig -v  |grep libfreetype
    - require:
      - file: freetype_lib

curl:
  file.managed:
    - name: /usr/local/src/curl-7.47.1.tar.gz
    - source: salt://php_base/files/curl-7.47.1.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: freetype_lib
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf curl-7.47.1.tar.gz && cd  curl-7.47.1 &&  ./configure --prefix=/usr/local/curl --enable-ares --without-nss --with-ssl  && make && make install
    - unless: test -d  /usr/local/curl
    - require:
      - file: curl
      - cmd: freetype_lib

pcre:
  file.managed:
    - name: /usr/local/src/pcre-8.36.tar.gz
    - source: salt://php_base/files/pcre-8.36.tar.gz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: curl
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf pcre-8.36.tar.gz && cd  pcre-8.36  &&  ./configure  && make && make install
    - unless: test -d  /usr/local/curl
    - require:
      - file: pcre
      - cmd: curl

icu4c:
  file.managed:
    - name: /usr/local/src/icu4c-55_1-src.tgz
    - source: salt://php_base/files/icu4c-55_1-src.tgz
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: pcre
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf icu4c-55_1-src.tgz && cd icu/source/  &&  ./configure --prefix=/usr  && make && make install
    - unless: test -d  /usr/local/curl
    - require:
      - file: icu4c
      - cmd:  pcre
