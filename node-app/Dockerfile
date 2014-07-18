FROM tavisto/node-base
ADD . /app
WORKDIR /app
RUN npm install 
EXPOSE 3000
ENV DEBUG express_4_docker*
CMD [ "npm", "start" ]
