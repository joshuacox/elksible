# elksible
ELK stack in docker containers brought up by ansible

`make server` is the intended use, it will prompt you for a port and data directory, you will need to ensure the port is open on the host and that the data directory is present and writable 

you’ll need an inventory file in /etc/ansible/hosts with some lines like:

```
elkhost ansible_ssh_port=22 ansible_ssh_host=127.0.0.1 ansible_ssh_user=root

[elksible]
elkhost
```

there are also the `make boostrap` and `make docker` recipes these will bootstrap ansible (i.e. install python and ansible) and install docker on a debian host respectively
