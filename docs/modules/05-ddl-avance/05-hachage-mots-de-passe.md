---
title: "05 — Hachage des mots de passe"
aside: true
---

# 05 — Hachage des mots de passe

## Objectif

Comprendre pourquoi on ne doit pas stocker un mot de passe en clair, puis voir une manière simple de stocker et vérifier un **hachage** dans MariaDB.

## Démo rapide

Avant de passer à PostgreSQL, vous pouvez visualiser le principe avec l'outil [bcrypt-generator.com](https://bcrypt-generator.com/).

Ce site permet :
- de générer un hachage `bcrypt` (bibliothèque populaire)
- de vérifier si un texte correspond à un hachage (à des fins de démonstration)

## L'essentiel à connaître

Un mot de passe ne devrait jamais être enregistré tel quel dans une table.

Le bon réflexe est :
- stocker un **hachage**
- utiliser un **sel** (une valeur unique ajoutée au mot de passe)
- comparer le mot de passe saisi avec le hachage stocké

Idée générale :
- l'utilisateur saisit un mot de passe
- le système calcule un hachage sécurisé
- seule la valeur hachée est conservée

Ainsi, si la table est exposée, on ne révèle pas directement les mots de passe.

## Pourquoi éviter le texte clair

Si une table contient ceci :

```text
alice | 123456
bob   | azerty
carol | motdepasse
```

alors une fuite de données compromet immédiatement tous les comptes.

Avec un hachage, la valeur stockée ressemble plutôt à une empreinte difficile à réutiliser directement.

Important :
- un hachage n'est pas un chiffrement
- on ne "décrypte" pas un hachage
- on vérifie plutôt si une nouvelle saisie produit un résultat compatible

## Hachage et salage

### Le hachage

Le **hachage** transforme une valeur en une empreinte.

Pour les mots de passe, on veut une fonction :
- lente par rapport à un hachage classique
- conçue pour résister aux attaques par force brute

### Le sel

Le **sel** est une valeur ajoutée au mot de passe avant le hachage.

Il permet notamment :
- d'éviter que deux utilisateurs ayant le même mot de passe aient la même valeur stockée
- de rendre moins efficaces les tables précalculées

Ainsi, `bonjour123` ne produira pas exactement le même hachage pour Alice et pour Bob si le sel est différent.

Exemple d'idée :

```text
Mot de passe saisi : bonjour123

Alice -> sel différent -> hachage A
Bob   -> autre sel     -> hachage B
```

Même si le mot de passe de départ est identique, le résultat stocké change parce que le sel change.

## Approche simple

### Fonctions de hachage intégrées

MariaDB inclut déjà des fonctions permettant de produire des hachages.

### Exemple de table `utilisateur`

```sql
create table utilisateur(
    id int auto_increment primary key,
    courriel varchar(255) not null unique,
    mot_de_passe_hache varchar(255) not null,
    cree_le timestamp default current_timestamp
);
```

### Exemple d'insertion

Lors d'une nouvelle insertion, on peut utiliser la fonction SHA2 pour produire un hachage.

```sql
insert into utilisateur (courriel, mot_de_passe_hache)
values (
    'alice@exemple.com',
    sha2('Bonjour123!', 256)
);
```

### Exemple de tentative de connexion

Si la requête retourne une ligne, cela signifie que la combinaison `courriel` + `mot de passe` était valide.

```sql
select id, courriel
from utilisateur
where courriel = 'alice@exemple.com'
  and mot_de_passe_hache = sha2('Bonjour123!', 256);
```

Lors d'une connexion, on ne compare pas avec le mot de passe en clair.

On compare plutôt :

- le mot de passe saisi
- avec la valeur hachée déjà stockée

---

### En pratique dans une vraie application

Dans beaucoup de projets, le hachage est souvent fait :

- dans l'application avant d'envoyer la requête vers la base de données
- avec une bibliothèque spécialisée

C'est une meilleure pratique.

Exemples courants :

- `bcrypt`
- `scrypt`
- `Argon2`

## À retenir

- un mot de passe doit être stocké sous forme hachée, pas en clair
- le sel améliore la sécurité du stockage
- dans MariaDB, des fonctions comme SHA2() permettent de faire une démonstration simple du hachage
- on peut simuler une connexion utilisateur en recalculant le mot de passe saisi et en le comparant à la valeur stockée dans la table

---

### Sources

- [MariaDB Documentation — SHA2](https://mariadb.com/kb/en/sha2/)
- [OWASP — Password Storage Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)
