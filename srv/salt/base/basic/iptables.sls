iptables:
  file.managed:
    - name: /etc/sysconfig/iptables
    - source: salt://basic/files/iptables
    - user: root
    - group: root
    - mode: 644
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: iptables
