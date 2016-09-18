ansible-role-httpd
=====================

Configure OpenBSD's [httpd(8)](http://man.openbsd.org/httpd.8).

Requirements
------------

None

Role Variables
--------------

| Variable | Description | Default |
|----------|-------------|---------|
| httpd\_user | the user of httpd | www |
| httpd\_group | the group of httpd | www |
| httpd\_service | the service name of httpd | httpd |
| httpd\_conf\_file | path to [httpd.conf(5)](http://man.openbsd.org/httpd.conf.5) | /etc/httpd.conf |
| httpd\_flags | (unused) | "" |
| httpd\_conf\_chroot | see [httpd.conf(5)](http://man.openbsd.org/httpd.conf.5) | "" |
| httpd\_conf\_default\_type | [httpd.conf(5)](http://man.openbsd.org/httpd.conf.5) | "" |
| httpd\_conf\_logdir | [httpd.conf(5)](http://man.openbsd.org/httpd.conf.5) | "" |
| httpd\_conf\_macro | a string of macro to defined in global section | "" |
| httpd\_conf\_type\_files | | ["/usr/share/misc/mime.types"] |
| httpd\_conf\_domains | see below | [] |
| httpd\_conf\_prefork | number of prefork | 2 |


## httpd\_conf\_domains

httpd\_conf\_domains is a list of a dict.

| key | value |
| name | server name |
| config | a string of the server's config. this string is enclosed by `server $name { }` |

Dependencies
------------

None

Example Playbook
----------------

    - hosts: localhost
      roles:
        - ansible-role-httpd
      vars:
        httpd_conf_macro: |
          interface = "egress"
        httpd_conf_domains:
          - name: default
            config: |
              listen on * port 80
          - name: example.org
            config: |
              listen on $interface port 80

License
-------

Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

Author Information
------------------

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)
