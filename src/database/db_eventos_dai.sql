--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.0

-- Started on 2024-05-31 10:30:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

-- CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16398)
-- Name: event_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_categories (
    id integer DEFAULT nextval('public.event_categories'::regclass) NOT NULL,
    name character varying(200),
    display_order integer
);


ALTER TABLE public.event_categories OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16402)
-- Name: event_enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_enrollments (
    id integer DEFAULT nextval('public.event_enrollments'::regclass) NOT NULL,
    id_user integer DEFAULT nextval('public.event_enrollments'::regclass),
    description character varying(250),
    registration_date_time date,
    attended boolean,
    observations character varying(300),
    rating integer,
    id_event integer NOT NULL
);


ALTER TABLE public.event_enrollments OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16409)
-- Name: event_enrollments_id_event_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_enrollments_id_event_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_enrollments_id_event_seq OWNER TO postgres;

--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 218
-- Name: event_enrollments_id_event_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_enrollments_id_event_seq OWNED BY public.event_enrollments.id_event;


--
-- TOC entry 219 (class 1259 OID 16410)
-- Name: event_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_locations (
    id integer DEFAULT nextval('public.event_locations'::regclass) NOT NULL,
    name character varying(30),
    full_address character varying(100),
    max_capacity integer,
    latitude double precision,
    longitude double precision,
    id_creator_user integer NOT NULL,
    id_location integer NOT NULL
);


ALTER TABLE public.event_locations OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16415)
-- Name: event_locations_id_location_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_locations_id_location_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_locations_id_location_seq OWNER TO postgres;

--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 220
-- Name: event_locations_id_location_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_locations_id_location_seq OWNED BY public.event_locations.id_location;


--
-- TOC entry 221 (class 1259 OID 16416)
-- Name: event_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_tags (
    id integer DEFAULT nextval('public.event_tags'::regclass) NOT NULL,
    id_tag integer DEFAULT nextval('public.event_tags'::regclass) NOT NULL,
    id_event integer NOT NULL
);


ALTER TABLE public.event_tags OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16421)
-- Name: event_tags_id_event_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_tags_id_event_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_tags_id_event_seq OWNER TO postgres;

--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 222
-- Name: event_tags_id_event_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_tags_id_event_seq OWNED BY public.event_tags.id_event;


--
-- TOC entry 223 (class 1259 OID 16422)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer DEFAULT nextval('public.events'::regclass) NOT NULL,
    name character varying(86),
    description character varying(300),
    id_event_category integer DEFAULT nextval('public.events'::regclass),
    start_date date,
    duration_in_minutes double precision,
    price double precision,
    enabled_for_enrollment boolean,
    max_assistance integer,
    id_creator_user integer DEFAULT nextval('public.events'::regclass),
    id_event_location integer NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16428)
-- Name: events_id_event_location_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_event_location_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_event_location_seq OWNER TO postgres;

--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 224
-- Name: events_id_event_location_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_event_location_seq OWNED BY public.events.id_event_location;


--
-- TOC entry 225 (class 1259 OID 16429)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    name character varying(100),
    latitude double precision,
    longitude double precision,
    id_province integer
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16432)
-- Name: locations_id_province_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_province_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_province_seq OWNER TO postgres;

--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 226
-- Name: locations_id_province_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_province_seq OWNED BY public.locations.id_province;


--
-- TOC entry 227 (class 1259 OID 16433)
-- Name: provinces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provinces (
    name character varying(100),
    full_name character varying(150),
    latitude double precision,
    longitude double precision,
    display_order integer,
    id integer NOT NULL
);


ALTER TABLE public.provinces OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16436)
-- Name: provinces_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provinces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.provinces_id_seq OWNER TO postgres;

--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 228
-- Name: provinces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provinces_id_seq OWNED BY public.provinces.id;


--
-- TOC entry 229 (class 1259 OID 16437)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    name character varying(50),
    id integer NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16440)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 230
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 231 (class 1259 OID 16441)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    first_name character varying(80),
    last_name character varying(74),
    username character varying(20),
    password character varying(25),
    id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16444)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 232
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4677 (class 2604 OID 16445)
-- Name: event_enrollments id_event; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments ALTER COLUMN id_event SET DEFAULT nextval('public.event_enrollments_id_event_seq'::regclass);


--
-- TOC entry 4681 (class 2604 OID 16447)
-- Name: event_tags id_event; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags ALTER COLUMN id_event SET DEFAULT nextval('public.event_tags_id_event_seq'::regclass);


--
-- TOC entry 4685 (class 2604 OID 16448)
-- Name: events id_event_location; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id_event_location SET DEFAULT nextval('public.events_id_event_location_seq'::regclass);


--
-- TOC entry 4686 (class 2604 OID 16449)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_province_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 16450)
-- Name: locations id_province; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id_province SET DEFAULT nextval('public.locations_id_province_seq'::regclass);


--
-- TOC entry 4688 (class 2604 OID 16451)
-- Name: provinces id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provinces ALTER COLUMN id SET DEFAULT nextval('public.provinces_id_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 16452)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 4690 (class 2604 OID 16453)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4852 (class 0 OID 16398)
-- Dependencies: 216
-- Data for Name: event_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4853 (class 0 OID 16402)
-- Dependencies: 217
-- Data for Name: event_enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4855 (class 0 OID 16410)
-- Dependencies: 219
-- Data for Name: event_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4857 (class 0 OID 16416)
-- Dependencies: 221
-- Data for Name: event_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4859 (class 0 OID 16422)
-- Dependencies: 223
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4861 (class 0 OID 16429)
-- Dependencies: 225
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.locations VALUES (87, 'Playa del Este', -34.663571, -54.94634, 10);
INSERT INTO public.locations VALUES (88, 'Cerro Catedral', -41.1794, -71.3826, 14);
INSERT INTO public.locations VALUES (89, 'Plaza San Martín', -31.420083, -64.188776, 5);
INSERT INTO public.locations VALUES (90, 'Cataratas del Iguazú', -25.6872, -54.435, 13);
INSERT INTO public.locations VALUES (91, 'Cerro Aconcagua', -32.6539, -70.0116, 12);
INSERT INTO public.locations VALUES (92, 'Puerto Madero', -34.6102, -58.3637, 1);
INSERT INTO public.locations VALUES (93, 'Glaciar Perito Moreno', -50.4966, -73.1377, 19);
INSERT INTO public.locations VALUES (94, 'Cerro Uritorco', -30.8395, -64.4724, 3);
INSERT INTO public.locations VALUES (95, 'Barrio Recoleta', -34.5889, -58.3926, 8);
INSERT INTO public.locations VALUES (96, 'Mar de las Pampas', -37.325, -57.025, 6);
INSERT INTO public.locations VALUES (97, 'Cerro Tres Picos', -38.248, -61.886, 20);
INSERT INTO public.locations VALUES (98, 'Cerro Fitz Roy', -49.2712, -73.0431, 18);
INSERT INTO public.locations VALUES (99, 'Puerto Pirámides', -42.5847, -64.2855, 4);
INSERT INTO public.locations VALUES (100, 'Barrio Palermo', -34.584, -58.4269, 9);
INSERT INTO public.locations VALUES (101, 'Cerro Tronador', -41.1833, -71.8833, 7);
INSERT INTO public.locations VALUES (102, 'Cerro Catedral', -25.4425, -54.5786, 2);
INSERT INTO public.locations VALUES (103, 'Barrio Caballito', -34.6223, -58.4388, 11);
INSERT INTO public.locations VALUES (104, 'Sierra de la Ventana', -38.1422, -61.7761, 15);
INSERT INTO public.locations VALUES (105, 'Parque Nacional Nahuel Huapi', -41.1508, -71.3092, 17);
INSERT INTO public.locations VALUES (106, 'San Carlos de Bariloche', -41.1335, -71.3103, 16);


--
-- TOC entry 4863 (class 0 OID 16433)
-- Dependencies: 227
-- Data for Name: provinces; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.provinces VALUES ('Buenos Aires', 'Buenos Aires', -34.6037, -58.3816, 1, 1);
INSERT INTO public.provinces VALUES ('Catamarca', 'Catamarca', -28.4696, -65.7852, 2, 2);
INSERT INTO public.provinces VALUES ('Chaco', 'Chaco', -26.8406, -60.7658, 3, 3);
INSERT INTO public.provinces VALUES ('Chubut', 'Chubut', -43.3002, -65.1023, 4, 4);
INSERT INTO public.provinces VALUES ('Córdoba', 'Córdoba', -31.4201, -64.1888, 5, 5);
INSERT INTO public.provinces VALUES ('Corrientes', 'Corrientes', -27.4691, -58.8309, 6, 6);
INSERT INTO public.provinces VALUES ('Entre Ríos', 'Entre Ríos', -32.0575, -59.0844, 7, 7);
INSERT INTO public.provinces VALUES ('Formosa', 'Formosa', -26.1852, -58.1752, 8, 8);
INSERT INTO public.provinces VALUES ('Jujuy', 'Jujuy', -24.1858, -65.2995, 9, 9);
INSERT INTO public.provinces VALUES ('La Pampa', 'La Pampa', -36.6167, -64.2833, 10, 10);
INSERT INTO public.provinces VALUES ('La Rioja', 'La Rioja', -29.4111, -66.8507, 11, 11);
INSERT INTO public.provinces VALUES ('Mendoza', 'Mendoza', -32.8895, -68.8458, 12, 12);
INSERT INTO public.provinces VALUES ('Misiones', 'Misiones', -27.4676, -55.8977, 13, 13);
INSERT INTO public.provinces VALUES ('Neuquén', 'Neuquén', -38.9526, -68.0591, 14, 14);
INSERT INTO public.provinces VALUES ('Río Negro', 'Río Negro', -41.1335, -71.3103, 15, 15);
INSERT INTO public.provinces VALUES ('Salta', 'Salta', -24.7859, -65.4117, 16, 16);
INSERT INTO public.provinces VALUES ('San Juan', 'San Juan', -31.5375, -68.5364, 17, 17);
INSERT INTO public.provinces VALUES ('San Luis', 'San Luis', -33.3016, -66.3378, 18, 18);
INSERT INTO public.provinces VALUES ('Santa Cruz', 'Santa Cruz', -50, -69, 19, 19);
INSERT INTO public.provinces VALUES ('Santa Fe', 'Santa Fe', -31.6107, -60.6973, 20, 20);
INSERT INTO public.provinces VALUES ('Santiago del Estero', 'Santiago del Estero', -27.7951, -64.2615, 21, 21);
INSERT INTO public.provinces VALUES ('Tierra del Fuego', 'Tierra del Fuego', -54.8, -68.3, 22, 22);
INSERT INTO public.provinces VALUES ('Tucumán', 'Tucumán', -26.8083, -65.2176, 23, 23);


--
-- TOC entry 4865 (class 0 OID 16437)
-- Dependencies: 229
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tags VALUES ('Mucha gente', 11);
INSERT INTO public.tags VALUES ('Poca gente', 12);
INSERT INTO public.tags VALUES ('Deportes', 13);
INSERT INTO public.tags VALUES ('Cultural', 14);
INSERT INTO public.tags VALUES ('Educación', 15);
INSERT INTO public.tags VALUES ('Arte', 16);
INSERT INTO public.tags VALUES ('Música', 17);
INSERT INTO public.tags VALUES ('Familiar', 18);
INSERT INTO public.tags VALUES ('Entretenimiento', 19);
INSERT INTO public.tags VALUES ('Gastronomía', 20);


--
-- TOC entry 4867 (class 0 OID 16441)
-- Dependencies: 231
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 218
-- Name: event_enrollments_id_event_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_enrollments_id_event_seq', 1, false);


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 220
-- Name: event_locations_id_location_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_locations_id_location_seq', 1, false);


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 222
-- Name: event_tags_id_event_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_tags_id_event_seq', 1, false);


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 224
-- Name: events_id_event_location_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_event_location_seq', 1, false);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 226
-- Name: locations_id_province_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_province_seq', 106, true);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 228
-- Name: provinces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provinces_id_seq', 1, false);


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 230
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 20, true);


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 232
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4692 (class 2606 OID 16455)
-- Name: event_categories event_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_categories
    ADD CONSTRAINT event_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4694 (class 2606 OID 16457)
-- Name: event_enrollments event_enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments
    ADD CONSTRAINT event_enrollments_pkey PRIMARY KEY (id);


--
-- TOC entry 4696 (class 2606 OID 16459)
-- Name: event_locations event_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_locations
    ADD CONSTRAINT event_locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4698 (class 2606 OID 16461)
-- Name: event_tags event_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT event_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4700 (class 2606 OID 16463)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 4702 (class 2606 OID 16465)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 16467)
-- Name: provinces provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);


--
-- TOC entry 4706 (class 2606 OID 16469)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4708 (class 2606 OID 16471)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2024-05-31 10:30:36

--
-- PostgreSQL database dump complete
--

