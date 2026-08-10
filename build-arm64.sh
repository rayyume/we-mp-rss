#!/bin/bash
set -e

echo "========================================="
echo "开始构建 ARM64 架构的 we-mp-rss 镜像"
echo "========================================="

# 检查是否为 ARM64 架构
ARCH=$(uname -m)
if [ "$ARCH" != "aarch64" ]; then
    echo "错误: 当前架构是 $ARCH，不是 aarch64"
    echo "此脚本只能在 ARM64 服务器上原生构建"
    exit 1
fi

# 步骤 1: 构建 base-mini 镜像
echo ""
echo "步骤 1/3: 构建 base-mini 基础镜像..."
docker build -t local/base-mini:latest \
    -f Dockerfiles/base-mini/Dockerfile \
    Dockerfiles/base-mini/

# 步骤 2: 构建 base-full 镜像
echo ""
echo "步骤 2/3: 构建 base-full 基础镜像..."
docker build -t local/base-full:latest \
    -f Dockerfiles/base-full/Dockerfile \
    Dockerfiles/base-full/

# 步骤 3: 构建主镜像 we-mp-rss
echo ""
echo "步骤 3/3: 构建 we-mp-rss 主镜像..."
docker build -t local/we-mp-rss:latest \
    -f Dockerfile.local \
    .

echo ""
echo "========================================="
echo "构建完成！"
echo "镜像: local/we-mp-rss:latest"
echo "========================================="
