include:
  - zabbix_agent

zabbix_agent_running:
  file.recurse:
    - source:  salt://roles/files/zabbix_conf
    - name: /etc/zabbix
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - clean: Ture
    - include_enpty: True
    - template: jinja
    - defaults:
      hostname: {{ grains['ip_interfaces']['eth0'][0] }}
      server: 10.169.111.171
  service.running:
    - name: zabbix_agentd
    - enable: True
    - require:
      - cmd:  zabbix_agent_initd
      - file: zabbix_agent_running
    - watch:
      - file: zabbix_agent_running
