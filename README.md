
Copied from https://github.com/metaneutrons/docker-simpleproxy 
with the [entrypoint.sh](./entrypoint.sh) modified to support running multiple proxies.

## Build the container
```
docker build -t simpleproxy .
```

## Run multi proxies
```
docker run -d -p 6200:6200 -p 6201:6201 -it simpleproxy '-L 6200 -R 192.168.1.1:6200|-L 6201 -R 192.168.1.1:6201'
```

Use the `|` to separate multiple [simpleproxy](https://www.unix.com/man-page/debian/1/simpleproxy/) commands.