# 🏗️ 第一阶段：构建依赖
FROM python:3.9.22-alpine3.21 AS builder

WORKDIR /app

RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    python3-dev \
    musl-dev

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

# 🏃 第二阶段：运行环境
FROM python:3.9.22-alpine3.21

WORKDIR /app

# 安装运行时依赖（不含编译工具）
RUN apk add --no-cache \
    libffi \
    openssl \
    tzdata \
    bash

# 拷贝构建好的依赖和项目代码
COPY --from=builder /install /usr/local
COPY . .

RUN chmod +x /app/entrypoint.sh

ENV TZ=Asia/Shanghai

EXPOSE 5000

CMD ["/app/entrypoint.sh"]
