---
layout: archive
title: "Talks"
permalink: /talks/
author_profile: true
---

{% for post in site.talks reversed %}
  {% include archive-single.html %}
{% endfor %}
