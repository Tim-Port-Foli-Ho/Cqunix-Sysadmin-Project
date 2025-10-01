# Cqunix-Sysadmin-Project

## Overview
This project documents the design, implementation and testing of an network and server for a small company called cqunix with 10 employees who exclusively use Ubuntu Linux. The six core servers are:
- Adelaide that host an Apache web server with a self-signed certificate for encrypted communication
- Sydney that provides secure SSH login and access to other servers
- Gladstone that acts as the internal Gitea Git server, syncing changes hourly to an external GitHub repository for disaster recovery.
- Bundaberg as a backup server automating staggered cron job backups for Adelaide, Gladstone, and Sydney with a 24-hour recovery point objective (RPO) following a 3-2-1 backup strategy
- Darwin as a DHCP server that manages IP address for all devices on the internal network
- Rocky as a router and firewall with iptables rules securing and routing network traffic

## Scope
- The project covers design, implementation, configuration and testing of the six dedicated servers
- Meeting minutes are recorded
- Network design including network diagram and justification
- Security configuration such as firewall rules, SSH auditing log, and password policies are documented
- Backup strategy is documented, a backup instruction is created, and backup and recovery automation is tested
- Device implementation are out of the scope.

## Assumptions
- Basic Linux system and network administation skills 
- Network devices other than servers are assumed but not implemented
- All servers are on a single subnet and VLAN segmentation for a project this size is not needed

## Lesson Learnt
During this project, I was mainly responsible for managing the Gladstone Git server, the Bundaberg backup server, and contributing to the Adelaide webserver tasks.

Some of the key things I learned include:
- Collaborating in a team setting with miniumal members require great and transparent communication to get the project completed.
- Configuring a secure web application with a self assigned certificate for encryption
- Implementing automated 3-2-1 backup strategy for an effective recover point objective with cron jobs and backup scripts
- Enable SSH connection to github repository

Challenges:
- Having members not communicate and drop out thus making this a project with two members
- Working remotely on this project, required additional time management to communicate with other member
