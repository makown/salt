http:
  {% if grains['id'] == 'TB1' %}
   port: 8101
  {% elif grains['id'] == 'TB3' %}
    port: 8103
   {% endif %}
