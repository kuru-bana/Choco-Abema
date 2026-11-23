# 依存パッケージなしなので、server.js をコピーして動かすだけ
FROM node:20-alpine

ENV NODE_ENV=production
WORKDIR /app

COPY package.json server.js ./

# Render / Railway / Fly.io は PORT を自動で入れる。未設定なら 3000
ENV PORT=3000
EXPOSE 3000

# root で動かさない
USER node

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:'+(process.env.PORT||3000)+'/healthz').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

CMD ["node", "server.js"]
