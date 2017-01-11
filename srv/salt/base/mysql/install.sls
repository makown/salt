include:
  - users.mysql
mysql_install:
  file.managed:
    - name: /usr/local/src/mysql-5.6.29.tar.gz
    - source: salt://mysql/files/mysql-5.6.29.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf mysql-5.6.29.tar.gz  && cd mysql-5.6.29 &&  cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DSYSCONFDIR=/etc -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_general_ci -DWITH_EMBEDDED_SERVER=1 -DENABLED_LOCAL_INFILE=1 -DWITH_SAFEMALLOC=OFF && make && make install 
    - unless: test -d  /usr/local/mysql
    - require:
      - file: mysql_install
      - user: mysql
      - file: mysql_else1
      - pkg: mysql_else1
