Run a IB(interactivebrokers) gateway or TWS in Docker container

Use ib-controller project, https://github.com/ib-controller/ib-controller

A sample docker-compose.yml
``` docker-compose
ibgw:
  image: zhuzhu/ib-docker
  environment:
    - "VNC_PASSWORD=password"
  ports:
    - "5900:5900"   # VNC port
    - "4003:4003"   # IB Gateway Port
```
