---
title: "02 — Requête de sélection (select)"
---

# 02 — Requête de sélection (select)

## Objectif

Comprendre la requête de sélection :
- utilité de la requête `select` et syntaxe de base
- sélectionner des colonnes d’une table
- ordonner les données retournées avec `order by`
- utiliser des alias de table avec `as`
- filtrer les données avec `where`

## Base de données de test à importer

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>
Pour suivre les exemples de ce module, vous devez importer une <strong>base de données de test</strong>.<br>
Celle-ci contient plus de données.

**Télécharger la base de données de test — Événements :** 
<br>
<a href="./../../databases/module_03_evenement_data.sql" target="_blank" rel="noopener">Fichier .sql à télécharger</a>

</div>

### Importation

Téléchargez le fichier SQL, puis **ouvrez-le dans DBeaver** (`Fichier` → `Ouvrir un fichier…`,
ou par glisser-déposer) et exécutez **tout le script** avec `Alt + X`.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Ce fichier est autoportant</strong><br>
Il contient déjà le <code>create database</code> et le <code>use</code> : il crée la base
<code>module_03_evenement_data</code> et la sélectionne.<br>
Rafraîchissez le navigateur de bases de données avec <code>F5</code> pour voir apparaître la
base, puis commencez votre script par <code>use module_03_evenement_data;</code>.<br>
Marche à suivre détaillée : <a href="./../02-ddl-base/07-import-export">Import et export d'une
base de données</a>.
</div>

---

## Utilité de `select`

La requête **`select`** permet de :
- consulter les données d’une base de données
- vérifier des insertions ou des mises à jour
- extraire des informations précises selon des critères

C’est la requête **la plus utilisée** en SQL.

---

## Syntaxe de base

Forme minimale :

```sql
select *  
from evenement;
```

- `select` : indique quelles colonnes retourner
- `from` : indique la table source
- `*` : signifie « toutes les colonnes »
- les retours de ligne peuvent simplifier la lecture

---

## Sélectionner des colonnes précises

Il est recommandé de sélectionner uniquement les colonnes nécessaires.

```sql
select nom, date_evenement, lieu  
from evenement;
```

Avantages :
- requêtes plus lisibles
- moins de données inutiles
- meilleures performances

---

## Ordonner les résultats (`order by`)

Les résultats ne sont **pas garantis** d’être dans un ordre précis sans `order by`.

```sql
select nom, date_evenement  
from evenement  
order by date_evenement;
```
>Les résultats seront en ordre de date  du plus petit au plus grand (`asc` par défaut)

Ordre décroissant :

```sql
select nom, date_evenement  
from evenement  
order by date_evenement desc;
```
>Les résultats seront en ordre de date  du plus grand au plus petit (`desc`)

---

## Limiter le nombre de résultats (`limit`) {#limit}

La clause `limit` permet de restreindre le **nombre de lignes** retournées par une requête.

```sql
select nom, date_evenement
from evenement
limit 5;
```
> Retourne seulement les 5 premières lignes.

Combinée avec `order by`, elle permet d'obtenir les premiers ou les derniers selon un critère :

```sql
select nom, date_evenement
from evenement
order by date_evenement desc
limit 1;
```
> Retourne l'événement le plus récent.

::: tip
`limit` s'applique **après** le tri. Sans `order by`, l'ordre des lignes retournées n'est pas garanti.
:::

---

## Filtrer les données (where)

La clause `where` permet de **restreindre** les lignes retournées.

### Comparaisons simples

```sql
select nom, lieu  
from evenement  
where lieu = 'Paris';
```
> Revoie les événements où le lieu est à Paris.

```sql
select nom, capacite  
from evenement  
where capacite > 50;
```
> Revoie les événements ayant une capacité supérieure à 50 personnes.

---

## Combiner des conditions

### and

```sql
select nom, capacite  
from evenement  
where capacite >= 50  
and capacite <= 150;
```

### or

```sql
select nom, lieu  
from evenement  
where lieu = 'Paris'  
or lieu = 'Toulouse';
```

---

## Filtrer avec des booléens

```sql
select nom  
from evenement  
where actif = true;
```

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Les booléens en MariaDB</strong><br>
MariaDB n'a pas de vrai type booléen : <code>boolean</code> est un <code>tinyint(1)</code>.
La colonne s'affiche donc <strong>1</strong> ou <strong>0</strong>, et les trois écritures
suivantes sont équivalentes :<br>
<code>where actif = true</code>, <code>where actif = 1</code>, <code>where actif</code>.
</div>

---

## Bonnes pratiques

- Toujours commencer par un `select` simple
- Ajouter les filtres progressivement
- Tester fréquemment avec peu de conditions
- Vérifier le résultat avant d’ajouter de la complexité

> Le filtrage est la base des requêtes plus avancées à venir (opérateurs, sous-requêtes, jointures).

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
  <strong class="block">ℹ️ À faire maintenant</strong>
  <p class="m-0">
    Pour mettre ces notions en pratique, passez au
    <a href="./../../labs/lab04-select" class="font-semibold underline hover:text-blue-700">
      Laboratoire 4 — Requêtes select
    </a>.
  </p>
</div>
