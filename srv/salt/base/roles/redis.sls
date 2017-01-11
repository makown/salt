include:
  - redis

redis_running:
  file.recurse:
    - name: /usr/local/redis/etc
    - source: salt://roles/files/redis_etc
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - clean: Ture
    - include_enpty: True
  service.running:
    - name: redis
    - enable: True
    - require:
      - cmd: redis_initd
      - file: redis_running
    - watch:
      - file: redis_running
