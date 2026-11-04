---
title: Grille d'évaluation — TP3
aside: false
---

# Grille d'évaluation — Travail Pratique #3

Le TP3 vaut **15 %** : la partie 1 (à la maison) compte pour **10 %**, la partie 2 (en classe,
supervisée) pour **5 %**. Chaque partie est notée sur 100, puis ramenée à son poids.

Chaque question est évaluée selon trois niveaux :

| Niveau | Description | Note |
|---|---|---|
| **Complet** | L'instruction s'exécute et fait exactement ce qui est demandé : lignes, colonnes, ordre, noms. | 100 % |
| **Partiel** | La logique est bonne, mais il manque un détail (voir les critères de chaque question). | 60 % |
| **Nul** | L'instruction ne s'exécute pas, ou ne répond pas à la demande. | 0 % |

---

## Partie 1 — à la maison (10 %)

### A. Expressions régulières (25 points — 6,25 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **1** Codes non conformes | Motif ancré (`^…$`), sensible à la casse (`(?-i)`), négation correcte. | Motif non ancré, ou casse ignorée (le code en minuscules passe pour conforme). |
| **2** Courriels invalides | Motif ancré, un seul `@`, extension d'au moins deux lettres, point échappé (`\\.`). | Point non échappé, extension d'une lettre acceptée, tri absent. |
| **3** Téléphones nettoyés | Filtre `regexp` sur un caractère non numérique; `regexp_replace` retire tous les séparateurs; alias. | Un séparateur oublié (espace, parenthèse), filtre absent. |
| **4** Extraction dans les incidents | Deux `regexp_substr` corrects, filtre sur `critique`, alias, tri. | Un des deux motifs imprécis (extrait un code malformé, ou `SC-` non exigé). |

### B. Jointures (25 points — 6,25 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **5** Billets non conformes et revendeur | Deux jointures correctes, filtre de la question 1 réutilisé, alias de table. | Colonne manquante, tri absent, alias de colonne `nom` ambigu. |
| **6** Programmation du samedi | Trois tables jointes, intervalle couvrant **toute** la journée. | Borne d'intervalle qui coupe des spectacles en soirée. |
| **7** Scans refusés | Quatre tables jointes; le festivalier est celui **du billet**. | Colonne ou tri manquant. |
| **8** Tous les artistes | `left join` sur `spectacle` **et** sur `scene` : les deux artistes sans spectacle apparaissent. | Le second `inner join` fait disparaître les artistes sans spectacle. |

### C. Agrégations et groupements (25 points — 6,25 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **9** Ventes par revendeur | `left join`, `count(b.id)` (0 pour Lumen Billets), `sum`, `round(avg(…), 2)`, tri. | `count(*)` qui donne 1 au revendeur sans vente, ou revendeur absent. |
| **10** Statistiques par catégorie | Quatre agrégats, arrondi, tri. | Arrondi ou alias manquant. |
| **11** Scènes avec au moins 3 refus | `where` sur le résultat **avant** le regroupement, `having count(*) >= 3`. | Seuil `> 3`, ou `group by` incomplet. |
| **12** Codes en double | `group by code` et `having count(*) > 1`. | Tri ou alias manquant. |

### D. Sous-requêtes corrélées (25 points — 8,33 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **13** Prix sous 75 % de la moyenne | Sous-requête corrélée sur la **catégorie**. | Moyenne de tous les billets (non corrélée) : la logique est fausse → **Nul**. |
| **14** Jamais acceptés | `exists` **et** `not exists`, corrélés sur le festivalier. | Seulement l'une des deux conditions (inclut les festivaliers jamais scannés). |
| **15** Codes partagés | `exists` corrélé sur le code **avec un `id` différent**. | Condition sur l'`id` oubliée : tous les billets sortent → **Nul**. |

### Conclusion de l'enquête

Non notée, mais obligatoire : une conclusion absente entraîne une pénalité de 5 %.

---

## Partie 2 — en classe, supervisée (5 %)

Les instructions doivent s'exécuter **dans l'ordre**. Une instruction qui échoue à cause d'une
question précédente ratée n'est pas pénalisée deux fois : on corrige la logique de chaque
réponse.

### A. Modifier la structure (20 points — 5 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **1** Colonne `actif` | `alter table … add column`, `not null`, `default true`. | `not null` ou `default` manquant. |
| **2** Désactiver Billets Éclair | `update` filtré sur le nom, une seule ligne. | — |
| **3** Agrandir le courriel | `modify column … varchar(150) not null`. | `not null` perdu (la colonne devient nullable). |
| **4** Renommer `duree` | `rename column` ou `change column` avec le type complet. | `change column` sans `not null`. |

### B. Nettoyer et verrouiller les billets (35 points — 7 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **5** Cascade | `drop foreign key scan_billet_fk` puis `add constraint scan_billet_fk … on delete cascade`. | Nom différent, ou `on update cascade` au lieu de `on delete`. |
| **6** Supprimer les billets d'Éclair | `delete` avec une sous-requête sur le nom du revendeur : 13 billets. | `id` codé en dur. |
| **7** Unicité du code | `add constraint billet_code_uq unique (code)`. | Nom inexact. |
| **8** Format du code | `check` avec `regexp`, motif ancré et `(?-i)`, nom exact. | Casse non exigée, motif non ancré, nom inexact. |
| **9** Index | `create index scan_date_heure_idx on scan (date_heure)`. | Nom inexact. |

### C. Mots de passe (20 points — 10 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **10** Hachage | Deux colonnes ajoutées, sel par revendeur, `sha2(concat(sel, mot_de_passe), 256)`, colonne en clair supprimée. | Hachage sans sel, ou colonne en clair conservée. |
| **11** Vérification | Le hachage est recalculé **avec le sel de la ligne** et comparé : 1 ligne. | Mot de passe comparé en clair → **Nul**. |

### D. Comptes et privilèges (25 points — 6,25 par question)

| Question | Complet si… | Exemples de « Partiel » |
|---|---|---|
| **12** `analyste` | `create user 'analyste'@'localhost'`, `grant select on festival_boreal.*`. | Hôte manquant (`'analyste'@'%'`). |
| **13** `agent_acces` | Privilèges **par table** : `select` sur `billet`, `select, insert` sur `scan`. | Droits accordés sur toute la base. |
| **14** `admin_festival` | `grant all privileges on festival_boreal.*`. | `on *.*` (tout le serveur) → **Nul** : contraire au moindre privilège. |
| **15** Retrait et vérification | `revoke insert on festival_boreal.scan`, puis `show grants for 'agent_acces'@'localhost'`. | `show grants` manquant. |

---

## Pénalités — Respect des consignes

| Cas | Impact |
|---|---|
| Retard dans la remise de la partie 1 | −10 % par jour (maximum −30 %) |
| Fichier de réponses non utilisé, ou ordre des requêtes modifié | −5 % |
| Notion non vue au cours, sans validation de l'enseignant | −5 % par occurrence (maximum −30 %) |
| Utilisation non autorisée d'une source externe ou plagiat | 0 % au travail |
