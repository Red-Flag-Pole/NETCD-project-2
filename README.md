NETCD Project 2
----
Infrastructure codes   
Ansible & Terraform  
 
TODO: /!\ BEFORE PUBLISHING REMOVE AND CLEAN ALL CREDS /!\

## Directories  
- netcdcloud-docker  
  Stores docker compose file   
- playbooks  
  Ansible playbooks  
- terrafrom/testing   
  Terrafrom .tf files  

## Terraform code
Install terraform and run the code from ```terraform/testing/```  
Will set up 1 VM with public IP and a DNS label of netcdtestingip1  
Edit the file and uncomment to also setup a second VM  
Security Group will open port 22, 80 and 443    

## Ansible playbook to set up Docker and Nextcloud
Instructions also found in playbooks directory  

1. Set up tar archive of the netcdcloud-docker directory 
  e.g.  
  ```
  administrator@ubuntu:~$ tar -cvf netcdcloud-docker.tar netcdcloud-docker/
  netcdcloud-docker/
  netcdcloud-docker/docker-compose.yml
  netcdcloud-docker/db.env
  netcdcloud-docker/proxy/
  netcdcloud-docker/proxy/Dockerfile
  netcdcloud-docker/proxy/uploadsize.conf
  ``` 
  
2. Move tar archive to playbooks directory  
    * make sure the file is named "netcdcloud-docker.tar"  
    * make sure archive contains everything under a folder called ```netcdcloud-docker/ ```
3. Run dockerinstall.yaml  
```ansible-playbook -i hosts.yaml dockerinstall.yaml --key-file NETCD_PrivKey.pem ```  
    
4. Run nextclouddocker.yaml  
```ansible-playbook -i hosts.yaml nextclouddocker.yaml --key-file NETCD_PrivKey.pem ```  
  
### Credits

Playbooks and Terrafrom code created and modified by  
 - Rui Bin   
 - Jia Yi  
 - Joanna  
  
Docker-compose found from official repo of nextcloud 

.dockerswarm.yaml modified from:  
https://www.blog.labouardy.com/setup-docker-swarm-on-aws-using-ansible-terraform/  
  
dockerinstall.yaml modified from:  
https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-docker-on-ubuntu-18-04 

