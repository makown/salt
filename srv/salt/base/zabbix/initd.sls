zabbix_server_initd:
  file.managed:
    - name: /etc/init.d/zabbix_server
    - source: salt://zabbix/files/zabbix_server
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: zabbix_install

  cmd.run:
    - name: chkconfig --add zabbix_server
    - unless: chkconfig --list |grep zabbix_server
    - require:
      - file: zabbix_server_initd
      - cmd:  zabbix_install


zabbix_agent_initd:
  file.managed:
    - name: /etc/init.d/zabbix_agentd
    - source: salt://zabbix/files/zabbix_agentd
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: zabbix_install

  cmd.run:
    - name: chkconfig --add zabbix_agentd
    - unless: chkconfig --list |grep zabbix_agentd
    - require:
      - file: zabbix_agent_initd
      - cmd:  zabbix_install
