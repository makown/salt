rsync_initd:
  file.managed:
    - name: /etc/init.d/rsync
    - source: salt://rsync/files/rsync
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: rsync_install

  cmd.run:
    - name: chkconfig --add rsync
    - unless: chkconfig --list |grep rsync
    - require:
      - file: rsync_initd
      - pkg:  rsync_install
