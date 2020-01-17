# Install & Configure Sonarqube 
SonarQube is an automatic code review tool to detect bugs, vulnerabilities and code smells in your code.

### Prerequisite
1. AWS EC2 (Ubuntu 18.04).
2. Java (openjdk-11-jdk).
3. PostgreSQL (postgres 10.10).
3. Sonarqube-7.9.2 (LTS).

#### Installation Steps  
In this tutorial I'm using the sonarqube version 7.9.2(lts). For any sonarqube we need to check the system requirements, the database version and the java version which supports the specific version for sonarqube. The version I'm using in this tutorial, requires 2GB of system RAM. So I'm using the aws instance type `t2.small`. The database `postgresql` and the `java` are also match the version specific. 

***Install Postgresql****
- Create a aws instance and install the database.
```sh
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
```
- Create the user(sonarqube) and database(sonarqubedb)
```sh
sudo su - postgres
psql
CREATE USER sonarqube WITH PASSWORD 'sonarqube123';
CREATE DATABASE sonarqubedb OWNER sonarqube;
GRANT ALL PRIVILEGES ON DATABASE sonarqubedb TO sonarqube;
\q
```

***Install Sonarqube***
- Download the sonarqube package and sonfigure it. We also need the java to be installed. 
```sh
sudo apt-get install unzip openjdk-11-jdk
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.9.2.zip
sudo unzip sonarqube-7.9.2.zip
sudo mv sonarqube-7.9.2 /opt/sonarqube
```
- Configuring sonarqube.
```sh
sudo adduser --system --no-create-home --group --disabled-login sonar
sudo chown -R sonar:sonar /opt/sonarqube
sudo vim /opt/sonarqube/bin/linux-x86-64/sonar.sh
RUN_AS_USER=sonar
```
- Configure the connection of database and web settings.
```sh
sudo vim /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonarqube
sonar.jdbc.password=kamisama123
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
sonar.web.javaAdditionalOpts=-server
sonar.web.host=0.0.0.0
```
- Set the security limit 
```sh
sudo vim /etc/security/limits.d/sonarqube.conf
sonarqube   -   nofile   65536
sonarqube   -   nproc    4096
```
- Set the sysctl limit.
```sh
sudo vim /etc/sysctl.conf
vm.max_map_count=262144
fs.file-max=65536
```
