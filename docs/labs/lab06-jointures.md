---
title: "Lab 06 — Jointures"
aside: false
---

# Lab 06 — Jointures

## Travail à réaliser

### Base de données à utiliser (Chinook)

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>
Ce laboratoire utilise la base de données <strong>Chinook</strong>.<br>
Si vous ne l'avez pas encore importée, référez-vous aux instructions du module :
<a href="../modules/04-jointures-agregations/02-jointures#base-de-donnees-de-test-a-importer-chinook">Importer Chinook</a>
</div>

Créez un nouveau script SQL dans DBeaver et **commencez-le par son `use`** :

```sql
use chinook;
```

---

## 1 — De la sous-requête à la jointure

Dans la partie précédente du cours, vous avez utilisé des sous-requêtes non corrélées pour **filtrer** des données.
Mais une sous-requête ne permet pas d'**afficher** les colonnes des deux tables en même temps — pour ça, il faut utiliser une jointure.

### a) Transformer en jointure

Les requêtes suivantes utilisent une sous-requête. Pour chacune, réécrivez-la avec un `join` de façon à afficher les colonnes des **deux** tables indiquées.

**Requête 1 :**

> Obtenir les `piste_id` des pistes qui appartiennent à un album de l'artiste **'Led Zeppelin'** :
> ```sql
> select piste_id
> from piste
> where album_id in (
>     select album_id from album
>     where artiste_id = (
>         select artiste_id from artiste where nom = 'Led Zeppelin'
>     )
> );
> ```
> Réécrivez cette requête avec des jointures pour afficher : le **nom de la piste**, le **titre de l'album** et le **nom de l'artiste**.

**Requête 2 :**

> Obtenir les clients qui ont au moins une facture :
> ```sql
> select c.client_id, c.prenom, c.nom_famille 
>from client c
>where c.client_id in (
>	select f.client_id 
>	from facture f 
>);
> ```
> Réécrivez avec un `join` pour afficher : le **prénom**, le **nom de famille** des clients, ainsi que le **numéro de facture (`facture_id`)** et la **date de facturation**. Triez par prénom de client et par date de facturation décroissante.

---

## 2 — Inner join

### a) Requêtes simples

1) Afficher le **titre de chaque album** ainsi que le **nom de l'artiste** correspondant. Trier par nom d'artiste, puis par titre d'album.
2) Afficher le **nom de chaque liste de lecture** et les **noms des pistes** qu'elle contient. Trier par nom de liste de lecture, puis par nom de piste. *(Indice : la table `liste_lecture_piste` fait le lien entre les deux)*

### b) Avec un filtre `where`

1) Afficher le **nom des pistes** et le **titre de l'album** pour toutes les pistes de l'album **'Nevermind'**.
2) Afficher le **prénom et nom du client**, le **numéro de facture** et la **date** pour toutes les factures du client **'Frank Harris'**.
3) Afficher le **nom des pistes** et leur **prix** pour les pistes du genre **'Jazz'**. Trier par prix décroissant.

---

## 3 — Left join

### Employés et leur superviseur

Dans Chinook, chaque employé peut avoir un superviseur — mais pas nécessairement (le grand patron n'en a pas). La colonne `superviseur_id` dans `employe` référence un autre employé.

Afficher le **prénom de chaque employé** ainsi que le **prénom de son superviseur**. Afficher `NULL` si l'employé n'a pas de superviseur. Trier par nom de superviseur.

---

## 4 — Transformer un `right join` en `left join`

La requête suivante répond à la question : **Afficher tous les employés (représentants), même ceux qui n'ont aucun client assigné, avec le prénom du client s'il existe.**

```sql
select r.prenom représentant, c.prenom client
from client c
right join employe r
    on c.representant_id = r.employe_id
order by r.prenom, c.prenom;
```

- Réécrivez cette requête en utilisant un `left join` à la place, de façon à obtenir **exactement le même résultat**.

---

## 5 — Expressions régulières (rappel) avec jointures

L'opérateur `regexp` permet de filtrer avec une **expression régulière** en MariaDB. Il s'utilise dans le `where`, comme `like`, mais avec la syntaxe regex.

```sql
-- Exemple : pistes dont le nom commence par un chiffre
select nom from piste where nom regexp '^[0-9]';
```

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Rappels MariaDB</strong><br>
- <code>regexp</code> ignore la casse : <code>[aeiou]</code> trouve aussi les majuscules.<br>
- Un antislash doit être doublé dans le motif : <code>'\\d'</code>, <code>'\\.'</code>. Sinon, MariaDB le retire sans avertissement.<br>
Détails : <a href="../modules/04-jointures-agregations/01-expressions-regulieres#utilisation-avec-mariadb">Utilisation avec MariaDB</a>
</div>

### Requêtes à écrire

- Afficher le **nom des pistes** et le **titre de l'album** pour les pistes dont le nom **commence par un chiffre**.
- Afficher le **nom des artistes** dont le nom **contient un nombre** (un ou plusieurs chiffres consécutifs).
- Afficher le **prénom et nom des clients** ainsi que leur **pays**, pour les clients dont le courriel **se termine par `.com`** (en utilisant une regex).
- Afficher le **nom des pistes** et le **nom de l'artiste** pour les pistes dont le nom **ne contient pas de voyelle**. Trier par nom de piste.

---

## 6 — Jointures multi-tables

- Afficher, pour chaque piste vendue : le **nom de la piste**, le **titre de l'album**, le **nom de l'artiste**, la **quantité** vendue et le **prix unitaire**. Trier par nom d'artiste.
- Afficher le **prénom et nom du client**, la **date de la facture** et le **nom des pistes** achetées pour toutes les factures de **2010**. Trier par nom de client, puis par date.

<details class="mt-6">
<summary class="cursor-pointer font-semibold text-red-700">
⚠️ Corrigé — À consulter seulement après avoir fait l'exercice
</summary>

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4 mt-4">
<strong>Important</strong><br>
Assurez-vous d'avoir <strong>complété l'exercice</strong> ou, au minimum, d'avoir
<strong>tenté sérieusement chacune des étapes</strong> avant de consulter le corrigé.<br><br>
Le nombre de lignes indiqué sous chaque requête vous permet de vérifier votre propre résultat.
Une autre écriture est correcte si elle retourne les mêmes lignes.
</div>

---

### 1 — De la sous-requête à la jointure

**Requête 1** — 114 lignes, comme la requête originale.

```sql
select p.nom piste, al.titre album, ar.nom artiste
from piste p
join album al on p.album_id = al.album_id
join artiste ar on al.artiste_id = ar.artiste_id
where ar.nom = 'Led Zeppelin';
```

**Requête 2** — 405 lignes.

```sql
select c.prenom, c.nom_famille, f.facture_id, f.date_facture
from client c
join facture f on c.client_id = f.client_id
order by c.prenom, f.date_facture desc;
```

La requête originale retourne 58 lignes, soit une par client. La jointure en retourne une par
**facture** : un client apparaît autant de fois qu'il a de factures.

---

### 2 — Inner join

**a) 1** — 347 lignes.

```sql
select al.titre, ar.nom artiste
from album al
join artiste ar on al.artiste_id = ar.artiste_id
order by ar.nom, al.titre;
```

**a) 2** — 8715 lignes.

```sql
select ll.nom liste_lecture, p.nom piste
from liste_lecture ll
join liste_lecture_piste llp on ll.liste_lecture_id = llp.liste_lecture_id
join piste p on llp.piste_id = p.piste_id
order by ll.nom, p.nom;
```

**b) 1** — 12 lignes.

```sql
select p.nom piste, al.titre album
from piste p
join album al on p.album_id = al.album_id
where al.titre = 'Nevermind';
```

**b) 2** — 7 lignes.

```sql
select c.prenom, c.nom_famille, f.facture_id, f.date_facture
from client c
join facture f on c.client_id = f.client_id
where c.prenom = 'Frank' and c.nom_famille = 'Harris';
```

**b) 3** — 130 lignes.

```sql
select p.nom, p.prix_unitaire
from piste p
join genre g on p.genre_id = g.genre_id
where g.nom = 'Jazz'
order by p.prix_unitaire desc;
```

Toutes ces pistes coûtent 0,99 $ : le tri est correct, même s'il ne change rien de visible ici.

---

### 3 — Left join

8 lignes, dont une avec `NULL` : Andrew, le grand patron.

```sql
select e.prenom employe, s.prenom superviseur
from employe e
left join employe s on e.superviseur_id = s.employe_id
order by s.nom_famille;
```

La table est jointe à elle-même : les alias `e` et `s` sont donc obligatoires. Un `join` simple
ferait disparaître Andrew. En tri croissant, MariaDB place les `NULL` en premier.

---

### 4 — Transformer un `right join` en `left join`

60 lignes, dont 5 employés sans client.

```sql
select r.prenom représentant, c.prenom client
from employe r
left join client c
    on c.representant_id = r.employe_id
order by r.prenom, c.prenom;
```

Il suffit d'inverser l'ordre des tables : celle dont on veut garder toutes les lignes (`employe`)
passe à gauche du `join`.

---

### 5 — Expressions régulières avec jointures

**Le nom de la piste commence par un chiffre** — 35 lignes.

```sql
select p.nom piste, al.titre album
from piste p
join album al on p.album_id = al.album_id
where p.nom regexp '^[0-9]';
```

**Le nom de l'artiste contient un nombre** — 3 lignes : U2, UB40 et The 12 Cellists of The Berlin Philharmonic.

```sql
select nom
from artiste
where nom regexp '[0-9]+';
```

Aucune jointure n'est nécessaire ici. Le motif `'[0-9]'` donne le même résultat : dès qu'il y a un
nombre, il y a au moins un chiffre.

**Le courriel se termine par `.com`** — 22 lignes.

```sql
select prenom, nom_famille, pays
from client
where courriel regexp '\\.com$';
```

L'antislash est doublé pour désigner un vrai point. Sans lui, `'.com$'` retourne aussi 22 lignes
dans Chinook, mais le point y signifie « n'importe quel caractère » : le motif accepterait
aussi `xcom`.

**Le nom de la piste ne contient pas de voyelle** — 13 lignes.

```sql
select p.nom piste, ar.nom artiste
from piste p
join album al on p.album_id = al.album_id
join artiste ar on al.artiste_id = ar.artiste_id
where p.nom not regexp '[aeiou]'
order by p.nom;
```

Deux cas à remarquer dans le résultat :

- `Gypsy` y figure parce que le `y` n'est pas dans le motif. Avec `'[aeiouy]'`, il reste 11 lignes.
- `Já!!!` y figure parce que `regexp` ne reconnaît pas `á` comme un `a` : il ignore la casse, mais
  pas les accents.

---

### 6 — Jointures multi-tables

**Pistes vendues** — 2202 lignes, une par ligne de facture.

```sql
select p.nom piste, al.titre album, ar.nom artiste, lf.quantite, lf.prix_unitaire
from ligne_facture lf
join piste p on lf.piste_id = p.piste_id
join album al on p.album_id = al.album_id
join artiste ar on al.artiste_id = ar.artiste_id
order by ar.nom;
```

Le prix unitaire vient de `ligne_facture` : c'est le prix payé au moment de la vente. La table
`piste` a aussi une colonne `prix_unitaire`, d'où l'importance de préfixer les colonnes.

**Factures de 2010** — 443 lignes.

```sql
select c.prenom, c.nom_famille, f.date_facture, p.nom piste
from client c
join facture f on c.client_id = f.client_id
join ligne_facture lf on f.facture_id = lf.facture_id
join piste p on lf.piste_id = p.piste_id
where year(f.date_facture) = 2010
order by c.nom_famille, f.date_facture;
```

</details>