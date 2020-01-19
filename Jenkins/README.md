# Jenkins
Automation With Jenkins CI/CD.

### Install Jenkins on AWS EC2
Jenkins is an open source automation tool written in Java with plugins built for Continuous Integration purpose. Jenkins is used to build and test your software projects continuously making it easier for developers to integrate changes to the project, and making it easier for users to obtain a fresh build. It also allows you to continuously deliver your software by integrating with a large number of testing and deployment technologies.

### Prerequisites 
 1. EC2 Instance With Ubuntu-18.04
    - With Internet Access
    - Security Group with Port 8080 open for internet
 2. Java (java-11-openjdk)

### Install Java
```
sudo apt install default-jdk
ls -ld /usr/lib/jvm/java-11-openjdk-amd64/
sudo vim /etc/environment 
JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
source /etc/environment
```
### Confirm Java Version
```
echo $JAVA_HOME
java -version
```
The Output should be similar like this.
```
openjdk version "11.0.5" 2019-10-15
OpenJDK Runtime Environment (build 11.0.5+10-post-Ubuntu-0ubuntu1.118.04)
OpenJDK 64-Bit Server VM (build 11.0.5+10-post-Ubuntu-0ubuntu1.118.04, mixed mode, sharing)
```

### Install Jenkins
You can install jenkins using the rpm or by setting up the repo. We will setup the repo so that we can update it easily in future. Get latest version of jenkins from https://jenkins.io/doc/book/installing/#debianubuntu
```
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```
### Start Jenkins
```
#Enable Jenkins Service at System Boot
systemctl enable jenkins.service

#Start Jenkins
systemctl start jenkins
```
### Accessing Jenkins
By default, jenkins runs at port 8080, You can access jenkins at
```
http://YOUR-SERVER-PUBLIC-IP:8080
```
### Configure Jenkins
 - The default Username is admin
 - Grab the default password
   - Password Location:/var/lib/jenkins/secrets/initialAdminPassword
 - Skip Plugin Installation; We can do it later
 - Change admin password
   - Admin > Configure > Password
 - Configure java path
   - Manage Jenkins > Global Tool Configuration > JDK
 - Create another admin user id

### Test Jenkins Jobs
 - Create “new item”
 - Enter an item name – My-First-Project
   - Chose Freestyle project
 - Under Build section Execute shell : echo "Welcome to Jenkins Demo"
 - Save your job
 - Build job
 - Check "console output"
