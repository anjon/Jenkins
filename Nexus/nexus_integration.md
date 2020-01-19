# Nexus Integration With Jenkins

### Prerequisite
1. Jenkins Installation (https://github.com/anjon/Jenkins/tree/master/jenkins_install)
2. Nexus Installation (https://github.com/anjon/Jenkins/tree/master/nexus_install)

#### Integration Steps
**Create a Repository in Nexus**
- Login to the nexus web console `http://nexus-ip:8081/` 
- Go to the settings `⚙️` then form there click `Repository` --> `create repositoy`.
- From the `Select Recepie` select type `maven2(hosted)`. Name the repository which you want. For me I used `TestRepo`
- Use version policy as `Snapshot`. Click the `Create repository`

**Integrate with Jenkins**
Now we have create a repository now we need to configure Jenkins.
- Login to the Jenkins `http://jenkins-ip:8080`
- Install *Nexus Artifact Uploader* plugin
  - `Jenkins Home --> Manage Jenkins --> Manage Plugin`
  - In the available tab search for *Nexus Artifact Uploader* plugin. Select it and install it.
- Add nexus host acceess credential in the jenkins
  - `Jenkins Home --> Credential --> Jenkins(Under Stores scoped) --> Global credential --> Add Credential`
  - Add username and password for nexus admin user. ID & Description I've used Nexus.

From the Jenkins Home page create a new item with type `Maven Project`. I've named this as `Nexus-Demo`.  
- On the `Source Code Management` section select `git` and add the `Repository URL=https://github.com/anjon/Maven-Web-App.git`
  - In my repository the brach is `*/master`. 
- In the `Build` section the `Root POM=pom.xml` , `Goals and options=clean install package`
- On the `Post Steps` section is the main configuration part. This configuration mostly depends on the pom.xml configuration. 
  - From `Add post-build step` drop down menu select `Nexus artifacat uploader`.
  - In **Nexus Details** part set it as `Nexus Version=NEXUS3`, `Protocol=HTTP`, `Nexus URL=http://nexus=ip:8081`   
  - Credentials drop menu select the Nexus one which just created. `GroupId=webapp`, `Version=1.0-SNAPSHOT`, `Repository=TestRepo`.  
  - On the box select the `Add` to define which artifact we want to upload in the nexus.
    - `ArtifactId=webapp`, `Type=war`, `File=target/webapp.war`.
- Click `Apply` & `Save`

Now our configuration is done. Project page run the `Build Now` and for checking on the nexus server login with the admin user and then cloek on the `🧊` tab then `Browser`. And then on the TestRepo. We will get the desired artifact uploaded onour Nexus. 
