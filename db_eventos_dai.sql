PGDMP  +                    |            Eventos-DAI    16.3    16.3 #    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    Eventos-DAI    DATABASE     �   CREATE DATABASE "Eventos-DAI" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Argentina.1252';
    DROP DATABASE "Eventos-DAI";
                postgres    false            �            1259    16399    eventos    TABLE     g  CREATE TABLE public.eventos (
    id integer NOT NULL,
    name character varying(150),
    description character varying(3000),
    id_event_category integer,
    id_event_location integer,
    start_date date,
    duration_in_minutes integer,
    price integer,
    enabled_for_enrollment integer,
    max_assistance integer,
    id_creator_user integer
);
    DROP TABLE public.eventos;
       public         heap    postgres    false            �            1259    16402    Usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Usuarios_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Usuarios_id_seq";
       public          postgres    false    215            �           0    0    Usuarios_id_seq    SEQUENCE OWNED BY     D   ALTER SEQUENCE public."Usuarios_id_seq" OWNED BY public.eventos.id;
          public          postgres    false    216            �            1259    16428    event_categories    TABLE     y   CREATE TABLE public.event_categories (
    id integer NOT NULL,
    name character varying,
    display_order integer
);
 $   DROP TABLE public.event_categories;
       public         heap    postgres    false            �            1259    16456    event_enrollments    TABLE        CREATE TABLE public.event_enrollments (
    id integer NOT NULL,
    id_event integer,
    id_user integer,
    description character varying,
    registration_date_time date,
    attended integer,
    observations character varying,
    rating integer
);
 %   DROP TABLE public.event_enrollments;
       public         heap    postgres    false            �            1259    16442    event_locations    TABLE       CREATE TABLE public.event_locations (
    id integer NOT NULL,
    id_location integer,
    name character varying,
    full_adress character varying,
    max_capacity character varying,
    latitude integer,
    longitude integer,
    id_creator_user integer
);
 #   DROP TABLE public.event_locations;
       public         heap    postgres    false            �            1259    16423 
   event_tags    TABLE     f   CREATE TABLE public.event_tags (
    id integer NOT NULL,
    id_event integer,
    id_tag integer
);
    DROP TABLE public.event_tags;
       public         heap    postgres    false            �            1259    16449 	   locations    TABLE     �   CREATE TABLE public.locations (
    id integer NOT NULL,
    name character varying,
    id_provincia integer,
    latitude integer,
    longitude integer
);
    DROP TABLE public.locations;
       public         heap    postgres    false            �            1259    16435 	   provinces    TABLE     �   CREATE TABLE public.provinces (
    id integer NOT NULL,
    name character varying,
    full_name character varying,
    latitude integer,
    longitude integer,
    display_order integer
);
    DROP TABLE public.provinces;
       public         heap    postgres    false            �            1259    16416    tags    TABLE     R   CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying
);
    DROP TABLE public.tags;
       public         heap    postgres    false            �            1259    16411    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    username character varying(50),
    password character(50)
);
    DROP TABLE public.users;
       public         heap    postgres    false            :           2604    16403 
   eventos id    DEFAULT     k   ALTER TABLE ONLY public.eventos ALTER COLUMN id SET DEFAULT nextval('public."Usuarios_id_seq"'::regclass);
 9   ALTER TABLE public.eventos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            �          0    16428    event_categories 
   TABLE DATA                 public          postgres    false    220   S$       �          0    16456    event_enrollments 
   TABLE DATA                 public          postgres    false    224   m$       �          0    16442    event_locations 
   TABLE DATA                 public          postgres    false    222   �$       �          0    16423 
   event_tags 
   TABLE DATA                 public          postgres    false    219   �$       �          0    16399    eventos 
   TABLE DATA                 public          postgres    false    215   �$       �          0    16449 	   locations 
   TABLE DATA                 public          postgres    false    223   �$       �          0    16435 	   provinces 
   TABLE DATA                 public          postgres    false    221   �$       �          0    16416    tags 
   TABLE DATA                 public          postgres    false    218   	%       �          0    16411    users 
   TABLE DATA                 public          postgres    false    217   #%       �           0    0    Usuarios_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Usuarios_id_seq"', 1, false);
          public          postgres    false    216            B           2606    16427    event_tags Event_Tags_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT "Event_Tags_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.event_tags DROP CONSTRAINT "Event_Tags_pkey";
       public            postgres    false    219            @           2606    16422    tags Tags_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tags
    ADD CONSTRAINT "Tags_pkey" PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tags DROP CONSTRAINT "Tags_pkey";
       public            postgres    false    218            <           2606    16408    eventos Usuarios_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT "Usuarios_pkey" PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.eventos DROP CONSTRAINT "Usuarios_pkey";
       public            postgres    false    215            >           2606    16415    users Usuarios_pkey1 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "Usuarios_pkey1" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT "Usuarios_pkey1";
       public            postgres    false    217            D           2606    16434 &   event_categories event_categories_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.event_categories
    ADD CONSTRAINT event_categories_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.event_categories DROP CONSTRAINT event_categories_pkey;
       public            postgres    false    220            L           2606    16462 (   event_enrollments event_enrollments_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.event_enrollments
    ADD CONSTRAINT event_enrollments_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.event_enrollments DROP CONSTRAINT event_enrollments_pkey;
       public            postgres    false    224            H           2606    16448    event_locations locations_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.event_locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.event_locations DROP CONSTRAINT locations_pkey;
       public            postgres    false    222            J           2606    16455    locations locations_pkey1 
   CONSTRAINT     W   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey1 PRIMARY KEY (id);
 C   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey1;
       public            postgres    false    223            F           2606    16441    provinces provinces_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.provinces DROP CONSTRAINT provinces_pkey;
       public            postgres    false    221            �   
   x���          �   
   x���          �   
   x���          �   
   x���          �   
   x���          �   
   x���          �   
   x���          �   
   x���          �   |   x���v
Q���W((M��L�+-N-*V��L�QH�,*.��K�M�Q�I�3A* ��������M�0G�P�`Cu��ļ�̒|u�PdRS��O�������9D��_��?����ݚ�� ��*�     