Gmail Filters
=============
A collection of [Gmail][gmail] filters that I use. The XML filters to be
imported into [Gmail][gmail] are generated using [gmail-britta][github].

License
-------
Copyright &copy; 2013 Joshua Spence &lt;<josh@joshuaspence.com>&gt;

This work is free. You can redistribute it and/or modify it under the terms of
the [Do What The Fuck You Want To Public License][wtfpl], Version 2, as
published by [Sam Hocevar](mailto:sam@hocevar.net). See the
[LICENSE.md](LICENSE.md) file for more details.

Dependencies
------------
To create the [Gmail][gmail] filters (in XML format), the following packages are
required:

* `ruby` (>= 1.9.2)
* `bundler` (>= 1.2.0)
* `gmail-britta` (>= 0.1.6)

These packages can be installed using the following commands:

```shell
apt-get install ruby
gem install bundler
gem install gmail-britta
```

Instructions
------------
To generate the [Gmail][gmail] filters in XML format, just run
`ruby filters.rb`.

Further Information
-------------------
See https://support.google.com/mail/answer/7190?hl=en.

[github]: <https://github.com/antifuchs/gmail-britta>
[gmail]: <https://mail.google.com>
[wtfpl]: <http://www.wtfpl.net>
