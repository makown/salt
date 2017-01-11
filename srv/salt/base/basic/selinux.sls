/etc/sysconfig/selinux:
  file.managed:
    - source: salt://basic/files/selinux
    - user: root
    - group: root
    - mode: 644
