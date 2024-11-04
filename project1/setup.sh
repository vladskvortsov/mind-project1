          #!/bin/bash
          apt update -y
          apt install -y unzip docker.io
          curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
          unzip awscliv2.zip
          ./aws/install
          usermod -aG docker ubuntu
          systemctl restart docker
          # newgrp docker
          sudo -u ubuntu aws configure set aws_access_key_id ${{ secrets.AWS_ACCESS_KEY_ID }}
          sudo -u ubuntu aws configure set aws_secret_access_key  ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          sudo -u ubuntu aws ecr get-login-password --region ${{ secrets.AWS_REGION }} | docker login --username AWS --password-stdin ${{ secrets.AWS_ACCOUNT_ID }}.dkr.ecr.${{ secrets.AWS_REGION }}.amazonaws.com
          # cd mind/
          docker compose up -d