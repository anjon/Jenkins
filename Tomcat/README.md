# Install Tomcat 

### Prerequisites
- EC2 Instance with RHEL-8
- Java (java-11-openjdk)

### Install Apache Tomcat
For tomcat we need java to be installed.
```sh
yum install java-11-openjdk
find /usr/lib/jvm/java-* | head -n 3
vim .bash_profile
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.5.10-2.el8_1.x86_64
PATH=$PATH:$JAVA_HOME:$HOME/bin
echo $JAVA_HOME
/usr/lib/jvm/java-11-openjdk-11.0.5.10-2.el8_1.x86_64
```
Download tomcat packages form the apache website https://tomcat.apache.org/download-90.cgi
```sh
cd /opt
wget http://apache.mirrors.tworzy.net/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz
tar -xzf apache-tomcat-9.0.30.tar.gz
```
Give execute permission to the 'startup.sh' & 'shutdown.sh' under the "bin" and create link files for tomcat startup.sh and shutdown.sh
```sh
chmod +x apache-tomcat-9.0.30/bin/startup.sh
chmod +x apache-tomcat-9.0.30/bin/shutdown.sh
ln -s /opt/apache-tomcat-9.0.30/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/apache-tomcat-9.0.30/bin/shutdown.sh /usr/local/bin/tomcatdown
```
### Start & Cinfigure Tomcat
Now we can start the tomcat and access form the web.
```sh
tomcatup 
ps aux | grep -i tomcat
```
access tomcat application from browser on prot 8080
http://<Public_IP>:8080

Using unique ports for each application is a best practice in an environment. But tomcat and Jenkins runs on ports number 8080. Hence lets change tomcat port number to 8090. Change port number in conf/server.xml file under tomcat home. Also we need to allow 8090 port on the AWS Security Group.
```sh
cd /opt/apache-tomcat-9.0.30/conf/
vim server.xml
<Connector port="8090" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
tomcatdown
tomcatup
```
Now the tomcat should be accessible on port 8090
http://<Public_IP>:8090

But tomcat application doesnt allow to login from browser. changing a default parameter in context.xml does solves the issue. 
```sh
#search for context.xml
find / -name context.xml
```
Above command gives 3 context.xml files. comment () Value ClassName field on files which are under **webapp** directory. After that restart tomcat services to effect these changes. Example 
```xml
<!--  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
```
```sh
tomcatdown
tocatup
```
Update users information in the tomcat-users.xml file goto tomcat home directory and Add below users to conf/tomcat-user.xml file
```xml
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="manager-jmx"/>
  <role rolename="manager-status"/>
  <user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
  <user username="deployer" password="deployer" roles="manager-script"/>
  <user username="tomcat" password="s3cret" roles="manager-gui"/>
```
Restart serivce and try to login to tomcat application from the browser. This time it should be Successful
