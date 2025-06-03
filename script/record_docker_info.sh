#!/bin/bash

# 创建日志目录
LOG_DIR="/${pwd}/operations_script/docker_info_log"
mkdir -p "$LOG_DIR"

# 时间戳
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# 日志文件路径
LOG_FILE="$LOG_DIR/docker_info_$TIMESTAMP.log"

# 写入日志
{
  echo "===== Docker 容器信息记录 ====="
  echo "记录时间: $(date)"
  echo

  echo ">>> 当前所有容器（含停止的）:"
  docker ps -a
  echo

  echo ">>> 所有容器详细 inspect 信息:"
  for container_id in $(docker ps -aq); do
    echo "----- 容器 ID: $container_id -----"
    docker inspect "$container_id"
    echo
  done

  echo ">>> 所有容器资源使用情况（docker stats）快照:"
  docker stats --no-stream
  echo

  echo ">>> 当前 Docker 网络配置:"
  docker network ls
  echo

  echo ">>> 当前 Docker 镜像列表:"
  docker images
  echo

  echo "===== 记录结束 ====="
} > "$LOG_FILE"

echo "Docker 信息记录完成，日志保存在: $LOG_FILE"
