# TP 2 - Réseau AWS - Création et appairage de 2 VPCs

&nbsp;

## Sommaire
- [Création des VPCs](#création-des-vpcs)
    - [VPC](#vpc)
    - [Sous réseaux](#sous-reseaux)
    - [Internet Gateway](#internet-gateway)
    - [NAT Gateway](#nat-gateway)
    - [Routing Tables](#routing-tables)
- [Création des instances et des bastions](#création-des-instances-et-des-bastions)
    - [TFX-Instance1](#tfx-instance1)
    - [TFX-BastionVCP1](#tfx-bastionvcp1)
    - [Validation connexion instance](#validation-connexion-instance)
        - [Configuration SSH](#configuration-ssh)
        - [Test SSH](#test-ssh)
- [Appairage des VPCs, Configuration du routage et tests](#appairage-des-vpcs-configuration-du-routage-et-tests)
    - [Créer le peering](#créer-le-peering)
    - [Mise à jour tables de routage](#mise-à-jour-tables-de-routage)
    - [Modification Security Group](#modification-security-group)
    - [Validation connectivité vers IBI-Instance2](#validation-connectivité-vers-ibi-instance2)

---

&nbsp;

## Création des VPCs
### VPC
> VPC > Virtual Private Cloud > Your VPCs > Create VPC

![CreateVPC](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/01-create-VPC-TFX-VPC1.png?raw=true)

***Note : En choisissant l'option **VPC and more**, on pourrait créer automatiquement toutes les ressources liées au VPC.
J'ai choisi VPC only afin de tester la création manuelle de celles ci.***

&nbsp;

### Sous réseaux
Création des réseaux permettant de segmenter les ressources du VPC
- TFX-public-subnet
- TFX-private-subnet

> VPC > Subnets > Create subnet

![CreateSubnet](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/02-create-subnet-1.png?raw=true)

**Public subnet**

![CreateSubnet](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/02-create-subnet-2.png?raw=true)

**Private subnet**

![CreateSubnet](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/02-create-subnet-3.png?raw=true)

&nbsp;

### Internet Gateway
L'**Internet Gateway** permet aux instances du sous-réseau public d'accéder à internet.

> VPC > Internet gateways > Create Internet gateways

Créer l'Internet Gateway

![Create IG1](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/03-create-internet-gw-1.png?raw=true)

L'attacher au VPC 

![Create IG2](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/03-create-internet-gw-2.png?raw=true)

&nbsp;

### NAT Gateway
La **NAT Gateway** permet aux instances du sous-réseau privé d'accéder à internet.

> VPC > NAT gateways > Create NAT gateway

![Create NG](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/05-create-nat-gw.png?raw=true)

&nbsp;

### Routing tables
Création des tables de routages :
- TFX-RT-public
- TFX-RT-PRIVATE

&nbsp;

> VPC > Route Tables > Create route tables


**Public RT**

Création table de routage et choix du VPC

![Create RT-Public1](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/04-create-rt-public-1.png?raw=true)

Création de la route de base

![Create RT-Public2](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/04-create-rt-public-2.png?raw=true)

On l'associe au subnet public

![Create RT-Public3](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/04-create-rt-public-3.png?raw=true)

**Private RT**

Création table de routage et choix du VPC

![Create RT-Private](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/06-create-rt-private-1.png?raw=true)

Création de la route de base

![Create RT-Private](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/06-create-rt-private-2.png?raw=true)

On l'associe au subnet privé

![Create RT-Private](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/06-create-rt-private-3.png?raw=true)

&nbsp;

## Création des instances et des bastions

### TFX-Instance1
Créer une instance TFX-instance1, l'ajouter au VPC, la positionner sur le sous réseau privé et l'associer à un securitygroup dédié.

> EC2 > Instances > Launch Instances

AMI Amazon Linux 2 (image custom importée depuis une autre région)

![CreateInstance1](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/07-create-tfx-instance1-1.png?raw=true)

Paramétrages réseaux

![CreateInstance1](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/07-create-tfx-instance1-2.png?raw=true)

&nbsp;

### TFX-BastionVCP1
Créer une instance TFX-BastionVCP1 et l'ajouter au VPC (l'association au securitygroup dédié a été gérée manuellement par la suite)

> EC2 > Instances > Launch Instances

AMI Amazon Linux 2 

![CreateBastion1](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/07-create-tfx-instance1-1.png?raw=true)

Paramètres réseaux

![CreateBastion2](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/07-create-tfx-instance1-2.png?raw=true)

Security Group

![CreateSGBastion1](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/09-create-sg-bastion.png?raw=true)

&nbsp;

### Validation connexion instance
L'objectif est de se connecter à l'instance TFX-Instance1 depuis ma machine Linux via un rebond avec TFX-BastionVCP1.
On utilisera les clés générées lors de la création de l'instance et du bastion

```shell
thomas@Mint:~/.ssh/AWS$ ll
total 20
drwxrwxr-x 2 thomas thomas 4096 nov.   8 11:55 ./
drwx------ 4 thomas thomas 4096 nov.   8 15:32 ../
-r-------- 1 thomas thomas 1674 nov.   8 11:50 TFX-bastion-keypair.pem
-r-------- 1 thomas thomas 1678 nov.   8 11:50 TFX-Inst1-keypair.pem
```
&nbsp;

#### Configuration SSH
Modification du fichier ~/.ssh/config pour déclarer nos hosts et le proxyjump

```shell
Host TFX-BastionVPC1
  hostname 52.91.138.127
  user ec2-user
  IdentityFile ~/.ssh/AWS/TFX-bastion-keypair.pem

Host TFX-InstanceVPC1
  hostname 10.7.2.42
  user ec2-user
  IdentityFile ~/.ssh/AWS/TFX-Inst1-keypair.pem
  ProxyJump TFX-BastionVPC1
```
&nbsp;

#### Test SSH

Connexion SSH vers TFX-Instance1 via rebond

```shell
thomas@Mint:~/.ssh$ ssh TFX-InstanceVPC1
   ,     #_
   ~\_  ####_        Amazon Linux 2
  ~~  \_#####\
  ~~     \###|       AL2 End of Life is 2025-06-30.
  ~~       \#/ ___
   ~~       V~' '->
    ~~~         /    A newer version of Amazon Linux is available!
      ~~._.   _/
         _/ _/       Amazon Linux 2023, GA and supported until 2028-03-15.
       _/m/'           https://aws.amazon.com/linux/amazon-linux-2023/

[ec2-user@ip-10-7-2-42 ~]$
```

&nbsp;

## Appairage des VPCs, Configuration du routage et tests

Un autre VCP identique (IBI_VCP2) a été crée en parallèle.
L'objectif est maintenant de lier ces deux VPC afin de valider l'interconnexion entre les deux instances privées (TFX-Instance1 et IBI-Instance2)

### Créer le peering

> VPC > Peering connexion > Create peering

Requête d'appairage

![CreatePeering1](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/10-create-peering-1.png?raw=true)

Validation d'appairage

![CreatePeering2](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/10-create-peering-2.png?raw=true)

&nbsp;

### Mise à jour tables de routage
Ajout du subnet VPC2 pour la connexion du peering

![EditRT](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/11-edit-vpc-routes.png?raw=true)

Status des routes

![EditRT](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/12-add-route-for-vcp2.png?raw=true)

&nbsp;

### Modification Security Group
Ajout d'une règle "Allow from VCP2" pour autoriser le traffic de VCP2.

![SGRule](https://github.com/thfx31/Ynov_infra_cloud/blob/main/TP2-creation-appairage-2-vcps/images/13-add-inbound-rules-for-vcp2.png?raw=true)

&nbsp;

### Validation connectivité vers IBI-Instance2
```shell
[ec2-user@ip-10-7-2-42 ~]$ ip a | grep eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP group default qlen 1000
    inet 10.7.2.42/24 brd 10.7.2.255 scope global dynamic eth0

[ec2-user@ip-10-7-2-42 ~]$ ping 10.103.2.83
PING 10.103.2.83 (10.103.2.83) 56(84) bytes of data.
64 bytes from 10.103.2.83: icmp_seq=1 ttl=255 time=1.44 ms
64 bytes from 10.103.2.83: icmp_seq=2 ttl=255 time=1.42 ms
64 bytes from 10.103.2.83: icmp_seq=3 ttl=255 time=1.66 ms
^C
--- 10.103.2.83 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 1.427/1.511/1.666/0.118 ms

[ec2-user@ip-10-7-2-42 ~]$ curl http://10.103.2.83
ami-id
ami-launch-index
ami-manifest-path
block-device-mapping/
events/
hostname
identity-credentials/
instance-action
instance-id
instance-life-cycle
instance-type
local-hostname
local-ipv4
mac
metrics/
network/
placement/
profile
public-keys/
reservation-id
security-groups
services/

[ec2-user@ip-10-7-2-42 ~]$ 
```