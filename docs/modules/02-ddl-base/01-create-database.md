---
title: "01 — Créer une base de données"
aside: false
---

# 01 — Créer une base de données

## Objectif
Comprendre qu’une **base de données MariaDB** est un **contenant logique de haut niveau**, utilisé pour regrouper les tables d’un même travail ou projet, avant même de contenir des données.

---

## DDL — Data Definition Language

Le **DDL** est la partie du langage SQL qui permet de **définir et modifier la structure d’une base de données** (BDs, tables, colonnes, contraintes).

---

## Organisation logique dans MariaDB

Dans MariaDB, les éléments sont organisés de la façon suivante :
- Serveur MariaDB
    - Base de données
        - Tables

> Une table appartient directement à une **base de données**.

---

## Rôle d’une base de données

Une base de données permet de :

- isoler complètement les données d’un travail ou d’un projet
- regrouper toutes les tables liées à un même contexte
- appliquer des paramètres globaux (droits, encodage)

---

## Base de données ou schéma ?

Dans certains SGBD (PostgreSQL, Oracle), un niveau supplémentaire appelé **schéma** s’insère
entre la base de données et les tables.

**Ce niveau n’existe pas dans MariaDB.** Pour MariaDB, les mots *base de données* et
*schéma* désignent exactement la même chose.

```sql
create database tp_evenements;
create schema tp_evenements;   -- fait rigoureusement la même chose
```

> Ne soyez donc pas surpris de voir le mot **Schema** apparaître dans DBeaver ou dans les
> messages d’erreur : il s’agit de votre base de données.

---

## Encodage de la base de données

Lors de la création d’une base de données, MariaDB lui associe un **jeu de caractères**
(*character set*) et une **règle de comparaison** (*collation*).

- Le jeu de caractères détermine comment les caractères sont stockés
- Il influence la gestion des accents et caractères spéciaux
- Le jeu **`utf8mb4`** est celui à utiliser : c’est le seul qui stocke correctement
  **tous** les caractères Unicode (accents, mais aussi emojis)

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Piège fréquent</strong><br>
Dans MariaDB, le jeu de caractères nommé <code>utf8</code> est un « faux » UTF-8 limité à
3 octets par caractère. Utilisez toujours <code>utf8mb4</code>.
</div>

**Dans ce cours**  
> Nous utilisons le jeu de caractères par défaut du serveur, configuré en `utf8mb4` lors de
> l’installation (voir le Lab 01).  
> Aucune configuration particulière n’est requise de votre part.

Il est toutefois possible de le préciser explicitement :

```sql
create database tp_evenements
    character set utf8mb4;
```

## Convention de nommage

### Bases de données
- minuscules
- mots séparés par des underscores (`_`)
- pas d’espaces ni d’accents
- nom représentatif du travail

**Exemples**
- `tp_evenements`
- `tp_gestion_clients`
- `tp_suivi_projets`

---

## Créer une base de données

### Instruction `CREATE DATABASE`

#### Syntaxe
```sql
create database nom_base;

create database tp_evenements;
```

#### Option GUI

<img src="./images/creation-bd-gui.png" alt="Création BD GUI" class="img-bordered w-s" />

## Choisir la base de données de travail

Créer une base de données ne veut pas dire qu’on y travaille. Il faut ensuite indiquer à
MariaDB **dans quelle base** les prochaines instructions doivent s’exécuter.

### Instruction `USE`

```sql
use tp_evenements;
```

À partir de ce moment, toutes les instructions (`create table`, `insert`, `select`…)
s’appliquent à `tp_evenements`, et ce jusqu’à ce qu’on écrive un autre `use`.

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Erreur classique</strong><br>
<code>No database selected</code> : vous avez oublié le <code>use</code> au début de votre script.
</div>

> Bonne habitude : commencer **tout script SQL** par son `use`. Ainsi, le script reste
> correct même si quelqu’un d’autre l’exécute.

### Option GUI

La base de données active peut aussi être choisie dans la barre d’outils de DBeaver.

<img src="./images/connexion-gui.png" alt="Connexion BD GUI" class="img-bordered w-s" />

>Vous pouvez aussi définir la base de données dans laquelle vous travaillez comme `objet par défaut`

<div class="bg-blue-50 border border-blue-200 text-blue-900 rounded-lg p-4">
Le <code>use</code> écrit dans le script et la sélection dans DBeaver font la même chose.
Pour vos travaux, écrivez toujours le <code>use</code> : votre script doit être complet à lui seul.
</div>

---

## Vérifier l’existence des bases de données

### Lister les bases disponibles
```sql
show databases;
```

### Savoir dans quelle base on se trouve
```sql
select database();
```

Vous pouvez également faire clic-droit et rafraîchir (F5)

<img src="./images/regenerer.png" alt="Regénérer BD" class="img-bordered w-s" />
