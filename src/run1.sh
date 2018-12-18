#!/bin/bash
#docker kill $(docker ps -q)
#docker network create reddit
echo "1-mongo"
docker run -d --network=reddit --network-alias=my_post_db --network-alias=my_comment_db -v reddit_db:/data/db mongo:latest
echo "2-post"
docker run -d --network=reddit --network-alias=my_post -e POST_DATABASE_HOST='my_post_db' -e POST_DATABASE='my_post' mkosterin/post:1.0
echo "3-comment"
docker run -d --network=reddit --network-alias=my_comment -e COMMENT_DATABASE_HOST='my_comment_db' -e COMMENT_DATABASE_HOST='my_comment' mkosterin/comment:2.0
echo "4-ui"
docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST='my_post' -e COMMENT_SERVICE_HOST='my_comment' mkosterin/ui:2.0

