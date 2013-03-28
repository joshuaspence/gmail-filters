Gmail Filters
=============

Introduction
------------
A collection of Gmail filters that I use. The XML filters to be imported into
Gmail are generated using
[gmail-britta](https://github.com/antifuchs/gmail-britta).

Dependencies
------------
To create the Gmail filters (in XML format), the following packages are
required:
* ruby (>= 1.9.2)
* bundler (>= 1.2.0)
* gmail-britta (>= 0.1.6)

These packages can be installed using the following commands:
```sh
apt-get install ruby
gem install bundler
gem install gmail-britta
```

Instructions
------------
To generate the Gmail filters in XML format, just run `make` or,
more specifically, `make build`. To remove the generated files, run `make
clean`.
