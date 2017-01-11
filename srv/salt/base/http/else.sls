http_else1:
  file.managed:
    - name: /usr/local/src/apr-1.5.2.tar.gz
    - source: salt://http/files/apr-1.5.2.tar.gz
    - user: root
    - group: root
    - mode: 644

http_else2:
  file.managed:
    - name: /usr/local/src/apr-util-1.5.4.tar.gz
    - source: salt://http/files/apr-util-1.5.4.tar.gz
    - user: root
    - group: root
    - mode: 644

http_else3:
  file.directory:
    - name: /data/web/default
    - user: www
    - group: www
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: www
http_else4:
  file.directory:
    - name: /data/logs
    - user: www
    - group: www
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: www
