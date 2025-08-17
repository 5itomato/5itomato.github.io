---
title: Nginx
description: 'Nginx 学习记录'
publishDate: 2025-02-02 01:38:57
tags: ['nginx', 'learning']
---

## Nginx 介绍
**Nginx** 是一款高性能的开源 Web 服务器，同时支持反向代理、负载均衡、HTTP 缓存等功能。  
- **核心优势**：
  - **高并发处理**：基于事件驱动的异步架构，可轻松支持数万并发连接。
  - **低内存消耗**：高效的内存管理机制。
  - **模块化设计**：通过模块扩展功能（如 HTTP/2、gzip 压缩等）。
- **应用场景**：静态资源托管、反向代理、API 网关、负载均衡。

---

## Web 服务器基础
### 静态资源托管
```nginx
server {
    listen 80;
    server_name example.com;
    root /var/www/html;  # 静态文件根目录
    
    location / {
        index index.html;
    }
}
```

- **关键指令**：
  - `listen`：监听端口。
  - `server_name`：域名。
  - `root`：静态资源存放路径。

### 配置示例

```bash
# 安装 Nginx（Ubuntu）
sudo apt update && sudo apt install nginx

# 启动服务
sudo systemctl start nginx
sudo systemctl enable nginx
```

------

## Location 指令

### 语法规则

```nginx
location [匹配模式] URI {
    # 配置逻辑
}
```

- **匹配模式**：
  - `=`：精确匹配（`location = /api`）。
  - `^~`：前缀匹配（优先级高于正则）。
  - `~`：正则匹配（区分大小写）。
  - `~*`：正则匹配（不区分大小写）。

### 优先级顺序

```
精确匹配（=） → 前缀匹配（^~） → 正则匹配（~或~*） → 通用匹配（/）
```

------

## 反向代理

### 基本配置

将请求转发到后端应用服务器（如 Node.js、Java）：

```nginx
server {
    listen 80;
    server_name api.example.com;
    
    location / {
        proxy_pass http://localhost:3000;  # 后端服务地址
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### 常用指令

- `proxy_pass`：定义后端服务地址。
- `proxy_set_header`：传递客户端请求头。

------

## 负载均衡

### 配置策略

```nginx
http {
    upstream backend {
        server 192.168.1.101:8080 weight=3;  # 权重轮询
        server 192.168.1.102:8080;
        server 192.168.1.103:8080 backup;    # 备用服务器
    }

    server {
        listen 80;
        location / {
            proxy_pass http://backend;
        }
    }
}
```

- **负载均衡算法**：
  - **轮询（默认）**：均匀分配请求。
  - **权重（weight）**：指定服务器优先级。
  - **IP Hash**：根据客户端 IP 分配固定服务器。

------

## 技术概要与配置说明

### 核心技术

- **事件驱动模型**：非阻塞 I/O，高效处理并发。
- **Master/Worker 架构**：Master 管理配置，Worker 处理请求。
- **热重载**：`nginx -s reload` 不中断服务更新配置。

### 常用配置片段

```nginx
# 启用 Gzip 压缩
gzip on;
gzip_types text/plain application/json;

# 日志配置
access_log /var/log/nginx/access.log;
error_log /var/log/nginx/error.log warn;
```

------

## Web 服务器部署实战

### 部署静态网站

- 将 HTML/CSS/JS 文件放入 `/var/www/html`。
- 配置 Nginx Server 块指向该目录。

### 域名解析

- 在 DNS 服务商添加 `A 记录`，将域名指向服务器 IP。

------

## 域名与 HTTPS 证书配置

### 使用 Let's Encrypt 免费证书

```bash
# 安装 Certbot
sudo apt install certbot python3-certbot-nginx

# 自动申请并配置证书
sudo certbot --nginx -d example.com -d www.example.com
```

### 强制 HTTPS 跳转

```nginx
server {
    listen 80;
    server_name example.com;
    return 301 https://$host$request_uri;  # 301 重定向到 HTTPS
}

server {
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    # 其他 HTTPS 配置...
}
```

------

## Docker + Nginx + HTTPS 实战

### Docker 部署 Nginx

```bash
# 拉取镜像
docker pull nginx:alpine

# 运行容器（挂载配置和证书）
docker run -d \
  --name my-nginx \
  -p 80:80 \
  -p 443:443 \
  -v /path/to/nginx.conf:/etc/nginx/nginx.conf \
  -v /path/to/certs:/etc/nginx/certs \
  nginx:alpine
```

### 自定义 Dockerfile

```dockerfile
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY certs/ /etc/nginx/certs/
EXPOSE 80 443
```

### HTTPS 配置整合

```nginx
server {
    listen 443 ssl;
    server_name docker.example.com;

    ssl_certificate /etc/nginx/certs/fullchain.pem;
    ssl_certificate_key /etc/nginx/certs/privkey.pem;

    location / {
        proxy_pass http://app:8080;  # 代理到其他容器
    }
}
```
