---
title: "Lab — Modélisation (papier-crayon) : Événements"
aside: false
---

# Lab 02 — Modélisation : Système d’événements

## But
Produire sur papier un **MRD** (modèle relationnel de données) comprenant :
- les **tables**
- les **colonnes et leurs types**
- les **clés primaires (PK)** et **clés étrangères (FK)**
- les **relations** et **cardinalités** (1–N, N–N)

---

## Contexte

Le cégep souhaite gérer des **événements** (conférences, ateliers, spectacles, etc.).

On veut conserver l’information sur :
- les **événements**
- les **personnes** (participants)
- les **organisateurs**
- les **inscriptions** aux événements

---

## Règles d’affaires

- Un événement est organisé par **un organisateur**.
- Un organisateur peut organiser **plusieurs événements**.
- Une personne peut s’inscrire à **plusieurs événements**.
- Un événement peut recevoir **plusieurs inscriptions**.
- Une inscription relie **une personne** et **un événement**.

---

## Travail à faire

1. Identifier les **tables**.
2. Définir les **colonnes** et leurs **types**.
3. Choisir une **PK** pour chaque table.
4. Ajouter les **FK** et les **relations**.
5. Dessiner le **MRD** et indiquer les **cardinalités**.

> Types suggérés : `INT`, `VARCHAR(n)`, `DATE`, `BOOLEAN`.

---

## À produire

- Liste des tables (colonnes + types)
- PK et FK clairement indiquées
- Relations (cardinalités)
- Schéma (sur papier)

::: tip
Papier-crayon fortement recommandé. Pour la mise au propre : https://app.diagrams.net/
:::
---

## Retour sur le lab

<div id="lab02-retour">
<iframe width="560" height="315" src="https://www.youtube.com/embed/hN4nC3aXmbY?si=UMwS4509rg9ir2ws" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>