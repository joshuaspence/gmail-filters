Gmail Filters
=============
A collection of [Gmail][gmail] filters that I use for personal emails. The XML
filters to be imported into [Gmail][gmail] are generated using
[gmail-britta][github].

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
