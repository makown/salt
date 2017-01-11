ntpd:
  service.running:
  - enable: True
  - reload: True
  - watch:
    - file: ntpd

  file.managed:
  - name: /etc/ntp.conf
  - source: salt://basic/files/ntp.conf

  cmd.run:
    - name: rm -rf /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    - unless:  test -L /etc/localtime
