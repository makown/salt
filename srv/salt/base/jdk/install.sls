jdk_install:
  file.managed:
    - name: /usr/local/src/jdk-8u91-linux-x64.rpm
    - source: salt://jdk/files/jdk-8u91-linux-x64.rpm
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && rpm -ivh jdk-8u91-linux-x64.rpm
    - unless: test -d /usr/java/jdk1.8.0_91
    - require:
      - file: jdk_install

jdk_sh:
  file.managed:
    - name: /etc/profile.d/jdk.sh
    - source: salt://jdk/files/jdk.sh
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: jdk_install 
