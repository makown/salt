include:
  - rsync

rsync_running:
  file.managed:
    - name: /etc/rsyncd.conf
    - source: salt://roles/files/rsync_conf/rsyncd.conf
    - user: root
    - group: root
    - mode: 600
  service.running:
    - name: rsync
    - enable: True
    - require:
      - file: rsync_running
      - file: rsync_password
      - pkg: rsync_install
    - watch:
      - file: rsync_running

rsync_password:
  file.managed:
    - name: /etc/rsync.password
    - source: salt://roles/files/rsync_conf/rsync.password
    - user: root
    - group: root
    - mode: 600
