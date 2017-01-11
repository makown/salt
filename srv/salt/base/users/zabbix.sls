zabbix:
  user.present:
    - fullname: zabbix
    - shell: /sbin/nologin
    - uid: 201
    - gid: 201
    - groups:
      - zabbix
    - require:
      - group: zabbix
  group.present:
    - gid: 201
