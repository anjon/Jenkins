# SonarQube Integration With Jenkins
This is sonar scanner to check and analysis of the source sode of your project. As I have installed and configure a separate sonarqube server now we need to integrate it with jenkins.

### Install SonarQube Scanner & Plugin in Jenkins 
1. First we need to download and configure the sonnar scanner in our jenkins server 
- Login jenkins server via ssh and download the sonar scanner.
```sh
cd /opt/
sudo wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip
sudo mv sonar-scanner-cli-3.3.0.1492-linux /opt/sonar_scanner
```
- Set SonarQube server details in sonar-scanner property file
  - Sonar properties file: /opt/sonar_scanner/conf/sonar-scanner.properties
  - sonar.host.url=http://<SONAR_SERVER_IP>:9000

2. Install "SonarQube scanner" plugin in jenkins.
- `Manage Jenkins` --> `Manage Plugins` --> `Avalable` --> `SonarQube Scanner`
- Select it and install this plugin.

### Configure SonarQube Server in Jenkins With Authentication Token
1. Generate authentication token in sonarqube server. 
  - Login to the sonarqube server. i.e `http://sonaqube-ip:9000/sonar`
  - Under the `Administration` --> `Security`. Set a name e.g `jenkins` and click `Generate`.
  - This will generate a wuthentication token we need to use in jenkins to integrate sonarqube server. Copy that token.

- Add sonarqube server is jenkins. 
  - Create a credential in jenkins to add the token we generate.
    - Under the `Administration` --> `Security`. Set a name e.g `jenkins` and click `Generate`. Copy that token.  
    - `Credentials` --> `Jenkins(Stores scoped to Jenkins)` --> `	Global credentials (unrestricted)`
    - `Add Credentials`. `Kind=Secret text`, `Secret="the token we generated"`, `ID & Description=Sonar-Admin`.
    - Click `Ok` to save this.
  - Set sonarqube server in system configuration. 
    - `Manage Jenkins` --> `Configure Systems`. In the `SonarQube servers` section click `Add SonarQube`
    - `Name=Sonar_Server`, `Server URL=http://sonar-server-ip:9000/sonar`
    - For `Server authentication token` select `Sonar-Admin` form the drop down menu.
