AWS_REGION = ap-southeast-1
AWS_ACCOUNT_ID = 390402577671

BACKEND_ECR_REPO_NAME = express-app-ecr
BACKEND_ECR_URI = $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(BACKEND_ECR_REPO_NAME)
BACKEND_DOCKER_IMAGE_NAME = express-app

FRONTEND_ECR_REPO_NAME = react-app-ecr
FRONTEND_ECR_URI = $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(FRONTEND_ECR_REPO_NAME)
FRONTEND_DOCKER_IMAGE_NAME = react-app

TAG ?= latest

backend-build:
	docker build -t $(BACKEND_DOCKER_IMAGE_NAME) ./express-app

backend-auth:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(BACKEND_ECR_URI)

backend-tag:
	docker tag $(BACKEND_DOCKER_IMAGE_NAME):$(TAG) $(BACKEND_ECR_URI):$(TAG)

backend-push:
	docker push $(BACKEND_ECR_URI):$(TAG)

backend-pull:
	docker pull $(BACKEND_ECR_URI):$(TAG)

backend-run:
	docker run -d -p 5000:5000 $(BACKEND_ECR_URI):$(TAG)



frontend-build:
	docker build -t $(FRONTEND_DOCKER_IMAGE_NAME) ./react-app

frontend-auth:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(FRONTEND_ECR_URI)

frontend-tag:
	docker tag $(FRONTEND_DOCKER_IMAGE_NAME):$(TAG) $(FRONTEND_ECR_URI):$(TAG)

frontend-push:
	docker push $(FRONTEND_ECR_URI):$(TAG)

frontend-pull:
	docker pull $(FRONTEND_ECR_URI):$(TAG)

frontend-run:
	docker run -d -p 8080:80 $(FRONTEND_ECR_URI):$(TAG)