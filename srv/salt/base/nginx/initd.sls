nginx_initd:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/files/nginx
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: nginx_install

  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig --list |grep nginx
    - require:
      - file: nginx_initd
      - cmd: nginx_install
