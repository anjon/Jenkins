# Nexus
Nexus is an open source artifacts repository manager manager 

### Prerequisite 
1. EC2 Instance with RHEL-8
2. Java (java-1.8.0-openjdk).

### Installation
Download a stable version of nexus. But please remember about the cpu requirement of latest nexus which require t3.medium type instance which have 4 vcpu. 
```sh
cd /opt
wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.0.2-02-unix.tar.gz
tar -zxf  nexus-3.0.2-02-unix.tar.gz
mv nexus-3.0.2-02 nexus
```
It is good practice not to run any service as root. So we are creating a new `nexus` user adn grant sudo permission
```sh
adduser nexus
visudo                              # nexus   ALL=(ALL)       NOPASSWD: ALL
chown -R nexus:nexus /opt/nexus     # chown -R nexus:nexus /opt/sonatype-work [latest version of nexus] 
```
Open /opt/nexus/bin/nexus.rc file, uncomment run_as_user parameter and set it as following.
```sh
vi /opt/nexus/bin/nexus.rc
run_as_user="nexus" (file shold have only this line)
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
ExecStart=/opt/nexus-3.15.2-01/bin/nexus start
ExecStop=/opt/nexus-3.15.2-01/bin/nexus stop
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
tail -f data/log/nexus.log
```

Login nexus server from browser on port 8081. Please check if the port 8081 is open on the Security Group. 
```http://<Nexus_server>:8081```  

The defaults credeitial to access the nexus in web.  

username : admin  
password : admin123
