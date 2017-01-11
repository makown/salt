include:
  - http

http_running:
  file.recurse:
    - name: /usr/local/apache/conf
    - source: salt://roles/files/http_conf
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - clean: Ture
    - include_empty: True
    - keep_symlinks: True
    - require:
      - cmd: http_initd
  service.running:
    - name: httpd
    - enable: True
    - require:
      - cmd: http_initd
      - file: http_running
    - watch:
      - file: http_running
