---
title: "03 — Contraintes"
aside: false
---

# 03 — Contraintes et Enums

## Objectif
Comprendre comment utiliser des **contraintes** pour assurer l’**intégrité minimale des données** dès la définition de la structure d’une table.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">Les contraintes permettent d’empêcher certaines erreurs <span class="font-bold">avant même l’insertion de données</span>.</div>

---

## Pourquoi utiliser des contraintes ?

Sans contraintes, une base de données peut accepter :
- des valeurs manquantes
- des doublons lorsqu'ils ne devraient pas être permis (ex.: courriel)
- des valeurs incohérentes (ex.: date dans le passé qui ne devrait pas l'être)

Les contraintes permettent donc :
- de **forcer des règles** sur les données
- de protéger la cohérence et la qualité des données

---

## Types de contraintes abordées

Dans cette section, nous verrons :
- NOT NULL / NULL
- UNIQUE  
- DEFAULT  
- CHECK  

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">Les clés primaires et étrangères seront vues dans la section suivante..</div>

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Pourquoi <code>id int primary key auto_increment</code> dans tous les exemples ?</strong><br>

<code>AUTO_INCREMENT</code> demande à MariaDB de générer automatiquement le prochain
identifiant. MariaDB impose une règle : <strong>une colonne <code>auto_increment</code> doit
obligatoirement être une clé</strong>. On la déclare donc tout de suite comme clé primaire,
même si les clés primaires sont expliquées en détail à la section suivante.

Sans le <code>primary key</code>, MariaDB refuse la table avec le message
<em>« there can be only one auto column and it must be defined as a key »</em>.
</div>

---

## Contrainte NOT NULL

### Rôle
- Empêche une colonne de contenir une valeur nulle (NULL).
- Dans le sens inverse, il n'est pas nécessaire d'indiquer `NULL` sur une colonne nullable.
- C'est la contrainte la plus couramment utilisée.

### Exemple

```sql
    create table evenement (
        id int primary key auto_increment,
        nom varchar(100) not null,
        date_evenement date not null
    );
```

>Ici, un événement doit obligatoirement avoir un nom et une date.

---

## Contrainte UNIQUE

### Rôle
Empêche la présence de **doublons** dans une colonne.

### Exemple

```sql
    create table participant (
        id int primary key auto_increment,
        courriel varchar(150) unique,
        nom varchar(100)
    );
```

>Deux participants ne peuvent pas avoir le même courriel.

---

## Contrainte DEFAULT

### Rôle
Attribue une **valeur par défaut** lorsqu’aucune valeur n’est fournie.

### Exemple

```sql
    create table evenement (
        id int primary key auto_increment,
        nom varchar(100) not null,
        actif boolean default true
    );
```

>Si aucune valeur n’est fournie pour la colonne `actif`, la valeur TRUE sera utilisée.

---

## Contrainte CHECK

### Rôle
Impose une **condition logique** sur les valeurs possibles d’une colonne.

### Exemple

```sql
    create table inscription (
        id int primary key auto_increment,
        nombre_places integer check (nombre_places > 0)
    );
```

>Le nombre de places doit être supérieur à 0.

---

## Combiner plusieurs contraintes

Une même colonne peut avoir **plusieurs contraintes**.

### Exemple

```sql
create table evenement (
    id int primary key auto_increment,
    nom varchar(100) not null,
    capacite integer not null check (capacite >= 0),
    actif boolean default true
);

```

>Les contraintes se complètent pour renforcer la qualité des données.

---

## Erreurs à éviter

- Oublier NOT NULL sur une colonne obligatoire
- Mettre UNIQUE sur une colonne qui peut légitimement se répéter  
- Utiliser des CHECK trop complexes  
- Croire que les contraintes remplacent toute validation applicative  

---

## Voir les contraintes dans DBeaver

<img src="./images/voir-contraintes.png" alt="Voir contraintes" class="img-bordered w-s" />

>Ces informations permettent de **valider rapidement** que la structure de la table correspond bien aux règles définies lors de sa création.

---

## Type ENUM

### Rôle
Limiter les **valeurs possibles** d’une colonne à un **ensemble prédéfini et fermé**.

Une colonne de type `ENUM` n’accepte **que les valeurs explicitement définies** dans la
déclaration de la colonne.

>Un `ENUM` est un **type de données et non une contrainte de table**. Il permet toutefois d'agir d'une façon similaire à un `CHECK`.

---

### Exemple

Dans MariaDB, l’ENUM se déclare **directement dans la colonne**, avec la liste des valeurs
permises entre parenthèses.

```sql
create table evenement (
    id int primary key auto_increment,
    nom varchar(100) not null,
    statut enum('planifie', 'annule', 'termine') not null
);
```

>Ici, la colonne `statut` ne peut contenir que l’une des trois valeurs listées.

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>À noter</strong><br>

- Il n’y a <strong>rien à créer au préalable</strong> : la liste des valeurs fait partie de
  la définition de la colonne.
- Si deux tables ont besoin de la même liste, il faut la répéter dans chacune.
- <code>ENUM</code> est une particularité de MariaDB et MySQL. Il n’existe pas dans tous les
  SGBD; un <code>CHECK</code> donne un résultat équivalent et est plus portable :

```sql
statut varchar(20) not null check (statut in ('planifie', 'annule', 'termine'))
```

</div>

---

### Visualisation dans DBeaver

La liste des valeurs permises apparaît **dans la définition de la colonne**, sous la
colonne `Type de données` de la table.

<img src="./images/enum1.png" alt="Voir enums" class="img-bordered w-s mb-5" />

