# TP 2 - Réseau AWS - Création et appairage de 2 VPCs

## Création des VPCs
### VPC
> VPC > Virtual Private Cloud > Your VPCs > Create VPC

(screen01)

### Sous réseaux
Création des réseaux
- TFX-public-subnet
- TFX-private-subnet

> VPC > Subnets > Create subnet

(screen*2)

### Internet Gateway
Créer la Gateway Internet

> VPC > Internet gateways > Create Internet gateways

(screen03)

L'attacher au VPC 

(screen)

### Routing tables
Création des tables de routages
- TFX-RT-public
- TFX-RT-PRIVATE

> VPC > Route Tables > Create route tables

(screens)

### NAT Gateway
> VPC > NAT gateways > Create NAT gateway

(screen)


## Création des instances et des bastions

### TFX-Instance1
Créer une instance TFX-instance1, l'ajouter au VPC, la positionner sur le sous réseau privé et l'associer à un securitygroup dédié.

> EC2 > Instances > Launch Instances

(screen*2)






## Appairage des VPCs, Configuration du routage et tests

