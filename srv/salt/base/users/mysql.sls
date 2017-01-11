mysql:
  user.present:
    - fullname: mysql
    - shell: /sbin/nologin
    - uid: 502
    - gid: 502
    - groups:
      - mysql
    - require:
      - group: mysql
  group.present:
    - gid: 502
