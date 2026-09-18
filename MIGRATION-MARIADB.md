# Migration PostgreSQL → MariaDB

Suivi de la conversion du contenu du cours 420-07B-FX. On procède **un module à la fois**.
Les tâches marquées 🧑 doivent être faites à la main (captures d'écran, fichiers .sql, PDF).

👉 **La liste de travail consolidée est dans [`A-FAIRE.md`](A-FAIRE.md)** : captures à refaire,
vidéos, vérifications DBeaver. Ce fichier-ci garde le détail et l'historique des décisions.

---

## Module 1 — Introduction ✅ TERMINÉ

Ce module est presque entièrement agnostique au SGBD (formats de données, structure
relationnelle, lecture d'un MRD). Rien de PostgreSQL n'y était enseigné.

**Fait**
- `01-formats-donnees.md` : ajout de MariaDB à la liste des SGBD relationnels + note
  indiquant que c'est le SGBD du cours.

**À vérifier / à faire à la main**
- 🧑 Aucune capture d'écran à refaire (les images du module 1 sont des photos perso et
  le MRD du concessionnaire, indépendants du SGBD).

---

## Lab 01 — Installations ✅ TERMINÉ (texte)

**Fait**
- Installateur EDB PostgreSQL → **paquet MSI MariaDB** (https://mariadb.org/download/).
- Mot de passe `postgres` → `root`; port `5432` → `3306`; service `postgresql-x64` → `MariaDB`.
- Ajout de l'étape « cocher *Use UTF8 as default server's character set* » à l'installation.
- Vérification PATH : `psql --version` → `mariadb --version`, avec une note expliquant que
  `mysql --version` fonctionne aussi (ancien nom du même client).
- Chemin PATH : `C:\Program Files\PostgreSQL\18\bin` -> `C:\Program Files\MariaDB 11.8\bin`
  (avec la mention que le numéro de version peut différer).
- L'ancre `#ajouter-au-path` a été **conservée** (le module 2 pointe dessus).
- Connexion DBeaver : pilote MariaDB (avec avertissement de ne pas choisir `MySQL`),
  `localhost:3306`, utilisateur `root`, option *Show all databases*.
- Création de BD : interclassement `UTF8` → jeu de caractères `utf8mb4`.
- **Ajout d'une étape 4.1.3** : la commande `use lab01;`, qui n'a pas d'équivalent en
  PostgreSQL et devient essentielle en MariaDB.
- Images renommées : `connexion-postgres.png` → `connexion-mariadb.png`,
  `options-connexion-postgres.png` → `options-connexion-mariadb.png` (le contenu est
  encore celui de PostgreSQL, à recapturer).

**🧑 Captures à refaire — 13 sur 17** (dans `docs/img/lab01/`)

| Image | Quoi capturer |
|---|---|
| `installateur.png` | Page de téléchargement de mariadb.org |
| `options.png` | Écran des composants de l'assistant MSI |
| `service.png` | `services.msc` avec le service `MariaDB` |
| `path.png` | Variable PATH avec le dossier `bin` de MariaDB |
| `connexion-mariadb.png` | Choix du pilote MariaDB dans DBeaver |
| `options-connexion-mariadb.png` | Onglet de connexion (host/port/root/*Show all databases*) |
| `drivers.png` | Dialogue de téléchargement du pilote MariaDB |
| `navigateur-bd.png` | Arborescence DBeaver avec la connexion MariaDB |
| `new-db.png` | Clic-droit → Créer base de données |
| `new-db-settings.png` | Dialogue avec le charset `utf8mb4` |
| `bd-lab01.png` | La base `lab01` dans l'arborescence |
| `new-db-code.png` | Ouverture d'un éditeur SQL sur la connexion |
| `execute.png` | Exécution du `create database lab01;` |
| `post-refresh.png` | L'arborescence après rafraîchissement |

**✅ Réutilisables tels quels** : `installateur-dbeaver.png`, `nouvelle-connexion.png`,
`refresh.png` (indépendants du SGBD).

**🧑 Deux détails d'interface à confirmer pendant que vous prenez les captures**
1. L'option **Show all databases** : selon la version de DBeaver, elle se trouve dans
   l'onglet `Main` ou dans un onglet `MySQL`/`MariaDB` des réglages de connexion.
   Ajustez la formulation de l'étape 3.4 si l'emplacement diffère.
2. Le libellé exact et l'emplacement de **Créer base de données** : en MariaDB, DBeaver
   n'a pas le niveau *Schémas* de PostgreSQL, donc l'arborescence est plus courte
   (connexion → bases → tables). Vérifiez si le clic-droit se fait bien sur un nœud
   `Bases de données` ou directement sur la connexion, et ajustez l'étape 4.2.

---

## Module 2 — DDL de base ✅ TERMINÉ (texte)

**`01-create-database.md` — la page la plus retravaillée**
- Hiérarchie « Serveur → Base → Schémas → Tables » → « Serveur → Base → Tables ».
- Section « Le concept de schéma » remplacée par **« Base de données ou schéma ? »** :
  explique que les deux mots sont synonymes en MariaDB (`create schema` = `create database`),
  pour que le mot *Schema* vu dans DBeaver ne les mêle pas.
- Encodage : UTF-8 générique → **`utf8mb4`**, avec l'avertissement que le charset nommé
  `utf8` dans MariaDB est un faux UTF-8 sur 3 octets.
- **Renversement complet** de la section connexion : « PostgreSQL n'utilise pas USE » devient
  une section `USE` avec l'erreur `No database selected` et la consigne de commencer tout
  script par son `use`.
- `select datname from pg_database;` → `show databases;` + `select database();`.

**`02-create-table.md`**
- Table des types réécrite : `INT`, `INT AUTO_INCREMENT`, `VARCHAR`, `TEXT`, `DATE`,
  `DATETIME`, `BOOLEAN`, `DECIMAL`.
- Encadré « Bon à savoir » ajouté : `INTEGER`/`NUMERIC` sont des synonymes, `BOOLEAN` est un
  `TINYINT(1)` qui s'affiche 1/0, `DATETIME` plutôt que `TIMESTAMP`, jamais `FLOAT` pour de l'argent.
- GUI : « sélectionner le schéma `public` » → « sélectionner la base de données ».
- Corrigé au passage : le `<details>` de cette page portait l'`id="ajouter-au-path"`,
  copié-collé du lab 01 (renommé `creer-table-gui`). Aucun lien ne pointait dessus.

**`03-contraintes-simples.md`**
- 6 × `id serial` → `id int primary key auto_increment`.
- **Encadré ajouté expliquant pourquoi le `primary key` apparaît dès cette page** : MariaDB
  refuse une colonne `auto_increment` qui n'est pas une clé
  (*there can be only one auto column and it must be defined as a key*). En PostgreSQL,
  `id serial` seul fonctionnait — d'où les exemples d'origine.
- Section ENUM réécrite : plus de `create type ... as enum`, la liste se déclare dans la
  colonne. Ajout d'une note disant qu'`ENUM` est propre à MariaDB/MySQL et qu'un `check ... in (...)`
  est plus portable.

**`04-cles-primaires-etrangeres.md`**
- `SERIAL` → `AUTO_INCREMENT` partout, avec explication de son fonctionnement.
- Ajout : le type d'une FK doit être **identique** à celui de la PK référencée, sinon `errno 150`.
- Ajout d'un encadré sur le **moteur InnoDB** (défaut, mais MyISAM ignore les FK en silence).
- « Atelier PostgreSQL » → « Atelier MariaDB » dans les données d'exemple.

**`05-demo-ddl.md`**
- Ajout du `use demo_evenements;` (dans la démo pas-à-pas et en tête du script complet).
- `default current_date` → `default (current_date)` — MariaDB exige les parenthèses autour
  d'une expression par défaut.
- ⚠️ **Bandeau rouge ajouté au-dessus de la vidéo YouTube** : elle montre PostgreSQL.

**`06-drop-simple.md`**
- Ajout de `drop table if exists`.
- **Section « Session Manager » entièrement remplacée** : MariaDB ne refuse pas de supprimer
  une base en cours d'utilisation, donc la manip n'a plus d'objet. À la place : l'erreur
  *Cannot delete or update a parent row* et `set foreign_key_checks = 0` en dernier recours.
- Nouvelle section : on peut supprimer la base active en MariaDB (contrairement à PostgreSQL).

**`07-import-export.md`** *(section import revue le 2026-09-09 après test en classe)*
- Export : `Backup` (pg_dump) → **`Dump database`** (mysqldump). Retrait du « cocher le
  schéma Public » et du format « Plain (SQL) ».
- **Confirmé par test** : le dump MariaDB ne contient ni `create database` ni `use`.
- Nouvelle section **« Compléter le fichier exporté »** : les étudiants ouvrent le `.sql`
  dans un éditeur et ajoutent eux-mêmes les deux lignes en tête.

  ```sql
  create database if not exists tp_evenements;
  use tp_evenements;
  ```

  Choix pédagogique assumé : le fichier remis doit être **autoportant**, et l'étudiant voit
  le SQL plutôt que de le déléguer à une commande.
- Import : `psql -U postgres -f fichier.sql` → **plus de ligne de commande du tout**. Voir la
  section « Import dans DBeaver » ci-dessous. *(La page est passée par deux versions
  intermédiaires le 2026-09-17 : `Get-Content ... | mariadb`, puis
  `mariadb -e "source ..."`, avant la décision de tout faire dans DBeaver.)*
- L'erreur `No database selected` est nommée explicitement et renvoie à la section précédente.

**✅ Accents à l'import — problème confirmé et corrigé (2026-09-17)**
Le pipe `Get-Content | mariadb` **détruit les accents**. Ce n'est pas une hypothèse : testé avec
`module_03_evenement_data.sql`, la ligne « Bruno Lefèvre » arrive en base sous la forme
« Bruno Lef??vre » — 14 caractères pour 14 octets, donc du pur ASCII : le `è` a été remplacé par
deux vrais points d'interrogation **dans les données**, pas seulement à l'affichage. Le fichier
source est pourtant bien en UTF-8 (`0xC3 0xA8`). PowerShell 5.1 ré-encode le texte vers la page
de code de la console avant de le passer à `mariadb.exe`, et ce qui n'est pas représentable
devient `?`.

Conséquence : toutes les recherches texte échouent (`like '%conférence%'` retournait 0 ligne).

Le contournement vérifié était `mariadb -u root -p --default-character-set=utf8mb4 -e "source
fichier.sql"` — le client ouvre le fichier lui-même, sans passer par le pipe (accents intacts :
13 caractères / 14 octets pour « Bruno Lefèvre »).

---

## Import dans DBeaver — décision du prof (2026-09-17)

Plutôt que de corriger la commande, **la ligne de commande est retirée du cours** : les étudiants
importent uniquement par DBeaver. L'export s'y faisait déjà (`Dump database`), donc l'import et
l'export sont maintenant au même endroit, et le problème d'encodage du pipe PowerShell disparaît
avec la commande.

Marche à suivre enseignée :
1. `Fichier` → `Ouvrir un fichier…` (ou glisser-déposer le `.sql` dans DBeaver).
2. Vérifier la connexion active dans la barre d'outils.
3. **`Alt + X`** (*Execute script*) — avec un encadré qui insiste : `Ctrl + Entrée` n'exécute
   qu'une seule instruction, ce qui est le piège classique sur un fichier de plusieurs centaines
   d'instructions.
4. `F5` pour rafraîchir l'arborescence.

Encadrés conservés/ajoutés : `No database selected`, « des `?` à la place des accents »
(l'explication reste utile, la cause possible devient l'encodage de lecture de DBeaver), et
l'avertissement sur l'écrasement des données.

Pages touchées : `02-ddl-base/07-import-export.md` (section, démo et « À retenir »), et
`03-sql-base/01-insert.md` / `02-select-where.md`.

**Décisions prises (2026-09-17)**
- `import-command.png` (la commande dans `cmd`) : `<img>` retiré de la page **et fichier
  supprimé** du dépôt.
- L'encadré « Avez-vous ajouté le client MariaDB à votre PATH ? » a été retiré de cette page,
  mais **l'étape PATH reste dans le lab 01** : elle sert toujours à vérifier l'installation avec
  `mariadb --version`. L'ancre `#ajouter-au-path` n'est donc plus référencée par aucune page —
  c'est normal, ne pas la « nettoyer ».

**🧑 À vérifier pendant la prise de captures**
- Le libellé exact du menu d'ouverture de fichier et le nom de l'entrée
  `SQL Editor` → `Execute script` dans votre version de DBeaver.
- J'ai écrit « vérifier l'encodage dans les préférences de DBeaver » sans donner le chemin exact
  du menu, faute de pouvoir le confirmer.
- 🧑 Une capture DBeaver de l'import (ouverture du fichier + *Execute script*) remplacerait
  avantageusement celle qui a été supprimée — la section n'a plus d'illustration.

🧑 **À faire** : prévenir les étudiants qui ont déjà importé un jeu de données accentué avec
`Get-Content | mariadb` — leurs données contiennent des `?` et doivent être réimportées.

---

### 🧑 À faire à la main — Module 2

**Bugs pré-existants corrigés au passage** (à confirmer que ça vous convient)
- `04-cles-primaires-etrangeres.md` : la table `salle` avait une **virgule finale** avant la
  parenthèse fermante (erreur de syntaxe). Corrigée.
- Même bloc : `nom integer null` pour un nom de salle — changé en `nom varchar(50) null`.
  Si c'était voulu, remettez-le.

**Captures à refaire — 13** (dans `docs/modules/02-ddl-base/images/`)

| Image | Quoi capturer |
|---|---|
| `creation-bd-gui.png` | Création de BD dans DBeaver (MariaDB) |
| `connexion-gui.png` | Sélecteur de base active dans la barre d'outils |
| `regenerer.png` | Rafraîchir l'arborescence |
| `create-table-gui.png` | Création de table (sans niveau schéma) |
| `créer-colonne.png` | Créer une colonne |
| `voir-contraintes.png` | Onglet des contraintes d'une table |
| `enum1.png` | Le type ENUM **dans la définition de la colonne** (plus de nœud « Types ») |
| `enum2.png` | Idem, vue rapprochée |
| `voir-schema.png` | Ouvrir le diagramme |
| `schema.png` | Le diagramme des 3 tables |
| `erreur.png` | L'erreur *Cannot delete or update a parent row* |
| `backup.png` / `backup-tables.png` / `backup-options.png` | Le dialogue **Dump database** |
| ~~`import-command.png`~~ | Supprimée : l'import se fait maintenant dans DBeaver |

**Supprimées** : `session-manager.png`, `terminate.png` (spécifiques à PostgreSQL).

**🧑 Trois choses à valider en exécutant la démo**
1. **`default (current_date)`** — j'ai mis les parenthèses parce que c'est la forme
   documentée par MariaDB pour une expression par défaut. Si la forme sans parenthèses
   passe aussi chez vous, vous pouvez simplifier. Je n'avais pas de serveur MariaDB pour tester.
2. **Le dialogue `Dump database` de DBeaver** — les libellés exacts des options
   (`Add DROP statements`, encodage) peuvent différer de ce que j'ai écrit. Ajustez la liste
   d'étapes pendant que vous prenez les captures.
3. **L'export inclut-il vraiment le `create database` ?** J'affirme que non (mysqldump ne
   l'ajoute qu'avec `--databases`). Vérifiez dans le fichier généré : si DBeaver l'inclut,
   retirez l'encadré rouge que j'ai ajouté.

**🧑 Vidéo à réenregistrer** : la démo YouTube de `05-demo-ddl.md`
(https://www.youtube.com/embed/1FbFcJfxpNs). Un bandeau d'avertissement est en place en attendant.

**TP1** : mis de côté — décision du prof (2026-09-09). Non converti.

---


## Lab 03 — DDL Concessionnaire ✅ TERMINÉ

**Fait**
- Consignes : « ouvrez un nouveau script sur cette base » → **« commencez votre script par
  `use lab03_concessionnaire;` »**.
- **L'étape « créer un type ENUM » a été supprimée de l'énoncé.** Elle était la première des
  deux tâches demandées; en MariaDB l'ENUM fait partie de la colonne, il n'y a rien à créer
  avant. Les sections de l'énoncé sont renumérotées 1→4 (client, vendeur, voiture, achat) et
  l'exigence ENUM est passée dans la section `voiture`, avec un rappel encadré.
- Corrigé converti : `serial` → `int auto_increment`, `numeric(10,2)` → `decimal(10,2)`,
  `integer` → `int`, `create type type_carburant` → `enum('essence','diesel','electrique')`
  dans la colonne, ajout du `use` en tête.
- « Ordre de création recommandé » : `type_carburant` retiré, passé de 5 à 4 étapes, avec une
  phrase expliquant le principe (tables sans FK d'abord).

**Question de réflexion remplacée**
- « Pourquoi le type ENUM doit-il être créé avant la table `voiture` ? » n'a plus de sens.
- Remplacée par : « Comment obtenir le même résultat avec un `CHECK` ? Quel est l'avantage
  de cette approche ? » — ce qui renvoie à la note de portabilité ajoutée dans
  `02-ddl-base/03-contraintes-simples.md`.

**Correction du 2026-09-09 — clé étrangère récursive**
Testé en classe : MariaDB **refuse** la FK récursive de `vendeur` déclarée dans son propre
`create table` (`errno 150 — Foreign key constraint is incorrectly formed`).
Le lab utilise maintenant la forme en deux temps :

```sql
create table vendeur (... id_superviseur int);

alter table vendeur
  add foreign key (id_superviseur) references vendeur(id_vendeur);
```

Trois endroits mis à jour : l'énoncé, le corrigé par table, et le script complet.

⚠️ **Conséquence pédagogique** : `alter table` n'est enseigné qu'au **module 5**. Un encadré
a été ajouté dans l'énoncé (section « Table `vendeur` ») qui donne la ligne toute faite aux
étudiants et précise qu'ils la verront en détail plus tard. Une question de réflexion a aussi
été ajoutée : « Pourquoi faut-il ajouter la clé étrangère **après** avoir créé la table ? »

Si vous préférez ne pas montrer `alter table` au module 2, l'autre option est de retirer
complètement la FK récursive de ce lab et de la réintroduire au module 5.

**Décision du 2026-09-09 — pas de script complet**
Un bloc « Script complet » avait été ajouté au corrigé, puis retiré : le lab se fait
**pas à pas** (une instruction à la fois), ce qui correspond aux consignes de l'énoncé.
Le corrigé présente donc uniquement les blocs table par table.

- Aucune capture d'écran dans ce lab : rien à refaire de ce côté.

---

## Module 3 — SQL de base ✅ TERMINÉ (texte)

Le SQL enseigné dans ce module (`insert`, `select/where`, `update/delete`, opérateurs,
sous-requêtes non corrélées) est compatible tel quel : aucune requête d'exemple n'a dû être
réécrite. Le travail a porté sur l'import, les jeux de données et deux nuances de MariaDB.

**Jeux de données — réécrits à la main** (`docs/public/databases/`)
Les deux fichiers étaient des `pg_dump` (`COPY ... FROM stdin`, `SET` PostgreSQL, séquences,
`connect`, schéma `public`). Ils sont maintenant des **scripts MariaDB lisibles** que les
étudiants peuvent ouvrir et comprendre :
- `drop database if exists` + `create database ... character set utf8mb4` + `use` en tête,
  donc **autoportants** (même principe que l'export enseigné au module 2).
- `serial`/séquences → `int primary key auto_increment`; `numeric(8,2)` → `decimal(8,2)`;
  `default CURRENT_DATE` → `default (current_date)`; contraintes `unique`/`check`/FK conservées.
- `COPY ... FROM stdin` → `insert into ... values`, avec les **id explicites** pour que les
  clés étrangères des inscriptions restent valides (30 événements, 47 participants,
  54 inscriptions — données identiques à la version PostgreSQL).
- **Nom des bases corrigé** : `module_03_evenements_empty`/`_data` (pluriel) →
  `module_03_evenement_empty`/`_data` (singulier). C'est le nom qu'utilisait déjà le lab 04 et
  il respecte la convention de nommage enseignée.
- ⚠️ Différence conservée telle quelle : la base *empty* n'a **pas** les colonnes
  `evenement.prix` ni `inscription.actif`, contrairement à la base *data*. C'était déjà le cas
  en PostgreSQL.

**`01-insert.md`**
- Import `psql -U postgres -f ...` → ouverture du `.sql` dans DBeaver et `Alt + X`,
  avec un encadré qui rappelle que le fichier est autoportant et qu'il faut commencer son script
  par `use module_03_evenement_empty;`.
- Encadré bleu : un `boolean` MariaDB s'affiche 1/0 dans l'onglet *Données*.
- « clés primaires générées par PostgreSQL » → « générées par la colonne `auto_increment` », et
  les deux prompts d'IA demandent maintenant du SQL **MariaDB**.

**`02-select-where.md`**
- Même traitement pour l'import (`module_03_evenement_data`).
- Nouvel encadré « Les booléens en MariaDB » : `where actif = true`, `= 1` et `where actif`
  sont équivalents.
- `limit` : aucune modification, la syntaxe est identique.

**`03-update-delete.md`** — ajout du `use module_03_evenement_data;` en tête. Les 8 exemples
`update`/`delete` fonctionnent sans changement.

**`04-operateurs.md`** — ajout de l'encadré jaune **« `like` ignore la casse »** : collations
`_ci` par défaut, mention que les accents peuvent aussi être ignorés selon la collation, et
`like binary` pour forcer la sensibilité à la casse.

**`05-sous-requetes-non-correlees.md`** — aucune modification nécessaire (`in`, `any`, `all`
se comportent pareil).

**`06-examen-1.md`** — `numeric(12,0)` → `decimal(12,0)`; l'étape « testez sur une nouvelle base
de données » donne maintenant le `create database` + `use`.

**`index.md`** — les deux liens « Lab » pointaient tous les deux vers `lab03-ddl` (copié-collé).
Corrigés vers `lab04-select` et `lab05-avance`.

---

## Labs 04 et 05 ✅ TERMINÉ (texte)

Le SQL de ces deux labos est déjà compatible MariaDB; les corrections portent sur le contexte.

**`lab04-select.md`**
- `title` du frontmatter : « Lab 03 » → « Lab 04 » (désynchronisé avec le H1).
- « portée : base de données `module_03_evenement_data` » → un bloc `use module_03_evenement_data;`
  à mettre en tête du script.

**`lab05-avance.md`**
- ⚠️ Bandeau rouge ajouté sous la vidéo YouTube : elle a été enregistrée avec PostgreSQL.
- Ajout du `use module_03_evenement_data;`.
- **Bug pré-existant corrigé** — exercice 3c) « Participants dans les villes "Paris", "Lyon",
  "Marseille" » : la table `participant` n'a pas de colonne de ville, l'exercice était
  impossible. Remplacé par « Participants dont l'identifiant fait partie de la liste (1, 5, 10) »,
  ce qui garde l'objectif (`in` sur une liste). À changer si vous aviez autre chose en tête.

**Domaines de courriel variés — correction du 2026-09-17**
L'exercice 3b) « Participants dont le courriel se termine par `@gmail.com` » retournait 0 ligne :
les 47 participants avaient tous une adresse `@example.com`. Le même défaut rendait l'exemple
« Courriels se terminant par `example.com` » de `03-sql-base/04-operateurs.md` inutile, puisqu'il
retournait tout le monde.

Plutôt que de réécrire l'énoncé, **12 participants du jeu de données sont passés à un domaine
personnel** dans `module_03_evenement_data.sql` : 7 `@gmail.com`, 3 `@hotmail.com`,
2 `@outlook.com`. Il reste 35 `@example.com`, et les 47 adresses restent distinctes
(contrainte `unique`).

Les deux adresses citées ailleurs dans le cours ont été **volontairement épargnées** :
`bruno.lefevre@example.com` (lab 05, exercice 2b) et `julie.petit2@example.com`
(`03-sql-base/03-update-delete.md`, exemple 3). Ne pas les modifier.

Les deux exercices fonctionnent maintenant : `like '%@gmail.com'` → 7 lignes,
`like '%@example.com'` → 35 lignes. Aucun énoncé n'a eu besoin d'être réécrit.

⚠️ La base doit être **réimportée** pour que le changement prenne effet.

**Formulation clarifiée — 2026-09-17**
4c) disait « ... et dont **le nom** contient "Tech" », ce qui se lisait comme le nom du
participant. Confirmé par le prof : c'est le **nom de l'événement**. L'énoncé dit maintenant
« et dont **le nom de l'événement** contient "Tech" ».

Vérifié sur les données : un seul événement correspond (« Conférence Tech 2026 », Paris,
prix 50), et il compte 3 inscrits, tous actifs — l'exercice retourne donc 3 lignes.
Attention en corrigeant : « Conférence FinTech » contient aussi « Tech », mais elle a lieu à
La Défense, donc elle est exclue par le filtre sur le lieu.

**✅ Validé sur serveur le 2026-09-17** (MariaDB 12.3)
- Les deux scripts s'importent sans erreur; compteurs conformes : 30 événements, 47 participants,
  54 inscriptions.
- `show create table inscription` confirme `date_inscription date NOT NULL DEFAULT curdate()` :
  la forme `default (current_date)` **fonctionne** (question ouverte depuis le module 2, réglée).
- `unique (evenement_id, participant_id)` sans le mot `INDEX` compile : la contrainte apparaît
  comme `UNIQUE KEY`. Le mot-clé `INDEX`/`KEY` est optionnel dans la grammaire MariaDB.
- `ENGINE=InnoDB`, `AUTO_INCREMENT=62`, `DEFAULT CHARSET=utf8mb4`, les deux FK en place.
- Collation du serveur : `utf8mb4_uca1400_ai_ci` — **insensible à la casse ET aux accents**.
  `like '%Conférence%'`, `'%conférence%'` et `'%conference%'` retournent les mêmes 7 lignes.
  L'encadré de `04-operateurs.md` est donc écrit en affirmation, plus en « à vérifier ».
- ⚠️ Le premier import, fait avec `Get-Content | mariadb`, avait détruit les accents. Voir la
  section du module 2 ci-dessus.

🧑 **Captures à revoir — 3** : `dbeaver-location.png`, `ouvrir-dbeaver.png` (indépendantes du
SGBD, probablement réutilisables telles quelles) et `voir-donnees.png` (montre l'onglet
*Données* de DBeaver sur PostgreSQL — à recapturer sur MariaDB, on y verra le 1/0 des booléens).

---

## Évaluations — refonte du 2026-09-18

Décision du prof : l'examen 1 se fait **sur papier**, en classe, et porte sur **toute la matière
depuis le début de la session** (modules 1 à 3). Safe Exam Browser n'est plus utilisé. Le TP2 est
refait en deux parties, dont une évaluée en classe sous surveillance.

### `03-sql-base/06-examen-1.md` — réécrite

- Modalités Safe Exam Browser retirées (installation, simulation `.seb`, mots de passe, sortie),
  ainsi que l'encadré « DBeaver doit être dans Program Files » qui n'existait que pour SEB.
- Consigne inversée : **écrire à la main d'abord, vérifier dans DBeaver ensuite**.
- Couverture élargie aux modules 1 et 2, qui n'étaient presque pas représentés :
  - partie 1 — lecture d'un MRD (diagramme **Mermaid `erDiagram`**, rendu vérifié dans le
    navigateur) et construction d'un modèle à partir de règles d'affaires (salle, diffuseur);
  - partie 2 — un script fautif à corriger, avec corrigé : `serial`, `create type ... as enum`,
    ordre de création des tables, type de FK ≠ type de PK, `varchar` sans longueur, `use`
    manquant, `time` au lieu de `datetime`;
  - partie 3 — cinq requêtes dont il faut **prédire le résultat** sur un jeu de données imprimé.
    Deux d'entre elles portent sur la collation `_ai_ci` : `like '%é%'` retrouve les `e` sans
    accent, et `= 'quebec'` retrouve `'Québec'`.
- Les images `dbeaver-location.png` et `ouvrir-dbeaver.png` ne sont plus référencées nulle part.

### `travaux/tp2-sql.md` — refait et converti

- Le DDL de l'énoncé était le dernier gros bloc PostgreSQL du site : `create database` sans `;`
  ni `use`, trois `create type ... as enum`, trois `serial`. Réécrit en MariaDB et sorti dans
  `docs/public/databases/tp2_guilde_structure.sql` (sans `drop database`, pour qu'un étudiant ne
  détruise pas ses insertions en réexécutant le script).
- `palladin` corrigé en `paladin` dans l'enum des classes.
- Structure : **partie A** à la maison (6 %) — 30 à 60 lignes par table au lieu de 50 à 100, et
  12 requêtes au lieu de 16, pour laisser le temps des labos; **partie B** en classe, supervisée
  (7 %). Le fichier de départ et la grille suivent la nouvelle numérotation.
- Les 12 blocs `.eval` sont conservés et leur texte varié en trois formulations. Ils demandent
  toujours des **jointures**, qui ne sont pas enseignées avant le module 4 : une réponse d'IA
  reste immédiatement reconnaissable.
- 🧑 La **vidéo explicative** a été retirée : elle décrivait l'ancien énoncé (16 questions) et
  avait été enregistrée en PostgreSQL. À réenregistrer si désirée.

### Partie B — hors dépôt

Le dépôt `Cochenille/BD1A26` est **public** (vérifié). L'énoncé de la partie B, son corrigé et sa
base remplie ne sont donc **pas** dans le dépôt : ils ont été remis au prof directement.

Le TP2 est découpé en **deux pages** (décision du prof, 2026-09-18) pour que les étudiants
n'aient pas le déroulement de l'évaluation supervisée avant d'entrer en classe :
`tp2-sql.md` (partie A) n'annonce que la date, la durée et le poids de la partie B, et
`tp2-partie-b.md` porte le déroulement — page **non listée**, à décommenter dans `config.mts`
au début de la période du 22 octobre. Le nombre de questions a aussi été retiré de la grille.

🧑 Importer une fois `tp2_guilde_partie_b.sql` dans DBeaver pour confirmer les résultats du
corrigé : ils ont été calculés hors SGBD, faute d'accès au serveur local.

---

## Module 4 — Jointures et agrégations ⏳ À FAIRE

- `01-expressions-regulieres.md` — **page la plus touchée du module** (~30 mentions).
  L'opérateur `~` de PostgreSQL n'existe pas : c'est `regexp` / `rlike` en MariaDB.
  `~*` (insensible à la casse) → comportement par défaut selon la collation.
  Les fonctions `regexp_replace` / `regexp_substr` existent en MariaDB 10.0+ (ok).
- `02-jointures.md` — **la section « Full join » (lignes 226-250) doit être réécrite** :
  MariaDB ne supporte pas `full join`. À présenter comme une limite du SGBD, avec le
  contournement classique `left join union right join`. La commande d'import de Chinook
  change aussi.
- `03-fonctions-agregation.md` / `04-group-by-having.md` — quasi identiques. Attention :
  MariaDB est **permissif** sur `group by` (colonnes non agrégées acceptées selon le mode
  `ONLY_FULL_GROUP_BY`) alors que PostgreSQL refuse. Un exemple qui « marche » en MariaDB
  mais qui est une mauvaise pratique : piège pédagogique à ajouter.
- `05-sous-requetes-correlees.md` — compatible.

🧑 **Base Chinook** : il faut la version **MySQL/MariaDB** de `docs/public/databases/chinook.sql`
(elle existe officiellement). Les noms de tables/colonnes peuvent différer légèrement de la
version PostgreSQL — **toutes les requêtes d'exemple du module 4 sont à revalider** une fois
la nouvelle base importée.
🧑 **Images** : `group-by-chinook.svg` (contient du texte SQL/noms de colonnes à revoir).

---

## Module 5 — DDL avancé ⏳ À FAIRE (le plus divergent)

- `01-alter-table.md` — `alter table ... alter column type` → `modify column` /
  `change column` en MariaDB. Liens vers la doc PostgreSQL à remplacer.
- `02-cascade-delete-update.md` — `on delete cascade` identique; mais `drop table ... cascade`
  n'existe pas en MariaDB (il faut `set foreign_key_checks = 0` ou l'ordre de suppression).
- `03-index-de-colonne.md` — `create index` compatible; seuls les liens vers la doc
  PostgreSQL sont à remplacer. `drop index` demande `on ma_table` en MariaDB.
- `04-gestion-de-comptes.md` — **réécriture majeure (428 lignes)**. Le modèle
  *rôle unifié* de PostgreSQL n'existe pas en MariaDB : on a `create user 'x'@'localhost'`
  (l'hôte fait partie de l'identité !), `grant ... on base.*`, `flush privileges`,
  `show grants`. Les rôles existent (MariaDB 10.0.5+) mais fonctionnent autrement.
  La notion de schéma `public` disparaît. Toute la page est à repenser.
- `05-hachage-mots-de-passe.md` — `pgcrypto` / `crypt()` / `gen_salt()` **n'existent pas**
  en MariaDB. Remplacer par `sha2()` + sel manuel, en expliquant clairement que le hachage
  applicatif (bcrypt/argon2) reste la bonne pratique. Approche à décider ensemble.
- `06-revision-examen-2.md` — à reprendre après les autres pages du module.

🧑 **Image** : `hierarchie-utilisateur-role-privileges.svg` (35 mentions de PostgreSQL dans
le texte du SVG) — à refaire selon le modèle utilisateur@hôte de MariaDB.

---

## Hors modules — à planifier après

| Fichier | Mentions | Nature |
|---|---|---|
| `docs/labs/lab01-installations.md` | ✅ | Texte converti — reste 13 captures 🧑 |
| `docs/labs/lab09-securite.md` | 3 | Suit les changements du module 5 |
| `docs/labs/lab03-ddl.md`, `lab06-jointures.md` | 1-2 | Commandes d'import |
| `docs/travaux/tp1-creation-bd.md` | — | ⏭️ **Ignoré** (décision du 2026-09-09) |
| `docs/travaux/tp3-ddl-avance.md` | 3 | Énoncé noté, dépend du module 5 |
| `docs/public/databases/*.sql` | — | Tous les jeux de données à reconvertir 🧑 |
| `docs/public/plan-cours.pdf` | — | Le PDF mentionne probablement PostgreSQL 🧑 |
| `docs/.vitepress/config.mts` | — | Le lien nav « Documentation MariaDB » redevient correct ✅ |
| `.github/workflows/agents/bd1.md` | — | ✅ Converti le 2026-09-17 (consigne MariaDB + écarts à éviter) |
| `CLAUDE.md` | — | ✅ Converti le 2026-09-17 (section « Migration PostgreSQL → MariaDB ») |
