# Do the npm install or yarn install in the full image
FROM mhart/alpine-node:8
WORKDIR /app
COPY package.json ./
RUN npm install --production


ENV PORT=4567

# And then copy over node_modules, etc from that stage to the smaller base image
FROM mhart/alpine-node:base-8
WORKDIR /app
COPY --from=0 /app .
COPY . .
EXPOSE 4567
CMD ["node", "arapaho"]
