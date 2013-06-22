##Echo server for API testing.

GET /{status_code}/{response_string}

* /200/abc
* /302/http://www.example.com
* /400/bad
* /500/error

POST /{status_code}/{anything}

{'a': 1}

PUT /{status_code}/{anything}

{'a': 1}

DELETE /{status_code}/{anything}

{'a': 1}
