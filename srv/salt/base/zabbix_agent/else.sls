zabbix_else:
  file.managed:
    - name: /usr/local/src/iksemel-1.4.tar.gz
    - source: salt://zabbix_agent/files/iksemel-1.4.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf iksemel-1.4.tar.gz && cd iksemel-1.4 && ./configure && make && make install && yum install net-snmp*  curl curl-devel -y
    - unless: test -f /usr/local/bin/iksperf
    - require:
      - file: zabbix_else
