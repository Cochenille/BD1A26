---
layout: home
title: 420-07B-FX — Introduction aux Bases de Données
hero:
  name: 420-07B-FX — Introduction aux Bases de Données
  text: Automne 2026
  image:
    src: /logos/logo.png
    alt: Logo du cours

---
<section id="semaine-8">
<div class="relative flex py-5 items-center mt-10">
   <div class="grow border-t border-gray-400"></div>
   <span class="shrink mx-4 text-gray-400">Semaine 8 — du 22 au 28 octobre</span>
  <div class="grow border-t border-gray-400"></div>
</div>
<div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
  <WeeklyTodo
    title="À faire cette semaine — En classe"
    subtitle="Activités réalisées pendant la séance."
    :steps="[
      {
        title: 'TP2 — partie B, en classe',
        description: 'Évaluation supervisée de deux heures, en début de période. Les consignes sont remises en classe.',
        badge: 'Évaluation — 7 %',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'secondary' }
        ]
      },
      {
        title: 'Module 4 — Expressions régulières',
        description: 'Construire des motifs dans regexr, puis les utiliser en MariaDB avec regexp, regexp_substr et regexp_replace.',
        links: [
          { text: 'Théorie — expressions régulières', href: '/modules/04-jointures-agregations/01-expressions-regulieres', variant: 'primary' }
        ]
      }
    ]"
  />

  <WeeklyTodo
    title="À préparer / compléter"
    subtitle="À compléter de votre côté."
    :steps="[
      {
        title: 'Remettre la partie A du TP2',
        description: 'Fichier .sql à déposer sur LÉA, au plus tard en début de période le 22 octobre.',
        badge: 'Remise — 6 %',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'primary' },
          { text: 'Grille d’évaluation', href: '/grilles/grille-tp2', variant: 'secondary' }
        ]
      },
      {
        title: 'Terminer les exercices d’expressions régulières',
        links: [
          { text: 'Exercices avec MariaDB', href: '/modules/04-jointures-agregations/01-expressions-regulieres#exercices-avec-mariadb', variant: 'primary' }
        ]
      },
      {
        title: 'Importer la base Chinook',
        description: 'Elle sert à tous les exemples sur les jointures, dès la semaine prochaine.',
        links: [
          { text: 'Importer Chinook', href: '/modules/04-jointures-agregations/02-jointures#base-de-donnees-de-test-a-importer-chinook', variant: 'secondary' }
        ]
      }
    ]"
  />
</div>
</section>

<section id="semaine-lecture">
<div class="relative flex py-5 items-center mt-10">
   <div class="grow border-t border-gray-400"></div>
   <span class="shrink mx-4 text-gray-400">Semaine de lecture — du 15 au 21 octobre</span>
  <div class="grow border-t border-gray-400"></div>
</div>
<div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
  <WeeklyTodo
    title="Pas de cours cette semaine"
    subtitle="Semaine de lecture."
    :steps="[
      {
        title: 'Aucune séance en classe',
        description: 'Profitez-en pour terminer la partie A du TP2.'
      }
    ]"
  />

  <WeeklyTodo
    title="À préparer / compléter"
    subtitle="À compléter de votre côté."
    :steps="[
      {
        title: 'Terminer la partie A du TP2',
        description: 'Écrivez vos requêtes vous-même : la partie B, en classe le 22 octobre, porte sur les mêmes notions.',
        badge: 'Remise le 22 octobre',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'primary' }
        ]
      }
    ]"
  />
</div>
</section>

<section id="semaine-7">
<div class="relative flex py-5 items-center mt-10">
   <div class="grow border-t border-gray-400"></div>
   <span class="shrink mx-4 text-gray-400">Semaine 7 — du 8 au 14 octobre</span>
  <div class="grow border-t border-gray-400"></div>
</div>
<div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
  <WeeklyTodo
    title="À faire cette semaine — En classe"
    subtitle="Activités réalisées pendant la séance."
    :steps="[
      {
        title: 'Examen 1 — sur papier',
        description: 'Porte sur les modules 1 à 3.',
        badge: 'Examen',
        links: [
          { text: 'Révision d’examen 1', href: '/modules/03-sql-base/06-examen-1', variant: 'secondary' }
        ]
      },
      {
        title: 'Atelier TP2',
        description: 'Le reste de la période est consacré à la partie A du TP2.',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'primary' }
        ]
      }
    ]"
  />

  <WeeklyTodo
    title="À préparer / compléter"
    subtitle="À compléter de votre côté."
    :steps="[
      {
        title: 'Avancer la partie A du TP2',
        badge: 'Remise le 22 octobre',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'primary' }
        ]
      }
    ]"
  />
</div>
</section>

<section id="semaine-6">
<div class="relative flex py-5 items-center mt-10">
   <div class="grow border-t border-gray-400"></div>
   <span class="shrink mx-4 text-gray-400">Semaine 6 — du 1er au 7 octobre</span>
  <div class="grow border-t border-gray-400"></div>
</div>
<div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
  <WeeklyTodo
    title="À faire cette semaine — En classe"
    subtitle="Activités réalisées pendant la séance."
    :steps="[
      {
        title: 'Lab 05 — Modification, opérateurs et sous-requêtes',
        links: [
          { text: 'Laboratoire 5', href: '/labs/lab05-avance', variant: 'primary' },
          { text: 'Théorie — sous-requêtes', href: '/modules/03-sql-base/05-sous-requetes-non-correlees', variant: 'secondary' }
        ]
      },
      {
        title: 'Révision de l’examen 1',
        links: [
          { text: 'Révision d’examen 1', href: '/modules/03-sql-base/06-examen-1', variant: 'primary' }
        ]
      }
    ]"
  />

  <WeeklyTodo
    title="À préparer / compléter"
    subtitle="À compléter de votre côté."
    :steps="[
      {
        title: 'Étudier pour l’examen 1',
        description: 'Examen sur papier le 8 octobre, modules 1 à 3.',
        links: [
          { text: 'Révision d’examen 1', href: '/modules/03-sql-base/06-examen-1', variant: 'primary' }
        ]
      },
      {
        title: 'Continuer la partie A du TP2',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'secondary' }
        ]
      }
    ]"
  />
</div>
</section>

<section id="semaine-5">
<div class="relative flex py-5 items-center mt-10">
   <div class="grow border-t border-gray-400"></div>
   <span class="shrink mx-4 text-gray-400">Semaine 5 — du 24 au 30 septembre</span>
  <div class="grow border-t border-gray-400"></div>
</div>
<div class="grid grid-cols-1 gap-5 lg:grid-cols-2">
  <WeeklyTodo
    title="À faire cette semaine — En classe"
    subtitle="Activités réalisées pendant la séance."
    :steps="[
      {
        title: 'Lab 04 — Requêtes de sélection avec filtres',
        description: 'Importer la base de démonstration, puis écrire les requêtes select du laboratoire.',
        links: [
          { text: 'Laboratoire 4', href: '/labs/lab04-select', variant: 'primary' },
          { text: 'Théorie — select et where', href: '/modules/03-sql-base/02-select-where', variant: 'secondary' }
        ]
      }
    ]"
  />

  <WeeklyTodo
    title="À préparer / compléter"
    subtitle="À compléter de votre côté."
    :steps="[
      {
        title: 'Terminer le lab 04',
        links: [
          { text: 'Laboratoire 4', href: '/labs/lab04-select', variant: 'primary' }
        ]
      },
      {
        title: 'Commencer l’énoncé du TP2',
        description: 'Créer la base de la Guilde et commencer les insertions. Les requêtes deviendront toutes faisables après le cours de la semaine prochaine.',
        badge: 'Partie A — remise le 22 octobre',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'primary' },
          { text: 'Grille d’évaluation', href: '/grilles/grille-tp2', variant: 'secondary' }
        ]
      }
    ]"
  />
</div>
</section>
