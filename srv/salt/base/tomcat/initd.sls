tomcat_initd:
  file.managed:
    - name: /etc/init.d/tomcat80
    - source: salt://tomcat/files/init.tomcat80
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: tomcat_install
  cmd.run:
    - name: chkconfig --add tomcat80
    - unless: chkconfig --list | grep tomcat80
    - require:
      - file:  tomcat_initd
