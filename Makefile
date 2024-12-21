AWS_REGION = ap-southeast-1
AWS_ACCOUNT_ID = 390402577671

BACKEND_ECR_REPO_NAME = express-app-ecr
BACKEND_ECR_URI = $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(BACKEND_ECR_REPO_NAME)
BACKEND_DOCKER_IMAGE_NAME = express-app

FRONTEND_ECR_REPO_NAME = react-app-ecr
FRONTEND_ECR_URI = $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(FRONTEND_ECR_REPO_NAME)
FRONTEND_DOCKER_IMAGE_NAME = react-app

backend-auth:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(BACKEND_ECR_URI)

backend-tag:
	docker tag $(BACKEND_DOCKER_IMAGE_NAME):latest $(BACKEND_ECR_URI):latest

backend-push:
	docker push $(BACKEND_ECR_URI):latest

backend-pull:
	docker pull $(BACKEND_ECR_URI):latest



frontend-auth:
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(FRONTEND_ECR_URI)

frontend-tag:
	docker tag $(FRONTEND_DOCKER_IMAGE_NAME):latest $(FRONTEND_ECR_URI):latest

frontend-push:
	docker push $(FRONTEND_ECR_URI):latest

frontend-pull:
	docker pull $(FRONTEND_ECR_URI):latest