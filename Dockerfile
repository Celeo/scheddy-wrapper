FROM node:23

LABEL repo="https://github.com/Celeo/scheddy-wrapper"
LABEL authors="Matt Boulanger"

WORKDIR /srv
EXPOSE 3000

COPY upstream .

CMD ["node", "build/index.js"]
