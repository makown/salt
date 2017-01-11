redis_initd:
  file.managed:
    - name: /etc/init.d/redis
    - source: salt://redis/files/redis
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: redis_install

  cmd.run:
    - name: chkconfig --add redis
    - unless: chkconfig --list |grep redis
    - require:
      - file: redis_initd
