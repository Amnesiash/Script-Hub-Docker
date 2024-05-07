
# 使用特定版本的Node.js官方镜像
FROM node:19.6.0

# 更新并安装git
RUN apt-get update && apt-get install -y git

# 安装pnpm和pm2
RUN npm install -g pnpm pm2

# 设置工作目录
WORKDIR /app

# 克隆Script-Hub项目，并进入项目目录
RUN git clone https://github.com/Script-Hub-Org/Script-Hub.git
RUN cd /app/Script-Hub
RUN chmod 777 /app/Script-Hub

WORKDIR /app/Script-Hub

RUN cd /app/Script-Hub

RUN pnpm i

# 设置环境变量
ENV HOST=0.0.0.0 \
    PORT=9100 \
    BASE_URL=https://scripthub-lp861i47.b4a.run/

# 暴露端口
EXPOSE 9100 9101

# 使用pm2启动应用
CMD ["pm2-runtime", "start", "pnpm", "--name", "ScriptHub", "--", "service"]
