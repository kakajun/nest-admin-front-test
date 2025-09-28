# 构建阶段
FROM node:20.12.0 as builder

#设置工作目录
WORKDIR /usr/app/nest-admin-front

# 复制 package.json 和 package-lock.json 文件
COPY package*.json ./
RUN npm  install

# 复制项目文件
COPY . .

RUN npm run build

# 运行阶段
FROM nginx:alpine

# 设置工作目录
WORKDIR /usr/app/nest-admin-front


# 将构建阶段的 dist 目录复制到工作目录
COPY --from=builder /usr/app/nest-admin-front/dist .

#暴露80端口
EXPOSE 80
