include:
  - zabbix

zabbix_server_running:
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

  service.running:
    - name: zabbix_server
    - enable: True
    - require:
      - cmd:  zabbix_server_initd
      - file: zabbix_server_running
    - watch:
      - file: zabbix_server_running
