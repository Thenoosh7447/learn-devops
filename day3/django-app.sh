#!/bin/bash

<< task
Simple notes app

task

git_clone() {
	echo "Cloning Django App....."
	git clone https://github.com/LondheShubham153/django-notes-app.git

}


requirements(){
	echo "Installing requirements"
	sudo yum install -y docker nginx
}

required_restarts() {
 sudo systemctl enable docker
 sudo systemctl enable nginx
}

deploy(){
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

echo "********** Deploying The App **********"
if ! git_clone; then
	echo "The Repository already exists"
	cd django-notes-app
fi	

requirements
required_restarts
deploy
echo "********** Deploying Finsihed  **********"





