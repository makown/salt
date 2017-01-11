/etc/resolv.conf:
  file.managed:
    - source: salt://basic/files/resolv.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      DNS_SERVER1: 192.168.0.1
      DNS_SERVER2: 202.96.134.133
