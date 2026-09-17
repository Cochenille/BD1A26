import { defineConfig } from "vitepress";
import { withMermaid } from "vitepress-plugin-mermaid";

export default withMermaid(
  defineConfig({
    base: "/BD1A26/",
    lang: "fr-CA",
    cleanUrls: true,
    title: "420-07B-FX",
    description:
      "Introduction aux bases de données — Énoncés, grilles, calendrier et ressources",
    themeConfig: {
      logo: "./logos/logo.png",

      nav: [
        {
          text: "Calendrier",
          items: [{ text: "Groupe 1", link: "/plan-cours/calendrier-gr1" }],
        },
        {
          text: "Modules",
          items: [
            { text: "Module 1 — Introduction", link: "/modules/01-introduction/" },
            { text: "Module 2 — DDL de base", link: "/modules/02-ddl-base/" },
            { text: "Module 3 — SQL", link: "/modules/03-sql-base/" },
          ],
        },
        { text: "Documentation MariaDB", link: "https://mariadb.com/docs" },
      ],

      sidebar: [
        {
          text: "Documents généraux",
          items: [
            {
              text: "Calendriers",
              items: [{ text: "Groupe 1", link: "/plan-cours/calendrier-gr1" }],
            },
          ],
        },
        {
          text: "Modules du cours",
          collapsed: false,
          items: [
            {
              text: "Module 1 — Introduction",
              collapsed: true,
              items: [
                { text: "Présentation", link: "/modules/01-introduction/00-presentation" },
                { text: "Formats de données", link: "/modules/01-introduction/01-formats-donnees" },
                { text: "Structure relationnelle", link: "/modules/01-introduction/02-structure-relationnelle" },
                { text: "Modèle de données", link: "/modules/01-introduction/03-modelisation" },
              ],
            },
            {
              text: "Module 2 — DDL de base",
              collapsed: true,
              items: [
                { text: "Create database", link: "/modules/02-ddl-base/01-create-database" },
                { text: "Create table", link: "/modules/02-ddl-base/02-create-table" },
                { text: "Contraintes et Enums", link: "/modules/02-ddl-base/03-contraintes-simples" },
                { text: "Clés primaires et étrangères", link: "/modules/02-ddl-base/04-cles-primaires-etrangeres" },
                { text: "Démonstration de création de BD", link: "/modules/02-ddl-base/05-demo-ddl" },
                { text: "DROP simple", link: "/modules/02-ddl-base/06-drop-simple" },
                { text: "Import & export", link: "/modules/02-ddl-base/07-import-export" },
              ],
            },
            {
              text: "Module 3 — SQL",
              collapsed: true,
              items: [
                { text: "Insert", link: "/modules/03-sql-base/01-insert" },
                { text: "Requête de sélection (select)", link: "/modules/03-sql-base/02-select-where" },
                { text: "Update, delete", link: "/modules/03-sql-base/03-update-delete" },
                { text: "Opérateurs et filtres", link: "/modules/03-sql-base/04-operateurs" },
                { text: "Sous-requêtes non corrélées", link: "/modules/03-sql-base/05-sous-requetes-non-correlees" },
                { text: "Révision d'examen 1", link: "/modules/03-sql-base/06-examen-1" },
              ],
            },
          ],
        },
        {
          text: "Laboratoires",
          collapsed: true,
          items: [
            { text: "Lab 01 — Installations", link: "/labs/lab01-installations" },
            { text: "Lab 02 — Modélisation", link: "/labs/lab02-modelisation" },
            { text: "Lab 03 — DDL", link: "/labs/lab03-ddl" },
            { text: "Lab 04 — Requêtes select", link: "/labs/lab04-select" },
            { text: "Lab 05 — Modification, opérateurs et sous-requêtes", link: "/labs/lab05-avance" },
          ],
        },
        {
          text: "Travaux pratiques",
          collapsed: true,
          items: [],
        },
        {
          text: "Grilles d’évaluation",
          collapsed: true,
          items: [],
        },
      ],

      search: {
        provider: "local",
      },
    },

    vite: {
      optimizeDeps: {
        include: ["fastdom", "fastdom/extensions/fastdom-promised.js"],
      },
    },
  })
);
