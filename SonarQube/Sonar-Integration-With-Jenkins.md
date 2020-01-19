# SonarQube Integration With Jenkins
This is sonar scanner to check and analysis of the source sode of your project. As I have installed and configure a separate sonarqube server now we need to integrate it with jenkins.

### Install SonarQube Scanner & Plugin In Jenkins 
***Step 01:*** First we need to download and configure the sonnar scanner in our jenkins server 
- Login jenkins server via ssh and download the sonar scanner.
```sh
cd /opt/
sudo wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
sudo mv sonar-scanner-cli-3.3.0.1492-linux /opt/sonar_scanner
```

- Set SonarQube server details in sonar-scanner property file
  - Sonar properties file: /opt/sonar_scanner/conf/sonar-scanner.properties
  - sonar.host.url=http://<SONAR_SERVER_PRI_IP>:9000

***Step 02:*** Install "SonarQube scanner" plugin in jenkins.
- `Manage Jenkins` --> `Manage Plugins` --> `Avalable` --> `SonarQube Scanner`
- Select it and install this plugin.

### Configure SonarQube Server In Jenkins With Authentication Token.
***Step 03:*** Generate authentication token in sonarqube server. 
- Login to the sonarqube server GUI. i.e `http://<SONAR_SERVER_PUB_IP>:9000/sonar`
- Under the `Administration` --> `Security`. Set a name e.g `jenkins` and click `Generate`.
- This will generate a wuthentication token we need to use in jenkins to integrate sonarqube server. Copy that token.

***Step 04:*** Add sonarqube server is jenkins. 
- Create a credential in jenkins to add the token we generate.
  - Under the `Administration` --> `Security`. Set a name e.g `jenkins` and click `Generate`. Copy that token.  
  - `Credentials` --> `Jenkins(Stores scoped to Jenkins)` --> `	Global credentials (unrestricted)`
  - `Add Credentials`. `Kind=Secret text`, `Secret="the token we generated"`, `ID & Description=Sonar-Admin`.
  - Click `Ok` to save this.
- Set sonarqube server in system configuration. 
  - `Manage Jenkins` --> `Configure Systems`. In the `SonarQube servers` section click `Add SonarQube`
  - `Name=Sonar_Server`, `Server URL=http://<SONAR_SERVER_PRI_IP>:9000/sonar`
  - For `Server authentication token` select `Sonar-Admin` form the drop down menu.

***Step 05:*** Configure Sonar Scanner in Jenkins Global Tool
- `Manage Jenkins` --> `Global Tool Configuration` --> In the `SonarQube Scanner` section click `Add SonarQube Scanner`
- `Name=Sonar-Scanner`, `SONAR_RUNNER_HOME=/opt/sonar-scanner/`
- Click `Apply` & `Save`.

### Set Up A Simple Project To Test The Configuration. 
- In the Jenkins Home, CLick `New Item`. Create a new project name `Sonar-Demo` with type `maven`
- In `Source Code Management` section select `Git` and set `Repository URL=https://github.com/anjon/Maven-Web-App.git`.
- In the `Build` section `Root POM=pom.xml`, `Goals and options=clean install package`
- In `Post Steps` section select `Execute SonarQube Scanner` form the `Add post-build step`.
- Set `Analysis properties` as below
```
sonar.projectKey=SonarProject
sonar.projectName=SonarProject
sonar.projectVersion=1.0
sonar.sources=/var/lib/jenkins/workspace/$JOB_NAME/src
```
- Click apply and save. 

Now our project is ready to test. Go to the project and click `Build Now`. After the successful build we need to go to the Sonar server to see the scan report. 

Thanks :whale2:





