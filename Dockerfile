# 使用 Node.js 20.10.0 Alpine 作为基础镜像
FROM node:20.10.0-alpine as build

ENV NEXT_PUBLIC_API_HOST_URL=""

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json 到容器中
COPY package*.json ./

# 安装依赖
RUN npm install

# 将应用程序代码复制到容器中
COPY . .

# 构建 TypeScript 代码
RUN npm run build

# 使用多阶段构建
FROM node:20.10.0-alpine

WORKDIR /app

# 从构建阶段复制构建的产物
COPY --from=build /app ./

# 暴露 3001 端口
EXPOSE 3001

# 启动应用程序
CMD ["npm", "start"]
