# Ansible playbooks & roles

Let's start with the following structure:



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