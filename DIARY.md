# Ansible playbooks & roles

Copy my own public key on ovh to ease ansible execution afterwards.

```
cat ~/.ssh/id_rsa.pub | ssh root@vps502106.ovh.net 'cat >> ~/.ssh/authorized_keys'
```

Trigger with:

```
ansible-playbook -i inventory/ovh-alo playbooks/bastion.yml
```

Once done, root is not allowed anymore to connect, one needs to change the `ansible_user` to your own user in the `inventory/ovh-alo` or use a different inventory afterwards with a technical user?

```
ansible -m ping -i inventory/ovh-alo all
```

Extract the `invalidate_root.yml` from `bastion.yml` since it is a one shot move; not idempotent.


## Inspiration

* [Install Ansible, Create Your Inventory File, and Run an Ansible Playbook and Some Ansible Commands](https://thornelabs.net/2014/03/08/install-ansible-create-your-inventory-file-and-run-an-ansible-playbook-and-some-ansible-commands.html)
* [Hash root's Password in RHEL and CentOS Kickstart Profiles](https://thornelabs.net/2014/02/03/hash-roots-password-in-rhel-and-centos-kickstart-profiles.html)
* [Stackoverflow - Ansible: best practice for maintaining list of sudoers
](https://stackoverflow.com/questions/33359404/ansible-best-practice-for-maintaining-list-of-sudoers)
* [Managing sshd with Ansible](https://blather.michaelwlucas.com/archives/1819)


# Mettre à Jour son OS (CentOS)

La liste de tous les composants qui seront mis à jour:

    yum list updates

Mise à jour du système:

    yum update

Redémarrer:

    reboot


# Bastion, DMZ, wtf!?!

* [Linux Demilitarized Zone (DMZ) Ethernet Interface Requirements and Configuration](https://www.cyberciti.biz/faq/linux-demilitarized-zone-howto/)

> Sample Example DMZ Setup
> Consider the following DMZ host with 3 NIC:
> [a] eth0 with 192.168.1.1 private IP address – Internal LAN ~ Desktop system
> [b] eth1 with 202.54.1.1 public IP address – WAN connected to ISP router
> [c] eth2 with 192.168.2.1 private IP address – DMZ connected to Mail / Web / DNS and other private servers
> 

* [IPtables tutorial / Les entrées deconntrack](https://www.inetdoc.net/guides/iptables-tutorial/theconntrackentries.html)
* [OpenSSH/Cookbook/Proxies and Jump Hosts](https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts)