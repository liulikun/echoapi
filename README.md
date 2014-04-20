## Echo server for API testing. (http://echoapi.herokuapp.com/)

It bounces back the request headers (for JSON response) and request params/data.

GET http://echoapi.herokuapp.com/{status_code}/{anything}?param1=value1&param2=value2

* http://echoapi.herokuapp.com/200/abc?a=1&b=2
* http://echoapi.herokuapp.com/200/abc?callback=xyz    (JSONP support)
* http://echoapi.herokuapp.com/302/http://www.example.com
* http://echoapi.herokuapp.com/400/bad
* http://echoapi.herokuapp.com/500/error


POST http://echoapi.herokuapp.com/{status_code}/{anything}

```
curl -v http://echoapi.herokuapp.com/200/ok -d '{"x":1}' -X POST -H "Content-Type: application/json"
```

PUT http://echoapi.herokuapp.com/{status_code}/{anything}

```
curl -v http://echoapi.herokuapp.com/200/ok -d '{"x":1}' -X PUT -H "Content-Type: application/json"
```

DELETE http://echoapi.herokuapp.com/{status_code}/{anything}

```
curl -v http://echoapi.herokuapp.com/200/ok -d '{"x":1}' -X DELETE -H "Content-Type: application/json"
```


### To simulate slow response, add 'sleep' param:

http://echoapi.herokuapp.com/200/ok?sleep=10
