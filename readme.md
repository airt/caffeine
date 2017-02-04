# caffeine

[![Build Status][build-badge]][build-status]
[![Test Coverage][coverage-badge]][coverage-result]

send http requests periodically

## usage

build from sources

    $ npm run build

run script

    $ bin/caffeine

    $ bin/caffeine --urls-file config/urls.json

    $ bin/caffeine --urls http://example.org,http://localhost:404

or run with monitor

    $ bin/caffeine --listen 9000
    $ open http://localhost:9000

## more

```
$ bin/caffeine --help

  Usage: caffeine [options]

  Options:

    -h, --help                output usage information
    -V, --version             output the version number
    -l, --listen <port>       create server to show logs
    -i, --interval <minutes>  set sending interval
    -u, --urls <url>,<urls>   set urls
    -f, --urls-file <file>    set urls file
    -o, --only-once           send requests only once
    -s, --silent              silent mode

```

the default interval is 10 minutes, customize with `--interval <minutes>`

## license

MIT

[build-badge]: https://img.shields.io/travis/airt/caffeine/master.svg
[build-status]: https://travis-ci.org/airt/caffeine
[coverage-badge]: https://img.shields.io/coveralls/airt/caffeine.svg
[coverage-result]: https://coveralls.io/github/airt/caffeine
