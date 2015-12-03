
# caffeine.node
send http request to given urls periodically

### usage

    # add `url` to `urls.json` firstly

    $ node index.js

or

    $ PORT=9000 node index.js -b [--view] [--test]

then open `http://localhost:9000`

### more

Timeout default is 10 to 20 minutes.
`Math.round(1000 * 600 * (Math.random() + 1))`

### License
This project is under MIT License. See LICENSE file for more information.
