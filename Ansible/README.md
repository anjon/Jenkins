# Ansible Install and Configuration RHEL 8.x server
First we need to launch a ec2 instance with RHEL-8 in aws. Connect to the instance. 

#### Install Ansible
```sh
sudo dnf install python3
python3 -V
alternatives --set python /usr/bin/python3
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf install ansible
# For Amazon Linux 
amazon-linux-extras install ansible2
ansible --version
```
#### Configure Ansible
Create a new user for ansible administration & grant sudo access for that user. (Both Master & Slave Node)
```sh
useradd ansadmin
echo "password" | passwd --stdin ansadmin
```
Add this `ansadmin` user to the have sudo rights 
```sh
echo "ansadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ansadmin
```
For this server we are using the passowrd based authenticaton. But for advanced use key-based authentication is advised. 
```sh
# sed command replaces "PasswordAuthentication no to yes" without editing file 
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd
```
Now login as ansadmin
```sh
ssh-keygen
ssh-copy-id ansadmin@<target-server>
```
add some host entry to the /etc/ansible/hosts file and then run the simple command to validate the configuration.
```sh
ansible all -m ping
```
The output should be like 
```
target-ip | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```
