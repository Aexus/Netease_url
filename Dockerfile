FROM python:3.9.22-alpine3.21

WORKDIR /app

# 安装构建依赖
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev \
    musl-dev \
    tzdata \
    bash

# 安装 Python 依赖
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# 拷贝项目代码
COPY . .

# 设置脚本权限
RUN chmod +x /app/entrypoint.sh

# 设置时区
ENV TZ=Asia/Shanghai

EXPOSE 5000

# 启动脚本（确保是 sh 脚本）
CMD ["/app/entrypoint.sh"]
