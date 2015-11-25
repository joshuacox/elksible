# elksible
ELK stack in docker containers brought up by ansible

`make server` is the intended use

you’ll need an inventory file in /etc/ansible/hosts with some lines like:

```
elkhost ansible_ssh_port=22 ansible_ssh_host=127.0.0.1 ansible_ssh_user=root

[elksible]
elkhost
```

there are also the `make boostrap` and `make docker` recipes these will install bootstrap ansible and install docker on a debian host respectively
