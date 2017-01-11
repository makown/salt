nginx_else1:
  file.managed:
    - name: /usr/local/src/pcre-8.39.tar.gz
    - source: salt://nginx/files/pcre-8.39.tar.gz
    - user: root
    - group: root
    - mode: 644
