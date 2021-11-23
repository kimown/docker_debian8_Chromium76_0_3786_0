# docker_debian8_Chromium76_0_3786_0
```
docker build -t docker_debian8_chromium76_0_3786_0:latest .
docker run -it docker_debian8_chromium76_0_3786_0 /bin/bash
```



```
#https://groups.google.com/a/chromium.org/g/chromium-dev/c/x3WR7Ll1r2M/m/E3J0fjmeBwAJ
gn gen out/Debug --args="is_debug=true symbol_level=2 enable_nacl=false"

```
