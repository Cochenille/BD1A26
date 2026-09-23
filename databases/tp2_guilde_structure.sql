-- ============================================================
-- TP2 — Registre de la Guilde des Aventuriers
-- Structure de la base de données (partie A)
-- Cours 420-07B-FX — Introduction aux bases de données
-- SGBD : MariaDB
--
-- Importation : ouvrir ce fichier dans DBeaver (Fichier > Ouvrir un fichier...)
-- puis executer tout le script avec Alt + X, et rafraichir avec F5.
--
-- ATTENTION : ce script ne supprime pas la base si elle existe deja.
-- Pour repartir a zero, executez d'abord : drop database guilde_aventuriers;
-- Vous perdrez alors toutes vos insertions.
-- ============================================================

create database guilde_aventuriers character set utf8mb4;
use guilde_aventuriers;

-- ------------------------------------------------------------
-- Les lieux du royaume
-- Table de reference : elle est deja remplie, vous n'avez pas
-- a y inserer de donnees.
-- ------------------------------------------------------------

create table lieu (
  id int primary key auto_increment,
  nom varchar(80) not null unique,
  region varchar(60) not null,
  niveau_danger int not null check (niveau_danger between 1 and 5),
  actif boolean not null default true
);

insert into lieu (id, nom, region, niveau_danger, actif) values
  (1,  'Val-Doré',        'Vallée d''Or',     1, true),
  (2,  'Corvebois',       'Vallée d''Or',     1, true),
  (3,  'Lac Miroir',      'Vallée d''Or',     3, true),
  (4,  'Bois de Fresnes', 'Marches du Nord',  2, true),
  (5,  'Mont Brisé',      'Marches du Nord',  4, true),
  (6,  'Col des Aigles',  'Marches du Nord',  5, true),
  (7,  'Port-Grismer',    'Côte Salée',       2, true),
  (8,  'Marais Blafard',  'Côte Salée',       4, false),
  (9,  'Plaines du Sud',  'Terres Basses',    3, true),
  (10, 'Désert d''Ombre', 'Terres Basses',    5, true);

-- ------------------------------------------------------------
-- Les quetes affichees dans le royaume
-- ------------------------------------------------------------

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

-- ------------------------------------------------------------
-- Les aventuriers inscrits a la Guilde
-- ------------------------------------------------------------

create table aventurier (
  id int primary key auto_increment,
  nom varchar(90) not null,
  courriel varchar(160) not null unique,
  classe enum('guerrier', 'mage', 'assassin', 'druide', 'paladin', 'barde') not null,
  niveau int not null check (niveau between 1 and 20),
  actif boolean not null default true
);

-- ------------------------------------------------------------
-- L'equipement possede par les aventuriers
-- ------------------------------------------------------------

create table equipement (
  id int primary key auto_increment,
  nom varchar(100) not null,
  categorie enum('arme', 'armure', 'potion', 'grimoire', 'relique') not null,
  valeur_or int not null check (valeur_or >= 0),
  aventurier_id int not null,
  actif boolean not null default true,

  foreign key (aventurier_id) references aventurier(id)
);

-- ------------------------------------------------------------
-- Les contrats signes entre un aventurier et une quete
-- ------------------------------------------------------------

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
