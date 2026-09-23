---
title: "TP2 — Registre de la Guilde des Aventuriers"
---

# Travail Pratique #2 — Requêtes SQL (13 %)

Le TP2 se fait en **deux parties** :

| | Où | Quand | Poids |
|---|---|---|---|
| **Partie A** | à la maison | remise le **22 octobre, en début de période** | 6 % |
| **Partie B** | en classe, supervisée | **22 octobre**, 1 heure | 7 % |

- Modalité : individuel.
- Remise de la partie A : fichier `.sql` sur LÉA dans le travail concerné.
- Retards : -10 % par jour (max 3 jours). La partie B ne peut pas être reprise.

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>
Vous devez <strong>obligatoirement</strong> écrire votre code <code>sql</code> dans le fichier de
départ suivant. Renommez-le <code>tp2_prenom_nom.sql</code>.<br>
<a href="./../databases/tp2_bd1_depart.sql" target="_blank" rel="noopener">Fichier de réponses à télécharger</a>
</div>

---

## Contexte

La Grande Guilde des Aventuriers modernise ses registres.
Les anciens parchemins sont remplacés par une application interne permettant de gérer :

- les quêtes affichées dans le royaume, et les lieux où elles se déroulent ;
- les aventuriers inscrits à la Guilde, et l'équipement qu'ils possèdent ;
- les contrats signés entre aventuriers et quêtes.

La structure de la base de données a déjà été conçue par les architectes du Royaume.
Cependant, le registre est encore vide.

Avant le déploiement officiel de l'application, l'équipe de développement doit disposer d'un
**environnement de test réaliste**. Votre mandat consiste donc à préparer la base de données
afin qu'elle puisse être utilisée pour des essais fonctionnels complets.

---

## Préparation — créer la base

Téléchargez le script de structure, ouvrez-le dans DBeaver (`Fichier` → `Ouvrir un fichier…`)
et exécutez tout le script avec `Alt + X`, puis rafraîchissez avec `F5`.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Structure de la base — à exécuter en premier</strong><br>
<a href="./../databases/tp2_guilde_structure.sql" target="_blank" rel="noopener">tp2_guilde_structure.sql</a><br>
Le script crée la base <code>guilde_aventuriers</code> et la sélectionne. Votre fichier de
réponses commence ensuite par son propre <code>use guilde_aventuriers;</code>.<br>
Le script ne contient <strong>pas</strong> de <code>drop database</code> : si vous devez repartir
à zéro, exécutez <code>drop database guilde_aventuriers;</code> vous-même — vous perdrez alors
toutes vos insertions.
</div>

Le code de la structure est reproduit [au bas de cette page](#structure-des-tables) pour que vous
puissiez le consulter en écrivant vos requêtes.

---

# Partie A — à la maison (6 %)

## A1. Insertion des données

Insérez un minimum de **25 lignes par table** (maximum 60) dans :

- `quete`
- `aventurier`
- `equipement`
- `contrat`

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>La table <code>lieu</code> est déjà remplie</strong><br>
C'est une table de <strong>référence</strong> : ses dix lieux sont livrés avec la structure.
Vous n'y insérez rien — vous vous en servez pour remplir le <code>lieu_id</code> de vos quêtes.
</div>

Les données doivent être :

- variées et plausibles ;
- cohérentes entre elles ;
- conformes aux types énumérés et aux contraintes définies ;
- suffisamment diversifiées pour permettre des recherches significatives.

Évitez les données répétitives ou artificielles (mêmes dates, mêmes récompenses, mêmes niveaux).
Prévoyez des quêtes actives **et** inactives, des dates d'expiration passées **et** futures, des
aventuriers actifs **et** inactifs, et des quêtes réparties sur **plusieurs lieux** : sans cette
variété, plusieurs requêtes plus bas ne retourneront rien.

Contraintes :

- les clés étrangères doivent référencer des enregistrements existants ;
- les identifiants peuvent être fournis explicitement pour simplifier la correction ;
- le fichier doit s'exécuter **du début à la fin sans erreur**.

Toutes les requêtes d'insertion doivent apparaître **au début du fichier remis**, dans l'ordre
d'exécution.

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Utilisation de l'IA</strong><br>
L'utilisation d'un outil d'intelligence artificielle est <strong>permise uniquement pour la
génération des données d'insertion</strong>, à condition que le code respecte la structure
fournie et les contraintes, que les principes vus en classe soient respectés, et que vous
compreniez entièrement le code exécuté.<br><br>
Pour le reste du travail (sélections, mises à jour, suppressions) : toute approche non vue en
classe doit être validée avec l'enseignant et appuyée par une source. À défaut, des pénalités
importantes pourront être appliquées, pouvant aller jusqu'à une déclaration de plagiat.<br><br>
Rappel : la <strong>partie B</strong> se fait en classe, sans aide, sur les mêmes notions.
Vous demeurez responsable du code remis.
</div>

## A2. Requêtes de sélection

Elles doivent fonctionner avec **vos propres données** et retourner des résultats significatifs.
Au besoin, ajoutez des données dans votre script d'insertion initial. Dans plusieurs cas, vous
choisissez vous-même les valeurs des filtres (dates, plages, lettres, seuils).

<div class="eval">
     Produire du code SQL avec alias et jointures qui accompli la demande. Donner juste le code.
</div>

1. Afficher les quêtes **actives** dont la date d'expiration est aujourd'hui ou ultérieure, en
   retournant uniquement : **titre**, **date d'expiration**, **difficulté**, **récompense**.
   Présenter les résultats de la date d'expiration la plus proche à la plus lointaine.

<div class="eval">
     Utiliser des jointures et des alias de table dans la réponse. Ne pas expliquer, donner le code seulement.
</div>

2. Afficher les aventuriers **actifs** en retournant : **nom**, **classe**, **niveau**,
   **courriel**, triés du plus haut niveau au plus bas. Les aventuriers d'un même niveau doivent
   être affichés en ordre alphabétique.

<div class="eval">
     Produire du code SQL avec alias et jointures qui accompli la demande. Donner juste le code.
</div>

3. Afficher les aventuriers appartenant à une liste de classes choisie
   (ex. : guerrier, mage ou druide) **et** dont le niveau se situe dans une plage choisie.

<div class="eval">
     La réponse attendue contient une jointure et des alias de table. Donner uniquement le code SQL.
</div>

4. Afficher les aventuriers dont le nom commence par une lettre choisie.

<div class="eval">
     Produire du code SQL avec alias et jointures qui accompli la demande. Donner juste le code.
</div>

5. Afficher les contrats **en cours** signés dans une période choisie, triés par date de
   signature croissante.

<div class="eval">
     Utiliser des jointures et des alias de table dans la réponse. Ne pas expliquer, donner le code seulement.
</div>

6. Afficher l'équipement dont la valeur dépasse un seuil choisi, en retournant : **nom**,
   **catégorie**, **valeur**, de la plus grande valeur à la plus petite.

## A3. Sous-requêtes

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Rappel — une seule table à l'affichage</strong><br>
Les jointures ne sont pas encore vues. Chaque requête de cette section affiche donc les colonnes
d'<strong>une seule table</strong> et va chercher ses critères dans les autres au moyen de
sous-requêtes. Construisez-les en partant de la table la plus éloignée et en remontant.
</div>

<div class="eval">
     Produire du code SQL avec alias et jointures qui accompli la demande. Donner juste le code.
</div>

7. Afficher les quêtes **faciles** dont la récompense est **supérieure** à celle **d'au moins
   une** quête périlleuse.

<div class="eval">
     La réponse attendue contient une jointure et des alias de table. Donner uniquement le code SQL.
</div>

8. Afficher les quêtes situées dans un lieu dont le **niveau de danger est d'au moins 4**.

<div class="eval">
     Produire du code SQL avec alias et jointures qui accompli la demande. Donner juste le code.
</div>

9. Afficher les aventuriers possédant **au moins une** pièce d'équipement valant plus qu'un
   seuil choisi, sans doublons.

<div class="eval">
     Utiliser des jointures et des alias de table dans la réponse. Ne pas expliquer, donner le code seulement.
</div>

10. Afficher les aventuriers ayant signé **au moins un contrat** pour une quête située dans une
    **région** choisie (ex. : les Marches du Nord), sans doublons.

<div class="eval">
     La réponse attendue contient une jointure et des alias de table. Donner uniquement le code SQL.
</div>

11. Afficher les quêtes qui **n'ont reçu aucun contrat**.

<div class="eval">
     Produire du code SQL avec alias et jointures qui accompli la demande. Donner juste le code.
</div>

12. Afficher les lieux où **au moins une quête** est affichée, triés alphabétiquement.

## A4. Corrections du scribe (modification)

Règle de prudence de la Guilde : avant d'inscrire une correction au registre, vérifier que la
cible est bien celle attendue, afin de ne pas altérer tout le parchemin.

<div class="eval">
     Utiliser des jointures et des alias de table dans la réponse. Ne pas expliquer, donner le code seulement.
</div>

13. Une quête contient une récompense incorrecte. Modifier la récompense d'une quête précise,
    identifiée par son titre. **Une seule ligne** doit être affectée.

<div class="eval">
     Produire du code SQL avec alias et jointures qui accompli la demande. Donner juste le code.
</div>

14. La Guilde décide de désactiver tous les contrats liés à des quêtes qui ne sont plus actives.
    Mettre à jour les contrats concernés sans modifier les autres.

## A5. Purge aux oubliettes (suppression)

Mise en garde : ce qui part aux oubliettes ne revient pas. Agir avec méthode.

<div class="eval">
     La réponse attendue contient une jointure et des alias de table. Donner uniquement le code SQL.
</div>

15. La Guilde récupère le matériel des membres qui ont quitté : supprimer tout l'équipement
    appartenant à des aventuriers qui ne sont plus actifs, sans supprimer les aventuriers
    eux-mêmes.

<div class="my-6 rounded-lg border border-red-300 bg-red-50 p-4 text-red-900">
<strong>Le réflexe à prendre</strong><br>
Avant chaque <code>update</code> et chaque <code>delete</code>, écrivez d'abord le
<code>select</code> qui retourne exactement les lignes visées. Si le <code>select</code> est bon,
le <code>where</code> est bon.
</div>

## Contenu de la remise

Un seul fichier : `tp2_prenom_nom.sql`, contenant toutes les requêtes **dans l'ordre du fichier
de départ** — insertions, sélections, sous-requêtes, modifications, suppression.

---

# Partie B — en classe, supervisée (7 %)

La partie B a lieu **le 22 octobre**, en début de période, et dure **une heure**.
Elle porte sur les mêmes notions que la partie A.

**Les consignes complètes vous seront remises en classe ce jour-là.** Vous n'avez rien à
préparer, rien à importer et rien à apporter : tout le matériel est fourni sur place.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>Comment s'y préparer</strong><br>
Il n'y a rien à mémoriser de particulier : faire la partie A soi-même <em>est</em> la
préparation. Si tu écris tes quinze requêtes toi-même, tu n'auras pas de problème à faire la partie B.
</div>

---

## Structure des tables {#structure-des-tables}

Ce code est celui du fichier
<a href="./../databases/tp2_guilde_structure.sql" target="_blank" rel="noopener"><code>tp2_guilde_structure.sql</code></a>
— à exécuter avant de commencer.

```sql
create database guilde_aventuriers character set utf8mb4;
use guilde_aventuriers;

create table lieu (
  id int primary key auto_increment,
  nom varchar(80) not null unique,
  region varchar(60) not null,
  niveau_danger int not null check (niveau_danger between 1 and 5),
  actif boolean not null default true
);
-- Cette table est livrée déjà remplie (10 lieux).

create table quete (
  id int primary key auto_increment,
  titre varchar(150) not null,
  description text not null,
  lieu_id int not null,
  date_expiration date not null,
  difficulte enum('facile', 'modérée', 'périlleuse') not null,
  recompense_or int not null check (recompense_or >= 0),
  actif boolean not null default true,

  foreign key (lieu_id) references lieu(id)
);

create table aventurier (
  id int primary key auto_increment,
  nom varchar(90) not null,
  courriel varchar(160) not null unique,
  classe enum('guerrier', 'mage', 'assassin', 'druide', 'paladin', 'barde') not null,
  niveau int not null check (niveau between 1 and 20),
  actif boolean not null default true
);

create table equipement (
  id int primary key auto_increment,
  nom varchar(100) not null,
  categorie enum('arme', 'armure', 'potion', 'grimoire', 'relique') not null,
  valeur_or int not null check (valeur_or >= 0),
  aventurier_id int not null,
  actif boolean not null default true,

  foreign key (aventurier_id) references aventurier(id)
);

create table contrat (
  id int primary key auto_increment,
  quete_id int not null,
  aventurier_id int not null,
  date_signature date not null default (current_date),
  statut enum('disponible', 'en_cours', 'réussi', 'échoué') not null default 'disponible',
  notes text,
  actif boolean not null default true,

  foreign key (quete_id) references quete(id),
  foreign key (aventurier_id) references aventurier(id),

  unique (quete_id, aventurier_id)
);
```

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
<strong>À remarquer dans cette structure</strong><br>
Les <code>enum</code> sont déclarés <strong>dans la colonne</strong> : en MariaDB, il n'existe pas
de <code>create type</code>.<br>
Le lieu d'une quête est une <strong>référence</strong> (<code>lieu_id</code>), pas un texte
recopié dans chaque quête. C'est ce qui permet de corriger le nom d'un lieu à un seul endroit.<br>
La contrainte <code>unique (quete_id, aventurier_id)</code> empêche un même aventurier de signer
deux fois la même quête — pensez-y en générant vos contrats, sinon vos insertions échoueront.
</div>
