---
title: "04 — Opérateurs et filtres"
aside: false
---

# 04 — Opérateurs et filtres SQL

## Objectif
- Combiner des conditions avec `and`, `or`, `not`
- Filtrer des données avec `like`, `between`, `in`
- Éliminer les doublons avec `distinct`
- Lire et écrire des requêtes plus proches de la réalité applicative

---

## Rappel — `where`

Les opérateurs vus dans ce module sont utilisés **principalement dans la clause `where`** afin de filtrer les lignes retournées ou modifiées.

---

## AND — Toutes les conditions doivent être vraies

### Principe
`and` permet de combiner plusieurs conditions qui doivent **toutes** être respectées.

### Exemple — Événements à Paris avec grande capacité

```sql
select *  
from evenement  
where lieu = 'Paris'  
and capacite >= 300;
```

---

## OR — Au moins une condition vraie

### Principe
`or` permet de sélectionner les lignes qui respectent **au moins une** des conditions.

### Exemple — Événements à Paris ou à Lyon

```sql
select *  
from evenement  
where lieu = 'Paris'  
or lieu = 'Lyon';
```

---

## ⚠️ AND + OR — Attention aux priorités

### Exemple — Événements à Paris ou Lyon, mais seulement en 2026

```sql
select *  
from evenement  
where (lieu = 'Paris' or lieu = 'Lyon')  
and date_evenement between '2026-01-01' and '2026-12-31';
```

➡️ Sans les parenthèses, le résultat serait différent.

---

## NOT — Exclure des résultats

### Principe
`not` inverse une condition.

### Exemple — Participants qui ne sont pas actifs

```sql
select *  
from participant  
where not actif;
```

---

### Exemple — Événements qui ne sont pas à Paris

```sql
select *  
from evenement  
where not lieu = 'Paris';
```

---

## LIKE — Recherche par motif (texte)

### Principe
`like` permet de rechercher des chaînes de caractères similaires.

- `%` : n'importe quelle suite de caractères (y compris zéro caractère)
- `_` : exactement un seul caractère

### Emplacement des caractères jokers

L'emplacement des `%` et `_` détermine le comportement de la recherche :

- **`%texte`** : commence par n'importe quoi, se termine par "texte"
- **`texte%`** : commence par "texte", se termine par n'importe quoi  
- **`%texte%`** : contient "texte" n'importe où
- **`_%`** : au moins un caractère (n'importe lequel)
- **`__`** : exactement deux caractères

### Exemple — Événements contenant le mot "Conférence"

```sql
select *  
from evenement  
where nom like '%Conférence%';
```

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>⚠️ En MariaDB, <code>like</code> ignore la casse <em>et</em> les accents</strong><br>
La collation par défaut (<code>utf8mb4_uca1400_ai_ci</code>) est <em>accent insensitive</em> et
<em>case insensitive</em>. Ces trois écritures retournent donc <strong>exactement les mêmes
lignes</strong> :<br>
<code>like '%Conférence%'</code> · <code>like '%conférence%'</code> ·
<code>like '%conference%'</code><br><br>
C'est pratique pour une recherche, mais ce n'est <strong>pas</strong> le comportement de tous
les SGBD : ailleurs (PostgreSQL, Oracle), <code>like</code> est sensible à la casse et aux
accents. Ne comptez pas là-dessus dans du code qui doit être portable.<br><br>
Pour une comparaison stricte, on ajoute <code>binary</code>, qui compare octet par octet :<br>
<code>where nom like binary '%Conférence%'</code>
</div>

---

### Exemple — Courriels se terminant par `example.com`

```sql
select *  
from participant  
where courriel like '%@example.com';
```

---

## BETWEEN — Intervalle de valeurs

### Principe
`between` permet de sélectionner une plage de valeurs **inclusive**.

### Exemple — Événements prévus à l’été 2026

```sql
select *  
from evenement  
where date_evenement between '2026-06-01' and '2026-08-31';
```

---

### Exemple — Événements avec capacité moyenne

```sql
select *  
from evenement  
where capacite between 100 and 300;
```

---

## IN — Appartenance à une liste

### Principe
`in` permet de tester si une valeur appartient à une liste donnée.

### Exemple — Événements dans certaines villes

```sql
select *  
from evenement  
where lieu in ('Paris', 'Lyon', 'Marseille');
```

---

### Exemple — Participants spécifiques (par id)

```sql
select *  
from participant  
where id in (1, 5, 10);
```

---

## Distinct — Éliminer les doublons

### Principe
`distinct` permet de ne retourner que des valeurs **uniques**.

### Exemple — Liste des villes où ont lieu des événements

```sql
select distinct lieu  
from evenement;
```

---

### Exemple — Liste des participants ayant au moins une inscription

```sql
select distinct participant_id  
from inscription;
```

---

## Exemple intégratif

### Exemple — Événements à Paris ou Lyon, hors ateliers, en 2026

```sql
select *  
from evenement  
where (lieu in ('Paris', 'Lyon'))  
and not nom like '%Atelier%'  
and date_evenement between '2026-01-01' and '2026-12-31';
```

---

## À retenir

- `and` : toutes les conditions
- `or` : au moins une condition
- `not` : exclusion
- `like` : recherche textuelle
- `between` : intervalle inclusif
- `in` : liste de valeurs
- `distinct` : suppression des doublons
- Les parenthèses sont **essentielles** avec `and` / `or`
