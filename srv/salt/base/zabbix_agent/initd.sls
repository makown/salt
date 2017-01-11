zabbix_agent_initd:
  file.managed:
    - name: /etc/init.d/zabbix_agentd
    - source: salt://zabbix_agent/files/zabbix_agentd
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
