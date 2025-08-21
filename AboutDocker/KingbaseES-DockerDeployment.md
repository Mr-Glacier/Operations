# Kingbase Docker 安装文档

<img src="https://docs.kingbase.com.cn/cn/img/logo1.png" alt="Kingbase Logo" width="200"/>

官方安装文档：[Kingbase Docker 安装](https://docs.kingbase.com.cn/cn/KES-V9R1C10/install/02-docker-install/)

## Docker 启动 Kingbase 示例

你可以使用以下命令启动 Kingbase 容器：

```bash
docker run -itd \
  --name kingbase \
  --restart always \
  --privileged \
  -e DB_USER=kingbase \
  -e DB_PASSWORD=oaXFweiuquiP0HJZr \
  -e DB_MODE=mysql \
  -e NEED_START=yes \
  -p 54321:54321 \
  -v /zkzd/prod/kingbase/data:/home/kingbase/userdata \
  kingbase_v009r001c010b0004_single_x86:v1 \
  /usr/sbin/init
