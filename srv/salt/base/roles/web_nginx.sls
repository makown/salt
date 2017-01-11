include:
  - nginx

nginx_running:
  file.recurse:
    - source:  salt://roles/files/nginx_conf
    - name: /usr/local/nginx/conf
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - clean: Ture
    - include_empty: True

  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - cmd: nginx_initd
      - file: nginx_running
    - watch:
      - file: nginx_running
