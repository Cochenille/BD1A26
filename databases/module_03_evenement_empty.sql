-- ============================================================
-- Module 3 — Base de démonstration « Événements » (structure seulement)
-- Cours 420-07B-FX — Introduction aux bases de données
-- SGBD : MariaDB
--
-- Importation : ouvrir ce fichier dans DBeaver (Fichier > Ouvrir un fichier...)
-- puis executer tout le script avec Alt + X, et rafraichir avec F5.
-- ============================================================

drop database if exists module_03_evenement_empty;
create database module_03_evenement_empty character set utf8mb4;
use module_03_evenement_empty;

-- ------------------------------------------------------------
-- Structure
-- ------------------------------------------------------------

create table evenement (
  id int primary key auto_increment,
  nom varchar(100) not null,
  date_evenement date not null,
  lieu varchar(100) not null,
  capacite int not null,
  actif boolean not null default true,
  check (capacite >= 0)
);

create table participant (
  id int primary key auto_increment,
  nom varchar(100) not null,
  courriel varchar(150) not null unique,
  actif boolean not null default true
);

create table inscription (
  id int primary key auto_increment,
  evenement_id int not null,
  participant_id int not null,
  date_inscription date not null default (current_date),
  unique (evenement_id, participant_id),
  foreign key (evenement_id) references evenement(id),
  foreign key (participant_id) references participant(id)
);

-- Aucune donnée : les tables sont remplies pendant la démonstration du module 3.
