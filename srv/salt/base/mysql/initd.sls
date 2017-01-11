mysql_initd:
  file.managed:
    - name: /etc/init.d/mysql
    - source: salt://mysql/files/mysql
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: mysql_install

  cmd.run:
    - name: chkconfig --add mysql
    - unless: chkconfig --list |grep mysql
    - require:
      - file: mysql_initd
      - cmd: mysql_install





mysql_first:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://mysql/files/my.cnf
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: mysql_initd
      - cmd: mysql_first

  cmd.run:
    - name: chown -R mysql:mysql /data/mysql && /usr/local/mysql/scripts/mysql_install_db --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql --datadir=/data/mysql --user=mysql &&  chgrp -R mysql /usr/local/mysql/.  &&  ln -sf /usr/local/mysql/lib /usr/lib/mysql && ln -sf /usr/local/mysql/include /usr/include/mysql  && ln -sf /usr/local/mysql/bin/mysql /usr/bin/mysql && ln -sf /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump && ln -sf /usr/local/mysql/bin/mysqld_safe /usr/bin/mysqld_safe && ln -sf /usr/local/mysql/bin/mysqlcheck /usr/bin/mysqlcheck  && ln -sf /usr/local/mysql/bin/myisamchk /usr/bin/myisamchk && ldconfig
    - unless: test -d /data/mysql/test
    - require:
      - file: mysql_else1
      - file: mysql_sec

mysql_sec:
  file.managed:
    - name:  /etc/ld.so.conf.d/mysql.conf
    - source: salt://mysql/files/mysql_ldso.conf
    - user: root
    - group: root
    - mode: 644
