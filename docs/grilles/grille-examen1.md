---
title: Grille d'évaluation — Examen 1
---

# Grille d'évaluation — Examen 1

Examen **sur papier**, en classe. Matière : **modules 1 à 3** (modélisation, DDL, SQL).

| Partie | Matière | Points |
|---|---|---:|
| 1 | Modélisation | 30 |
| 2 | DDL | 30 |
| 3 | SQL | 40 |
| | **Total** | **100** |

## Échelle d'évaluation

| Niveau | Valeur |
|---|---|
| Excellent | 100 % |
| Suffisant | 70 % |
| Insuffisant | 40 % |
| Incorrect | 0 % |

## Correction sur papier

Le code étant écrit à la main, il n'est pas exécuté. La correction porte sur la **logique** et
sur la **syntaxe enseignée**, avec la distinction suivante :

| Type d'écart | Traitement |
|---|---|
| Point-virgule final, indentation, majuscules/minuscules des mots-clés | Non pénalisé |
| Nom de colonne approximatif mais sans ambiguïté (`date_spect.` pour `date_spectacle`) | Non pénalisé |
| Mot-clé manquant ou mal placé qui empêcherait l'exécution (`from`, `where`, virgule entre colonnes) | Pénalisé — descendre d'un niveau |
| Erreur de logique (mauvais filtre, mauvaise table, `and` au lieu de `or`) | Pénalisé selon la grille |
| Syntaxe d'un autre SGBD (`serial`, `create type … as enum`, `ilike`, `~`) | Pénalisé — descendre d'un niveau |

---

## Partie 1 — Modélisation (30 pts)

### Q1 — Repérer les clés d'un modèle (8 pts)

| Niveau | Description |
|---|---|
| Excellent | Toutes les PK et les FK identifiées. Chaque FK est rattachée à la bonne table référencée. |
| Suffisant | Toutes les PK identifiées; une FK manquante ou rattachée à la mauvaise table. |
| Insuffisant | Confusion entre PK et FK, ou plusieurs clés omises. |
| Incorrect | Les clés ne sont pas repérées. |

---

### Q2 — Déterminer et justifier les cardinalités (12 pts)

| Niveau | Description |
|---|---|
| Excellent | Chaque relation est correctement qualifiée (1–N, N–N) et justifiée par un exemple concret dans les deux sens. |
| Suffisant | Cardinalités correctes mais justification absente ou donnée dans un seul sens. |
| Insuffisant | Une cardinalité sur deux est correcte, ou la table associative n'est pas reconnue comme telle. |
| Incorrect | Cardinalités majoritairement erronées. |

---

### Q3 — Interpréter le modèle (10 pts)

| Niveau | Description |
|---|---|
| Excellent | La table qui représente une action est reconnue et expliquée. L'emplacement de chaque information demandée est correctement localisé, y compris l'information qui **ne se stocke pas** parce qu'elle se calcule. |
| Suffisant | Localisations correctes, mais l'information calculée est présentée comme une colonne à stocker. |
| Insuffisant | Plusieurs informations mal localisées. |
| Incorrect | Le modèle n'est pas interprété. |

---

## Partie 2 — DDL (30 pts)

### Q4 — Identifier et corriger les erreurs d'un script (14 pts)

Pour chaque erreur, l'étudiant indique la ligne, explique pourquoi c'est une erreur et écrit
la correction.

| Niveau | Description |
|---|---|
| Excellent | Au moins huit erreurs sont relevées; chacune est **expliquée** (pourquoi le script échoue ou pourquoi le choix est mauvais) et accompagnée d'une **correction** valide en MariaDB (`use` ajouté, ordre de création, type de FK identique à la PK, `enum` dans la colonne, `auto_increment` sur une clé…). |
| Suffisant | Six ou sept erreurs relevées et corrigées, ou huit relevées mais avec des explications superficielles ou des corrections absentes ou inexactes. |
| Insuffisant | Cinq erreurs ou moins, ou erreurs relevées sans explication ni correction. |
| Incorrect | Les erreurs ne sont pas identifiées. |

---

### Q5 — Écrire un `create table` complet (16 pts)

| Niveau | Description |
|---|---|
| Excellent | Clé primaire auto-incrémentée. Types appropriés à la nature de chaque donnée. Contraintes pertinentes (`not null`, `unique`, `check`, valeur par défaut), y compris un `unique` sur une paire de colonnes lorsque la règle porte sur une combinaison. Clé étrangère correctement déclarée et du bon type. |
| Suffisant | Table fonctionnelle, mais un type discutable ou une contrainte pertinente omise. |
| Insuffisant | Table créée, mais clé primaire ou clé étrangère absente ou mal déclarée. |
| Incorrect | Instruction non fonctionnelle ou absente. |

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Sur le choix des types</strong><br>
Un type est « approprié » s'il correspond à l'usage réel de la donnée, pas seulement à son
apparence. Un numéro sur lequel on ne calcule jamais et qui peut commencer par un zéro est une
chaîne, pas un entier — c'est ce raisonnement qui est évalué, et il doit pouvoir être justifié.
</div>

---

## Partie 3 — SQL (40 pts)

### Q6 — Insertion (6 pts)

| Niveau | Description |
|---|---|
| Excellent | Colonnes listées explicitement. Valeurs dans le bon ordre et du bon type. Les colonnes automatiques ou à valeur par défaut sont omises à bon escient. Insertion multiple en une seule instruction là où c'est demandé. |
| Suffisant | Insertion valide, mais colonnes non listées, ou une colonne à valeur par défaut fournie inutilement. |
| Insuffisant | Insertion tentée mais nombre de valeurs ne correspondant pas aux colonnes, ou types incompatibles. |
| Incorrect | Aucune insertion fonctionnelle. |

---

### Q7 — Prédire le résultat de requêtes (8 pts)

| Niveau | Description |
|---|---|
| Excellent | Les lignes retournées sont exactes pour chaque requête, y compris l'ordre lorsqu'un `order by` est présent. Les cas liés à la collation (casse et accents ignorés) sont traités correctement. |
| Suffisant | Une requête sur quatre est mal évaluée, ou l'ordre est ignoré. |
| Insuffisant | La moitié des requêtes est mal évaluée, ou les bornes de `between` et l'effet de `distinct` ne sont pas maîtrisés. |
| Incorrect | Les résultats annoncés ne correspondent pas aux données. |

---

### Q8 — Sélection et filtres (10 pts)

| Niveau | Description |
|---|---|
| Excellent | Colonnes demandées exactement. Filtres corrects, y compris les opérateurs (`between`, `in`, `like`, `not`, `and`/`or`). Tri conforme à l'énoncé. `distinct` employé là où des doublons sont attendus. |
| Suffisant | Requêtes fonctionnelles, mais tri absent, colonne superflue, ou borne d'intervalle inexacte. |
| Insuffisant | Logique de filtre majoritairement incorrecte, ou `and`/`or` intervertis. |
| Incorrect | Requêtes non fonctionnelles. |

---

### Q9 — Sous-requête non corrélée (8 pts)

| Niveau | Description |
|---|---|
| Excellent | Sous-requête placée dans le `where` et retournant **une seule colonne**. Opérateur approprié (`in`, `not in`, `any`, `all`). Résultat conforme à la demande. |
| Suffisant | Logique correcte, mais opérateur mal choisi (ex. `in` là où `not in` est attendu) ou sous-requête retournant plus d'une colonne. |
| Insuffisant | Sous-requête tentée mais reliée à la mauvaise clé, donc ciblant les mauvaises lignes. |
| Incorrect | Aucune sous-requête, ou requête non fonctionnelle. |

---

### Q10 — Mise à jour et suppression ciblées (8 pts)

| Niveau | Description |
|---|---|
| Excellent | `where` présent et ciblant exactement les lignes demandées. Aucune ligne non visée ne serait affectée. Sous-requête employée là où elle est exigée. |
| Suffisant | Ciblage correct mais imprécis : le filtre affecterait quelques lignes de plus que demandé. |
| Insuffisant | `update` ou `delete` structurellement correct mais ciblant les mauvaises lignes. |
| Incorrect | Instruction sans `where`, ou non fonctionnelle. |

<div class="my-6 rounded-lg border border-red-300 bg-red-50 p-4 text-red-900">
<strong>Cas particulier</strong><br>
Un <code>update</code> ou un <code>delete</code> <strong>sans clause <code>where</code></strong>
affecterait toute la table : la question est cotée <strong>Incorrect</strong>, même si le reste
de l'instruction est bien écrit.
</div>
