# Hangfire HTTP Server

一个基于 Hangfire 的 HTTP 任务调度服务器，提供 Web UI 界面管理定时任务和后台作业。

## 功能特性

- 基于 Web UI 的任务管理界面
- HTTP 任务调度支持
- PostgreSQL 持久化存储
- 多语言支持
- 控制台输出支持
- 任务标签管理
- 心跳监控
- 基本认证保护
- 只读面板支持

## 技术栈

- .NET 9.0
- Hangfire.Core 1.8.12
- Hangfire.HttpJob 3.8.5
- Hangfire.PostgreSql 1.20.10
- NLog.Web.AspNetCore 5.4.0

## 配置说明

### 环境变量配置

支持通过环境变量配置以下参数：

- `HangfirePostgreConnectionString`: PostgreSQL 连接字符串
- `Lang`: 界面语言设置 (例如: "zh-CN", "en-US")
- `HangfireQueues`: 任务队列名称，多个用逗号分隔
- `ServerName`: 服务器名称
- `WorkerCount`: 工作线程数

### 配置文件

主要配置文件：
- `appsettings.json`
- `hangfire/hangfire_global.json`

## 部署说明

### Docker 部署

1. 构建镜像
```bash
docker build -t hangfire-http-server .
```

2. 运行容器
```bash
docker run -d \
  -p 5000:5000 \
  -e HangfirePostgreConnectionString="Host=postgres;Port=5432;Database=hangfire;Username=user;Password=pass" \
  -e Lang="zh-CN" \
  --name hangfire-server \
  hangfire-http-server
```

### 本地开发

1. 安装依赖
```bash
dotnet restore
```

2. 运行项目
```bash
dotnet run
```

默认访问地址：http://localhost:5180

## 主要特性说明

1. **任务调度**
   - 支持 HTTP 任务的创建和调度
   - 可视化的任务执行状态监控
   - 任务重试和错误处理

2. **安全性**
   - 支持基本认证保护 Dashboard
   - 可配置只读面板
   - SSL 支持

3. **监控和日志**
   - 集成 NLog 日志系统
   - 任务执行控制台输出
   - 心跳监控

4. **扩展性**
   - 支持自定义任务队列
   - 可配置工作线程数
   - 支持多语言界面

## 许可证

[MIT License](LICENSE)
