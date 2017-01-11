include:
  - users.zabbix
zabbix_install:
  file.managed:
    - name: /usr/local/src/zabbix-3.2.2.tar.gz
    - source: salt://zabbix_agent/files/zabbix-3.2.2.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name:  cp /usr/local/mysql/bin/mysql_config /usr/bin/ && cd /usr/local/src/ && tar -xvzf zabbix-3.2.2.tar.gz && cd  zabbix-3.2.2  && ./configure --prefix=/usr/local/zabbix --sysconfdir=/etc/zabbix/  --enable-agent   && make install
    - unless: test -d  /usr/local/zabbix
    - require:
      - file: zabbix_install
      - user: zabbix
      - cmd: zabbix_else
