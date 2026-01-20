#!/bin/bash

<< task
Simple notes app

task

git_clone() {
	echo "Cloning Django App....."
if [[ -d django-notes-app ]]; then
	echo "The repository already exists!!!"
	echo "Pulling the latest repo...."
	
else
	echo "Cloning Django App....."
	git clone https://github.com/LondheShubham153/django-notes-app.git
fi
echo "*************---------------**************"

}


requirements(){
echo "*********** Installing Requirements ************"
if [[ -e /bin/git || -e /bin/nginx ]]; then
	echo "The services already exists !!!!!!!!"
else
	sudo yum install -y docker nginx
fi

}

required_restarts() {
echo "*************---------------**************"
echo "Restarting the services............"

 sudo systemctl enable docker
 sudo systemctl enable nginx
 sudo systemctl restart docker
 sudo systemctl restart nginx

echo "*************---------------**************" 
}

deploy(){
	cd django-notes-app
	docker build -t notes-app .
	docker run -d -p 8000:8000 notes-app:latest
}

echo "********** Deploying The App **********"

git_clone
requirements
required_restarts
deploy
echo "********** Deploying Finished  **********"





