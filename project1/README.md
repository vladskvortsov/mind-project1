# EC2-RDS-Elasticache-Cloudfont-Deploy
This is the pipeline for deploying dockerized backend images to EC2 (through private ECR), connecting them to RDS and Elasticashe databases, and deploying frontend to the s3 bucket using Cloudfront for caching. First of all, it builds images from Dockerfiles stored in _backend-rds_ and _backend-redis_ (if you want you can provide your own) folders and pushes them to the private ECR. It creates custom VPC, separate security groups for RDS, Elasticache, EC2, subnet groups for databases, and instance profile for EC2 for access to ECR. Also, it creates EC2, RDS, Elasticache, S3, Cloudfront resources and ECR repository from scratch if they don't already exist. 

## Technologies Used:

#### - _AWS Services_
#### - _Docker/Docker-Compose_
#### - _GitHub Actions_

## Requirements to Deploy the Project
- AWS Account
- Github Account

## Environmental variables:
Variables for backend used by example phyton code, if you wanna use your own containers you should provide your vars in the _deploy-backend.yml_.

    DB_NAME
    DB_USER
    DB_PASSWORD 
    DB_HOST
    DB_PORT 
    REDIS_HOST
    REDIS_PORT 
    REDIS_DB 
    CORS_ALLOWED_ORIGINS

## AWS Infrastructure
The project integrates multiple AWS services:
* Amazon Elastic Compute Cloud (EC2):

Hosts the backend containers running by docker-compose.
* Amazon Relational Database Service (RDS):

Provides a managed database for backend operations.

* Amazon ElastiCache:

Caching service (Redis) for performance optimization.
* Amazon Elastic Container Registry (ECR):

Stores Docker images for deployment.
* Amazon Cloudfront

Caching service for low latency access to frontend.
* Amazon S3 Bucket

Stores frontend files.

## Deploying the project
### Step 1: Fork and Clone
Fork the repository to your GitHub account. Clone the repository to your local machine for configuration or modifications.

### Step 2: Set Up Secrets
Go to Settings > Secrets and Variables > Actions in your GitHub repository.
Add the following secrets:

    AWS_ACCESS_KEY_ID: IAM access key for AWS API operations.
    AWS_SECRET_ACCESS_KEY: Secret key paired with the access key.
    AWS_REGION: The AWS region where resources will be created (e.g., us-east-1).
    AWS_ACCOUNT_ID: ID number of your account (e.g. 111122244444).
    AWS_S3_BUCKET_NAME: Name for your S3 bucket to create.

### Step 3: Deploy AWS Resources
Trigger the _deploy-project_ workflow to deploy the whole infrastructure.

### Step 5: Confirm Resource Status
Validate that the AWS resources are live:
Check EC2 instance for running status and public IP.
Verify RDS and ElastiCache instances are available using the AWS Management Console or CLI.

### Step 6: Retrieve Cloudfront Endpoint and access the frontend webpage
Copy Cloudfront endpoint from your AWS console and access the frontend page. 
> Note: Use `http://` connection for this project.

You can use CI/CD workflows for further updates or scaling.

## Key Notes: 
> Resource Costs: Ensure you understand AWS pricing to manage project costs effectively.
Security: Use the least privileged access for AWS credentials. `Don't paste AWS credentials anywhere excluding GitHub Secrets`
Debugging: You can monitor the infrastructure deploying in GitHub Action logs, and find out errors if they present.
Documentation: Don't forget to update the repository’s README.md to reflect current workflows and configurations.