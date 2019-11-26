# Ansible playbook to set up Docker and Nextcloud

1. Set up TAR archive of the netcdcloud-docker directory 
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
3. Run dockerinstall.yaml  
```ansible-playbook -i hosts.yaml dockerinstall.yaml --key-file NETCD_PrivKey.pem ```  
    
4. Run nextclouddocker.yaml  
```ansible-playbook -i hosts.yaml nextclouddocker.yaml --key-file NETCD_PrivKey.pem ```  
  
## Credits

Playbooks created and modified by  
 - Rui Bin   
 - Jia Yi  
 - Joanna  

.dockerswarm.yaml modified from:  
https://www.blog.labouardy.com/setup-docker-swarm-on-aws-using-ansible-terraform/  
  
dockerinstall.yaml modified from:  
https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-docker-on-ubuntu-18-04  
