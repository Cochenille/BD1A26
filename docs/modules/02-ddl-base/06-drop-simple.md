---
title: "05 — Suppression simple (DROP)"
aside: false
---

# 06 — Suppression simple (DROP)

## Objectif
Comprendre comment **supprimer une structure** (table ou base de données) à l’aide du DDL, et prendre conscience du **caractère irréversible** de ces opérations.

---

## Le rôle de DROP

L’instruction `DROP` permet de :
- supprimer définitivement une **table**
- supprimer définitivement une **base de données**

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>À retenir</strong><br>
<code>DROP</code> agit sur la <strong>structure</strong> de la base de données, pas sur les données une par une.
</div>

---

## Supprimer une table

### Instruction DROP TABLE

```sql
drop table nom_table;
```

### Exemple

```sql
drop table inscription;
```

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4">
<strong>Attention</strong><br>
La table est supprimée définitivement, ainsi que toutes les données qu’elle contient.
</div>

<div class="bg-blue-50 border border-blue-200 text-blue-900 rounded-lg p-4 mt-4">
<strong>Astuce — <code>if exists</code></strong><br>

```sql
drop table if exists inscription;
```

Avec <code>if exists</code>, MariaDB ne produit pas d’erreur si la table n’existe pas déjà.
C’est très pratique en début de script : on peut le réexécuter autant de fois qu’on veut.
</div>

---

## Ordre de suppression des tables

Lorsqu’il y a des relations entre tables :

- une table contenant une **clé étrangère** dépend d’une autre table
- MariaDB empêche la suppression d’une table encore référencée

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Règle importante</strong><br>
Supprimer d’abord les tables dépendantes (avec clés étrangères), puis les tables référencées.
</div>

### Exemple d’ordre correct
1. inscription (contient des clés étrangères)
2. participant  
3. evenement  

---

## Supprimer une base de données

### Instruction DROP DATABASE

```sql
drop database nom_base;
```

### Exemple

```sql
drop database demo_evenements;
```

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4">
<strong>Danger</strong><br>
La base de données complète est supprimée : tables, contraintes et données.<br>
Aucune récupération n’est possible dans le cadre du cours.
</div>

---

## Cas d’usage typiques dans le cours

- corriger une erreur de structure importante (voir la démo plus bas)
- nettoyer après des tests

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Bonnes pratiques</strong><br>

- Être certain de la base ou de la table ciblée avant d’exécuter un <code>DROP</code>.
- **Avoir une copie du code SQL ayant servi à créer la base de données ainsi que les tables.**

</div>

---

## Démo

Nous avons remarqué une erreur de structure dans une des tables de la démo précédente. Plus tard, nous verrons comme utiliser `ALTER` pour corriger cette erreur.
Pour le moment (et le premier TP), nous voulons un script de création complet et parfait. Nous allons donc supprimer les tables et la base de données pour ensuite réexécuter notre script corrigé.

### Étapes
- Supprimer la table `inscription`.
- Constater que les tables `participant` et `evenement` existent toujours.
- Observer la disparition de la relation dans la visualisation du schéma.
- Supprimer la bd
- Application de la correction dans la structure (ex.: un nouveau champ prénom dans participant)
- Réexécution du script complet.

## Astuce — Supprimer des tables liées par des clés étrangères

<img src="./images/erreur.png" alt="Erreur" class="img-bordered mb-5" />

Si vous supprimez les tables dans le mauvais ordre, MariaDB refuse l’opération :

```text
Cannot delete or update a parent row: a foreign key constraint fails
```

La bonne façon de régler cela est de **respecter l’ordre de suppression** vu plus haut :
les tables enfants (celles qui contiennent des clés étrangères) en premier.

### En dernier recours

Quand on veut vider une base complète et qu’on ne sait plus quel est le bon ordre, il est
possible de désactiver temporairement la vérification des clés étrangères :

```sql
set foreign_key_checks = 0;

drop table if exists evenement;
drop table if exists participant;
drop table if exists inscription;

set foreign_key_checks = 1;
```

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4 mb-5">
<strong>À utiliser avec prudence</strong><br>
Tant que <code>foreign_key_checks</code> vaut <code>0</code>, MariaDB accepte de créer des
incohérences dans vos données. <strong>Toujours le remettre à <code>1</code></strong> à la
fin du script.<br>
Pour vos travaux, la bonne réponse reste de supprimer les tables dans le bon ordre.
</div>

---

## Supprimer la base de données dans laquelle on travaille

Contrairement à d’autres SGBD, MariaDB accepte de supprimer la base de données active,
même si vous y êtes connecté avec un `use`.

```sql
use demo_evenements;
drop database demo_evenements;
```

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4 mb-5">
Après cette commande, vous n’êtes plus dans aucune base : la prochaine instruction donnera
<code>No database selected</code>. Il faut refaire un <code>use</code> vers une autre base.
</div>
