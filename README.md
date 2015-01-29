# certmeister-redis

certmeister-redis is an [Redis](http://redis.io/) store for [Certmeister](https://github.com/sheldonh/certmeister),
the conditionally autosigning Certificate Authority.

# Testing

The tests expect to be run against a redis server instance on port 6379 on the local host.
The instance can be started as follows:

```
redis-server
```
