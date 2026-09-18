---
title: "TP2 — Partie B (évaluation supervisée)"
aside: false
---

# TP2 — Partie B — évaluation supervisée (7 %)

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Cette page est publiée au début de la période du 22 octobre.</strong><br>
Les questions vous sont remises séparément par l'enseignant.
</div>

- Durée : **1 heure**, en début de période.
- Individuel.
- Porte sur les mêmes notions que la partie A : `insert`, `select`, opérateurs, sous-requêtes,
  `update` et `delete` ciblés.

---

## Avant de commencer

1. **Importez la base fournie** : ouvrez le fichier `.sql` remis par l'enseignant dans DBeaver
   (`Fichier` → `Ouvrir un fichier…`), exécutez tout le script avec `Alt + X`, puis rafraîchissez
   l'arborescence avec `F5`.

   La structure est **la même qu'à la partie A**; seules les données changent. Il n'y a donc rien
   de nouveau à apprendre sur le modèle.

2. Créez un nouveau script SQL et nommez votre fichier **`tp2b_prenom_nom.sql`**.

3. Commencez votre fichier par son `use` :

```sql
use guilde_partie_b;
```

4. Numérotez vos réponses avec des commentaires : `-- 1)`, `-- 2)`, et ainsi de suite.

---

## Pendant l'évaluation

<div class="my-6 rounded-lg border border-red-300 bg-red-50 p-4 text-red-900">
<strong>Aide permise</strong><br>
Le <strong>site du cours uniquement</strong>. Aucune autre aide n'est permise : autres sites Web,
intelligence artificielle, notes d'un collègue, échanges entre étudiants.<br>
Tous les onglets autres que le site du cours doivent être fermés au début de la période.
</div>

Conseils :

- Avant chaque `update` ou `delete`, écrivez d'abord le `select` qui retourne les lignes visées.
  Si le `select` est bon, le `where` est bon.
- Relisez la question après avoir écrit la requête : les colonnes demandées, le tri et
  l'élimination des doublons font partie de la réponse.
- Sauvegardez votre fichier régulièrement.

---

## Remise

Remettez votre fichier `tp2b_prenom_nom.sql` sur LÉA **avant la fin de la période**.
Aucune période de grâce.

---

## Barème

Chaque question vaut le même nombre de points.

| Niveau | Description |
|---|---|
| **Complet** | La requête s'exécute et retourne exactement le résultat demandé : lignes, colonnes et ordre. |
| **Partiel** | La logique est bonne, mais il manque un détail — colonne superflue ou manquante, tri absent, doublons non éliminés, borne d'intervalle inexacte. |
| **Nul** | La requête ne s'exécute pas, ou ne répond pas à la demande. |

La grille complète du TP2 est dans les [grilles d'évaluation](./../grilles/grille-tp2).
