mysql_else1:
  file.directory:
    - name: /data/mysql
    - user: mysql
    - group: mysql
    - mode: 755
    - makedirs: True
    - require:
      - user: mysql

  pkg.installed:
    - names:
      - cmake
      - ncurses
      - ncurses-devel
