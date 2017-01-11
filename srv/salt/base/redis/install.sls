redis_install:
  file.managed:
    - name: /usr/local/src/redis-3.2.5.tar.gz
    - source: salt://redis/files/redis-3.2.5.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name:  cd /usr/local/src && tar -xvzf redis-3.2.5.tar.gz && cd redis-3.2.5 && make PREFIX=/usr/local/redis install && mkdir -p /usr/local/redis/etc
    - unless: test -d  /usr/local/redis
    - require:
      - file: redis_install
