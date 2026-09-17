-- ============================================================
-- Module 3 — Base de démonstration « Événements » (avec données)
-- Cours 420-07B-FX — Introduction aux bases de données
-- SGBD : MariaDB
--
-- Importation : ouvrir ce fichier dans DBeaver (Fichier > Ouvrir un fichier...)
-- puis executer tout le script avec Alt + X, et rafraichir avec F5.
-- ============================================================

drop database if exists module_03_evenement_data;
create database module_03_evenement_data character set utf8mb4;
use module_03_evenement_data;

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
  prix decimal(8,2) not null default 50,
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
  actif boolean not null default true,
  unique (evenement_id, participant_id),
  foreign key (evenement_id) references evenement(id),
  foreign key (participant_id) references participant(id)
);

-- ------------------------------------------------------------
-- Données
-- ------------------------------------------------------------

insert into evenement (id, nom, date_evenement, lieu, capacite, actif, prix) values
  (1, 'Conférence Tech 2026', '2026-03-15', 'Paris', 300, true, 50.00),
  (2, 'Atelier Data Science', '2026-04-02', 'Lyon', 40, true, 0.00),
  (3, 'Salon de l''Entrepreneuriat', '2026-05-20', 'Marseille', 500, true, 50.00),
  (4, 'Meetup Développement Web', '2026-02-10', 'Toulouse', 80, true, 50.00),
  (5, 'Formation Cybersécurité', '2026-06-05', 'Lille', 25, false, 0.00),
  (6, 'Conférence IA & Innovation', '2026-07-10', 'Paris', 400, true, 50.00),
  (7, 'Forum Cloud Computing', '2026-07-18', 'Lyon', 250, false, 0.00),
  (8, 'Journée Big Data', '2026-08-05', 'Nantes', 180, true, 50.00),
  (9, 'Hackathon Étudiant', '2026-08-20', 'Rennes', 120, true, 50.00),
  (10, 'Sommet Cybersécurité', '2026-09-02', 'Paris', 350, false, 50.00),
  (11, 'Atelier DevOps', '2026-09-15', 'Bordeaux', 60, true, 0.00),
  (12, 'Conférence UX/UI', '2026-09-25', 'Strasbourg', 150, true, 50.00),
  (13, 'Meetup Python', '2026-10-03', 'Grenoble', 90, true, 50.00),
  (14, 'Meetup Java', '2026-10-10', 'Nice', 90, false, 50.00),
  (15, 'Workshop Kubernetes', '2026-10-18', 'Lille', 50, true, 50.00),
  (16, 'Salon Open Source', '2026-11-02', 'Paris', 600, true, 0.00),
  (17, 'Conférence FinTech', '2026-11-12', 'La Défense', 300, true, 50.00),
  (18, 'Forum RH & Tech', '2026-11-20', 'Reims', 200, false, 50.00),
  (19, 'Journée Qualité Logicielle', '2026-12-01', 'Tours', 140, true, 50.00),
  (20, 'Conférence Green IT', '2026-12-10', 'Annecy', 160, true, 50.00),
  (21, 'Bootcamp Full Stack', '2027-01-15', 'Paris', 30, true, 50.00),
  (22, 'Atelier SQL Avancé', '2027-01-22', 'Lyon', 40, false, 0.00),
  (23, 'Conférence Mobile Dev', '2027-02-05', 'Montpellier', 220, true, 50.00),
  (24, 'Meetup Startup', '2027-02-12', 'Station F', 180, true, 50.00),
  (25, 'Forum E-commerce', '2027-02-25', 'Roubaix', 260, true, 50.00),
  (26, 'Conférence Blockchain', '2027-03-05', 'Paris', 320, false, 0.00),
  (27, 'Journée Test Logiciel', '2027-03-12', 'Angers', 110, true, 50.00),
  (28, 'Sommet IT Public', '2027-03-20', 'Bercy', 500, true, 50.00),
  (29, 'Atelier Accessibilité Web', '2027-04-02', 'Caen', 70, false, 0.00),
  (30, 'Rencontre CTO', '2027-04-10', 'Paris', 100, true, 50.00);

insert into participant (id, nom, courriel, actif) values
  (1, 'Alice Martin', 'alice.martin@example.com', true),
  (2, 'Bruno Lefèvre', 'bruno.lefevre@example.com', true),
  (3, 'Camille Dupont', 'camille.dupont@example.com', true),
  (4, 'David Moreau', 'david.moreau@example.com', true),
  (5, 'Emma Girard', 'emma.girard@gmail.com', false),
  (6, 'François Bernard', 'francois.bernard@example.com', true),
  (7, 'Julie Petit', 'julie.petit@example.com', true),
  (8, 'Alice Martin', 'alice.martin2@example.com', true),
  (9, 'Bruno Lefevre', 'bruno.lefevre2@example.com', true),
  (10, 'Camille Dupont', 'camille.dupont2@example.com', false),
  (11, 'David Morel', 'david.morel@gmail.com', true),
  (12, 'Emma Girard', 'emma.girard2@example.com', true),
  (13, 'François Bernard', 'francois.bernard2@example.com', true),
  (14, 'Julie Petit', 'julie.petit2@example.com', false),
  (15, 'Lucas Renault', 'lucas.renault@example.com', true),
  (16, 'Manon Dubois', 'manon.dubois@gmail.com', true),
  (17, 'Nicolas Faure', 'nicolas.faure@example.com', true),
  (18, 'Océane Leroy', 'oceane.leroy@example.com', true),
  (19, 'Paul Gauthier', 'paul.gauthier@hotmail.com', false),
  (20, 'Quentin Roche', 'quentin.roche@example.com', true),
  (21, 'Romain Blanchard', 'romain.blanchard@example.com', true),
  (22, 'Sarah Chevalier', 'sarah.chevalier@gmail.com', true),
  (23, 'Thomas Perrin', 'thomas.perrin@example.com', true),
  (24, 'Ulysse Marchand', 'ulysse.marchand@example.com', true),
  (25, 'Valérie Meunier', 'valerie.meunier@outlook.com', false),
  (26, 'William Henry', 'william.henry@example.com', true),
  (27, 'Zoé Colin', 'zoe.colin@gmail.com', true),
  (28, 'Antoine Lacroix', 'antoine.lacroix@example.com', true),
  (29, 'Béatrice Noel', 'beatrice.noel@example.com', true),
  (30, 'Cédric Rolland', 'cedric.rolland@hotmail.com', false),
  (31, 'Delphine Roussel', 'delphine.roussel@example.com', true),
  (32, 'Élodie Garnier', 'elodie.garnier@example.com', true),
  (33, 'Florian Picard', 'florian.picard@gmail.com', true),
  (34, 'Gaëlle Lambert', 'gaelle.lambert@example.com', true),
  (35, 'Hugo Fernandez', 'hugo.fernandez@example.com', false),
  (36, 'Inès Aubert', 'ines.aubert@example.com', true),
  (37, 'Julien Caron', 'julien.caron@example.com', true),
  (38, 'Karim Benali', 'karim.benali@hotmail.com', true),
  (39, 'Laura Masson', 'laura.masson@example.com', true),
  (40, 'Mathieu Teixeira', 'mathieu.teixeira@example.com', false),
  (41, 'Nathalie Hoarau', 'nathalie.hoarau@gmail.com', true),
  (42, 'Olivier Cousin', 'olivier.cousin@example.com', true),
  (43, 'Pascal Verdier', 'pascal.verdier@example.com', true),
  (44, 'Rachid El Amrani', 'rachid.elamrani@example.com', true),
  (45, 'Sophie Lemoine', 'sophie.lemoine@outlook.com', false),
  (46, 'Thibault Moreau', 'thibault.moreau@example.com', true),
  (47, 'Yann Leclerc', 'yann.leclerc@example.com', true);

insert into inscription (id, evenement_id, participant_id, date_inscription, actif) values
  (1, 1, 1, '2026-01-10', true),
  (2, 1, 2, '2026-01-12', true),
  (3, 1, 3, '2026-01-15', true),
  (4, 2, 2, '2026-02-01', true),
  (5, 2, 4, '2026-02-02', true),
  (6, 3, 1, '2026-03-05', true),
  (7, 3, 5, '2026-03-06', true),
  (8, 3, 6, '2026-03-07', true),
  (9, 4, 3, '2026-01-25', true),
  (10, 4, 4, '2026-01-26', true),
  (11, 4, 7, '2026-01-27', true),
  (12, 5, 2, '2026-04-01', true),
  (13, 5, 6, '2026-04-02', true),
  (21, 5, 10, '2026-01-20', true),
  (22, 6, 11, '2026-01-22', true),
  (23, 6, 12, '2026-01-23', true),
  (24, 6, 13, '2026-01-24', true),
  (25, 7, 14, '2026-01-25', true),
  (26, 7, 15, '2026-01-26', true),
  (27, 9, 16, '2026-01-28', true),
  (28, 9, 17, '2026-01-29', true),
  (29, 9, 18, '2026-01-29', true),
  (30, 9, 19, '2026-01-30', true),
  (31, 10, 20, '2026-02-01', true),
  (32, 11, 21, '2026-02-03', true),
  (33, 11, 22, '2026-02-03', true),
  (34, 13, 23, '2026-02-05', true),
  (35, 13, 24, '2026-02-06', true),
  (36, 13, 25, '2026-02-06', true),
  (37, 14, 26, '2026-02-08', true),
  (38, 15, 27, '2026-02-10', true),
  (39, 15, 28, '2026-02-11', true),
  (40, 17, 29, '2026-02-14', true),
  (41, 17, 30, '2026-02-15', true),
  (42, 17, 31, '2026-02-15', true),
  (43, 18, 32, '2026-02-18', true),
  (44, 19, 33, '2026-02-20', true),
  (45, 19, 34, '2026-02-21', true),
  (46, 21, 35, '2026-02-24', true),
  (47, 21, 36, '2026-02-24', true),
  (48, 21, 37, '2026-02-25', true),
  (49, 22, 38, '2026-02-27', true),
  (50, 23, 39, '2026-03-01', true),
  (51, 23, 40, '2026-03-02', true),
  (52, 25, 41, '2026-03-04', true),
  (53, 25, 42, '2026-03-05', true),
  (54, 25, 43, '2026-03-05', true),
  (55, 26, 44, '2026-03-07', true),
  (56, 27, 45, '2026-03-09', true),
  (57, 27, 46, '2026-03-10', true),
  (58, 29, 47, '2026-03-12', true),
  (59, 30, 1, '2026-03-15', true),
  (60, 30, 2, '2026-03-15', true),
  (61, 30, 3, '2026-03-16', true);
