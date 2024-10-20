# Calcul des coûts d’une Infrastructure as a Service en fonction de différents Cloud Provider
&nbsp;

> Pour chacune des infrastructures décrites ci-dessous calculer le coût
sur 3 cloud providers (AWS, GCP, Azure, Scaleway et OVH).\
Faire apparaître le détail des calculs et comparer les résultats finaux.

&nbsp;


## Infrastructure n°1

### Demande
- 1 serveur avec les ressources suivantes :
- 16 Go de RAM minimum
- 4 vCPU
- 100 Go de stockage disque

&nbsp;

### Comparatif

| Cloud Provider | Prix/mois | Devis |
| ----------- | ----------- | ----------- |
| AWS | 133.31 USD | [Calculator AWS](https://calculator.aws/#/estimate?id=17a355cc3b3c1f393a63466fd38cdfc3c0288658)
| GCP | 133.21 USD | [Calculator GCP](https://cloud.google.com/products/calculator?hl=fr&dl=CjhDaVJsT1RZMk5HSXpPQzAyWmpKbUxUUTBPREl0WWprek5TMHhORFZtWlRnNFpHSXpaR1VRQVE9PRAIGiRERUQ3RDc1OC1FMTBCLTRCRTEtODk2Qy0zNkJCQzY2QkIxMzg)
| OVHcloud | 74.17 USD | [Prices OVHcloud](https://www.ovhcloud.com/en/public-cloud/prices/) | 

&nbsp;

### Calcul des coûts

#### AWS

- **Machine type** : t3a.xlarge
- **Prix de l'instance** : 0.1699 USD / heure
- **Stockage EBS** : 0.0928 USD/Go par mois (soit 9.28 USD/mois)
- **Total**  : (0.1699*730) + 9.28 = **133.31 USD/mois**

#### GCP
- **Machine type** : e2-standard-4
- **Prix de l'instance** : 113.49 USD
- **Stockage SSD** : 19.72 USD
- **Total**  : 113.49 + 19.72 = **133.21 USD/mois**

#### OVHcloud
- **Machine type** : b3-16
- **Prix de l'instance + stockage** :  0.1016 USD / heure
- **Total**  : 0.1016 * 730 = **74.17 USD/mois**

&nbsp;

---

&nbsp;

## Infrastructure n°2

### Demande
- 6 serveurs avec les ressources suivantes :
    - 6 Go de RAM minimum
    - 3 vCPU
    - 20 Go de stockage disque par serveur
- Particularité : 3 serveurs sont éteints la nuit de 22h à 6h du matin

&nbsp;

### Comparatif

| Cloud Provider | Prix/mois | Devis |
| ----------- | ----------- | ----------- | 
| AWS | 620.70 USD | [Calculator AWS](https://calculator.aws/#/estimate?id=462b310d0c8c662c48005dde264431e9d99959eb)|
| GCP | 483.02 USD | [Calculator GCP](https://cloud.google.com/products/calculator?hl=fr&dl=CjhDaVEwTmpjMU5EUTFNeTA0TkdFd0xUUTNPVGN0WWpjM1pDMDJZMkl3TXpBNU9HSXlOMllRQVE9PRAIGiREQzFCOUE5My1GNDk0LTQ4NDMtQUFGQi1CNzVCODM1QTQ0ODM)
| OVHcloud | 362.82 USD | [Prices OVHcloud](https://www.ovhcloud.com/en/public-cloud/prices/)

&nbsp;

### Calcul des coûts et analyse

#### AWS

- **Instance** : t3a.xlarge
- **Prix de l'instance** : 0.1699 USD / heure
- **Stockage EBS** : 0.0928 USD/Go par mois (soit 1.86 USD/mois par serveur)
- **Serveurs 24h/24h** : 0.1699*730 = 121.62 USD/mois
- **Serveurs 16h/24h** : 0.1699*480 = 81.56 USD/mois
- **Stockage total** : 6 serveurs * 1.86 USD = 11.16 USD / mois
- **Total** : (3 * 121.62) + (3 * 81.56) + 11.16 = **620.70 USD/mois**

&nbsp;

> **Analyse** : je suis parti sur une machine **t3a.xlarge** même si elle propose 16 Go de RAM.\
En effet, elle est moins chère que la **c5a.xlarge**.\
Cette dernière est bien plus véloce, mais sans contexte, je ne sais pas si la différence de prix est justifiée.\
Enfin, j'ai écarté des machines moins chères comme la **c6g.xlarge**.\
Elle est basée sur une architecture processeur ARM et sans contexte, elle pourrait ne pas être adaptée à notre besoin.

&nbsp;

#### GCP
- **Machine type** : e2-custom
- **Prix de l'instance H24** : 279.51 USD (pour 3 serveurs)
- **Prix de l'instance H16** : 183.79 USD (pour 3 serveurs)
- **Stockage SSD H24** : 11.83 USD (pour 3 serveurs)
- **Stockage SSD H16** : 7.86 USD (pour 3 serveurs)
- **Total**  : 279.51 + 183.79 + 11.83 + 7.86 = **483.02 USD/mois**

&nbsp;

> **Analyse** : je suis parti sur une machine de type e2 qui d'après mes recherches semble être dans la gamme de la **t3a.xlarge** d'AWS.\
Par contre, si l'on cherche à optimiser les coûts, le fait de pouvoir customiser son hardware est plus rentable.

&nbsp;

#### OVHcloud
- **Machine type** : b3-16
- **Prix de l'instance + stockage** :  0.1016 USD / heure
- **Total H24**  : (0.1016 * 730) * 3 = **222.51 USD/mois**
- **Total H16**  : (0.1016 * 480) * 3 = **146.31 USD/mois**
- **Total** : 222.51 + 146.31 = **362.82 USD / mois**

&nbsp;

> **Analyse** : comme précédement, j'ai gardé de la cohérence dans l'équivalence des machines.\
Par conséquent, la b3-16 dépasse les prérequis mais elle reste moins chère que ses concurrentes.

&nbsp;

---

&nbsp;

## Infrastructure n°3
- 3 serveurs avec les ressources suivantes :
    - 4 Go de RAM minimum
    - 2 vCPU
    - 50 Go de stockage disque par serveur
- 1 load balancer qui répartit 5 Mb/s de données équitablement vers les 3 serveurs ci-dessus
- 1 service de base de données managé
    - 8 Go de RAM minimum
    - 2 vCPU
    - 10 Go de stockage disque
&nbsp;

### Récapitulatif 
| Cloud Provider | Prix/mois | Devis |
| ----------- | ----------- | ----------- |
| AWS | 170.55 USD | [Calculator AWS](https://calculator.aws/#/estimate?id=a2c4612ab76e38834d980050cd05463ac22ff6e6)|
| GCP | 307.41 USD | [Calculator GCP](https://cloud.google.com/products/calculator?hl=fr&dl=CjhDaVJqWVRNM09XUmpaaTFtWTJReExUUTBaVEl0WVRNNFl5MWlaR1ZtTW1JMVpXSmpabVFRQVE9PRAOGiQ2NjVDN0MyRi0zN0YzLTQ5NUUtQjE2QS01NUQ5OTBCNjhEMTE)
| OVHcloud | 335.52 USD  | [Prices OVHcloud]()

&nbsp;

### Calcul des coûts et analyse

#### Calcul du trafic réseau du LB
> *Conversion du début Mb/s vers Mo/s*\
> 5 Mb/s = 5/8 Mo/s = 0.625 Mo/s
>
> *Calcul volume total par heure*\
0.625 Mo/s * 3600 = 2250 Mo/h = 2.25 Go/h
>
>*Calcul du volume mensuel*\
>2.25 Go/h * 24 h = 54 Go/jour\
>54 Go/jour * 30 jours = 1620 Go/mois = **1.62 To/mois**

&nbsp;

#### AWS
##### Serveur

- **Instance** : t3a.medium
- **Prix de l'instance** : 0.0425 USD / heure
- **Stockage EBS** : 0.0928 USD/Go par mois (soit 4.64 USD/mois)
- **Total**  : [(0.0425*730) * 3] + 4.6 = **97.68 USD/mois**

##### Load Balancer
- **Instance** : ElasticLoadBalancer (Network LB)
- **LCUs (Load Capacity Units)** : 2.25 GB/h = 2.25 TCP processed bytes LCUs
- **Prix de l'instance** : 0.0063 USD/h 
- **Total**  : (0.0063 * 2.25 * 730)= **10.35 USD/mois**

##### SGBD managé
- **Instance** : db.t3.medium
- **Prix de l'instance** : 0.082 USD / heure * (100% utilised month) * 730 heures = 59.86 USD / mois
- **Stockage EBS** : 0.133 USD/Go par mois (soit 2.66 USD/mois)
- **Total**  : 59.86 + 2.66 = **62.52 USD/mois**

&nbsp;

#### GCP
##### Serveur

- **Machine type** : e2-custom
- **Prix de l'instance** : 147.55 USD
- **Stockage SSD** : 17.40 USD
- **Total**  : 147.55 + 17.40 = **164.95 USD/mois**

##### Load Balancer
- **Instance** : Cloud Load Balancing Networking
- **Number of forwarding rules** : 1 = 21.35 USD
- **Amount of inbound data** : 100 GiB = 0.94 USD
- **Amount of outbound data** : 100 GiB = 0.94 USD
- **Amount of data processed** : 2.25 GB = 0.02 USD
- **Total**  : 21.35 + 0.94 + 0.94 + 0.02 = **23.24 USD/mois**

##### SGBD managé
- **Instance** : Cloud SQL (PostgreSQL)
- **Prix de l'instance** : **119.21 USD/mois**

&nbsp;

#### OVHcloud
##### Serveur

- **Machine type** : b3-8
- **Prix de l'instance + stockage** :  0.0508 USD / heure
- **Total**  : 0.0508 * 730 * 3 = **111.26 USD/mois**

##### Load Balancer
- **Instance** : Load Balancer M 
- **Total**  : 0.0238 * 730 = **17.38 USD/mois**

##### SGBD managé
- **Instance** : Essential DB1-15
- **Prix de l'instance** : 0.2834 USD/h
- **Total**  : 0.2834 * 730 = **206.88 USD/mois**

> **Analyse** : dans le calcul pour OVHCloud, notre serveur PostgreSQL nous coûte très cher.\
En effet, ne pouvant pas faire de custom, je suis obligé de prendre une config trop importante pour respecter les prerequis hardware.