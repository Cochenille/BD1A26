---
title: Grille d’évaluation — TP2
---

# Grille d’évaluation — Travail Pratique #2

Le TP2 vaut **13 %** de la note finale, répartis en deux parties :

| Partie | Description | Poids |
|---|---|---|
| **A** | Travail à la maison — insertions et 12 requêtes | 6 % |
| **B** | Évaluation supervisée en classe, sur une base fournie | 7 % |

Chaque critère est évalué selon des niveaux de performance. Les pondérations indiquent le poids
de chaque critère dans la note de la partie concernée.

---

# Partie A — travail à la maison (6 %)

## 1) Insertion des données — 20 %

| Niveau | Description | Note |
|---|---|---|
**Excellent** | Insertions pleinement fonctionnelles. 30 à 60 lignes par table. Contraintes respectées. Données variées, cohérentes et plausibles, permettant à toutes les requêtes de retourner des résultats significatifs. | 100 % |
**Suffisant** | Insertions fonctionnelles, mais quelques éléments mineurs à ajuster (variété, cohérence ou respect de certaines contraintes). | 60 % |
**Absent ou insuffisant** | Insertions non fonctionnelles ou plusieurs éléments importants à corriger (quantité, cohérence ou contraintes). | 0 % |

---

## 2) Requêtes de sélection et sous-requêtes (Q1 à Q9) — 50 %*

| Niveau | Description | Note |
|---|---|---|
**Excellent** | Toutes les requêtes sont fonctionnelles et conformes aux consignes. Filtres, tris, colonnes demandées et gestion des doublons correctement appliqués. | 100 % |
**Suffisant** | Les requêtes fonctionnent globalement, mais un à quelques éléments mineurs sont à ajuster (tri, filtre, colonnes retournées, précision des résultats). | 60 % |
**Insuffisant** | Plusieurs requêtes ne fonctionnent pas ou produisent des résultats incorrects. Logique partiellement ou majoritairement erronée. | 0 % |

>*Chaque requête est évaluée individuellement.

---

## 3) Modifications et suppression (Q10 à Q12) — 30 %*

| Niveau | Description | Note |
|---|---|---|
**Excellent** | Les mises à jour et la suppression sont correctement ciblées. Aucune ligne non prévue n’est affectée. Logique sécuritaire et conforme aux consignes. | 100 % |
**Suffisant** | Les requêtes fonctionnent mais le ciblage ou la logique présente un ou quelques éléments mineurs à corriger. | 60 % |
**Insuffisant** | Requêtes non fonctionnelles, ciblage incorrect ou logique dangereuse (impact involontaire sur plusieurs lignes). | 0 % |

>*Chaque requête est évaluée individuellement.

---

<div class="my-6 rounded-lg border border-red-300 bg-red-50 p-4 text-red-900">
<strong>Conditions de recevabilité de la partie A</strong><br>
Le fichier doit être remis au bon format (<code>tp2_prenom_nom.sql</code>), respecter l'ordre et
les commentaires du fichier de départ, et s'exécuter <strong>du début à la fin sans erreur</strong>.
Un fichier qui s'interrompt à la première instruction est corrigé tel quel.
</div>

---

# Partie B — évaluation supervisée (7 %)

Questions courtes sur une base fournie en classe, corrigées **à la requête**. Chaque question
vaut le même nombre de points.

| Niveau | Description | Note |
|---|---|---|
**Excellent** | La requête s’exécute et retourne exactement le résultat attendu (lignes, colonnes et ordre). | 100 % |
**Suffisant** | La requête s’exécute et la logique est la bonne, mais le résultat présente un écart mineur : colonne superflue ou manquante, tri absent, doublons non éliminés, borne d’intervalle inexacte. | 60 % |
**Insuffisant** | La requête ne s’exécute pas, ou retourne un résultat qui ne correspond pas à la demande. | 0 % |

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Écart entre les deux parties</strong><br>
Un écart important entre la qualité de la partie A et celle de la partie B peut donner lieu à une
rencontre de validation, où l'étudiant est invité à expliquer le code remis en partie A.
</div>
