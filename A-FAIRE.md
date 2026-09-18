# À faire — travail manuel en attente

Liste de travail pour la migration MariaDB. Ce fichier ne contient **que** ce qui demande une
intervention humaine (captures, vidéos, vérifications dans DBeaver). Le « pourquoi » de chaque
point et l'historique complet sont dans [`MIGRATION-MARIADB.md`](MIGRATION-MARIADB.md).

Dernière mise à jour : **2026-09-18**.

---

## 1. Captures d'écran

### Prioritaire — module 3 (matière du 24 septembre)

- [x] **`docs/modules/03-sql-base/images/voir-donnees.png`** — conservée telle quelle
  (décision du prof, 2026-09-18). L'écart qui subsiste avec le texte : la colonne `actif` y
  apparaît comme une case cochée, alors que l'encadré juste au-dessus annonce un `1` ou un `0`.

- [ ] **Nouvelle capture — import dans DBeaver**, pour `docs/modules/02-ddl-base/images/`.
  La section « Importer une base de données (DBeaver) » de `07-import-export.md` n'a plus
  d'illustration depuis la suppression de `import-command.png`. Montrer l'ouverture du fichier
  et/ou le bouton *Execute script*.

- [x] `dbeaver-location.png`, `ouvrir-dbeaver.png` — **ne sont plus référencées** depuis la
  réécriture de la page de révision d'examen 1 (elles servaient aux consignes Safe Exam Browser).
  À supprimer ou à réutiliser ailleurs.

### Module 2 — 13 captures (`docs/modules/02-ddl-base/images/`)

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

Supprimées, ne pas recréer : `session-manager.png`, `terminate.png`, `import-command.png`.

### Lab 01 — 13 captures (`docs/img/lab01/`)

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

Réutilisables telles quelles : `installateur-dbeaver.png`, `nouvelle-connexion.png`,
`refresh.png`.

---

## 2. Vidéos à réenregistrer

Les deux ont un bandeau rouge d'avertissement en place en attendant.

- [ ] `02-ddl-base/05-demo-ddl.md` — démo de création de BD (montre `serial`, pas de `use`).
- [ ] `labs/lab05-avance.md` — démo de requêtes (interface PostgreSQL).
- [ ] `travaux/tp2-sql.md` — la vidéo explicative a été **retirée** de la page : elle décrivait
      l'ancien énoncé (16 questions, PostgreSQL). À réenregistrer si vous la voulez.

---

## 3. Vérifications à faire pendant la prise de captures

- [ ] **Libellés DBeaver** utilisés dans `07-import-export.md` : le chemin exact du menu
      d'ouverture de fichier, et le nom de l'entrée `SQL Editor` → `Execute script`.
- [ ] **Encodage dans les préférences de DBeaver** — j'ai écrit « vérifier l'encodage dans les
      préférences » sans donner le chemin du menu, faute de pouvoir le confirmer.
- [ ] **Dialogue `Dump database`** — les libellés des options (`Add DROP statements`, encodage)
      peuvent différer de ce qui est écrit.
- [ ] **L'export inclut-il le `create database` ?** La page affirme que non. Si DBeaver l'inclut
      chez vous, retirer l'encadré rouge correspondant.
- [ ] **Option DBeaver « Blank line is statement delimiter »** — si elle est active, une
      instruction contenant une ligne vide (comme le `create table inscription` de la démo du
      module 2) est coupée en deux et lève une erreur de syntaxe. À vérifier avant le cours.
- [x] **`like binary`** — vérification abandonnée (décision du prof, 2026-09-18).
      L'encadré de `03-sql-base/04-operateurs.md` reste tel quel.

---

## 4. Suites de la migration

- [ ] **Prévenir les étudiants** qui ont déjà importé un jeu de données accentué avec
      `Get-Content ... | mariadb` : leurs bases contiennent des `?` à la place des accents et
      doivent être réimportées. La commande n'est plus enseignée (tout passe par DBeaver).
- [x] **TP2** — refait en deux parties et converti en MariaDB le 2026-09-18
      (voir `MIGRATION-MARIADB.md`, section « Évaluations »).
- [ ] **Partie B du TP2** — importer `tp2_guilde_partie_b.sql` une fois dans DBeaver et
      confirmer les résultats attendus du corrigé (calculés hors SGBD). Ces trois fichiers sont
      **hors dépôt** : le dépôt GitHub est public.
- [x] **`docs/grilles/grille-examen1.md`** — rédigée le 2026-09-18 (30 modélisation / 30 DDL /
      40 SQL) et ajoutée à la sidebar.
- [ ] **Page d'accueil** — ajouter la section « semaine 5 » avec ses deux `WeeklyTodo`.
- [ ] **Module 4** — Chinook version MySQL/MariaDB à récupérer, `full join` à réécrire,
      `regexp` au lieu de `~`, piège `ONLY_FULL_GROUP_BY` à ajouter.
- [ ] **Module 5** — le plus divergent : `04-gestion-de-comptes.md` (modèle utilisateur@hôte)
      et `05-hachage-mots-de-passe.md` (pas de `pgcrypto`) sont à repenser.
- [ ] **`docs/public/plan-cours.pdf`** — mentionne probablement PostgreSQL.
- [ ] **Décision en suspens** : la base *empty* n'a pas `evenement.prix` ni `inscription.actif`,
      contrairement à la base *data*. C'était déjà le cas en PostgreSQL — à confirmer que c'est
      voulu.

---

## Reprendre sur un autre poste

```bash
git pull && npm install
```

```bash
npm run docs:dev
```

Pour recharger les bases de démonstration du module 3 : ouvrir les `.sql` de
`docs/public/databases/` dans DBeaver et `Alt + X`. Les fichiers sont autoportants
(`drop database` + `create database` + `use` en tête).
