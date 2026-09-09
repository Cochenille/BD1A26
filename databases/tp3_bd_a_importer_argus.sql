--
-- PostgreSQL database dump
--

\restrict TX87c8mm8iMhuc4kcoQvVHcl6rQ6oKiU6sKeRddzKej2uWQMeOqdnswRPdEMFnw

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-04-04 14:19:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE argus;
--
-- TOC entry 5093 (class 1262 OID 20223)
-- Name: argus; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE argus WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE argus OWNER TO postgres;

\unrestrict TX87c8mm8iMhuc4kcoQvVHcl6rQ6oKiU6sKeRddzKej2uWQMeOqdnswRPdEMFnw
\connect argus
\restrict TX87c8mm8iMhuc4kcoQvVHcl6rQ6oKiU6sKeRddzKej2uWQMeOqdnswRPdEMFnw

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 868 (class 1247 OID 20238)
-- Name: decision_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.decision_enum AS ENUM (
    'allumer',
    'eteindre',
    'chauffer',
    'refroidir',
    'verrouiller',
    'deverrouiller',
    'redemarrer',
    'envoyer_alerte',
    'activer_mode_eco',
    'lancer_autonettoyage',
    'missiles_nucleaires'
);


ALTER TYPE public.decision_enum OWNER TO postgres;

--
-- TOC entry 871 (class 1247 OID 20262)
-- Name: type_capteur_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_capteur_enum AS ENUM (
    'temperature',
    'presence',
    'niveau_cafe',
    'papier',
    'ouverture',
    'consommation'
);


ALTER TYPE public.type_capteur_enum OWNER TO postgres;

--
-- TOC entry 865 (class 1247 OID 20225)
-- Name: type_equipement_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_equipement_enum AS ENUM (
    'thermostat',
    'porte',
    'cafetiere',
    'imprimante',
    'ordinateur',
    'lumiere'
);


ALTER TYPE public.type_equipement_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 20306)
-- Name: capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capteur (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    equipement_id integer NOT NULL,
    type_capteur public.type_capteur_enum NOT NULL,
    unite character varying(20) NOT NULL,
    est_actif boolean DEFAULT true NOT NULL
);


ALTER TABLE public.capteur OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 20305)
-- Name: capteur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.capteur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.capteur_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 223
-- Name: capteur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.capteur_id_seq OWNED BY public.capteur.id;


--
-- TOC entry 228 (class 1259 OID 20344)
-- Name: decision_ia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.decision_ia (
    id integer NOT NULL,
    decision public.decision_enum NOT NULL,
    equipement_id integer NOT NULL,
    date_heure timestamp without time zone NOT NULL,
    succes boolean NOT NULL
);


ALTER TABLE public.decision_ia OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 20343)
-- Name: decision_ia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.decision_ia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.decision_ia_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 227
-- Name: decision_ia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.decision_ia_id_seq OWNED BY public.decision_ia.id;


--
-- TOC entry 222 (class 1259 OID 20288)
-- Name: equipement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipement (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    type_equipement public.type_equipement_enum NOT NULL,
    salle_id integer NOT NULL,
    est_actif boolean DEFAULT true NOT NULL
);


ALTER TABLE public.equipement OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20287)
-- Name: equipement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipement_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 221
-- Name: equipement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipement_id_seq OWNED BY public.equipement.id;


--
-- TOC entry 226 (class 1259 OID 20327)
-- Name: lecture_capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecture_capteur (
    id integer NOT NULL,
    capteur_id integer NOT NULL,
    type_capteur public.type_capteur_enum NOT NULL,
    date_heure timestamp without time zone NOT NULL,
    valeur numeric(10,2) NOT NULL
);


ALTER TABLE public.lecture_capteur OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20326)
-- Name: lecture_capteur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lecture_capteur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lecture_capteur_id_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 225
-- Name: lecture_capteur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lecture_capteur_id_seq OWNED BY public.lecture_capteur.id;


--
-- TOC entry 230 (class 1259 OID 20361)
-- Name: log_systeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log_systeme (
    id integer NOT NULL,
    date_heure timestamp without time zone NOT NULL,
    code_log character varying(50) NOT NULL,
    message character varying(255) NOT NULL,
    niveau character varying(20) NOT NULL,
    equipement_id integer
);


ALTER TABLE public.log_systeme OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 20360)
-- Name: log_systeme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.log_systeme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_systeme_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 229
-- Name: log_systeme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.log_systeme_id_seq OWNED BY public.log_systeme.id;


--
-- TOC entry 220 (class 1259 OID 20276)
-- Name: salle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salle (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    nom character varying(100) NOT NULL,
    etage integer NOT NULL,
    CONSTRAINT salle_etage_check CHECK (((etage >= 1) AND (etage <= 3)))
);


ALTER TABLE public.salle OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 20275)
-- Name: salle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salle_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 219
-- Name: salle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salle_id_seq OWNED BY public.salle.id;


--
-- TOC entry 232 (class 1259 OID 20378)
-- Name: utilisateur_systeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur_systeme (
    id integer NOT NULL,
    nom_utilisateur character varying(50),
    courriel character varying(150),
    niveau_acces character varying(20),
    mot_de_passe character varying(255) NOT NULL,
    actif boolean DEFAULT true NOT NULL,
    dernier_acces timestamp without time zone
);


ALTER TABLE public.utilisateur_systeme OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 20377)
-- Name: utilisateur_systeme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_systeme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_systeme_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 231
-- Name: utilisateur_systeme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_systeme_id_seq OWNED BY public.utilisateur_systeme.id;


--
-- TOC entry 4898 (class 2604 OID 20309)
-- Name: capteur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur ALTER COLUMN id SET DEFAULT nextval('public.capteur_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 20347)
-- Name: decision_ia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_ia ALTER COLUMN id SET DEFAULT nextval('public.decision_ia_id_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 20291)
-- Name: equipement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement ALTER COLUMN id SET DEFAULT nextval('public.equipement_id_seq'::regclass);


--
-- TOC entry 4900 (class 2604 OID 20330)
-- Name: lecture_capteur id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecture_capteur ALTER COLUMN id SET DEFAULT nextval('public.lecture_capteur_id_seq'::regclass);


--
-- TOC entry 4902 (class 2604 OID 20364)
-- Name: log_systeme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_systeme ALTER COLUMN id SET DEFAULT nextval('public.log_systeme_id_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 20279)
-- Name: salle id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salle ALTER COLUMN id SET DEFAULT nextval('public.salle_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 20381)
-- Name: utilisateur_systeme id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur_systeme ALTER COLUMN id SET DEFAULT nextval('public.utilisateur_systeme_id_seq'::regclass);


--
-- TOC entry 5079 (class 0 OID 20306)
-- Dependencies: 224
-- Data for Name: capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.capteur (id, code, equipement_id, type_capteur, unite, est_actif) FROM stdin;
1	CAP-OUV-001-01	1	ouverture	bool	t
2	CAP-OUV-004-01	4	ouverture	bool	t
3	CAP-OUV-009-01	9	ouverture	bool	t
4	CAP-OUV-012-01	12	ouverture	bool	t
5	CAP-OUV-017-01	17	ouverture	bool	t
6	CAP-OUV-021-01	21	ouverture	bool	t
7	CAP-OUV-025-01	25	ouverture	bool	t
8	CAP-OUV-031-01	31	ouverture	bool	t
9	CAP-TMP-005-01	5	temperature	degC	t
10	CAP-TMP-010-01	10	temperature	degC	t
11	CAP-TMP-013-01	13	temperature	degC	t
12	CAP-TMP-018-01	18	temperature	degC	t
13	CAP-TMP-022-01	22	temperature	degC	t
14	CAP-TMP-026-01	26	temperature	degC	t
15	CAP-TMP-032-01	32	temperature	degC	t
16	CAP-CON-005-02	5	consommation	W	t
17	CAP-CON-010-02	10	consommation	W	t
18	CAP-CON-013-02	13	consommation	W	t
19	CAP-CON-018-02	18	consommation	W	t
20	CAP-CON-022-02	22	consommation	W	t
21	CAP-CON-026-02	26	consommation	W	t
22	CAP-CON-032-02	32	consommation	W	t
23	CAP-CON-002-01	2	consommation	W	t
24	CAP-CON-006-01	6	consommation	W	t
25	CAP-CON-014-01	14	consommation	W	t
26	CAP-CON-019-01	19	consommation	W	t
27	CAP-CON-023-01	23	consommation	W	t
28	CAP-CON-027-01	27	consommation	W	t
29	CAP-CON-033-01	33	consommation	W	t
30	CAP-PAP-007-01	7	papier	feuilles	t
31	CAP-PAP-015-01	15	papier	feuilles	t
32	CAP-PAP-029-01	29	papier	feuilles	t
33	CAP-PAP-035-01	35	papier	feuilles	t
34	CAP-CON-007-02	7	consommation	W	t
35	CAP-CON-015-02	15	consommation	W	t
36	CAP-CON-029-02	29	consommation	W	t
37	CAP-CON-035-02	35	consommation	W	t
38	CAP-PRE-003-01	3	presence	bool	t
39	CAP-PRE-008-01	8	presence	bool	t
40	CAP-PRE-011-01	11	presence	bool	t
41	CAP-PRE-016-01	16	presence	bool	t
42	CAP-PRE-020-01	20	presence	bool	t
43	CAP-PRE-030-01	30	presence	bool	t
44	CAP-PRE-036-01	36	presence	bool	t
45	CAP-CON-003-02	3	consommation	W	t
46	CAP-CON-008-02	8	consommation	W	t
47	CAP-CON-011-02	11	consommation	W	t
48	CAP-CON-016-02	16	consommation	W	t
49	CAP-CON-020-02	20	consommation	W	t
50	CAP-CON-030-02	30	consommation	W	t
51	CAP-CON-036-02	36	consommation	W	t
52	CAP-CAF-024-01	24	niveau_cafe	pct	t
53	CAP-CAF-028-01	28	niveau_cafe	pct	t
54	CAP-CAF-034-01	34	niveau_cafe	pct	t
55	CAP-CON-024-02	24	consommation	W	t
56	CAP-CON-028-02	28	consommation	W	t
57	CAP-CON-034-02	34	consommation	W	t
\.


--
-- TOC entry 5083 (class 0 OID 20344)
-- Dependencies: 228
-- Data for Name: decision_ia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.decision_ia (id, decision, equipement_id, date_heure, succes) FROM stdin;
1	allumer	2	2026-02-17 07:35:00	t
2	chauffer	5	2026-02-17 07:40:00	t
3	verrouiller	31	2026-02-17 07:50:00	t
4	deverrouiller	31	2026-02-17 07:51:00	t
5	activer_mode_eco	16	2026-02-17 07:55:00	t
6	envoyer_alerte	28	2026-02-17 08:15:00	t
7	verrouiller	25	2026-02-17 08:16:00	t
8	eteindre	27	2026-02-17 08:17:00	t
9	redemarrer	29	2026-02-17 08:18:00	t
10	redemarrer	29	2026-02-17 08:19:00	t
11	redemarrer	29	2026-02-17 08:20:00	t
12	refroidir	26	2026-02-17 08:21:00	t
13	activer_mode_eco	30	2026-02-17 08:24:00	t
14	lancer_autonettoyage	28	2026-02-17 08:25:00	f
15	deverrouiller	25	2026-02-17 08:28:00	f
16	activer_mode_eco	36	2026-02-17 08:35:00	t
\.


--
-- TOC entry 5077 (class 0 OID 20288)
-- Dependencies: 222
-- Data for Name: equipement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipement (id, nom, type_equipement, salle_id, est_actif) FROM stdin;
1	POR-A101	porte	1	t
2	LUM-A101	lumiere	1	t
3	ORD-A101	ordinateur	1	t
4	POR-A102	porte	2	t
5	THM-A102	thermostat	2	t
6	LUM-A102	lumiere	2	t
7	IMP-A102	imprimante	2	t
8	ORD-A102	ordinateur	2	t
9	POR-A103	porte	3	t
10	THM-A103	thermostat	3	t
11	ORD-A103	ordinateur	3	t
12	POR-B201	porte	4	t
13	THM-B201	thermostat	4	t
14	LUM-B201	lumiere	4	t
15	IMP-B201	imprimante	4	t
16	ORD-B201	ordinateur	4	t
17	POR-B202	porte	5	t
18	THM-B202	thermostat	5	t
19	LUM-B202	lumiere	5	t
20	ORD-B202	ordinateur	5	t
21	POR-B203	porte	6	t
22	THM-B203	thermostat	6	t
23	LUM-B203	lumiere	6	t
24	CAF-B203	cafetiere	6	t
25	POR-B204	porte	7	t
26	THM-B204	thermostat	7	t
27	LUM-B204	lumiere	7	t
28	CAF-B204	cafetiere	7	t
29	IMP-B204	imprimante	7	t
30	ORD-B204	ordinateur	7	t
31	POR-C301	porte	8	t
32	THM-C301	thermostat	8	t
33	LUM-C301	lumiere	8	t
34	CAF-C301	cafetiere	8	t
35	IMP-C301	imprimante	8	t
36	ORD-C301	ordinateur	8	t
\.


--
-- TOC entry 5081 (class 0 OID 20327)
-- Dependencies: 226
-- Data for Name: lecture_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecture_capteur (id, capteur_id, type_capteur, date_heure, valeur) FROM stdin;
1	1	ouverture	2026-02-17 07:30:00	1.00
2	2	ouverture	2026-02-17 07:30:00	1.00
3	3	ouverture	2026-02-17 07:30:00	1.00
4	4	ouverture	2026-02-17 07:30:00	1.00
5	5	ouverture	2026-02-17 07:30:00	1.00
6	6	ouverture	2026-02-17 07:30:00	1.00
7	7	ouverture	2026-02-17 07:30:00	1.00
8	8	ouverture	2026-02-17 07:30:00	1.00
9	9	temperature	2026-02-17 07:30:00	22.20
10	10	temperature	2026-02-17 07:30:00	21.60
11	11	temperature	2026-02-17 07:30:00	21.60
12	12	temperature	2026-02-17 07:30:00	21.00
13	13	temperature	2026-02-17 07:30:00	21.60
14	14	temperature	2026-02-17 07:30:00	22.20
15	15	temperature	2026-02-17 07:30:00	22.20
16	16	consommation	2026-02-17 07:30:00	118.00
17	17	consommation	2026-02-17 07:30:00	126.00
18	18	consommation	2026-02-17 07:30:00	118.00
19	19	consommation	2026-02-17 07:30:00	126.00
20	20	consommation	2026-02-17 07:30:00	126.00
21	21	consommation	2026-02-17 07:30:00	126.00
22	22	consommation	2026-02-17 07:30:00	110.00
23	23	consommation	2026-02-17 07:30:00	43.00
24	24	consommation	2026-02-17 07:30:00	35.00
25	25	consommation	2026-02-17 07:30:00	43.00
26	26	consommation	2026-02-17 07:30:00	39.00
27	27	consommation	2026-02-17 07:30:00	43.00
28	28	consommation	2026-02-17 07:30:00	35.00
29	29	consommation	2026-02-17 07:30:00	35.00
30	30	papier	2026-02-17 07:30:00	474.00
31	31	papier	2026-02-17 07:30:00	480.00
32	32	papier	2026-02-17 07:30:00	468.00
33	33	papier	2026-02-17 07:30:00	480.00
34	34	consommation	2026-02-17 07:30:00	125.00
35	35	consommation	2026-02-17 07:30:00	125.00
36	36	consommation	2026-02-17 07:30:00	105.00
37	37	consommation	2026-02-17 07:30:00	125.00
38	38	presence	2026-02-17 07:30:00	0.00
39	39	presence	2026-02-17 07:30:00	0.00
40	40	presence	2026-02-17 07:30:00	0.00
41	41	presence	2026-02-17 07:30:00	0.00
42	42	presence	2026-02-17 07:30:00	0.00
43	43	presence	2026-02-17 07:30:00	0.00
44	44	presence	2026-02-17 07:30:00	0.00
45	45	consommation	2026-02-17 07:30:00	176.00
46	46	consommation	2026-02-17 07:30:00	176.00
47	47	consommation	2026-02-17 07:30:00	152.00
48	48	consommation	2026-02-17 07:30:00	152.00
49	49	consommation	2026-02-17 07:30:00	140.00
50	50	consommation	2026-02-17 07:30:00	140.00
51	51	consommation	2026-02-17 07:30:00	152.00
52	52	niveau_cafe	2026-02-17 07:30:00	92.00
53	53	niveau_cafe	2026-02-17 07:30:00	88.00
54	54	niveau_cafe	2026-02-17 07:30:00	88.00
55	55	consommation	2026-02-17 07:30:00	760.00
56	56	consommation	2026-02-17 07:30:00	805.00
57	57	consommation	2026-02-17 07:30:00	805.00
58	1	ouverture	2026-02-17 07:45:00	0.00
59	2	ouverture	2026-02-17 07:45:00	0.00
60	3	ouverture	2026-02-17 07:45:00	0.00
61	4	ouverture	2026-02-17 07:45:00	0.00
62	5	ouverture	2026-02-17 07:45:00	0.00
63	6	ouverture	2026-02-17 07:45:00	0.00
64	7	ouverture	2026-02-17 07:45:00	0.00
65	8	ouverture	2026-02-17 07:45:00	0.00
66	9	temperature	2026-02-17 07:45:00	22.40
67	10	temperature	2026-02-17 07:45:00	21.80
68	11	temperature	2026-02-17 07:45:00	21.80
69	12	temperature	2026-02-17 07:45:00	21.20
70	13	temperature	2026-02-17 07:45:00	21.80
71	14	temperature	2026-02-17 07:45:00	22.40
72	15	temperature	2026-02-17 07:45:00	22.40
73	16	consommation	2026-02-17 07:45:00	121.00
74	17	consommation	2026-02-17 07:45:00	129.00
75	18	consommation	2026-02-17 07:45:00	121.00
76	19	consommation	2026-02-17 07:45:00	129.00
77	20	consommation	2026-02-17 07:45:00	129.00
78	21	consommation	2026-02-17 07:45:00	129.00
79	22	consommation	2026-02-17 07:45:00	113.00
80	23	consommation	2026-02-17 07:45:00	43.00
81	24	consommation	2026-02-17 07:45:00	35.00
82	25	consommation	2026-02-17 07:45:00	43.00
83	26	consommation	2026-02-17 07:45:00	39.00
84	27	consommation	2026-02-17 07:45:00	43.00
85	28	consommation	2026-02-17 07:45:00	35.00
86	29	consommation	2026-02-17 07:45:00	35.00
87	30	papier	2026-02-17 07:45:00	470.00
88	31	papier	2026-02-17 07:45:00	476.00
89	32	papier	2026-02-17 07:45:00	464.00
90	33	papier	2026-02-17 07:45:00	476.00
91	34	consommation	2026-02-17 07:45:00	130.00
92	35	consommation	2026-02-17 07:45:00	130.00
93	36	consommation	2026-02-17 07:45:00	110.00
94	37	consommation	2026-02-17 07:45:00	130.00
95	38	presence	2026-02-17 07:45:00	0.00
96	39	presence	2026-02-17 07:45:00	0.00
97	40	presence	2026-02-17 07:45:00	0.00
98	41	presence	2026-02-17 07:45:00	0.00
99	42	presence	2026-02-17 07:45:00	0.00
100	43	presence	2026-02-17 07:45:00	0.00
101	44	presence	2026-02-17 07:45:00	0.00
102	45	consommation	2026-02-17 07:45:00	183.00
103	46	consommation	2026-02-17 07:45:00	183.00
104	47	consommation	2026-02-17 07:45:00	159.00
105	48	consommation	2026-02-17 07:45:00	159.00
106	49	consommation	2026-02-17 07:45:00	147.00
107	50	consommation	2026-02-17 07:45:00	147.00
108	51	consommation	2026-02-17 07:45:00	159.00
109	52	niveau_cafe	2026-02-17 07:45:00	86.00
110	53	niveau_cafe	2026-02-17 07:45:00	82.00
111	54	niveau_cafe	2026-02-17 07:45:00	82.00
112	55	consommation	2026-02-17 07:45:00	772.00
113	56	consommation	2026-02-17 07:45:00	817.00
114	57	consommation	2026-02-17 07:45:00	817.00
115	1	ouverture	2026-02-17 08:00:00	0.00
116	2	ouverture	2026-02-17 08:00:00	0.00
117	3	ouverture	2026-02-17 08:00:00	0.00
118	4	ouverture	2026-02-17 08:00:00	0.00
119	5	ouverture	2026-02-17 08:00:00	0.00
120	6	ouverture	2026-02-17 08:00:00	0.00
121	7	ouverture	2026-02-17 08:00:00	0.00
122	8	ouverture	2026-02-17 08:00:00	0.00
123	9	temperature	2026-02-17 08:00:00	22.60
124	10	temperature	2026-02-17 08:00:00	22.00
125	11	temperature	2026-02-17 08:00:00	22.00
126	12	temperature	2026-02-17 08:00:00	21.40
127	13	temperature	2026-02-17 08:00:00	22.00
128	14	temperature	2026-02-17 08:00:00	22.60
129	15	temperature	2026-02-17 08:00:00	22.60
130	16	consommation	2026-02-17 08:00:00	124.00
131	17	consommation	2026-02-17 08:00:00	132.00
132	18	consommation	2026-02-17 08:00:00	124.00
133	19	consommation	2026-02-17 08:00:00	132.00
134	20	consommation	2026-02-17 08:00:00	132.00
135	21	consommation	2026-02-17 08:00:00	132.00
136	22	consommation	2026-02-17 08:00:00	116.00
137	23	consommation	2026-02-17 08:00:00	43.00
138	24	consommation	2026-02-17 08:00:00	35.00
139	25	consommation	2026-02-17 08:00:00	43.00
140	26	consommation	2026-02-17 08:00:00	39.00
141	27	consommation	2026-02-17 08:00:00	43.00
142	28	consommation	2026-02-17 08:00:00	35.00
143	29	consommation	2026-02-17 08:00:00	35.00
144	30	papier	2026-02-17 08:00:00	466.00
145	31	papier	2026-02-17 08:00:00	472.00
146	32	papier	2026-02-17 08:00:00	460.00
147	33	papier	2026-02-17 08:00:00	472.00
148	34	consommation	2026-02-17 08:00:00	135.00
149	35	consommation	2026-02-17 08:00:00	135.00
150	36	consommation	2026-02-17 08:00:00	115.00
151	37	consommation	2026-02-17 08:00:00	135.00
152	38	presence	2026-02-17 08:00:00	0.00
153	39	presence	2026-02-17 08:00:00	1.00
154	40	presence	2026-02-17 08:00:00	0.00
155	41	presence	2026-02-17 08:00:00	1.00
156	42	presence	2026-02-17 08:00:00	1.00
157	43	presence	2026-02-17 08:00:00	1.00
158	44	presence	2026-02-17 08:00:00	1.00
159	45	consommation	2026-02-17 08:00:00	190.00
160	46	consommation	2026-02-17 08:00:00	190.00
161	47	consommation	2026-02-17 08:00:00	166.00
162	48	consommation	2026-02-17 08:00:00	166.00
163	49	consommation	2026-02-17 08:00:00	154.00
164	50	consommation	2026-02-17 08:00:00	154.00
165	51	consommation	2026-02-17 08:00:00	166.00
166	52	niveau_cafe	2026-02-17 08:00:00	80.00
167	53	niveau_cafe	2026-02-17 08:00:00	76.00
168	54	niveau_cafe	2026-02-17 08:00:00	76.00
169	55	consommation	2026-02-17 08:00:00	784.00
170	56	consommation	2026-02-17 08:00:00	829.00
171	57	consommation	2026-02-17 08:00:00	829.00
172	1	ouverture	2026-02-17 08:15:00	1.00
173	2	ouverture	2026-02-17 08:15:00	1.00
174	3	ouverture	2026-02-17 08:15:00	1.00
175	4	ouverture	2026-02-17 08:15:00	1.00
176	5	ouverture	2026-02-17 08:15:00	1.00
177	6	ouverture	2026-02-17 08:15:00	1.00
178	7	ouverture	2026-02-17 08:15:00	1.00
179	8	ouverture	2026-02-17 08:15:00	1.00
180	9	temperature	2026-02-17 08:15:00	22.80
181	10	temperature	2026-02-17 08:15:00	22.20
182	11	temperature	2026-02-17 08:15:00	22.20
183	12	temperature	2026-02-17 08:15:00	21.60
184	13	temperature	2026-02-17 08:15:00	22.20
185	14	temperature	2026-02-17 08:15:00	22.80
186	15	temperature	2026-02-17 08:15:00	22.80
187	16	consommation	2026-02-17 08:15:00	127.00
188	17	consommation	2026-02-17 08:15:00	135.00
189	18	consommation	2026-02-17 08:15:00	127.00
190	19	consommation	2026-02-17 08:15:00	135.00
191	20	consommation	2026-02-17 08:15:00	135.00
192	21	consommation	2026-02-17 08:15:00	135.00
193	22	consommation	2026-02-17 08:15:00	119.00
194	23	consommation	2026-02-17 08:15:00	43.00
195	24	consommation	2026-02-17 08:15:00	35.00
196	25	consommation	2026-02-17 08:15:00	43.00
197	26	consommation	2026-02-17 08:15:00	39.00
198	27	consommation	2026-02-17 08:15:00	43.00
199	28	consommation	2026-02-17 08:15:00	35.00
200	29	consommation	2026-02-17 08:15:00	35.00
201	30	papier	2026-02-17 08:15:00	462.00
202	31	papier	2026-02-17 08:15:00	468.00
203	32	papier	2026-02-17 08:15:00	456.00
204	33	papier	2026-02-17 08:15:00	468.00
205	34	consommation	2026-02-17 08:15:00	140.00
206	35	consommation	2026-02-17 08:15:00	140.00
207	36	consommation	2026-02-17 08:15:00	310.00
208	37	consommation	2026-02-17 08:15:00	140.00
209	38	presence	2026-02-17 08:15:00	0.00
210	39	presence	2026-02-17 08:15:00	1.00
211	40	presence	2026-02-17 08:15:00	0.00
212	41	presence	2026-02-17 08:15:00	1.00
213	42	presence	2026-02-17 08:15:00	1.00
214	43	presence	2026-02-17 08:15:00	1.00
215	44	presence	2026-02-17 08:15:00	1.00
216	45	consommation	2026-02-17 08:15:00	197.00
217	46	consommation	2026-02-17 08:15:00	197.00
218	47	consommation	2026-02-17 08:15:00	173.00
219	48	consommation	2026-02-17 08:15:00	173.00
220	49	consommation	2026-02-17 08:15:00	161.00
221	50	consommation	2026-02-17 08:15:00	161.00
222	51	consommation	2026-02-17 08:15:00	173.00
223	52	niveau_cafe	2026-02-17 08:15:00	74.00
224	53	niveau_cafe	2026-02-17 08:15:00	58.00
225	54	niveau_cafe	2026-02-17 08:15:00	70.00
226	55	consommation	2026-02-17 08:15:00	796.00
227	56	consommation	2026-02-17 08:15:00	1820.00
228	57	consommation	2026-02-17 08:15:00	841.00
229	1	ouverture	2026-02-17 08:30:00	0.00
230	2	ouverture	2026-02-17 08:30:00	0.00
231	3	ouverture	2026-02-17 08:30:00	0.00
232	4	ouverture	2026-02-17 08:30:00	0.00
233	5	ouverture	2026-02-17 08:30:00	0.00
234	6	ouverture	2026-02-17 08:30:00	0.00
235	7	ouverture	2026-02-17 08:30:00	0.00
236	8	ouverture	2026-02-17 08:30:00	0.00
237	9	temperature	2026-02-17 08:30:00	23.00
238	10	temperature	2026-02-17 08:30:00	22.40
239	11	temperature	2026-02-17 08:30:00	22.40
240	12	temperature	2026-02-17 08:30:00	21.80
241	13	temperature	2026-02-17 08:30:00	22.40
242	14	temperature	2026-02-17 08:30:00	17.00
243	15	temperature	2026-02-17 08:30:00	23.00
244	16	consommation	2026-02-17 08:30:00	130.00
245	17	consommation	2026-02-17 08:30:00	138.00
246	18	consommation	2026-02-17 08:30:00	130.00
247	19	consommation	2026-02-17 08:30:00	138.00
248	20	consommation	2026-02-17 08:30:00	138.00
249	21	consommation	2026-02-17 08:30:00	240.00
250	22	consommation	2026-02-17 08:30:00	122.00
251	23	consommation	2026-02-17 08:30:00	43.00
252	24	consommation	2026-02-17 08:30:00	35.00
253	25	consommation	2026-02-17 08:30:00	43.00
254	26	consommation	2026-02-17 08:30:00	39.00
255	27	consommation	2026-02-17 08:30:00	43.00
256	28	consommation	2026-02-17 08:30:00	35.00
257	29	consommation	2026-02-17 08:30:00	35.00
258	30	papier	2026-02-17 08:30:00	458.00
259	31	papier	2026-02-17 08:30:00	464.00
260	32	papier	2026-02-17 08:30:00	452.00
261	33	papier	2026-02-17 08:30:00	464.00
262	34	consommation	2026-02-17 08:30:00	145.00
263	35	consommation	2026-02-17 08:30:00	145.00
264	36	consommation	2026-02-17 08:30:00	310.00
265	37	consommation	2026-02-17 08:30:00	145.00
266	38	presence	2026-02-17 08:30:00	0.00
267	39	presence	2026-02-17 08:30:00	1.00
268	40	presence	2026-02-17 08:30:00	0.00
269	41	presence	2026-02-17 08:30:00	1.00
270	42	presence	2026-02-17 08:30:00	1.00
271	43	presence	2026-02-17 08:30:00	1.00
272	44	presence	2026-02-17 08:30:00	1.00
273	45	consommation	2026-02-17 08:30:00	204.00
274	46	consommation	2026-02-17 08:30:00	204.00
275	47	consommation	2026-02-17 08:30:00	180.00
276	48	consommation	2026-02-17 08:30:00	180.00
277	49	consommation	2026-02-17 08:30:00	168.00
278	50	consommation	2026-02-17 08:30:00	168.00
279	51	consommation	2026-02-17 08:30:00	180.00
280	52	niveau_cafe	2026-02-17 08:30:00	68.00
281	53	niveau_cafe	2026-02-17 08:30:00	64.00
282	54	niveau_cafe	2026-02-17 08:30:00	64.00
283	55	consommation	2026-02-17 08:30:00	808.00
284	56	consommation	2026-02-17 08:30:00	853.00
285	57	consommation	2026-02-17 08:30:00	853.00
286	1	ouverture	2026-02-17 08:45:00	1.00
287	2	ouverture	2026-02-17 08:45:00	1.00
288	3	ouverture	2026-02-17 08:45:00	1.00
289	4	ouverture	2026-02-17 08:45:00	1.00
290	5	ouverture	2026-02-17 08:45:00	1.00
291	6	ouverture	2026-02-17 08:45:00	1.00
292	7	ouverture	2026-02-17 08:45:00	1.00
293	8	ouverture	2026-02-17 08:45:00	1.00
294	9	temperature	2026-02-17 08:45:00	23.20
295	10	temperature	2026-02-17 08:45:00	22.60
296	11	temperature	2026-02-17 08:45:00	22.60
297	12	temperature	2026-02-17 08:45:00	22.00
298	13	temperature	2026-02-17 08:45:00	22.60
299	14	temperature	2026-02-17 08:45:00	17.00
300	15	temperature	2026-02-17 08:45:00	23.20
301	16	consommation	2026-02-17 08:45:00	133.00
302	17	consommation	2026-02-17 08:45:00	141.00
303	18	consommation	2026-02-17 08:45:00	133.00
304	19	consommation	2026-02-17 08:45:00	141.00
305	20	consommation	2026-02-17 08:45:00	141.00
306	21	consommation	2026-02-17 08:45:00	240.00
307	22	consommation	2026-02-17 08:45:00	125.00
308	23	consommation	2026-02-17 08:45:00	43.00
309	24	consommation	2026-02-17 08:45:00	35.00
310	25	consommation	2026-02-17 08:45:00	43.00
311	26	consommation	2026-02-17 08:45:00	39.00
312	27	consommation	2026-02-17 08:45:00	43.00
313	28	consommation	2026-02-17 08:45:00	35.00
314	29	consommation	2026-02-17 08:45:00	35.00
315	30	papier	2026-02-17 08:45:00	454.00
316	31	papier	2026-02-17 08:45:00	460.00
317	32	papier	2026-02-17 08:45:00	448.00
318	33	papier	2026-02-17 08:45:00	460.00
319	34	consommation	2026-02-17 08:45:00	150.00
320	35	consommation	2026-02-17 08:45:00	150.00
321	36	consommation	2026-02-17 08:45:00	310.00
322	37	consommation	2026-02-17 08:45:00	150.00
323	38	presence	2026-02-17 08:45:00	0.00
324	39	presence	2026-02-17 08:45:00	1.00
325	40	presence	2026-02-17 08:45:00	0.00
326	41	presence	2026-02-17 08:45:00	1.00
327	42	presence	2026-02-17 08:45:00	1.00
328	43	presence	2026-02-17 08:45:00	1.00
329	44	presence	2026-02-17 08:45:00	1.00
330	45	consommation	2026-02-17 08:45:00	211.00
331	46	consommation	2026-02-17 08:45:00	211.00
332	47	consommation	2026-02-17 08:45:00	187.00
333	48	consommation	2026-02-17 08:45:00	187.00
334	49	consommation	2026-02-17 08:45:00	175.00
335	50	consommation	2026-02-17 08:45:00	175.00
336	51	consommation	2026-02-17 08:45:00	187.00
337	52	niveau_cafe	2026-02-17 08:45:00	62.00
338	53	niveau_cafe	2026-02-17 08:45:00	58.00
339	54	niveau_cafe	2026-02-17 08:45:00	58.00
340	55	consommation	2026-02-17 08:45:00	820.00
341	56	consommation	2026-02-17 08:45:00	865.00
342	57	consommation	2026-02-17 08:45:00	865.00
343	1	ouverture	2026-02-17 09:00:00	0.00
344	2	ouverture	2026-02-17 09:00:00	0.00
345	3	ouverture	2026-02-17 09:00:00	0.00
346	4	ouverture	2026-02-17 09:00:00	0.00
347	5	ouverture	2026-02-17 09:00:00	0.00
348	6	ouverture	2026-02-17 09:00:00	0.00
349	7	ouverture	2026-02-17 09:00:00	0.00
350	8	ouverture	2026-02-17 09:00:00	0.00
351	9	temperature	2026-02-17 09:00:00	23.40
352	10	temperature	2026-02-17 09:00:00	22.80
353	11	temperature	2026-02-17 09:00:00	22.80
354	12	temperature	2026-02-17 09:00:00	22.20
355	13	temperature	2026-02-17 09:00:00	22.80
356	14	temperature	2026-02-17 09:00:00	17.00
357	15	temperature	2026-02-17 09:00:00	23.40
358	16	consommation	2026-02-17 09:00:00	136.00
359	17	consommation	2026-02-17 09:00:00	144.00
360	18	consommation	2026-02-17 09:00:00	136.00
361	19	consommation	2026-02-17 09:00:00	144.00
362	20	consommation	2026-02-17 09:00:00	144.00
363	21	consommation	2026-02-17 09:00:00	240.00
364	22	consommation	2026-02-17 09:00:00	128.00
365	23	consommation	2026-02-17 09:00:00	43.00
366	24	consommation	2026-02-17 09:00:00	35.00
367	25	consommation	2026-02-17 09:00:00	43.00
368	26	consommation	2026-02-17 09:00:00	39.00
369	27	consommation	2026-02-17 09:00:00	43.00
370	28	consommation	2026-02-17 09:00:00	35.00
371	29	consommation	2026-02-17 09:00:00	35.00
372	30	papier	2026-02-17 09:00:00	450.00
373	31	papier	2026-02-17 09:00:00	456.00
374	32	papier	2026-02-17 09:00:00	444.00
375	33	papier	2026-02-17 09:00:00	456.00
376	34	consommation	2026-02-17 09:00:00	155.00
377	35	consommation	2026-02-17 09:00:00	155.00
378	36	consommation	2026-02-17 09:00:00	135.00
379	37	consommation	2026-02-17 09:00:00	155.00
380	38	presence	2026-02-17 09:00:00	0.00
381	39	presence	2026-02-17 09:00:00	1.00
382	40	presence	2026-02-17 09:00:00	0.00
383	41	presence	2026-02-17 09:00:00	1.00
384	42	presence	2026-02-17 09:00:00	1.00
385	43	presence	2026-02-17 09:00:00	1.00
386	44	presence	2026-02-17 09:00:00	1.00
387	45	consommation	2026-02-17 09:00:00	218.00
388	46	consommation	2026-02-17 09:00:00	218.00
389	47	consommation	2026-02-17 09:00:00	194.00
390	48	consommation	2026-02-17 09:00:00	194.00
391	49	consommation	2026-02-17 09:00:00	182.00
392	50	consommation	2026-02-17 09:00:00	182.00
393	51	consommation	2026-02-17 09:00:00	194.00
394	52	niveau_cafe	2026-02-17 09:00:00	56.00
395	53	niveau_cafe	2026-02-17 09:00:00	52.00
396	54	niveau_cafe	2026-02-17 09:00:00	52.00
397	55	consommation	2026-02-17 09:00:00	832.00
398	56	consommation	2026-02-17 09:00:00	877.00
399	57	consommation	2026-02-17 09:00:00	877.00
400	1	ouverture	2026-02-17 09:15:00	0.00
401	2	ouverture	2026-02-17 09:15:00	0.00
402	3	ouverture	2026-02-17 09:15:00	0.00
403	4	ouverture	2026-02-17 09:15:00	0.00
404	5	ouverture	2026-02-17 09:15:00	0.00
405	6	ouverture	2026-02-17 09:15:00	0.00
406	7	ouverture	2026-02-17 09:15:00	0.00
407	8	ouverture	2026-02-17 09:15:00	0.00
408	9	temperature	2026-02-17 09:15:00	23.60
409	10	temperature	2026-02-17 09:15:00	23.00
410	11	temperature	2026-02-17 09:15:00	23.00
411	12	temperature	2026-02-17 09:15:00	22.40
412	13	temperature	2026-02-17 09:15:00	23.00
413	14	temperature	2026-02-17 09:15:00	17.00
414	15	temperature	2026-02-17 09:15:00	23.60
415	16	consommation	2026-02-17 09:15:00	139.00
416	17	consommation	2026-02-17 09:15:00	147.00
417	18	consommation	2026-02-17 09:15:00	139.00
418	19	consommation	2026-02-17 09:15:00	147.00
419	20	consommation	2026-02-17 09:15:00	147.00
420	21	consommation	2026-02-17 09:15:00	240.00
421	22	consommation	2026-02-17 09:15:00	131.00
422	23	consommation	2026-02-17 09:15:00	43.00
423	24	consommation	2026-02-17 09:15:00	35.00
424	25	consommation	2026-02-17 09:15:00	43.00
425	26	consommation	2026-02-17 09:15:00	39.00
426	27	consommation	2026-02-17 09:15:00	43.00
427	28	consommation	2026-02-17 09:15:00	35.00
428	29	consommation	2026-02-17 09:15:00	35.00
429	30	papier	2026-02-17 09:15:00	446.00
430	31	papier	2026-02-17 09:15:00	452.00
431	32	papier	2026-02-17 09:15:00	440.00
432	33	papier	2026-02-17 09:15:00	452.00
433	34	consommation	2026-02-17 09:15:00	160.00
434	35	consommation	2026-02-17 09:15:00	160.00
435	36	consommation	2026-02-17 09:15:00	140.00
436	37	consommation	2026-02-17 09:15:00	160.00
437	38	presence	2026-02-17 09:15:00	0.00
438	39	presence	2026-02-17 09:15:00	0.00
439	40	presence	2026-02-17 09:15:00	0.00
440	41	presence	2026-02-17 09:15:00	0.00
441	42	presence	2026-02-17 09:15:00	0.00
442	43	presence	2026-02-17 09:15:00	0.00
443	44	presence	2026-02-17 09:15:00	0.00
444	45	consommation	2026-02-17 09:15:00	225.00
445	46	consommation	2026-02-17 09:15:00	225.00
446	47	consommation	2026-02-17 09:15:00	201.00
447	48	consommation	2026-02-17 09:15:00	201.00
448	49	consommation	2026-02-17 09:15:00	189.00
449	50	consommation	2026-02-17 09:15:00	189.00
450	51	consommation	2026-02-17 09:15:00	201.00
451	52	niveau_cafe	2026-02-17 09:15:00	50.00
452	53	niveau_cafe	2026-02-17 09:15:00	46.00
453	54	niveau_cafe	2026-02-17 09:15:00	46.00
454	55	consommation	2026-02-17 09:15:00	844.00
455	56	consommation	2026-02-17 09:15:00	889.00
456	57	consommation	2026-02-17 09:15:00	889.00
\.


--
-- TOC entry 5085 (class 0 OID 20361)
-- Dependencies: 230
-- Data for Name: log_systeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log_systeme (id, date_heure, code_log, message, niveau, equipement_id) FROM stdin;
1	2026-02-17 07:45:00	SYS-CHK-101	Routine salle=A-102 equip=THM-A102 statut=ok	info	5
2	2026-02-17 08:00:00	SYS-CHK-201	Routine salle=B-201 equip=IMP-B201 statut=ok	info	15
3	2026-02-17 08:15:00	ALR-IA-204	Incident salle=B-204 equip=CAF-B204 capteur=**** motif=**** score=97	critique	28
4	2026-02-17 08:15:10	CAF-ALR-204	Capteur salle=B-204 equip=CAF-B204 motif=vapeur_cafe valeur=1820 seuil=900	critique	28
5	2026-02-17 08:16:00	ACT-IA-204	Action salle=B-204 equip=POR-B204 decision=verrouiller raison=score_critique	info	25
6	2026-02-17 08:17:00	ACT-IA-205	Action salle=B-204 equip=LUM-B204 decision=eteindre raison=mode_confinement	info	27
7	2026-02-17 08:18:00	ACT-IA-206	Action salle=B-204 equip=IMP-B204 decision=redemarrer raison=file_impression_suspendue	avertissement	29
8	2026-02-17 08:19:00	SEC-AUD-204	Audit salle=B-204 utilisateur=maintenance_nuit acces=admin_partage resultat=autorise	critique	\N
9	2026-02-17 08:20:00	ALR-IA-205	Anomalie salle=B-204 equip=THM-B204 capteur=CAP-TMP-026-01 motif=refroidissement_excessif score=88	critique	26
10	2026-02-17 08:21:00	ALR-IA-206	Boucle salle=B-204 equip=IMP-B204 motif=redemarrage_recurrent compteur=3	critique	29
11	2026-02-17 08:22:00	SEC-OVR-204	Override refuse utilisateur=maintenance_nuit salle=B-204 raison=session_concurrente	avertissement	\N
12	2026-02-17 08:23:00	SYS-CHK-301	Routine salle=C-301 equip=CAF-C301 statut=ok	info	34
13	2026-02-17 08:24:00	ACT-IA-207	Action salle=B-204 equip=ORD-B204 decision=activer_mode_eco raison=confinement	info	30
14	2026-02-17 08:25:00	ACT-IA-208	Action salle=B-204 equip=CAF-B204 decision=lancer_autonettoyage raison=odeur_persistante	avertissement	28
15	2026-02-17 08:28:00	ACT-IA-209	Action salle=B-204 equip=POR-B204 decision=deverrouiller raison=intervention_humaine	avertissement	25
16	2026-02-17 08:29:00	SEC-CHK-302	Routine salle=A-101 utilisateur=enquete_stage acces=lecture resultat=ok	info	\N
17	2026-02-17 08:31:00	ALR-IA-301	Incident salle=C-301 equip=IMP-C301 capteur=CAP-PAP-035-01 motif=papier_faible score=61	critique	35
\.


--
-- TOC entry 5075 (class 0 OID 20276)
-- Dependencies: 220
-- Data for Name: salle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salle (id, code, nom, etage) FROM stdin;
1	A-101	Hall d'accueil	1
2	A-102	Salle Neptune	1
3	A-103	Bureau Sigma	1
4	B-201	Salle Orion	2
5	B-202	Salle Atlas	2
6	B-203	Cuisine Pixel	2
7	B-204	Salle Boreale	2
8	C-301	Salle Helios	3
\.


--
-- TOC entry 5087 (class 0 OID 20378)
-- Dependencies: 232
-- Data for Name: utilisateur_systeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur_systeme (id, nom_utilisateur, courriel, niveau_acces, mot_de_passe, actif, dernier_acces) FROM stdin;
1	iris_admin	iris.admin@batinet.local	admin	ArgusMaster42!	t	2026-02-17 08:10:00
2	maintenance_nuit	maintenance.nuit@batinet.local	admin	cafeEncore42	t	2026-02-17 08:22:00
3	nina_tech	nina.tech@batinet.local	technicien	capteurFixe	t	2026-02-16 21:05:00
4	enquete_stage	enquete.stage@batinet.local	enqueteur	lectureSeulement	t	2026-02-17 08:29:00
5	audit_temp	audit.temp@batinet.local	enqueteur	audit123	f	2026-02-15 17:00:00
\.


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 223
-- Name: capteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.capteur_id_seq', 57, true);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 227
-- Name: decision_ia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.decision_ia_id_seq', 16, true);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 221
-- Name: equipement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipement_id_seq', 36, true);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 225
-- Name: lecture_capteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lecture_capteur_id_seq', 456, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 229
-- Name: log_systeme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.log_systeme_id_seq', 17, true);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 219
-- Name: salle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salle_id_seq', 8, true);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 231
-- Name: utilisateur_systeme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_systeme_id_seq', 5, true);


--
-- TOC entry 4911 (class 2606 OID 20320)
-- Name: capteur capteur_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT capteur_code_key UNIQUE (code);


--
-- TOC entry 4913 (class 2606 OID 20318)
-- Name: capteur capteur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT capteur_pkey PRIMARY KEY (id);


--
-- TOC entry 4917 (class 2606 OID 20354)
-- Name: decision_ia decision_ia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_ia
    ADD CONSTRAINT decision_ia_pkey PRIMARY KEY (id);


--
-- TOC entry 4909 (class 2606 OID 20299)
-- Name: equipement equipement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement
    ADD CONSTRAINT equipement_pkey PRIMARY KEY (id);


--
-- TOC entry 4915 (class 2606 OID 20337)
-- Name: lecture_capteur lecture_capteur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecture_capteur
    ADD CONSTRAINT lecture_capteur_pkey PRIMARY KEY (id);


--
-- TOC entry 4919 (class 2606 OID 20371)
-- Name: log_systeme log_systeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_systeme
    ADD CONSTRAINT log_systeme_pkey PRIMARY KEY (id);


--
-- TOC entry 4907 (class 2606 OID 20286)
-- Name: salle salle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salle
    ADD CONSTRAINT salle_pkey PRIMARY KEY (id);


--
-- TOC entry 4921 (class 2606 OID 20387)
-- Name: utilisateur_systeme utilisateur_systeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur_systeme
    ADD CONSTRAINT utilisateur_systeme_pkey PRIMARY KEY (id);


--
-- TOC entry 4923 (class 2606 OID 20321)
-- Name: capteur capteur_equipement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT capteur_equipement_id_fkey FOREIGN KEY (equipement_id) REFERENCES public.equipement(id);


--
-- TOC entry 4925 (class 2606 OID 20355)
-- Name: decision_ia decision_ia_equipement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.decision_ia
    ADD CONSTRAINT decision_ia_equipement_id_fkey FOREIGN KEY (equipement_id) REFERENCES public.equipement(id);


--
-- TOC entry 4922 (class 2606 OID 20300)
-- Name: equipement equipement_salle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement
    ADD CONSTRAINT equipement_salle_id_fkey FOREIGN KEY (salle_id) REFERENCES public.salle(id);


--
-- TOC entry 4924 (class 2606 OID 20338)
-- Name: lecture_capteur lecture_capteur_capteur_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecture_capteur
    ADD CONSTRAINT lecture_capteur_capteur_fk FOREIGN KEY (capteur_id) REFERENCES public.capteur(id);


--
-- TOC entry 4926 (class 2606 OID 20372)
-- Name: log_systeme log_systeme_equipement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.log_systeme
    ADD CONSTRAINT log_systeme_equipement_id_fkey FOREIGN KEY (equipement_id) REFERENCES public.equipement(id);


-- Completed on 2026-04-04 14:19:42

--
-- PostgreSQL database dump complete
--

\unrestrict TX87c8mm8iMhuc4kcoQvVHcl6rQ6oKiU6sKeRddzKej2uWQMeOqdnswRPdEMFnw

