sshd:
  service.running:
  - enable: True
  - watch:
    - file: sshd
  file.managed:
  - name: /etc/ssh/sshd_config
  - source: salt://basic/files/sshd_config
