# TP 1 - Infrastructure AWS - Load Balancer et Instances EC2

&nbsp;

## Sommaire
- [Création d'un LoadBalancer](#création-d'un-load-balancer)
    - [TargetGroup TFX-TargetGroup](#target-group-tfx-targetgroup)
    - [Load Balancer TFX-LoadBalancer](#load-balancer-tfx-loadbalancer)
    - [Security Group TFX-SecurityGroup-LB](#security-group-tfx-securitygroup-lb)
- [Création d'une Amazon Machine Image](#création-d'une-amazon-machine-image)
    - [Lancer une instance EC2 de base](#lancer-une-instance-ec2-de-base)
    - [Configuration du serveur](#configuration-du-serveur)
        - [Connection SSH](#connection-ssh)
        - [Installer et configurer un serveur web](#installer-et-configurer-un-serveur-web)
    - [Créer une AMI personnalisée](#créer-une-ami-personnalisée)
- [Création de la première instance EC2 et configuration des security groups](#création-de-la-première-instance-ec2-et-configuration-des-security-groups)
    - [Créer un Security Group “TFX_SecurityGroup_EC2”](#créer-un-security-group-tfx_securitygroup_ec2)
    - [Créer une instance "EC2 TFX_Instance1"](#créer-une-instance-ec2-tfx_instance1)
    - [Test du load balancer avec TFX_instance1](#test-du-load-balancer-avec-tfx_instance1)
- [Installation de l'AWS CLI et ajout d’une seconde instance](#installation-de-l'aws-cli-et-ajout-d’une-seconde-instance)
    - [Installation sous Linux Mint](#installation-sous-linux-mint)
    - [Création d’une clé de sécurité pour AWS CLI](création-d’une-clé-de-sécurité-pour-aws-cli)
    - [Créer une nouvelle instance EC2 avec AWS CLI](#créer-une-nouvelle-instance-ec2-avec-aws-cli)
    - [Vérifier le TargetGroup](#vérifier-le-targetgroup)
    - [Vérifier que le LB exitch bien sur l'autre instance](#vérifier-que-le-lb-switch-bien-sur-l'autre-instance)

---

&nbsp;

## Création d'un Load Balancer


### Target Group TFX-TargetGroup

Créer un TargetGroup 'TFX_TargetGroup"

![TargetGroup](https://github.com/thfx31/Ynov_infra_cloud/blob/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/01-create_targetgroup.png?raw=true)

&nbsp;

### Load Balancer TFX-LoadBalancer

Créer le LB TFX_LeadBalancer qui utilise le TargetGroup crée précédement

> EC2 > Load Balancing > Load Balancer > Create Load Balancer


![LoadBalancer](https://github.com/thfx31/Ynov_infra_cloud/blob/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/02-create_lb.png?raw=true)

&nbsp;

### Security Group TFX-SecurityGroup-LB
Créer le securityGroup pour le loadbalancer

> EC2 > Network & Security > Security Group > Create Security Group 

![SecurityGroup-LB](https://github.com/thfx31/Ynov_infra_cloud/blob/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/03-create_securitygroup1.png?raw=true)


Modifier le SecurityGroup pour le loadbalancer

![Edit-LB-SG](https://github.com/thfx31/Ynov_infra_cloud/blob/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/04-SG_for_lb.png?raw=true)

&nbsp;


## Création d'une Amazon Machine Image

### Lancer une instance EC2 de base

> EC2 > Instances > Instances > Launch Instances 


![Create-Webserver](https://github.com/thfx31/Ynov_infra_cloud/blob/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/05-create-ec2-webserver-instance.png?raw=true)


### Configuration du serveur

#### Connection SSH

***Note : une keypair “TFX-Keypair” a été générée lors de la création de la machine et associée à celle ci***

```shell
thomas@Mint:~/Ynov/Infra_cloud/AWS-labs$ ls TFX-Keypair.pem 
TFX-Keypair.pem

thomas@Mint:~/Ynov/Infra_cloud/AWS-labs$ ssh -i "TFX-Keypair.pem" ec2-user@ec2-3-250-97-35.eu-west-1.compute.amazonaws.com
The authenticity of host 'ec2-3-250-97-35.eu-west-1.compute.amazonaws.com (3.250.97.35)' can't be established.
ED25519 key fingerprint is SHA256:QMrUiOeijNLj5l6wlcckIiNdEBXtSL35GN5y2se3j98.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ec2-3-250-97-35.eu-west-1.compute.amazonaws.com' (ED25519) to the list of known hosts.
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

[ec2-user@ip-172-31-24-58 ~]$
```
&nbsp;


#### Installer et configurer un serveur web 

Création d’un script permettant l’installation d’un serveur web et la récupération de son instance-id :

```shell
[ec2-user@ip-172-31-24-58 ~]$ vim install-webserver.sh

#!/bin/bash

# Update packages and install Apache HTTP Server
sudo yum update -y
sudo yum install -y httpd

# Start Apache and enable it to launch on startup
sudo systemctl start httpd
sudo systemctl enable httpd

# Create a script to retrieve instance-id metadata and save it in an HTML file
cat << 'EOF' > /var/www/html/metadata.sh
#!/bin/bash
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/instance-id > /var/www/html/index.html
EOF

# Make the script executable
sudo chmod +x /var/www/html/metadata.sh

# Add a cron job to run the script on instance startup
(crontab -l 2>/dev/null; echo "@reboot /var/www/html/metadata.sh") | sudo crontab -
```
&nbsp;


Rendre exécutable le script, le lancer et vérifier son bon fonctionnement

```shell
[ec2-user@ip-172-31-24-58 ~]$ chmod +x install-webserver.sh

[ec2-user@ip-172-31-24-58 ~]$ sudo ./install-webserver.sh

[ec2-user@ip-172-31-24-58 ~]$ ll /var/www/html/metadata.sh 
-rwxr-xr-x 1 root root 250  7 nov.  16:43 /var/www/html/metadata.sh

[ec2-user@ip-172-31-24-58 ~]$ sudo -i

[root@ip-172-31-24-58 ~]# crontab -l
@reboot /var/www/html/metadata.sh
```
&nbsp;


### Créer une AMI personnalisée

> EC2 > Instances > Instances > Actions > Image and templates > Create image 

![Create-Webserver-AMI](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/07-create%20webserver-ami.png)

&nbsp;


## Création de la première instance EC2 et configuration des security groups

### Créer un Security Group TFX_SecurityGroup_EC2
L'ajouter l'instance créée précédemment à ce Security Group.

> EC2 > Security Groups > Create security group

![Create-SG-EC2](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/08-create-securitygroup-ec2-1.png)

### Créer une instance EC2 TFX_Instance1
L'instance va utiliser le Security Group“TFX_SecurityGroup_EC2” et l’AMI créée précédemment.

> EC2 > Instances > Instances > Launch Instances 


![Create-TFX_Instance1-1](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/09-create-tfx-instance1-1.png)

![Create-TFX_Instance1-2](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/09-create-tfx-instance1-2.png)

### Test du load balancer avec TFX_instance1 

![Create-TFX_Instance1-2](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/10-test-lb-tfx-instance1.png)

&nbsp;

## Installation de l'AWS CLI et ajout d’une seconde instance

### Installation sous Linux Mint
```shell
thomas@Mint:~$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

thomas@Mint:~$ unzip awscliv2.zip

thomas@Mint:~$ sudo ./aws/install
```


### Création d’une clé de sécurité pour AWS CLI

![AWSCLI-1](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/13-awcli-key-1.png)


![AWSCLI-2](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/14-awcli-key-2.png)


### Créer une nouvelle instance EC2 avec AWS CLI

```shell
# Se connecter au compte AWS et configurer la clé + la région
thomas@Mint:~$ aws configure

# Récupérer l'ID de l'instance existante'
thomas@Mint:~$ aws ec2 describe-instances --filters "Name=tag:Name,Values=TFX_Instance1" --query "Reservations[*].Instances[*].InstanceId" --output text
i-07ec3f3b57b6e2086

# Afficher les paramètres de l'instance existante
thomas@Mint:~$ aws ec2 describe-instances --instance-ids i-07ec3f3b57b6e2086 --query "Reservations[0].Instances[0].[InstanceType, ImageId, SubnetId, KeyName, SecurityGroups[*].GroupId]" --output json
[
    "t2.micro",
    "ami-0a4186be086b3b6b4",
    "subnet-0655f72c900baddc5",
    "TFX-Keypair",
    [
        "sg-0ffc31c0288d77a61"
    ]
]

# Créer la nouvelle instance à partir des informations collectées
thomas@Mint:~$ aws ec2 run-instances \
  --image-id ami-0a4186be086b3b6b4 \
  --instance-type t2.micro \
  --key-name TFX-Keypair \
  --security-group-ids sg-0ffc31c0288d77a61 \
  --subnet-id subnet-0655f72c900baddc5 \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=TFX_Instance2}]'

149028371915    r-01be30a65b378dd5d
INSTANCES       0       x86_64  c2ac6598-ac74-43e2-adc3-64b87fd8aca3    legacy-bios     False   True    xen     ami-0a4186be086b3b6b4   i-0de2201421b09d2e1     t2.micro        TFX-Keypair     2024-11-07T17:41:22+00:00  ip-172-31-18-181.eu-west-1.compute.internal     172.31.18.181           /dev/xvda       ebs     True            subnet-0655f72c900baddc5        hvm     vpc-0035b5ae8bbbefd3f
CAPACITYRESERVATIONSPECIFICATION        open
CPUOPTIONS      1       1
ENCLAVEOPTIONS  False
MAINTENANCEOPTIONS      default
METADATAOPTIONS enabled disabled        1       optional        disabled        pending
MONITORING      disabled
NETWORKINTERFACES               interface       06:cd:e6:ad:4d:93       eni-0eb80cf688bc420e3   149028371915    ip-172-31-18-181.eu-west-1.compute.internal     172.31.18.181   True    in-use  subnet-0655f72c900baddc5   vpc-0035b5ae8bbbefd3f
ATTACHMENT      2024-11-07T17:41:22+00:00       eni-attach-07199fa53fe7a9884    True    0       0       attaching
GROUPS  sg-0ffc31c0288d77a61    TFX-SecurityGroup_EC2
PRIVATEIPADDRESSES      True    ip-172-31-18-181.eu-west-1.compute.internal     172.31.18.181
PLACEMENT       eu-west-1c              default
PRIVATEDNSNAMEOPTIONS   False   False   ip-name
SECURITYGROUPS  sg-0ffc31c0288d77a61    TFX-SecurityGroup_EC2
STATE   0       pending
STATEREASON     pending pending
TAGS    Name    TFX_Instance2

# Ajouter l'instance au TargetGroup du LB
thomas@Mint:~$ aws elbv2 register-targets --target-group-arn arn:aws:elasticloadbalancing:eu-west-1:149028371915:targetgroup/TFX-TargetGroup/68ad82842eb585ac --targets Id=i-0de2201421b09d2e1,Port=80
```
&nbsp;


### Vérifier le TargetGroup

> EC2 > Target groups > TFX-TargetGroup

![TargetGroup](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/11-check-targetgroup.png)

&nbsp;

### Vérifier que le LB switch bien sur l'autre instance

![Check-LB](https://raw.githubusercontent.com/thfx31/Ynov_infra_cloud/refs/heads/main/AWS_TP/TP1_Load_balancer_instances_EC2/images/12-test-lb-tfx-instance2.png)
