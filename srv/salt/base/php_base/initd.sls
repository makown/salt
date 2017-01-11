php_fpm:
  file.managed:
    - name: /usr/local/php/etc/php-fpm.conf
    - source: salt://php_base/files/php-fpm.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php_install

  cmd.run:
    - name: ln -sf /usr/local/php/bin/php /usr/bin/php  && ln -sf /usr/local/php/bin/phpize /usr/bin/phpize && ln -sf /usr/local/php/bin/pear /usr/bin/pear && ln -sf /usr/local/php/bin/pecl /usr/bin/pecl
    - unless: test -f /usr/bin/pecl
    - require:
      - cmd: php_install

fpm_initd:
  file.managed:
    - name: /etc/init.d/php-fpm
    - source: salt://php_base/files/init.d.php-fpm5.2
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: php_install

  service.running:
    - name: php-fpm
    - enable: True
    - require:
      - cmd: php_fpm
      - file: fpm_initd
