# dnmp
基于Docker搭建nginx、php等web开发环境

## requirement
- docker
- docker-compose

## 启动
```shell
sudo docker-compose -f /path/to/dnmp/docker-compose.yml up -d
```

如果变更了 `Dockfile` 或者 `docker-compose.yml` 相关的内容，则需要加 `--build`
```shell
sudo docker-compose -f /path/to/dnmp/docker-compose.yml up --build -d
```

## 关闭
```shell
sudo docker-compose -f /path/to/dnmp/docker-compose.yml stop
```

## 查看日志
```shell
sudo docker-compose logs -f --tail 10 service_name
```
如：
```shell
sudo docker-compose logs -f --tail 10 nginx
```

