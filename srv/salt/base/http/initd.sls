http_initd:
  file.managed:
    - name: /etc/init.d/httpd
    - source: salt://http/files/init.d.httpd
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: http_install

  cmd.run:
    - name: chkconfig --add httpd
    - unless: chkconfig --list |grep httpd
    - require:
      - file: http_initd
