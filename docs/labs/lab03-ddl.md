---
title: "Lab 03 — Modélisation DDL : Concessionnaire automobile"
aside: false
---

# Lab 03 — Modélisation DDL : Concessionnaire automobile

## Objectif du laboratoire
Appliquer les notions de **DDL** vues dans le cours afin de :
- créer des tables relationnelles
- définir des **types de données appropriés**
- respecter un **schéma relationnel fourni**

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4 mb-5">
<strong>Important — apprentissage</strong><br>
Les instructions SQL doivent être <strong>tapées manuellement</strong> (ne pas copier-coller).  
L’objectif est de maîtriser la syntaxe et d’être capable de la reproduire lors d’un examen.
</div>

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Consignes importantes</strong><br>
<ul class="list-disc pl-5">
  <li>Créez d'abord la base de données lab03_concessionnaire</li>
  <li>Commencez votre script par <code>use lab03_concessionnaire;</code></li>
  <li>Exécutez une étape à la fois</li>
</ul>
</div>

---

## Contexte

Un concessionnaire automobile souhaite gérer :
- ses **clients**
- ses **vendeurs**
- ses **voitures**
- les **achats** effectués

Un schéma relationnel est fourni (image).

<img src="../modules/01-introduction/images/mrd-concessionnaire.png" alt="Schéma du concessionnaire" class="img-bordered mb-5" />

---

## Travail à réaliser

À partir du schéma fourni, écrire les instructions SQL nécessaires pour créer les tables suivantes :

- `client`
- `vendeur`
- `voiture`
- `achat`

Le script doit pouvoir être exécuté **sur une base de données vide déjà créée**.

---

## Détails et contraintes à respecter

### 1) Table `client`
- Clé primaire auto-générée
- Colonnes :
  - nom (obligatoire)
  - prénom (obligatoire)
  - téléphone (obligatoire)

---

### 2) Table `vendeur`
- Clé primaire auto-générée
- Colonnes :
  - nom (obligatoire)
  - prénom (obligatoire)
- Relation récursive :
  - un vendeur peut avoir **0 ou 1 superviseur**
  - le superviseur est un autre vendeur

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Particularité MariaDB — à lire avant d'écrire cette table</strong><br>

MariaDB <strong>refuse</strong> une clé étrangère qui pointe vers la table en cours de
création. Il faut donc procéder en deux temps : créer la table avec la colonne
<code>id_superviseur</code>, puis ajouter la clé étrangère juste après.

```sql
alter table vendeur
    add foreign key (id_superviseur) references vendeur(id_vendeur);
```

L'instruction <code>alter table</code> sera vue en détail au module 5. Pour ce laboratoire,
recopiez simplement cette ligne après votre <code>create table vendeur</code>.
</div>

---

### 3) Table `voiture`
- Clé primaire auto-générée
- Colonnes obligatoires :
  - marque
  - modèle
  - année
  - prix affiché
  - type de carburant
- Le type de carburant doit être un **ENUM** limité à quelques valeurs
  (ex. essence, diesel, electrique)
- Le prix affiché doit être **strictement positif**
- Deux voitures identiques (même marque, modèle et année) ne doivent pas être dupliquées

<div class="bg-blue-50 border border-blue-200 text-blue-900 rounded-lg p-4">
<strong>Rappel</strong><br>
Dans MariaDB, un <code>ENUM</code> se déclare <strong>directement dans la colonne</strong>.
Il n'y a aucun type à créer avant la table.
</div>

---

### 4) Table `achat`
- Clé primaire auto-générée
- Colonnes obligatoires :
  - date d’achat
  - prix de vente
- Le prix de vente doit être **strictement positif**
- Un achat est associé :
  - à un client
  - à un vendeur
  - à une voiture
- Toutes ces relations doivent être représentées par des **clés étrangères**

---

## Vérification (dans DBeaver)

- Visualiser le schéma relationnel.
- Vérifier :
  - les clés primaires
  - les clés étrangères
  - les contraintes (NOT NULL, UNIQUE, CHECK)
  - la relation récursive du vendeur

---

## Questions (réflexion)

- Pourquoi la relation superviseur → vendeur est-elle optionnelle ?
- Pourquoi faut-il ajouter la clé étrangère de `vendeur` **après** avoir créé la table ?
- Pourquoi la table `achat` contient-elle plusieurs clés étrangères ?
- Quel problème est évité par la contrainte d’unicité sur la table `voiture` ?
- Quelle serait la façon d’obtenir le même résultat que l’`ENUM` du carburant en utilisant
  une contrainte `CHECK` ? Quel est l’avantage de cette deuxième approche ?

<details class="mt-6">
<summary class="cursor-pointer font-semibold text-red-700">
⚠️ Corrigé — À consulter seulement après avoir fait l’exercice
</summary>

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4 mt-4">
<strong>Important</strong><br>
Assurez-vous d’avoir <strong>complété l’exercice</strong> ou, au minimum, d’avoir
<strong>tenté sérieusement chacune des étapes</strong> avant de consulter le corrigé.<br><br>
Le but du laboratoire est de pratiquer l’écriture du SQL et la réflexion sur la structure,
pas de recopier une solution.
</div>

---

### Sélection de la base de données

```sql
use lab03_concessionnaire;
```

---

### Table `client`

```sql
create table client (
  id_client int primary key auto_increment,
  nom varchar(50) not null,
  prenom varchar(50) not null,
  telephone varchar(20) not null
);
```

---

### Table `vendeur`

```sql
create table vendeur (
  id_vendeur int primary key auto_increment,
  nom varchar(50) not null,
  prenom varchar(50) not null,
  id_superviseur int
);

alter table vendeur
  add foreign key (id_superviseur) references vendeur(id_vendeur);
```

>La table se référence elle-même. Comme `id_superviseur` peut être `null`, un vendeur
sans superviseur reste permis.

>La clé étrangère est ajoutée **après** la création : MariaDB refuse une clé étrangère qui
pointe vers une table qui n'existe pas encore, et pendant le `create table`, `vendeur`
n'existe pas encore.

---

### Table `voiture`

```sql
create table voiture (
  id_voiture int primary key auto_increment,
  marque varchar(40) not null,
  modele varchar(40) not null,
  annee int not null,
  prix_affiche decimal(10,2) not null check (prix_affiche > 0),
  carburant enum('essence', 'diesel', 'electrique') not null,
  unique (marque, modele, annee)
);
```
---

### Table `achat`

```sql
create table achat (
  id_achat int primary key auto_increment,
  date_achat date not null,
  prix_vente decimal(10,2) not null check (prix_vente > 0),
  id_client int not null,
  id_vendeur int not null,
  id_voiture int not null,
  foreign key (id_client) references client(id_client),
  foreign key (id_vendeur) references vendeur(id_vendeur),
  foreign key (id_voiture) references voiture(id_voiture)
);
```

---

### Ordre de création recommandé

1. client  
2. vendeur  
3. voiture  
4. achat  

>Les tables sans clé étrangère d'abord, `achat` en dernier puisqu'elle référence les trois autres.

</details>
