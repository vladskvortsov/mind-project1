#!/bin/bash
AWS_ACCESS_KEY_ID=$1

apt update -y
apt install -y unzip docker.io docker-compose git awscli
usermod -aG docker ubuntu
systemctl restart docker
# newgrp docker
sudo -u ubuntu aws configure set aws_access_key_id ${ AWS_ACCESS_KEY_ID }
sudo -u ubuntu aws configure set aws_secret_access_key  ${{ secrets.AWS_SECRET_ACCESS_KEY }}
sudo -u ubuntu aws ecr get-login-password --region ${{ secrets.AWS_REGION }} | docker login --username AWS --password-stdin ${{ secrets.AWS_ACCOUNT_ID }}.dkr.ecr.${{ secrets.AWS_REGION }}.amazonaws.com
cd /home/ubuntu/
git clone https://github.com/vladskvortsov/mind.git
cd mind/project1/
echo "SECRET_KEY=my-secret-key
DEBUG=False

DB_NAME=mydb
DB_USER=dbuser
# DB_PASSWORD=mypassword
DB_HOST=mydb.cd4yqq2kkslu.eu-north-1.rds.amazonaws.com
DB_PORT=5432

REDIS_HOST=redis-0001-001.redis.fljh7y.eun1.cache.amazonaws.com
REDIS_PORT=6379
REDIS_DB=0
#REDIS_PASSWORD=mypassword

CORS_ALLOWED_ORIGINS=http://d2xytvnh88jebv.cloudfront.net" > vars.env

echo '
# version: '3.8'
services:
backend_rds:
    env_file:
    - vars.env
    image: ${{ secrets.AWS_ACCOUNT_ID }}.dkr.ecr.${{ secrets.AWS_REGION }}.amazonaws.com/project1-backend:backend-rds
    container_name: backend_rds
    ports:
    - "8000:8000"
    networks:
    - backend
    entrypoint: ["sh", "-c", "sleep 10 && python manage.py runserver 0.0.0.0:8000"]

backend_redis:
    env_file:
    - vars.env
    image: ${{ secrets.AWS_ACCOUNT_ID }}.dkr.ecr.${{ secrets.AWS_REGION }}.amazonaws.com/project1-backend:backend-redis
    container_name: backend_redis
    ports:
    - "8003:8003"
    networks:
    - backend
    entrypoint: ["sh", "-c", "sleep 10 && python manage.py runserver 0.0.0.0:8003"]

networks:
backend:
    driver: bridge' > docker-compose.yml
docker-compose up -d