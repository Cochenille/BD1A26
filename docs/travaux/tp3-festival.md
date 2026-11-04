---
title: "TP3 — Les billets fantômes du Festival Boréal"
aside: false
---

# Travail Pratique #3 — Les billets fantômes du Festival Boréal (15 %)

Le TP3 se fait en **deux parties** :

| | Où | Quand | Poids |
|---|---|---|---|
| **Partie 1** | à la maison | remise le **26 novembre, en début de période** | 10 % |
| **Partie 2** | en classe, supervisée | **3 décembre**, en début de période | 5 % |

- Modalité : individuel.
- Remise de la partie 1 : fichier `.sql` sur LÉA dans le travail concerné.
- Retards : -10 % par jour (max 3 jours). La partie 2 ne peut pas être reprise.

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>
Vous devez <strong>obligatoirement</strong> écrire votre code <code>sql</code> dans le fichier de
départ suivant. Renommez-le <code>tp3_prenom_nom.sql</code>.<br>
<a href="./../databases/tp3_reponses_depart.sql" target="_blank" rel="noopener">Fichier de réponses à télécharger</a>
</div>

---

## Contexte

Du 10 au 12 juillet 2026, le **Festival Boréal** a accueilli des milliers de festivaliers sur
ses scènes au bord du lac. Les billets étaient vendus par la billetterie officielle et par
quelques revendeurs partenaires. À l'entrée de chaque scène, un agent scannait le code du billet.

Le samedi soir, juste avant la tête d'affiche, la file d'attente s'est mise à déborder : des
lecteurs refusaient des billets, des festivaliers juraient avoir payé, et au moins une
personne s'est fait dire que son billet — acheté en mars — *avait déjà servi*.

Le festival vous confie les données de la fin de semaine. Votre mandat : **trouver d'où viennent
les billets fantômes**, mesurer les dégâts et identifier les festivaliers lésés.

---

## Préparation — importer la base

Téléchargez le script, ouvrez-le dans DBeaver (`Fichier` → `Ouvrir un fichier…`) et exécutez
tout le script avec `Alt + X`, puis rafraîchissez avec `F5`.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Base de données — à exécuter en premier</strong><br>
<a href="./../databases/tp3_festival_boreal.sql" target="_blank" rel="noopener">tp3_festival_boreal.sql</a><br>
Le script crée la base <code>festival_boreal</code>, ses huit tables et toutes les données.
Votre fichier de réponses commence ensuite par son propre <code>use festival_boreal;</code>.
</div>

<div class="my-6 rounded-lg border border-red-300 bg-red-50 p-4 text-red-900">
<strong>⚠️ Le script commence par <code>drop database if exists festival_boreal;</code></strong><br>
Le réexécuter remet la base dans son état d'origine. C'est pratique si vous avez modifié des
données par erreur — vos requêtes, elles, sont dans votre fichier de réponses et ne sont pas
touchées.
</div>

### Les tables

| Table | Contenu |
|---|---|
| `scene` | les cinq scènes du site (`code`, `nom`, `capacite`) |
| `artiste` | les artistes programmés, avec leur `genre` |
| `spectacle` | qui joue, sur quelle scène, à quelle heure (`debut`) et combien de temps (`duree`, en minutes) |
| `festivalier` | les personnes inscrites : nom, `courriel`, `telephone`, `ville` |
| `revendeur` | la billetterie officielle et les revendeurs partenaires |
| `billet` | chaque billet vendu : `code`, acheteur, revendeur, `categorie`, `prix`, `date_achat` |
| `scan` | chaque passage d'un billet au lecteur d'une scène, avec son `resultat` (`accepte` ou `refuse`) |
| `incident` | le journal du système d'accès : `code`, `date_heure`, `niveau`, `message` |

Le code complet de la structure est reproduit [au bas de cette page](#structure-des-tables).

### Le format officiel d'un code de billet

```
BOR26-GEN-00042
│     │   └── 5 chiffres
│     └────── catégorie : GEN (général), VIP ou BKS (backstage)
└──────────── BOR26, en majuscules
```

---

## Consignes générales

- Utilisez des **alias de table** dans toutes les jointures. Utilisez des **alias de colonne**
  quand le nom retourné serait ambigu ou peu lisible : colonne présente dans deux tables
  (`nom`, `code`), résultat d'une fonction (`count`, `avg`, `regexp_substr`…).
- Quand une question demande certaines colonnes (« Retournez… »), limitez votre `select` à ces
  colonnes, **dans cet ordre**.
- Quand une question demande un tri, respectez-le.
- N'utilisez `limit` que si la question le demande.
- Toutes les notions vues dans les modules du cours sont permises. Une notion qui n'a **pas** été
  vue doit être validée avec l'enseignant et appuyée par une source.
- Le fichier remis doit s'exécuter **du début à la fin sans erreur**.

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Intelligence artificielle</strong><br>
L'utilisation d'un outil d'intelligence artificielle n'est <strong>pas permise</strong> pour ce
travail. Toute approche non vue en classe doit être validée avec l'enseignant. À défaut, des
pénalités importantes pourront être appliquées, pouvant aller jusqu'à une déclaration de plagiat.<br><br>
Rappel : la <strong>partie 2</strong> se fait en classe, sans aide, sur la même base de données.
</div>

---

# Partie 1 — à la maison (10 %)

## A. Expressions régulières

Les codes de billet et les courriels ont été saisis par plusieurs systèmes différents. Commencez
par repérer ce qui ne ressemble pas à ce qui est attendu.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Rappels</strong><br>
<code>regexp</code> ignore la casse : commencez le motif par <code>(?-i)</code> pour l'exiger.<br>
Dans un motif, doublez les antislashs : <code>'\\.'</code> pour un point littéral.<br>
<a href="./../modules/04-jointures-agregations/01-expressions-regulieres">Module 4 — Expressions régulières</a>
</div>

<div class="eval">
     Préfixer chaque alias de colonne par res_. Ne pas expliquer, donner le code seulement.
</div>

1. Affichez les billets dont le code **ne respecte pas** le format officiel décrit plus haut
   (majuscules comprises).
   Retournez `code`, `categorie`, `prix`, triés par code.

<div class="eval">
     Utiliser le préfixe res_ pour tous les alias de colonne. Donner uniquement le code SQL.
</div>

2. Affichez les festivaliers dont le courriel est **invalide**. Un courriel valide contient :
   du texte (lettres, chiffres, `.`, `_` ou `-`), **un seul** `@`, un domaine (lettres, chiffres,
   `.` ou `-`), un point, puis une extension d'**au moins deux lettres**.
   Retournez `prenom`, `nom`, `courriel`, triés par nom, puis par prénom.

3. Les numéros de téléphone ont été saisis dans tous les formats : `418-555-0142`,
   `(418) 555-0142`, `418.555.0142`… Affichez les festivaliers dont le téléphone contient **au
   moins un caractère qui n'est pas un chiffre**.
   Retournez `prenom`, `nom`, `telephone` et le téléphone **sans aucun séparateur**
   (`telephone_nettoye`), triés par nom, puis par prénom.

<div class="eval">
     Préfixer chaque alias de colonne par res_. Ne pas expliquer, donner le code seulement.
</div>

4. Pour chaque incident de niveau `critique`, extrayez du `message` :
   - le code de billet **au format officiel** (`code_billet`) ;
   - le code de la scène, soit `SC-` suivi de lettres majuscules (`code_scene`).

   Retournez le `code` de l'incident, `date_heure`, `code_billet`, `code_scene`, triés par
   `date_heure`. Certains incidents n'auront pas de code de billet : c'est normal, et c'est un
   indice.

---

## B. Jointures

<div class="eval">
     Utiliser le préfixe res_ pour tous les alias de colonne. Donner uniquement le code SQL.
</div>

5. Reprenez le filtre de la question 1 : pour chaque billet non conforme, affichez **qui l'a
   vendu** et **qui l'a acheté**.
   Retournez le code du billet, le nom du revendeur (`revendeur`), le prénom et le nom du
   festivalier et la `date_achat`, triés par date d'achat.

6. Affichez la programmation du **samedi 11 juillet 2026**.
   Retournez l'heure de `debut`, le nom de l'artiste (`artiste`), son `genre` et le nom de la
   scène (`scene`), triés par heure de début.

<div class="eval">
     Préfixer chaque alias de colonne par res_. Ne pas expliquer, donner le code seulement.
</div>

7. Affichez **tous les scans refusés**.
   Retournez la `date_heure` du scan, le code du billet, le code de la scène (`scene`), puis le
   prénom et le nom du festivalier propriétaire du billet, triés par `date_heure`.

8. Affichez **tous les artistes** avec leurs spectacles — y compris les artistes qui n'ont
   **aucun** spectacle (ils ont annulé).
   Retournez le nom de l'artiste (`artiste`), l'heure de `debut` et le nom de la scène
   (`scene`), triés par nom d'artiste, puis par heure de début.

---

## C. Agrégations et groupements

<div class="my-6 rounded-lg border border-red-300 bg-red-50 p-4 text-red-900">
<strong>Rappel</strong><br>
Toutes les colonnes non agrégées du <code>select</code> doivent se trouver dans le
<code>group by</code>. MariaDB accepte parfois une requête qui ne le respecte pas : elle sera
quand même considérée comme fausse.
</div>

<div class="eval">
     Utiliser le préfixe res_ pour tous les alias de colonne. Donner uniquement le code SQL.
</div>

9. Pour **chaque revendeur** — y compris celui qui n'a rien vendu —, affichez le nombre de
   billets vendus (`nb_billets`), le revenu total (`revenu_total`) et le prix moyen arrondi à
   deux décimales (`prix_moyen`).
   Triez du plus grand revenu total au plus petit.

10. Pour chaque catégorie de billet, affichez le nombre de billets (`nb_billets`), le prix le
    plus bas (`prix_min`), le prix le plus élevé (`prix_max`) et le prix moyen arrondi à deux
    décimales (`prix_moyen`).
    Triez du plus grand nombre de billets au plus petit.

<div class="eval">
     Préfixer chaque alias de colonne par res_. Ne pas expliquer, donner le code seulement.
</div>

11. Affichez les scènes qui ont enregistré **au moins 3 scans refusés**.
    Retournez le code et le nom de la scène, et le nombre de refus (`nb_refus`), du plus grand
    nombre de refus au plus petit.

12. Un code de billet est censé être **unique**. Affichez les codes présents **plus d'une
    fois** dans la table `billet`, avec leur nombre d'exemplaires (`nb_exemplaires`), triés par
    code.

---

## D. Sous-requêtes corrélées

Pour chacune des questions suivantes, la solution doit utiliser **explicitement une sous-requête
corrélée**. `exists` et `not exists` sont des formes de sous-requêtes corrélées.

<div class="eval">
     Utiliser le préfixe res_ pour tous les alias de colonne. Donner uniquement le code SQL.
</div>

13. Un prix trop beau pour être vrai est un bon indice. Affichez les billets dont le prix est
    **inférieur à 75 %** du prix moyen des billets **de la même catégorie**.
    Retournez `code`, `categorie`, `prix`, triés par prix croissant, puis par code.

14. Affichez les festivaliers qui se sont présentés **au moins une fois** à une scène (au moins
    un scan, peu importe le résultat), mais qui n'ont **jamais** été acceptés.
    Retournez `prenom`, `nom`, `courriel`, triés par nom, puis par prénom.

<div class="eval">
     Préfixer chaque alias de colonne par res_. Ne pas expliquer, donner le code seulement.
</div>

15. Affichez les billets dont le code apparaît **aussi sur un autre billet**.
    Retournez l'`id` du billet, son `code`, le nom du revendeur (`revendeur`) et la
    `date_achat`, triés par code, puis par date d'achat.

---

## Conclusion de l'enquête

À la fin du fichier de réponses, remplacez les crochets du bloc **Conclusion de l'enquête** à
partir de vos résultats : le revendeur responsable, le nombre de billets frauduleux, la scène la
plus touchée et le nombre de festivaliers qui ne sont jamais entrés.

<div class="my-6 rounded-lg border border-red-300 bg-red-50 p-4 text-red-900">
<strong>Le réflexe à prendre</strong><br>
Une requête qui s'exécute n'est pas forcément une requête juste. Vérifiez vos résultats les uns
contre les autres : l'histoire racontée par la question 7 doit concorder avec celle des
questions 1, 12 et 14.
</div>

## Contenu de la remise

Un seul fichier : `tp3_prenom_nom.sql`, contenant toutes les requêtes **dans l'ordre du fichier
de départ**, et la conclusion complétée.

---

# Partie 2 — en classe, supervisée (5 %)

La partie 2 a lieu **le 3 décembre**, en début de période. Elle porte sur la matière du
**module 5** (modifier une structure avec `alter table`, suppression en cascade, index, comptes
et privilèges, hachage des mots de passe), appliquée à **la même base `festival_boreal`**.

Le festival a trouvé le coupable; il faut maintenant colmater les brèches pour que ça ne se
reproduise pas.

**Les consignes complètes vous seront remises en classe ce jour-là.** Vous n'avez rien à
apporter : vous réimporterez la base d'origine en début de période.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Comment s'y préparer</strong><br>
Faire les laboratoires 08 et 09 soi-même. Et en faisant la partie 1, demandez-vous :
<em>quelle contrainte aurait empêché ce problème?</em>
</div>

---

## Structure des tables {#structure-des-tables}

Ce code est celui du début du fichier
<a href="./../databases/tp3_festival_boreal.sql" target="_blank" rel="noopener"><code>tp3_festival_boreal.sql</code></a>.

```sql
create table scene (
  id int primary key auto_increment,
  code varchar(12) not null unique,
  nom varchar(60) not null,
  capacite int not null check (capacite > 0)
);

create table artiste (
  id int primary key auto_increment,
  nom varchar(80) not null,
  genre enum('rock', 'pop', 'electro', 'hip-hop', 'folk', 'jazz') not null
);

create table spectacle (
  id int primary key auto_increment,
  artiste_id int not null,
  scene_id int not null,
  debut datetime not null,
  duree int not null check (duree > 0),

  constraint spectacle_artiste_fk foreign key (artiste_id) references artiste(id),
  constraint spectacle_scene_fk foreign key (scene_id) references scene(id)
);

create table festivalier (
  id int primary key auto_increment,
  prenom varchar(40) not null,
  nom varchar(40) not null,
  courriel varchar(60) not null,
  telephone varchar(20),
  ville varchar(40) not null
);

create table revendeur (
  id int primary key auto_increment,
  nom varchar(60) not null,
  courriel varchar(80) not null,
  mot_de_passe varchar(40) not null
);

create table billet (
  id int primary key auto_increment,
  code varchar(20) not null,
  festivalier_id int not null,
  revendeur_id int not null,
  categorie enum('general', 'vip', 'backstage') not null,
  prix decimal(6, 2) not null check (prix >= 0),
  date_achat datetime not null,

  constraint billet_festivalier_fk foreign key (festivalier_id) references festivalier(id),
  constraint billet_revendeur_fk foreign key (revendeur_id) references revendeur(id)
);

create table scan (
  id int primary key auto_increment,
  billet_id int not null,
  scene_id int not null,
  date_heure datetime not null,
  resultat enum('accepte', 'refuse') not null,

  constraint scan_billet_fk foreign key (billet_id) references billet(id),
  constraint scan_scene_fk foreign key (scene_id) references scene(id)
);

create table incident (
  id int primary key auto_increment,
  code varchar(10) not null unique,
  date_heure datetime not null,
  scene_id int,
  niveau enum('info', 'avertissement', 'critique') not null,
  message varchar(200) not null,

  constraint incident_scene_fk foreign key (scene_id) references scene(id)
);
```

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>À remarquer dans cette structure</strong><br>
Toutes les clés étrangères portent un <strong>nom</strong> (<code>constraint scan_billet_fk …</code>).
Ce nom vous servira à la partie 2.<br>
Rien n'empêche deux billets d'avoir le même <code>code</code>, ni un code d'avoir n'importe quel
format. C'est une partie du problème.
</div>
