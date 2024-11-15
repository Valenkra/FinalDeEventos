--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.0

-- Started on 2024-06-07 12:18:25

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


--
-- TOC entry 233 (class 1255 OID 16398)
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
-- TOC entry 216 (class 1259 OID 16399)
-- Name: event_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_categories (
    id integer DEFAULT nextval('public.event_categories'::regclass) NOT NULL,
    name character varying(200),
    display_order integer
);


ALTER TABLE public.event_categories OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16403)
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
-- TOC entry 218 (class 1259 OID 16410)
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
-- TOC entry 219 (class 1259 OID 16411)
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
    name character varying(86),
    description character varying(300),
    id_event_category integer DEFAULT nextval('public.events'::regclass),
    start_date date,
    duration_in_minutes double precision,
    price double precision,
    enabled_for_enrollment boolean,
    max_assistance integer,
    id_creator_user integer DEFAULT nextval('public.events'::regclass),
    id_event_location integer NOT NULL, 
    id integer DEFAULT nextval('public.events'::regclass) NOT NULL
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
    first_name character varying(100),
    last_name character varying(100),
    username character varying(200),
    password character varying(100),
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
-- TOC entry 4682 (class 2604 OID 16446)
-- Name: event_tags id_event; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags ALTER COLUMN id_event SET DEFAULT nextval('public.event_tags_id_event_seq'::regclass);


--
-- TOC entry 4686 (class 2604 OID 16447)
-- Name: events id_event_location; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id_event_location SET DEFAULT nextval('public.events_id_event_location_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 16448)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_province_seq'::regclass);


--
-- TOC entry 4688 (class 2604 OID 16449)
-- Name: provinces id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provinces ALTER COLUMN id SET DEFAULT nextval('public.provinces_id_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 16450)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 4690 (class 2604 OID 16451)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4852 (class 0 OID 16399)
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
INSERT INTO public.event_categories VALUES (11, 'Gourmet', 11);


--
-- TOC entry 4853 (class 0 OID 16403)
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
-- TOC entry 4855 (class 0 OID 16411)
-- Dependencies: 219
-- Data for Name: event_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_locations VALUES (1, 'Conferencia de Marketing', 'Av. Libertador 123', 100, -34.6037, -58.3816, 1, 1);
INSERT INTO public.event_locations VALUES (2, 'Taller de Fotografía', 'Calle Principal 456', 120, -28.4696, -65.7852, 2, 2);
INSERT INTO public.event_locations VALUES (3, 'Fiesta de Fin de Año', 'Av. Belgrano 789', 150, -26.8406, -60.7658, 3, 3);
INSERT INTO public.event_locations VALUES (4, 'Concierto de Jazz', 'Plaza Principal, 1001', 200, -43.3002, -65.1023, 4, 4);
INSERT INTO public.event_locations VALUES (5, 'Curso de Cocina', 'Av. Libertador 246', 80, -31.4201, -64.1888, 5, 5);
INSERT INTO public.event_locations VALUES (6, 'Feria de Artesanías', 'Calle Independencia 789', 180, -27.4691, -58.8309, 6, 6);
INSERT INTO public.event_locations VALUES (7, 'Concurso de Pintura', 'Av. Belgrano 1234', 250, -32.0575, -59.0844, 7, 7);
INSERT INTO public.event_locations VALUES (8, 'Presentación de Libro', 'Av. Mitre 567', 100, -26.1852, -58.1752, 8, 8);
INSERT INTO public.event_locations VALUES (9, 'Exposición de Arte', 'Calle San Martín 1010', 150, -24.1858, -65.2995, 9, 9);
INSERT INTO public.event_locations VALUES (10, 'Feria del Libro', 'Plaza Principal 456', 120, -36.6167, -64.2833, 10, 10);
INSERT INTO public.event_locations VALUES (11, 'Show de Stand-up', 'Av. Rivadavia 789', 200, -29.4111, -66.8507, 11, 11);
INSERT INTO public.event_locations VALUES (12, 'Taller de Escritura', 'Calle Belgrano 246', 80, -32.8895, -68.8458, 12, 12);
INSERT INTO public.event_locations VALUES (13, 'Exposición de Fotografía', 'Calle Principal 1010', 180, -27.4676, -55.8977, 13, 13);
INSERT INTO public.event_locations VALUES (14, 'Festival de Cine', 'Av. San Martín 789', 250, -38.9526, -68.0591, 14, 14);
INSERT INTO public.event_locations VALUES (15, 'Torneo de Ajedrez', 'Av. Belgrano 1234', 100, -41.1335, -71.3103, 15, 15);
INSERT INTO public.event_locations VALUES (16, 'Concierto de Rock', 'Av. Libertador 567', 150, -24.7859, -65.4117, 16, 16);
INSERT INTO public.event_locations VALUES (17, 'Festival de Tango', 'Plaza Principal 789', 180, -31.5375, -68.5364, 17, 17);
INSERT INTO public.event_locations VALUES (18, 'Exposición de Esculturas', 'Av. Libertador 1010', 200, -33.3016, -66.3378, 18, 18);
INSERT INTO public.event_locations VALUES (19, 'Concierto de Música Clásica', 'Calle Principal 123', 250, -50, -69, 19, 19);
INSERT INTO public.event_locations VALUES (20, 'Feria de Diseño', 'Calle 123, Ciudad', 120, -31.6107, -60.6973, 20, 20);
INSERT INTO public.event_locations VALUES (21, 'Fiesta Estelar', 'Avenida de las Estrellas', 150, 40.7128, -74.0060, 1, 1);
INSERT INTO public.event_locations VALUES (22, 'Carnaval Nocturno', 'Calle de las Luces', 200, 34.0522, -118.2437, 2, 2);
INSERT INTO public.event_locations VALUES (23, 'Festival del Sol', 'Paseo Solar', 300, 51.5074, -0.1278, 3, 3);
INSERT INTO public.event_locations VALUES (24, 'Noche de Gala', 'Avenida del Glamour', 400, 48.8566, 2.3522, 4, 4);
INSERT INTO public.event_locations VALUES (25, 'Encuentro Lunar', 'Calle de los Astros', 450, 35.6895, 139.6917, 5, 5);
INSERT INTO public.event_locations VALUES (26, 'Aurora Boreal', 'Calle de las Maravillas', 60, 37.7749, -122.4194, 6, 6);
INSERT INTO public.event_locations VALUES (27, 'Sinfonía Estelar', 'Avenida del Cosmos', 250, 45.4215, -75.6919, 7, 7);
INSERT INTO public.event_locations VALUES (28, 'Eclipse Magnético', 'Calle de las Sombras', 350, 52.5200, 13.4050, 8, 8);
INSERT INTO public.event_locations VALUES (29, 'Galaxia Encantada', 'Paseo de las Estrellas', 180, -33.8688, 151.2093, 9, 9);
INSERT INTO public.event_locations VALUES (30, 'Luz Lunar', 'Avenida de los Sueños', 280, 19.4326, -99.1332, 10, 10);
INSERT INTO public.event_locations VALUES (31, 'Desfile de Fantasía', 'Avenida de los Ensueños', 380, -22.9068, -43.1729, 11, 11);
INSERT INTO public.event_locations VALUES (32, 'Revolución de Colores', 'Calle del Arcoíris', 200, 37.7749, -122.4194, 12, 12);
INSERT INTO public.event_locations VALUES (33, 'Cumbre Celestial', 'Montaña de las Estrellas', 300, 51.1789, -115.5715, 13, 13);
INSERT INTO public.event_locations VALUES (34, 'Maratón Galáctico', 'Sendero de los Planetas', 450, 40.7128, -74.0060, 14, 14);
INSERT INTO public.event_locations VALUES (35, 'Fiesta de las Constelaciones', 'Calle de las Constelaciones', 150, 34.0522, -118.2437, 15, 15);
INSERT INTO public.event_locations VALUES (36, 'Noche Cósmica', 'Avenida de los Astros', 280, 48.8566, 2.3522, 16, 16);
INSERT INTO public.event_locations VALUES (37, 'Encuentro Lunar', 'Paseo Lunar', 380, 35.6895, 139.6917, 17, 17);
INSERT INTO public.event_locations VALUES (38, 'Festival Estelar', 'Avenida de las Estrellas', 420, 40.7128, -74.0060, 18, 18);
INSERT INTO public.event_locations VALUES (39, 'Carnaval Galáctico', 'Calle de las Galaxias', 230, 34.0522, -118.2437, 19, 19);
INSERT INTO public.event_locations VALUES (40, 'Desfile de Planetas', 'Avenida de los Planetas', 270, 51.5074, -0.1278, 20, 20);
INSERT INTO public.event_locations VALUES (41, 'Luna Brillante', 'Calle de las Maravillas', 160, 37.7749, -122.4194, 1, 1);
INSERT INTO public.event_locations VALUES (42, 'Estrella Fugaz', 'Avenida de los Sueños', 300, 45.4215, -75.6919, 2, 2);
INSERT INTO public.event_locations VALUES (43, 'Galaxia Encantada', 'Calle de los Encantos', 180, 52.5200, 13.4050, 3, 3);
INSERT INTO public.event_locations VALUES (44, 'Noche de Estrellas', 'Avenida de las Noches', 250, -33.8688, 151.2093, 4, 4);
INSERT INTO public.event_locations VALUES (45, 'Fiesta Cósmica', 'Calle de las Maravillas', 320, 19.4326, -99.1332, 5, 5);
INSERT INTO public.event_locations VALUES (46, 'Festival Lunar', 'Avenida de la Luna', 420, -22.9068, -43.1729, 6, 6);
INSERT INTO public.event_locations VALUES (47, 'Celestial Parade', 'Rainbow Avenue', 380, 37.7749, -122.4194, 7, 7);
INSERT INTO public.event_locations VALUES (48, 'Revolution of Colors', 'Arcade Street', 200, 51.1789, -115.5715, 8, 8);
INSERT INTO public.event_locations VALUES (49, 'Heavenly Summit', 'Star Mountain', 300, 40.7128, -74.0060, 9, 9);
INSERT INTO public.event_locations VALUES (50, 'Galactic Marathon', 'Planet Trail', 450, 34.0522, -118.2437, 10, 10);
INSERT INTO public.event_locations VALUES (51, 'Constellation Party', 'Constellation Street', 150, 48.8566, 2.3522, 11, 11);
INSERT INTO public.event_locations VALUES (52, 'Cosmic Night', 'Astro Avenue', 280, 35.6895, 139.6917, 12, 12);
INSERT INTO public.event_locations VALUES (53, 'Lunar Encounter', 'Moonwalk', 380, 40.7128, -74.0060, 13, 13);
INSERT INTO public.event_locations VALUES (54, 'Stellar Festival', 'Starlight Avenue', 420, 34.0522, -118.2437, 14, 14);
INSERT INTO public.event_locations VALUES (55, 'Galactic Carnival', 'Galaxy Street', 230, 51.5074, -0.1278, 15, 15);
INSERT INTO public.event_locations VALUES (56, 'Planet Parade', 'Planet Avenue', 270, 37.7749, -122.4194, 16, 16);
INSERT INTO public.event_locations VALUES (57, 'Bright Moon', 'Wonder Street', 160, 45.4215, -75.6919, 17, 17);
INSERT INTO public.event_locations VALUES (58, 'Shooting Star', 'Dream Avenue', 300, 52.5200, 13.4050, 18, 18);
INSERT INTO public.event_locations VALUES (59, 'Enchanted Galaxy', 'Enchantment Street', 180, -33.8688, 151.2093, 19, 19);
INSERT INTO public.event_locations VALUES (60, 'Starry Night', 'Night Avenue', 320, 19.4326, -99.1332, 20, 20);
INSERT INTO public.event_locations VALUES (61, 'Cosmic Gala', 'Galactic Street', 420, -22.9068, -43.1729, 1, 1);
INSERT INTO public.event_locations VALUES (62, 'Lunar Festival', 'Moon Avenue', 380, 37.7749, -122.4194, 2, 2);
INSERT INTO public.event_locations VALUES (63, 'Starlit Parade', 'Starlit Avenue', 200, 51.1789, -115.5715, 3, 3);
INSERT INTO public.event_locations VALUES (64, 'Celestial Summit', 'Celestial Mountain', 300, 40.7128, -74.0060, 4, 4);
INSERT INTO public.event_locations VALUES (65, 'Galactic Marathon II', 'Planet Trail II', 450, 34.0522, -118.2437, 5, 5);
INSERT INTO public.event_locations VALUES (66, 'Starlight Soiree', 'Starlight Street', 150, 48.8566, 2.3522, 6, 6);
INSERT INTO public.event_locations VALUES (67, 'Astro Carnival', 'Astro Street', 280, 35.6895, 139.6917, 7, 7);
INSERT INTO public.event_locations VALUES (68, 'Moonlit Encounter', 'Moonlit Street', 380, 40.7128, -74.0060, 8, 8);
INSERT INTO public.event_locations VALUES (69, 'Stellar Fiesta', 'Stellar Avenue', 420, 34.0522, -118.2437, 9, 9);
INSERT INTO public.event_locations VALUES (70, 'Galactic Glow', 'Galactic Avenue', 230, 51.5074, -0.1278, 10, 10);
INSERT INTO public.event_locations VALUES (71, 'Planet Paradise', 'Paradise Street', 270, 37.7749, -122.4194, 11, 11);
INSERT INTO public.event_locations VALUES (72, 'Lunar Light', 'Light Avenue', 160, 45.4215, -75.6919, 12, 12);
INSERT INTO public.event_locations VALUES (73, 'Shooting Star Spectacle', 'Dream Street', 300, 52.5200, 13.4050, 13, 13);
INSERT INTO public.event_locations VALUES (74, 'Enchanted Galaxy II', 'Enchantment Avenue', 180, -33.8688, 151.2093, 14, 14);
INSERT INTO public.event_locations VALUES (75, 'Night Sky', 'Sky Street', 320, 19.4326, -99.1332, 15, 15);
INSERT INTO public.event_locations VALUES (76, 'Cosmic Carnival', 'Cosmic Street', 420, -22.9068, -43.1729, 16, 16);
INSERT INTO public.event_locations VALUES (77, 'Lunar Spectacular', 'Spectacular Avenue', 380, 37.7749, -122.4194, 17, 17);
INSERT INTO public.event_locations VALUES (78, 'Starry Soiree', 'Starry Street', 200, 51.1789, -115.5715, 18, 18);
INSERT INTO public.event_locations VALUES (79, 'Celestial Celebration', 'Celebration Street', 300, 40.7128, -74.0060, 19, 19);
INSERT INTO public.event_locations VALUES (80, 'Galactic Gathering', 'Gathering Avenue', 450, 34.0522, -118.2437, 20, 20);
INSERT INTO public.event_locations VALUES (81, 'Constellation Gala', 'Constellation Avenue', 150, 48.8566, 2.3522, 1, 1);
INSERT INTO public.event_locations VALUES (82, 'Cosmic Parade', 'Cosmic Avenue', 280, 35.6895, 139.6917, 2, 2);
INSERT INTO public.event_locations VALUES (83, 'Lunar Revelry', 'Revelry Street', 380, 40.7128, -74.0060, 3, 3);
INSERT INTO public.event_locations VALUES (84, 'Starlight Celebration', 'Starlight Avenue II', 420, 34.0522, -118.2437, 4, 4);


--
-- TOC entry 4857 (class 0 OID 16416)
-- Dependencies: 221
-- Data for Name: event_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_tags VALUES (1, 5, 5);
INSERT INTO public.event_tags VALUES (2, 8, 2);
INSERT INTO public.event_tags VALUES (3, 7, 8);
INSERT INTO public.event_tags VALUES (4, 4, 4);
INSERT INTO public.event_tags VALUES (5, 2, 1);
INSERT INTO public.event_tags VALUES (6, 9, 7);
INSERT INTO public.event_tags VALUES (7, 5, 3);
INSERT INTO public.event_tags VALUES (8, 1, 6);
INSERT INTO public.event_tags VALUES (9, 3, 9);
INSERT INTO public.event_tags VALUES (10, 6, 5);
INSERT INTO public.event_tags VALUES (11, 8, 2);
INSERT INTO public.event_tags VALUES (12, 5, 8);
INSERT INTO public.event_tags VALUES (13, 4, 4);
INSERT INTO public.event_tags VALUES (14, 9, 1);
INSERT INTO public.event_tags VALUES (15, 7, 6);
INSERT INTO public.event_tags VALUES (16, 9, 3);
INSERT INTO public.event_tags VALUES (17, 6, 7);
INSERT INTO public.event_tags VALUES (18, 1, 9);
INSERT INTO public.event_tags VALUES (19, 3, 2);
INSERT INTO public.event_tags VALUES (20, 8, 5);
INSERT INTO public.event_tags VALUES (21, 1, 1);
INSERT INTO public.event_tags VALUES (22, 2, 2);
INSERT INTO public.event_tags VALUES (23, 3, 3);
INSERT INTO public.event_tags VALUES (24, 4, 4);
INSERT INTO public.event_tags VALUES (25, 4, 3);
INSERT INTO public.event_tags VALUES (26, 6, 6);
INSERT INTO public.event_tags VALUES (27, 7, 7);
INSERT INTO public.event_tags VALUES (28, 8, 8);
INSERT INTO public.event_tags VALUES (29, 9, 9);
INSERT INTO public.event_tags VALUES (30, 10, 10);


--
-- TOC entry 4859 (class 0 OID 16422)
-- Dependencies: 223
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Concierto de Verano', '¡Disfruta de una noche llena de música en nuestro concierto de verano! Ven y únete a nosotros para una experiencia inolvidable.', 1, '2024-06-01', 120, 50, true, 100, 1, 1, 1);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Taller de Cocina', 'Aprende a cocinar platos deliciosos de la mano de nuestros chefs expertos en nuestro taller de cocina. ¡No te lo pierdas!', 2, '2024-06-02', 90, 40, true, 80, 2, 2, 2);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Sesión de Yoga al Aire Libre', 'Encuentra paz y equilibrio en nuestra sesión de yoga al aire libre. Desconéctate del estrés diario y conecta contigo mismo.', 3, '2024-06-03', 150, 60, true, 120, 3, 3, 3);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Exposición de Arte Contemporáneo', 'Explora obras fascinantes de artistas contemporáneos en nuestra exposición de arte. ¡Descubre nuevas perspectivas y emociones!', 4, '2024-06-04', 180, 70, true, 150, 4, 4, 4);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Torneo de Fútbol Local', 'Únete a la emoción del fútbol en nuestro torneo local. ¡Apoya a tu equipo favorito y disfruta de la competencia!', 5, '2024-06-05', 120, 50, true, 100, 5, 5, 5);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Curso de Fotografía Básica', 'Descubre el mundo de la fotografía en nuestro curso básico. Aprende técnicas fundamentales y captura momentos inolvidables.', 6, '2024-06-06', 90, 40, true, 80, 6, 6, 6);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Charla sobre Medio Ambiente', 'Únete a nuestra charla sobre medio ambiente y descubre cómo puedes contribuir a un futuro más sostenible. ¡Juntos podemos marcar la diferencia!', 7, '2024-06-07', 150, 60, true, 120, 7, 7, 7);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Noche de Cine al Aire Libre', 'Disfruta de una noche bajo las estrellas con nuestra proyección de cine al aire libre. Trae tus mantas y palomitas para una experiencia inolvidable.', 8, '2024-06-08', 180, 70, true, 150, 8, 8, 8);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Clase de Baile Latino', 'Aprende los pasos de baile más candentes en nuestra clase de baile latino. ¡Diviértete y libera tu energía con ritmos apasionados!', 9, '2024-06-09', 120, 50, true, 100, 9, 9, 9);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Taller de Fotografía Creativa', 'Descubre los secretos de la fotografía creativa en nuestro taller intensivo. Aprende técnicas avanzadas para capturar momentos únicos.', 7, '2024-07-15', 180, 80, true, 50, 7, 7, 10);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Concierto Acústico', 'Disfruta de una noche íntima con música acústica de calidad. Artistas locales te transportarán con sus melodías y letras profundas.', 3, '2024-08-05', 150, 40, true, 80, 3, 3, 11);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Exposición de Arte Contemporáneo', 'Explora las obras más recientes de artistas contemporáneos locales e internacionales. Una experiencia visual que no te puedes perder.', 8, '2024-09-20', 120, 20, true, 200, 8, 8, 12);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Feria de Diseño y Moda', 'Descubre las últimas tendencias en diseño y moda en nuestra feria anual. Con desfiles, talleres y productos exclusivos para todos los amantes del estilo.', 6, '2024-07-30', 240, 60, true, 150, 6, 6, 13);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Curso de Cocina Internacional', 'Viaja por el mundo a través de sabores y técnicas culinarias en nuestro curso intensivo de cocina internacional. Desde sushi japonés hasta tapas españolas, aprenderás a preparar platos auténticos.', 4, '2024-08-10', 180, 70, true, 40, 4, 4, 14);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Charla Motivacional: Alcanzando Tus Metas', 'Únete a nosotros para una charla inspiradora sobre cómo establecer y alcanzar metas significativas en la vida personal y profesional.', 5, '2024-09-05', 90, 0, true, 200, 5, 5, 15);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Festival de Cine Independiente', 'Sumérgete en el mundo del cine independiente con proyecciones de películas innovadoras y conversaciones con directores y actores.', 2, '2024-08-25', 300, 25, true, 300, 2, 2, 16);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Curso de Escritura Creativa', 'Desarrolla tu creatividad literaria en nuestro curso de escritura creativa. Aprende técnicas para escribir cuentos, poesía y más.', 1, '2024-07-20', 150, 50, true, 30, 1, 1, 17);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Fiesta Temática de los 80s', 'Revive la magia de los años 80 en nuestra fiesta temática. Con música, vestimenta y ambiente retro que te transportará en el tiempo.', 10, '2024-09-15', 180, 35, true, 120, 10, 10, 18);
INSERT INTO public.events(name, description, id_event_category, start_date, duration_in_minutes, price, enabled_for_enrollment, max_assistance, id_creator_user, id_event_location, id) VALUES ('Seminario de Marketing Digital', 'Domina las estrategias de marketing digital en nuestro seminario intensivo. Ideal para emprendedores y profesionales que buscan potenciar su negocio en línea.', 11, '2024-08-15', 120, 60, true, 50, 11, 11, 19);


--
-- TOC entry 4861 (class 0 OID 16429)
-- Dependencies: 225
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.locations VALUES (1, 'Playa del Este', -34.663571, -54.94634, 10);
INSERT INTO public.locations VALUES (2, 'Cerro Catedral', -41.1794, -71.3826, 14);
INSERT INTO public.locations VALUES (3, 'Plaza San Martín', -31.420083, -64.188776, 5);
INSERT INTO public.locations VALUES (4, 'Cataratas del Iguazú', -25.6872, -54.435, 13);
INSERT INTO public.locations VALUES (5, 'Cerro Aconcagua', -32.6539, -70.0116, 12);
INSERT INTO public.locations VALUES (6, 'Puerto Madero', -34.6102, -58.3637, 1);
INSERT INTO public.locations VALUES (7, 'Glaciar Perito Moreno', -50.4966, -73.1377, 19);
INSERT INTO public.locations VALUES (8, 'Cerro Uritorco', -30.8395, -64.4724, 3);
INSERT INTO public.locations VALUES (9, 'Barrio Recoleta', -34.5889, -58.3926, 8);
INSERT INTO public.locations VALUES (10, 'Mar de las Pampas', -37.325, -57.025, 6);
INSERT INTO public.locations VALUES (11, 'Cerro Tres Picos', -38.248, -61.886, 20);
INSERT INTO public.locations VALUES (12, 'Cerro Fitz Roy', -49.2712, -73.0431, 18);
INSERT INTO public.locations VALUES (13, 'Puerto Pirámides', -42.5847, -64.2855, 4);
INSERT INTO public.locations VALUES (14, 'Barrio Palermo', -34.584, -58.4269, 9);
INSERT INTO public.locations VALUES (15, 'Cerro Tronador', -41.1833, -71.8833, 7);
INSERT INTO public.locations VALUES (16, 'Cerro Catedral', -25.4425, -54.5786, 2);
INSERT INTO public.locations VALUES (17, 'Barrio Caballito', -34.6223, -58.4388, 11);
INSERT INTO public.locations VALUES (18, 'Sierra de la Ventana', -38.1422, -61.7761, 15);
INSERT INTO public.locations VALUES (19, 'Parque Nacional Nahuel Huapi', -41.1508, -71.3092, 17);
INSERT INTO public.locations VALUES (20, 'San Carlos de Bariloche', -41.1335, -71.3103, 16);
INSERT INTO public.locations VALUES (21, 'La Cumbrecita', -64.7737, -31.9101, 1);
INSERT INTO public.locations VALUES (22, 'Villa General Belgrano', -64.5615, -31.9774, 2);
INSERT INTO public.locations VALUES (23, 'Villa La Angostura', -71.6306, -40.7580, 3);
INSERT INTO public.locations VALUES (24, 'El Calafate', -72.2776, -50.3378, 4);
INSERT INTO public.locations VALUES (25, 'Puerto Madryn', -65.0380, -42.7692, 5);
INSERT INTO public.locations VALUES (26, 'Colón', -58.1156, -32.2300, 6);
INSERT INTO public.locations VALUES (27, 'San Martín de los Andes', -71.3436, -40.1652, 7);
INSERT INTO public.locations VALUES (28, 'Merlo', -65.0265, -32.3392, 8);
INSERT INTO public.locations VALUES (29, 'San Rafael', -68.3307, -34.6177, 9);
INSERT INTO public.locations VALUES (30, 'Tilcara', -65.3500, -23.5774, 10);
INSERT INTO public.locations VALUES (31, 'La Falda', -64.4871, -31.1017, 11);
INSERT INTO public.locations VALUES (32, 'Capilla del Monte', -64.5220, -30.8597, 12);
INSERT INTO public.locations VALUES (33, 'San Antonio de Areco', -59.4730, -34.2472, 13);
INSERT INTO public.locations VALUES (34, 'Chascomús', -58.0126, -35.5734, 14);
INSERT INTO public.locations VALUES (35, 'San Pedro', -59.6666, -33.6862, 15);
INSERT INTO public.locations VALUES (36, 'Güemes', -64.8762, -25.2339, 16);
INSERT INTO public.locations VALUES (37, 'Villa Gesell', -56.9777, -37.2632, 17);
INSERT INTO public.locations VALUES (38, 'Luján', -59.1015, -34.5703, 18);
INSERT INTO public.locations VALUES (39, 'Villa María', -63.2421, -32.4072, 19);
INSERT INTO public.locations VALUES (40, 'Junín de los Andes', -71.0706, -39.9563, 20);
INSERT INTO public.locations VALUES (41, 'San Juan', -68.5364, -31.5375, 21);
INSERT INTO public.locations VALUES (42, 'Río Ceballos', -64.3136, -31.1734, 22);
INSERT INTO public.locations VALUES (43, 'Jáchal', -68.7665, -30.2341, 23);
INSERT INTO public.locations VALUES (44, 'Achiras', -64.7783, -33.1739, 1);
INSERT INTO public.locations VALUES (45, 'Yerba Buena', -65.2994, -26.8525, 2);
INSERT INTO public.locations VALUES (46, 'Perico', -65.1130, -24.3707, 3);
INSERT INTO public.locations VALUES (47, 'Purmamarca', -65.4945, -22.1200, 4);
INSERT INTO public.locations VALUES (48, 'La Quiaca', -65.5923, -22.1032, 5);
INSERT INTO public.locations VALUES (49, 'Goya', -59.2611, -29.1406, 6);
INSERT INTO public.locations VALUES (50, 'Villa Dolores', -65.3681, -31.9444, 7);
INSERT INTO public.locations VALUES (51, 'San Fernando del Valle de Catamarca', -65.7795, -28.4696, 8);
INSERT INTO public.locations VALUES (52, 'Comodoro Rivadavia', -67.4833, -45.8667, 9);
INSERT INTO public.locations VALUES (53, 'Esquel', -71.3167, -42.9167, 10);
INSERT INTO public.locations VALUES (54, 'Villa Carlos Paz', -64.4912, -31.4241, 11);
INSERT INTO public.locations VALUES (55, 'La Paz', -59.1081, -30.7380, 12);
INSERT INTO public.locations VALUES (56, 'Santiago del Estero', -64.2605, -27.7834, 13);
INSERT INTO public.locations VALUES (57, 'San Luis', -66.3356, -33.2950, 14);
INSERT INTO public.locations VALUES (58, 'Rosario de la Frontera', -64.6998, -25.7980, 15);
INSERT INTO public.locations VALUES (59, 'San José de Jáchal', -68.7580, -30.2513, 16);
INSERT INTO public.locations VALUES (60, 'Villa Ángela', -60.7054, -27.5733, 17);
INSERT INTO public.locations VALUES (61, 'Rawson', -65.1023, -43.3002, 18);
INSERT INTO public.locations VALUES (62, 'Ushuaia', -68.3029, -54.8070, 19);
INSERT INTO public.locations VALUES (63, 'San Miguel de Tucumán', -65.2176, -26.8083, 20);
INSERT INTO public.locations VALUES (64, 'Concordia', -58.0209, -31.3929, 21);
INSERT INTO public.locations VALUES (65, 'Neuquén', -68.0591, -38.9516, 22);
INSERT INTO public.locations VALUES (66, 'Choele Choel', -65.6857, -39.2907, 23);
INSERT INTO public.locations VALUES (67, 'Villa La Bolsa', -64.4677, -31.4796, 1);
INSERT INTO public.locations VALUES (68, 'Santa Rosa de Calamuchita', -64.5246, -32.0662, 2);
INSERT INTO public.locations VALUES (69, 'Puerto San Julián', -67.7278, -49.3008, 3);
INSERT INTO public.locations VALUES (70, 'Villa Mercedes', -65.4557, -33.6758, 4);
INSERT INTO public.locations VALUES (71, 'Bell Ville', -62.6906, -32.6255, 5);
INSERT INTO public.locations VALUES (72, 'Las Heras', -68.8126, -32.8213, 6);
INSERT INTO public.locations VALUES (73, 'Río Grande', -67.7105, -54.8064, 7);
INSERT INTO public.locations VALUES (74, 'Paso de los Libres', -57.0887, -29.7117, 8);
INSERT INTO public.locations VALUES (75, 'San Pedro de Jujuy', -64.8667, -24.2333, 9);
INSERT INTO public.locations VALUES (76, 'Pergamino', -60.5736, -33.8896, 10);
INSERT INTO public.locations VALUES (77, 'Villa Unión', -68.0505, -30.8701, 11);
INSERT INTO public.locations VALUES (78, 'Cafayate', -65.9742, -26.0822, 12);
INSERT INTO public.locations VALUES (79, 'Santa Teresita', -56.7176, -36.5371, 13);
INSERT INTO public.locations VALUES (80, 'La Toma', -65.6094, -33.0540, 14);
INSERT INTO public.locations VALUES (81, 'San Luis del Palmar', -58.5467, -27.5072, 15);
INSERT INTO public.locations VALUES (82, 'Tanti', -64.5802, -31.3496, 16);
INSERT INTO public.locations VALUES (83, 'El Bolsón', -71.4977, -41.9603, 17);
INSERT INTO public.locations VALUES (84, 'Malargüe', -69.5842, -35.4756, 18);
INSERT INTO public.locations VALUES (85, 'Villa Gesell', -56.9777, -37.2632, 19);
INSERT INTO public.locations VALUES (86, 'Esperanza', -60.9310, -31.4486, 20);
INSERT INTO public.locations VALUES (87, 'Victoria', -60.2015, -32.6184, 21);
INSERT INTO public.locations VALUES (88, 'San Vicente', -54.1308, -27.3785, 22);
INSERT INTO public.locations VALUES (89, 'El Dorado', -54.6500, -26.5500, 23);
INSERT INTO public.locations VALUES (90, 'Puan', -62.8089, -37.2357, 1);
INSERT INTO public.locations VALUES (91, 'Jesús María', -64.0920, -30.9816, 2);
INSERT INTO public.locations VALUES (92, 'Chascomús', -58.0126, -35.5734, 3);
INSERT INTO public.locations VALUES (93, 'San Pedro', -59.6666, -33.6862, 4);
INSERT INTO public.locations VALUES (94, 'General Alvear', -67.5833, -34.9167, 5);
INSERT INTO public.locations VALUES (95, 'San Antonio de Areco', -59.4730, -34.2472, 6);
INSERT INTO public.locations VALUES (96, 'Villa María', -63.2421, -32.4072, 7);
INSERT INTO public.locations VALUES (97, 'San Nicolás de los Arroyos', -60.2159, -33.3350, 8);
INSERT INTO public.locations VALUES (98, 'Pilar', -58.8661, -34.4587, 9);
INSERT INTO public.locations VALUES (99, 'San Fernando', -58.5514, -34.4512, 10);
INSERT INTO public.locations VALUES (100, 'Concepción del Uruguay', -58.2372, -32.4825, 11);


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

INSERT INTO public.tags VALUES ('Mucha gente', 1);
INSERT INTO public.tags VALUES ('Poca gente', 2);
INSERT INTO public.tags VALUES ('Deportes', 3);
INSERT INTO public.tags VALUES ('Cultural', 4);
INSERT INTO public.tags VALUES ('Educación', 5);
INSERT INTO public.tags VALUES ('Arte', 6);
INSERT INTO public.tags VALUES ('Música', 7);
INSERT INTO public.tags VALUES ('Familiar', 8);
INSERT INTO public.tags VALUES ('Entretenimiento', 9);
INSERT INTO public.tags VALUES ('Gastronomía', 10);


--
-- TOC entry 4867 (class 0 OID 16441)
-- Dependencies: 231
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES ('Paula', 'Morales', 'paulamorales@gmail.com', 'passpass', 1);
INSERT INTO public.users VALUES ('Fernando', 'Ortega', 'fernandoortega@gmail.com', 'passwordpass', 2);
INSERT INTO public.users VALUES ('Verónica', 'Ramírez', 'veronicaramirez@gmail.com', 'passpass123', 3);
INSERT INTO public.users VALUES ('Daniel', 'Flores', 'danielflores@gmail.com', 'passwordpass123', 4);
INSERT INTO public.users VALUES ('Carmen', 'González', 'carmengonzalez@gmail.com', 'passpasspass', 5);
INSERT INTO public.users VALUES ('Rosa', 'Jiménez', 'rosajimenez@gmail.com', 'pass123pass', 6);
INSERT INTO public.users VALUES ('Pablo', 'Cabrera', 'pablocabrera@gmail.com', '123pass123', 7);
INSERT INTO public.users VALUES ('Marcela', 'Vargas', 'marcelavargas@gmail.com', 'passpass123', 8);
INSERT INTO public.users VALUES ('Alberto', 'Romero', 'albertoromero@gmail.com', '123456789', 9);
INSERT INTO public.users VALUES ('Silvia', 'Navarro', 'silvianavarro@gmail.com', '987654321', 10);
INSERT INTO public.users VALUES ('Lorenzo', 'Cruz', 'lorenzocruz@gmail.com', 'passwordpassword', 11);
INSERT INTO public.users VALUES ('Raquel', 'Ortiz', 'raquelortiz@gmail.com', 'passwordpassword123', 12);
INSERT INTO public.users VALUES ('Gonzalo', 'Rivas', 'gonzalorivas@gmail.com', 'passwordpassword456', 13);
INSERT INTO public.users VALUES ('Cristina', 'Moreno', 'cristinamoreno@gmail.com', 'passwordpassword789', 14);
INSERT INTO public.users VALUES ('Mario', 'Álvarez', 'marioalvarez@gmail.com', 'password123456', 15);
INSERT INTO public.users VALUES ('Eva', 'Fuentes', 'evafuentes@gmail.com', '123456abcdef', 16);
INSERT INTO public.users VALUES ('José', 'Santos', 'josesantos@gmail.com', 'abcdef123456', 17);
INSERT INTO public.users VALUES ('Isabel', 'Vega', 'isabelvega@gmail.com', 'passwordabcdef', 18);
INSERT INTO public.users VALUES ('Roberto', 'Serrano', 'robertoserrano@gmail.com', 'abcdefpassword', 19);
INSERT INTO public.users VALUES ('Natalia', 'Blanco', 'nataliablanco@gmail.com', 'passwordabcdef123', 20);
INSERT INTO public.users VALUES ('Gabriel', 'Iglesias', 'gabrieliglesias@gmail.com', '123456password', 21);
INSERT INTO public.users VALUES ('Alicia', 'Molina', 'aliciamolina@gmail.com', 'password123456', 22);
INSERT INTO public.users VALUES ('Martín', 'Castro', 'martincastro@gmail.com', 'abcdef123456', 23);
INSERT INTO public.users VALUES ('Victoria', 'Herrera', 'victoriaherrera@gmail.com', 'password123456789', 24);


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
-- TOC entry 4692 (class 2606 OID 16453)
-- Name: event_categories event_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_categories
    ADD CONSTRAINT event_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4694 (class 2606 OID 16455)
-- Name: event_enrollments event_enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments
    ADD CONSTRAINT event_enrollments_pkey PRIMARY KEY (id);


--
-- TOC entry 4696 (class 2606 OID 16457)
-- Name: event_locations event_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_locations
    ADD CONSTRAINT event_locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4698 (class 2606 OID 16459)
-- Name: event_tags event_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT event_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4700 (class 2606 OID 16461)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 4702 (class 2606 OID 16463)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 16465)
-- Name: provinces provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);


--
-- TOC entry 4706 (class 2606 OID 16467)
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4708 (class 2606 OID 16469)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2024-06-07 12:18:25

--
-- PostgreSQL database dump complete
--

