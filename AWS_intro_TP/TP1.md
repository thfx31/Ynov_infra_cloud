# Quel type de cloud pour quels besoins

&nbsp;

> **Cas n°1:**\
**Eldo** est une start-up qui développe un logiciel qui a pour
objectif la mise en relation de professionnels du BTP avec des prospects
qui souhaitent faire des travaux chez eux. En plus d’un module de mise
en relation, Eldo développe un CRM pour les professionnels du BTP.\
Nombre d’employés : 60

**Quelle solution est la plus adaptée pour héberger les logiciels Eldo ?**

Je proposerai à Eldo de partir sur une solution de type **PaaS**.\
Celà permettrait aux équipes de développement de se concentrer sur leur coeur de métier, sans avoir à se soucier de la gestion des serveurs.

- Offre : cloud public
- Estimation mensuelle : entre 800€ et 1500€
- Solutions PaaS
    - AWS : AWS Elastic Beanstalk
    - GCP : Google App Engine 
    - Microsoft : Azure App Service 

&nbsp;

---

&nbsp;

> **Cas n°2:**\
**MySecureProtect** est une entreprise qui développe et exploite
des objets connectés en lien avec la sécurité des habitations des
particuliers. Plus d’un million d’objets connectés sont en liaison
constante avec les serveurs de l’entreprise. Une application mobile
permet de gérer son système de sécurité et de recevoir des notifications
en cas d’anomalies. La spécificité de ce système est qu’il sollicite les
serveurs dans 3 cas bien précis. Le matin lorsque les personnes quittent
le domicile pour activer l’alarme, le soir pour désactiver l’alarme et enfin
dans de rare cas lorsqu’une anomalie de sécurité est détectée.\
Nombre d’employés : 150

**Quelle solution pensez-vous la plus optimale et pourquoi ?**\
Je proposerai à MySecureProtect de partir sur une solution de type **PaaS**, permettant de simplifier la gestion des applications IoT tout en permettant un scaling automatique lors des pics d'activité (activation/désactivation de l'alarme).

Une alternative intéressante pourrait être un service **IaaS**, permettant à MySecureProtect d'avoir plus de contôle sur la gestion de la charge dynamique.

- Offre : cloud public
- Estimation mensuelle : entre 10000 et 18000 €
- Solutions Paas:
    - AWS : AWS IoT Core
    - GCP : Google Cloud IoT Core
    - Microsoft: Azure IoT Hub

&nbsp;

---

&nbsp;

> **Cas n°3 :**\
Paul est un particulier de 37 ans qui souhaite reprendre le contrôle de ses données. Il fait beaucoup de photos et apprécie pouvoir les stocker à un seul endroit mais y accéder depuis de nombreux appareils. Il dispose d’environ 800 Go de données et son besoin en stockage évolue relativement peu. Les compétences en informatique de Paul sont limitées.
Nombre d’employé : N/A\

**Que conseillez-vous à Paul ?**
Une solution cloud **SaaS** sera la plus adaptée.
S'il souhaite *rééelement* reprendre le contrôle de ses données, je lui proposerai de se tourner vers un prestataire respectueux de la vie privée comme Proton ou Leviia.
S'il souhaite des solutions plus "intégrées" mais moins éthiques, il pourra se tourner vers Amazon, Google, MS, etc..

- Offre : cloud public
- Estimation mensuelle : entre 6 et 10 €
- Solutions SaaS :
    - Proton Drive : Proton Duo
    - Leviia : Solo
    - AWS : Amazon Drive
    - GCP : Google One
    - Microsoft : OneDrive
    - Apple iCloud

&nbsp;

---

&nbsp;

> **Cas n°4 :**\
Une grande entreprise française de soutien aux armées du pays, accréditée par le ministère des armées et dont le nom est confidentiel, a besoin de moderniser ses infrastructures informatiques.
Les besoins en termes de diversité de service, de quantité de serveurs, stockages et réseaux évoluent très rapidement.
Nombre d’employés : 5000

**Quelle solution doit être mise en place pour moderniser l’infrastructure de cette entreprise ?**
Étant donné la taille de l'entreprise et la nécessité de diversifier les services et d'adapter les ressources rapidement, une solution **IaaS** offrirait la meilleure solution.

- Offre : cloud privé
- Estimation mensuelle : 
- Solutions IaaS:
    - OpenStack
    - Nutanix
    - D'autres solutions propriétaires existent mais je considère que la criticité des données nécessite un acteur opensource.

&nbsp;

---

&nbsp;

> **Cas n°5 :** TheFoodStore est une petite entreprise qui cherche à publier
un site e-commerce rapidement afin de générer ses premières ventes en
ligne.
Nombre d’employés : 5
Quelle solution sera la plus adaptée pour TheFoodStore ?

Je proposerai un service **SaaS** orienté e-commerce, rapide à lancer et simple à prendre en main.

- Offre : cloud public
- Estimation mensuelle : entre 40 et 100 € en fonction des services (appli, domaine, hébergement, ads..)
- Solutions Saas:
    - Shopify
    - WooCommerce
    - BigCommerce

&nbsp;

---

&nbsp;

> **Cas n°6** :
DeliverEats est une plateforme permettant de commander et
se faire livrer des repas. Elle dispose d’une application mobile et d’un
site internet pour passer commande. Les livreurs de commandes
disposent d’une application mobile qui les guide dans leurs livraisons,
tandis que les restaurateurs reçoivent les commandes à préparer sur
une application pour tablette.
Nombre d’employés : inconnu

**Quels types d'architecture peuvent être envisagées dans ce cas ? Quels
sont les avantages et inconvénients des différentes solutions ?**\
On conseillera à DeliverEats de partir sur une solution **PaaS**, lui permettant de développer et déployer ses applications tout en bénéficiant d'une gestion d'infrastructure.
Comme dans le cas n°2, l'alternative **IaaS** est tout aussi crédible.

- Offre : cloud public
- Estimation mensuelle : entre 5000 et 10000 € en fonction des services (hébergement, SGDB managé, stockage, notifications, sécurité)
- Solutions PaaS
    - AWS : AWS Elastic Beanstalk, RDS, S3, SNS..
    - GCP : Google App Engine, Cloud SQL, Cloud Storage, Cloud Sub..
    - Microsoft : Azure App Service, SQL DB, Blob Storage, Notification Hubs..

&nbsp;

---

&nbsp;

> **Cas n°7** :
L’entreprise de télévendeurs Onenveutpa a besoin d’un nouveau système pour la gestion des informations de ses potentiels futurs clients. Les télévendeurs travaillent partout dans le monde.
Nombre de télévendeurs : beaucoup trop

**Quelle solution proposez-vous ?**
Une solution de type **SaaS** sera complètement adaptée.

- Offre : cloud public
- Estimation mensuelle : très variable en fonction des services souscrits (abonnement/télévendeurs, formation, support..)
- Solutions Saas:
    - Salesforce
    - HubSpot
    - Zoho CRM
