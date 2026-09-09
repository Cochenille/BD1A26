---
title: "01 — Formats de données"
---

# 01 — Formats de données

## Objectifs
- Distinguer format de fichier vs structure de stockage persistante.
- Nommer des formats courants et leurs cas d’usage.
- Situer “relationnel” vs “non-relationnel” au bon niveau (modèle, pas format).

## Structurer des données
L'exemple suivant peut être interprété par un humain, car il sait lire (normalement) et son cerveau structure les données de façon inconsciente.
> Alex, 19 ans, étudie en informatique au cégep, aime le ski, Python, la poutine a un chat nommé Pixel, travaille à temps partiel, habite à Québec, aime le café, s’est inscrit le 14 janvier, préfère les cours le matin et a déjà échoué un cours de math.

Pour qu'un ordinateur puisse interpréter des données, elles doit d'abord être structurées:

- Nom : Alex
- Intérêts: ski, Python, poutine, café
- Adresse: Québec
- etc.

## Données & stockage
### Formats texte

Le format texte est la façon la plus simple de structurer et de présenter des données à l'ordinateur.

- JSON (exemple )
- XML
- CSV

#### JSON (JavaScript Object Notation)
- Format très léger et courrant en Web (ex.: requêtes REST).
- Les données sont structurées en les regroupant dans des accolades avec de l'indentation.
- Les listes sont supportées

```json
{
  "nom": "Alex",
  "age": 19,
  "programme": "Informatique",
  "ville": "Québec",
  "interets": ["ski", "Python", "poutine", "café"]
}
```

#### XML
- Les données sont encapsulées par des balises
- Traditionnellement utilisé en Web (ex.: requêtes SOAP)
- Aussi utilisé dans des fichiers de configuration (ex.: C#)

```xml
<etudiant>
  <nom>Alex</nom>
  <age>19</age>
  <programme>Informatique</programme>
  <ville>Québec</ville>
  <interets>
    <interet>ski</interet>
    <interet>Python</interet>
    <interet>poutine</interet>
    <interet>café</interet>
  </interets>
</etudiant>
```

#### CSV
- Données séparées par des virgules
- Se lit facilement avec Excel/Sheets
- Pas de structure imbriquée (supporte pas les listes).

```csv
nom,age,programme,ville,interets
Alex,19,Informatique,Québec,"ski;Python;poutine;café"
```

### Limites des fichiers
- Concurrence (plusieurs utilisateurs)
- Intégrité (données incohérentes)
- Performance (recherche, index)
- Sécurité (accès, audit)

>Ces formats permettent de stocker des données, mais ils deviennent rapidement limités dès qu’on a plusieurs utilisateurs, des recherches fréquentes ou des règles à respecter… d’où l’intérêt des bases de données.

## Types de bases de données
### Relationnelles vs non relationnelles

Lorsqu’on parle de bases de données, on distingue généralement **deux grandes familles** selon la façon dont les données sont **modélisées et organisées** :
- les bases de données **relationnelles**
- les bases de données **non relationnelles** (*NoSQL*)

---

### Bases de données relationnelles (SGBD)

Une base de données relationnelle organise les données sous forme de **tables liées entre elles par des relations**.

#### Caractéristiques
- Données stockées dans des **tables** (lignes et colonnes)
- Chaque table représente une **entité** (ex. : Étudiant, Cours, Inscription)
- Les tables sont reliées par des **clés** (clé primaire, clé étrangère)
- Structure **définie à l’avance** (schéma rigide)

#### Exemple conceptuel

**Table Étudiant**
| id | nom | programme |
|---|---|---|
| 1 | Alex | Informatique |
| 2 | Marthe | Histoire |

**Table Cours**
| id | nom |
|---|---|
| 1 | BD1 |
| 2 | Prog1 |

**Table Inscription**
| id | etudiant_id | cours_id |
|---|---|---|
| 1 | 1 | 1 |
| 2 | 1 | 2 |

>Une inscription relie un étudiant à un cours à l’aide d’une clé étrangère.

#### Exemples de SGBD relationnels
- MariaDB  
- MySQL  
- PostgreSQL  
- SQL Server  
- SQLite  

> Dans ce cours, nous utiliserons **MariaDB**, un SGBD libre et gratuit,
> issu du même projet d'origine que MySQL. Les deux partagent presque tout leur SQL.

#### Cas d’usage typiques
- Systèmes scolaires
- Gestion de comptes utilisateurs
- Facturation, inventaire
- Applications où l’**intégrité des données** est essentielle

---

### Bases de données non relationnelles (NoSQL)

Les bases non relationnelles ne reposent pas sur des tables liées par des clés.  
Elles privilégient une structure **plus flexible**, adaptée aux données qui évoluent souvent.

Il existe plusieurs types de bases non relationnelles. En voici deux principales.

---

#### 1) Bases orientées documents

Les données sont stockées sous forme de **documents**, souvent en JSON.

```json
{
  "nom": "Alex",
  "programme": "Informatique",
  "cours": ["BD1", "Programmation", "Réseaux"]
}
```
#### Cas d’usage typiques
- Systèmes scolaires
- Gestion de comptes utilisateurs
- Facturation, inventaire
- Applications où l’**intégrité des données** est essentielle

#### Cas d’usage
- Applications Web
- APIs
- Données semi-structurées

#### Exemples
- MongoDB
- CouchDB

#### 2) Bases clé–valeur

Les données sont stockées sous forme de **paires clé → valeur**.

```text
"user:123" → { "nom": "Alex", "role": "étudiant" }
```

#### Cas d’usage
- Cache
- Sessions utilisateur
- Données temporaires

#### Exemples
- Redis
- DynamoDB

## Vérification
### Cas 1 — Quel stockage choisir ?

Une application mobile permet à des étudiants de :
- consulter leur horaire
- s’inscrire à des cours
- voir leurs notes

Les données doivent :
- être **cohérentes** (pas d’inscription à un cours inexistant)
- gérer des **relations** (étudiants ↔ cours ↔ inscriptions)
- être **persistantes** et fiables

**Question :**  
Quel type de stockage est le plus approprié ?
- Fichier (JSON / CSV)
- Base de données relationnelle
- Base clé–valeur

---

### Cas 2 — Quel stockage choisir ?

Un site Web doit :
- mémoriser l’état de connexion des utilisateurs
- conserver ces données seulement quelques minutes
- offrir des accès **très rapides**
- ne pas nécessiter de relations complexes

**Question :**  
Quel type de stockage est le plus approprié ?
- Base de données relationnelle
- Base clé–valeur
- Fichier texte

<div class="my-6 rounded-lg border-2 border-red-500 bg-red-50 p-4 text-red-900">
  <strong class="block text-lg">🛑 STOP</strong>
  <p class="m-0">
    Avant de continuer, <strong>complétez le Laboratoire 1</strong>.
    Il contient <strong>toutes les installations requises</strong> pour la suite du cours.
  </p>

  [Aller au laboratoire 1](./../../labs/lab01-installations.md)
</div>


