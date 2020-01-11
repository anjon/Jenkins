# Install Apache Maven
Go to the official maven website and download the latest stable release https://maven.apache.org/download.cgi and make the configuration.

```
sudo wget http://ftp.ps.pl/pub/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar -xzf apache-maven-3.6.3-bin.tar.gz
sudo mkdir /opt/maven
sudo mv apache-maven-3.6.3 /opt/maven
ls -ld  /opt/maven/apache-maven-3.6.3/
sudo vim /etc/profile.d/maven.sh
export M2_HOME=/opt/maven/apache-maven-3.6.3/
export PATH=${M2_HOME}/bin:${PATH}
source /etc/profile.d/maven.sh
```
Now check the maven configuration with the following command and the output should be like that.
```
$ mvn -version 
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /opt/maven/apache-maven-3.6.3
Java version: 11.0.5, vendor: Private Build, runtime: /usr/lib/jvm/java-11-openjdk-amd64
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "4.15.0-1051-aws", arch: "amd64", family: "unix"
```
### Maven Configuration for Jenkins
- Go to 'Manage Jenkins' 
- Click on the "Global Tool Configuration"
- In the "Maven" Section add Name=Maven, MAVEN_HOME=/opt/maven/apache-maven-3.6.3
- Then in the down button "Apply" & "Save"

### Maven Plugin to add for Jenkins
- Go to 'Manage Jenkins'
- Then to the "Manage Plugin"
- Now on the 'Available' tab search for "Maven Invoker plugin" & "Unleash Maven Plugin"
- Select both of them and click "Install Without Restart"

Now you are ready to go for the Maven Project :v:
