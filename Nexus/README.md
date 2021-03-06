# Nexus
Nexus is an open source artifacts repository manager manager 

### Prerequisite 
1. EC2 Instance with RHEL-8
2. Java (java-1.8.0-openjdk).

### Installation
For this installation we need to have java in the system in this case I'm using `java-1.8.0-openjdk`. Then download the latest version of nexus.  
```sh
yum install java-1.8.0-openjdk
cd /opt
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -zxf latest-unix.tar.gz
mv nexus-3.20.1-01 nexus
```
It is good practice not to run any service as root. So we are creating a new `nexus` user adn grant sudo permission
```sh
adduser nexus
visudo                              # nexus   ALL=(ALL)       NOPASSWD: ALL
chown -R nexus.nexus nexus
chown -R nexus.nexus sonatype-work
```
Open /opt/nexus/bin/nexus.rc file, uncomment run_as_user parameter and set it as following.
```sh
vim /opt/nexus/bin/nexus.rc
run_as_user="nexus" (file shold have only this line)
```
For the nexus we need to tune some memory parameter as I'm using the t2.micro instance form aws. Just tune this below 3 memory parameter. The rest defaults are as it was.
```sh
vim nexus/bin/nexus.vmoptions
-Xms512m
-Xmx512m
-XX:MaxDirectMemorySize=512m
```

Create a systemd service for nexus.
```sh
vim /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target
  
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
  
[Install]
WantedBy=multi-user.target
```

Now we can start the service form systemctl.
```sh
systemctl daemon-reload
systemctl enable nexus.service
systemctl start nexus.service
```

For checking the nexus log about the progress 
```sh
tail -f /opt/sonatype-work/nexus3/log/nexus.log
```

Login nexus server from browser on port 8081. Please check if the port 8081 is open on the Security Group. 
```http://<Nexus_server>:8081```  

The defaults is admin and the password you can get from  
cat /opt/sonatype-work/nexus3/admin.password
