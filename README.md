Gmail Filters
=============
A collection of [Gmail][gmail] filters that I use for personal emails. The XML
filters to be imported into [Gmail][gmail] are generated using
[gmail-britta][github].

License
-------
Copyright &copy; 2013 Joshua Spence &lt;<josh@joshuaspence.com>&gt;

This work is free. You can redistribute it and/or modify it under the terms of
the [Do What The Fuck You Want To Public License][wtfpl], Version 2, as
published by [Sam Hocevar](sam@hocevar.net). See the [license file](LICENSE.md)
for more details.

Instructions
------------
To generate the [Gmail][gmail] filters in XML format, just run
`ruby filters.rb`. The filters will be printed to `stdout`. Pipe this output to
a file and import into [Gmail][settings]. Voilà!

Further Information
-------------------
See https://support.google.com/mail/answer/7190?hl=en.

[github]: <https://github.com/antifuchs/gmail-britta>
[gmail]: <https://mail.google.com>
[settings]: <https://mail.google.com/mail/u/0/?shva=1#settings/filters>
[wtfpl]: <http://www.wtfpl.net>
