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
      }
      /* À décommenter en même temps que le TP2 dans config.mts :
      ,{
        title: 'Commencer l’énoncé du TP2',
        description: 'Créer la base de la Guilde et commencer les insertions. Les requêtes deviendront toutes faisables après le cours de la semaine prochaine.',
        badge: 'Partie A — remise le 22 octobre',
        links: [
          { text: 'Énoncé du TP2', href: '/travaux/tp2-sql', variant: 'primary' },
          { text: 'Grille d’évaluation', href: '/grilles/grille-tp2', variant: 'secondary' }
        ]
      }
      */
    ]"
  />
</div>
</section>
