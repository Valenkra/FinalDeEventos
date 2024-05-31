--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.0

-- Started on 2024-05-31 11:56:59

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

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 233 (class 1255 OID 16503)
-- Name: create_invoice(text, numeric, date); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_invoice(IN customer_name text, IN total_amount numeric, IN invoice_date date)
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO invoices (customer_name, total_amount, invoice_date)
  VALUES (customer_name, total_amount, invoice_date);
END;
$$;


ALTER PROCEDURE public.create_invoice(IN customer_name text, IN total_amount numeric, IN invoice_date date) OWNER TO postgres;

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
    rating double precision,
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
-- TOC entry 4678 (class 2604 OID 16445)
-- Name: event_enrollments id_event; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments ALTER COLUMN id_event SET DEFAULT nextval('public.event_enrollments_id_event_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 16447)
-- Name: event_tags id_event; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags ALTER COLUMN id_event SET DEFAULT nextval('public.event_tags_id_event_seq'::regclass);


--
-- TOC entry 4686 (class 2604 OID 16448)
-- Name: events id_event_location; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id_event_location SET DEFAULT nextval('public.events_id_event_location_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 16449)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_province_seq'::regclass);


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

INSERT INTO public.event_categories VALUES (1, 'Conciertos', 1);
INSERT INTO public.event_categories VALUES (2, 'Conferencias', 2);
INSERT INTO public.event_categories VALUES (3, 'Festivales', 3);
INSERT INTO public.event_categories VALUES (4, 'Talleres de Arte', 4);
INSERT INTO public.event_categories VALUES (5, 'Cursos de Cocina', 5);
INSERT INTO public.event_categories VALUES (6, 'Exposiciones', 6);
INSERT INTO public.event_categories VALUES (7, 'Eventos Deportivos', 7);
INSERT INTO public.event_categories VALUES (8, 'Ferias', 8);
INSERT INTO public.event_categories VALUES (9, 'Encuentros Culturales', 9);
INSERT INTO public.event_categories VALUES (10, 'Charlas', 10);


--
-- TOC entry 4853 (class 0 OID 16402)
-- Dependencies: 217
-- Data for Name: event_enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_enrollments VALUES (1, 1, 'First event enrollment', '2023-05-01', true, 'No observations', 4.5, 1);
INSERT INTO public.event_enrollments VALUES (2, 2, 'Second event enrollment', '2023-05-02', false, 'Late arrival', 3, 2);
INSERT INTO public.event_enrollments VALUES (3, 3, 'Third event enrollment', '2023-05-03', true, 'Good session', 5, 3);
INSERT INTO public.event_enrollments VALUES (4, 4, 'Fourth event enrollment', '2023-05-04', true, 'Informative', 4.2, 4);
INSERT INTO public.event_enrollments VALUES (5, 5, 'Fifth event enrollment', '2023-05-05', false, 'Had to leave early', 2.8, 5);
INSERT INTO public.event_enrollments VALUES (6, 6, 'Sixth event enrollment', '2023-05-06', true, 'Well organized', 4.7, 6);
INSERT INTO public.event_enrollments VALUES (7, 7, 'Seventh event enrollment', '2023-05-07', false, 'Missed due to illness', 1, 7);
INSERT INTO public.event_enrollments VALUES (8, 8, 'Eighth event enrollment', '2023-05-08', true, 'Very engaging', 4.9, 8);
INSERT INTO public.event_enrollments VALUES (9, 9, 'Ninth event enrollment', '2023-05-09', false, 'Could not attend', 0, 9);
INSERT INTO public.event_enrollments VALUES (10, 10, 'Tenth event enrollment', '2023-05-10', true, 'Excellent', 5, 10);
INSERT INTO public.event_enrollments VALUES (11, 11, 'Eleventh event enrollment', '2023-05-11', false, 'Schedule conflict', 2, 11);
INSERT INTO public.event_enrollments VALUES (12, 12, 'Twelfth event enrollment', '2023-05-12', true, 'Useful insights', 4.3, 12);
INSERT INTO public.event_enrollments VALUES (13, 13, 'Thirteenth event enrollment', '2023-05-13', true, 'Very informative', 4.8, 13);
INSERT INTO public.event_enrollments VALUES (14, 14, 'Fourteenth event enrollment', '2023-05-14', false, 'Was not interested', 1.5, 14);
INSERT INTO public.event_enrollments VALUES (15, 15, 'Fifteenth event enrollment', '2023-05-15', true, 'Good presentation', 4, 15);
INSERT INTO public.event_enrollments VALUES (16, 16, 'Sixteenth event enrollment', '2023-05-16', true, 'Learned a lot', 4.6, 16);
INSERT INTO public.event_enrollments VALUES (17, 17, 'Seventeenth event enrollment', '2023-05-17', false, 'Forgot about it', 1, 17);
INSERT INTO public.event_enrollments VALUES (18, 18, 'Eighteenth event enrollment', '2023-05-18', true, 'Amazing experience', 5, 18);
INSERT INTO public.event_enrollments VALUES (19, 19, 'Nineteenth event enrollment', '2023-05-19', true, 'Good but could be better', 3.5, 19);
INSERT INTO public.event_enrollments VALUES (20, 20, 'Twentieth event enrollment', '2023-05-20', false, 'Technical issues', 2.3, 20);


--
-- TOC entry 4855 (class 0 OID 16410)
-- Dependencies: 219
-- Data for Name: event_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_locations VALUES (1, 'Conferencia de Marketing', 'Av. Libertador 123', 100, -34.6037, -58.3816, 1, 87);
INSERT INTO public.event_locations VALUES (2, 'Taller de Fotografía', 'Calle Principal 456', 120, -28.4696, -65.7852, 2, 88);
INSERT INTO public.event_locations VALUES (3, 'Fiesta de Fin de Año', 'Av. Belgrano 789', 150, -26.8406, -60.7658, 3, 89);
INSERT INTO public.event_locations VALUES (4, 'Concierto de Jazz', 'Plaza Principal, 1001', 200, -43.3002, -65.1023, 4, 90);
INSERT INTO public.event_locations VALUES (5, 'Curso de Cocina', 'Av. Libertador 246', 80, -31.4201, -64.1888, 5, 91);
INSERT INTO public.event_locations VALUES (6, 'Feria de Artesanías', 'Calle Independencia 789', 180, -27.4691, -58.8309, 6, 92);
INSERT INTO public.event_locations VALUES (7, 'Concurso de Pintura', 'Av. Belgrano 1234', 250, -32.0575, -59.0844, 7, 93);
INSERT INTO public.event_locations VALUES (8, 'Presentación de Libro', 'Av. Mitre 567', 100, -26.1852, -58.1752, 8, 94);
INSERT INTO public.event_locations VALUES (9, 'Exposición de Arte', 'Calle San Martín 1010', 150, -24.1858, -65.2995, 9, 95);
INSERT INTO public.event_locations VALUES (10, 'Feria del Libro', 'Plaza Principal 456', 120, -36.6167, -64.2833, 10, 96);
INSERT INTO public.event_locations VALUES (11, 'Show de Stand-up', 'Av. Rivadavia 789', 200, -29.4111, -66.8507, 11, 97);
INSERT INTO public.event_locations VALUES (12, 'Taller de Escritura', 'Calle Belgrano 246', 80, -32.8895, -68.8458, 12, 98);
INSERT INTO public.event_locations VALUES (13, 'Exposición de Fotografía', 'Calle Principal 1010', 180, -27.4676, -55.8977, 13, 99);
INSERT INTO public.event_locations VALUES (14, 'Festival de Cine', 'Av. San Martín 789', 250, -38.9526, -68.0591, 14, 100);
INSERT INTO public.event_locations VALUES (15, 'Torneo de Ajedrez', 'Av. Belgrano 1234', 100, -41.1335, -71.3103, 15, 101);
INSERT INTO public.event_locations VALUES (16, 'Concierto de Rock', 'Av. Libertador 567', 150, -24.7859, -65.4117, 16, 102);
INSERT INTO public.event_locations VALUES (17, 'Festival de Tango', 'Plaza Principal 789', 180, -31.5375, -68.5364, 17, 103);
INSERT INTO public.event_locations VALUES (18, 'Exposición de Esculturas', 'Av. Libertador 1010', 200, -33.3016, -66.3378, 18, 104);
INSERT INTO public.event_locations VALUES (19, 'Concierto de Música Clásica', 'Calle Principal 123', 250, -50, -69, 19, 105);
INSERT INTO public.event_locations VALUES (20, 'Feria de Diseño', 'Calle 123, Ciudad', 120, -31.6107, -60.6973, 20, 106);


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

INSERT INTO public.events VALUES (1, 'Concierto de Verano', '¡Disfruta de una noche llena de música en nuestro concierto de verano! Ven y únete a nosotros para una experiencia inolvidable.', 1, '2024-06-01', 120, 50, true, 100, 1, 1);
INSERT INTO public.events VALUES (2, 'Taller de Cocina', 'Aprende a cocinar platos deliciosos de la mano de nuestros chefs expertos en nuestro taller de cocina. ¡No te lo pierdas!', 2, '2024-06-02', 90, 40, true, 80, 2, 2);
INSERT INTO public.events VALUES (3, 'Sesión de Yoga al Aire Libre', 'Encuentra paz y equilibrio en nuestra sesión de yoga al aire libre. Desconéctate del estrés diario y conecta contigo mismo.', 3, '2024-06-03', 150, 60, true, 120, 3, 3);
INSERT INTO public.events VALUES (4, 'Exposición de Arte Contemporáneo', 'Explora obras fascinantes de artistas contemporáneos en nuestra exposición de arte. ¡Descubre nuevas perspectivas y emociones!', 4, '2024-06-04', 180, 70, true, 150, 4, 4);
INSERT INTO public.events VALUES (5, 'Torneo de Fútbol Local', 'Únete a la emoción del fútbol en nuestro torneo local. ¡Apoya a tu equipo favorito y disfruta de la competencia!', 5, '2024-06-05', 120, 50, true, 100, 5, 5);
INSERT INTO public.events VALUES (6, 'Curso de Fotografía Básica', 'Descubre el mundo de la fotografía en nuestro curso básico. Aprende técnicas fundamentales y captura momentos inolvidables.', 6, '2024-06-06', 90, 40, true, 80, 6, 6);
INSERT INTO public.events VALUES (7, 'Charla sobre Medio Ambiente', 'Únete a nuestra charla sobre medio ambiente y descubre cómo puedes contribuir a un futuro más sostenible. ¡Juntos podemos marcar la diferencia!', 7, '2024-06-07', 150, 60, true, 120, 7, 7);
INSERT INTO public.events VALUES (8, 'Noche de Cine al Aire Libre', 'Disfruta de una noche bajo las estrellas con nuestra proyección de cine al aire libre. Trae tus mantas y palomitas para una experiencia inolvidable.', 8, '2024-06-08', 180, 70, true, 150, 8, 8);
INSERT INTO public.events VALUES (9, 'Clase de Baile Latino', 'Aprende los pasos de baile más candentes en nuestra clase de baile latino. ¡Diviértete y libera tu energía con ritmos apasionados!', 9, '2024-06-09', 120, 50, true, 100, 9, 9);


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

INSERT INTO public.users VALUES ('Paula', 'Morales', 'paulamorales', 'passpass', 1);
INSERT INTO public.users VALUES ('Fernando', 'Ortega', 'fernandoortega', 'passwordpass', 2);
INSERT INTO public.users VALUES ('Verónica', 'Ramírez', 'veronicaramirez', 'passpass123', 3);
INSERT INTO public.users VALUES ('Daniel', 'Flores', 'danielflores', 'passwordpass123', 4);
INSERT INTO public.users VALUES ('Carmen', 'González', 'carmengonzalez', 'passpasspass', 5);
INSERT INTO public.users VALUES ('Rosa', 'Jiménez', 'rosajimenez', 'pass123pass', 6);
INSERT INTO public.users VALUES ('Pablo', 'Cabrera', 'pablocabrera', '123pass123', 7);
INSERT INTO public.users VALUES ('Marcela', 'Vargas', 'marcelavargas', 'passpass123', 8);
INSERT INTO public.users VALUES ('Alberto', 'Romero', 'albertoromero', '123456789', 9);
INSERT INTO public.users VALUES ('Silvia', 'Navarro', 'silvianavarro', '987654321', 10);
INSERT INTO public.users VALUES ('Lorenzo', 'Cruz', 'lorenzocruz', 'passwordpassword', 11);
INSERT INTO public.users VALUES ('Raquel', 'Ortiz', 'raquelortiz', 'passwordpassword123', 12);
INSERT INTO public.users VALUES ('Gonzalo', 'Rivas', 'gonzalorivas', 'passwordpassword456', 13);
INSERT INTO public.users VALUES ('Cristina', 'Moreno', 'cristinamoreno', 'passwordpassword789', 14);
INSERT INTO public.users VALUES ('Mario', 'Álvarez', 'marioalvarez', 'password123456', 15);
INSERT INTO public.users VALUES ('Eva', 'Fuentes', 'evafuentes', '123456abcdef', 16);
INSERT INTO public.users VALUES ('José', 'Santos', 'josesantos', 'abcdef123456', 17);
INSERT INTO public.users VALUES ('Isabel', 'Vega', 'isabelvega', 'passwordabcdef', 18);
INSERT INTO public.users VALUES ('Roberto', 'Serrano', 'robertoserrano', 'abcdefpassword', 19);
INSERT INTO public.users VALUES ('Natalia', 'Blanco', 'nataliablanco', 'passwordabcdef123', 20);
INSERT INTO public.users VALUES ('Gabriel', 'Iglesias', 'gabrieliglesias', '123456password', 21);
INSERT INTO public.users VALUES ('Alicia', 'Molina', 'aliciamolina', 'password123456', 22);
INSERT INTO public.users VALUES ('Martín', 'Castro', 'martincastro', 'abcdef123456', 23);
INSERT INTO public.users VALUES ('Victoria', 'Herrera', 'victoriaherrera', 'password123456789', 24);


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

SELECT pg_catalog.setval('public.users_id_seq', 24, true);


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


-- Completed on 2024-05-31 11:56:59

--
-- PostgreSQL database dump complete
--

