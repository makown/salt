www:
  user.present:
    - fullname: www
    - shell: /sbin/nologin
    - uid: 501
    - gid: 501
    - groups:
      - www
    - require:
      - group: www
  group.present:
    - gid: 501
