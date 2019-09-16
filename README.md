# jenkins-dind-slave
Jenkins Docker-in-Docker com awscli, google shell, git, python, terraform e kubernetes


# Utilizar a imagem pronta:

´´´ docker run -it -d  -p 50000:50000  vemcompy/jenkins-dind-slave:latest ´´´

# Buildar imagem:

docker build -t dockerhub_account/jenkins-dind-slave:latest .



