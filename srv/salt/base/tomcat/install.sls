include:
  - jdk

tomcat_install:
  file.managed:
    - name: /usr/local/src/apache-tomcat-8.0.23.tar.gz
    - source: salt://tomcat/files/apache-tomcat-8.0.23.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar -xzf apache-tomcat-8.0.23.tar.gz   && mkdir -p /usr/local/tomcat/ &&  mv /usr/local/src/apache-tomcat-8.0.23 /usr/local/tomcat/80
    - unless: test -d /usr/local/tomcat/80
    - require:
      - file: tomcat_install
      - file: jdk_sh
