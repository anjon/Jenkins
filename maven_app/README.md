# Create a Simple Hello-World Maven App
To Create a simple maven project there is a resource in the maven website https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html

### Check Maven Configuration
First we need to check if the maven is installed properly or not. 
```
mvn --version
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /opt/maven/apache-maven-3.6.3
Java version: 11.0.5, vendor: Private Build, runtime: /usr/lib/jvm/java-11-openjdk-amd64
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "5.0.0-37-generic", arch: "amd64", family: "unix"
```

### Create and Test the Maven App
There is the basic command for creating a simple project which create a maven project with the default directory structure with simple hello-world output. 
```
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=maven_app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
cd maven_app
tree
maven_app
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── mycompany
    │               └── app
    │                   └── App.java
    └── test
        └── java
            └── com
                └── mycompany
                    └── app
                        └── AppTest.java
```
The src/main/java directory contains the project source code, the src/test/java directory contains the test source, and the pom.xml file is the project's Project Object Model, or POM.

Now I've modified the hello-world default output on the file "src/main/java/com/mycompany/app/App.java" to > "This is a basic project for CI/CD with Jenkins !!!!" 

### Build the Project
Now we need to build the maven project with the "package command". The "package" command includes the following step's
- validate
- generate-sources
- process-sources
- generate-resources
- process-resources
- compile
```
mvn package
[INFO] Building jar: /home/anjon/Desktop/Jenkins/maven_app/target/maven_app-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  6.372 s
[INFO] Finished at: 2020-01-11T12:58:08+01:00
[INFO] ------------------------------------------------------------------------
```

### Test Maven
To test the maven project which we have build
```
java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App
```
The Output should be 
```
This is a basic project for CI/CD with Jenkins !!!!
```
