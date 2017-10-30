--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.8
-- Dumped by pg_dump version 9.5.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO mint;

--
-- Name: carts; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE carts (
    id bigint NOT NULL,
    user_id bigint,
    variant_id bigint,
    quantity integer DEFAULT 1,
    size integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE carts OWNER TO mint;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE carts_id_seq OWNER TO mint;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE carts_id_seq OWNED BY carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE categories (
    id bigint NOT NULL,
    title character varying,
    "desc" text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    slug character varying,
    parent_category_id bigint,
    state integer DEFAULT 0,
    weight integer DEFAULT 0
);


ALTER TABLE categories OWNER TO mint;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO mint;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: colors; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE colors (
    id bigint NOT NULL,
    title character varying,
    slug character varying,
    "desc" text,
    parent_color_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    color character varying,
    image character varying
);


ALTER TABLE colors OWNER TO mint;

--
-- Name: colors_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE colors_id_seq OWNER TO mint;

--
-- Name: colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE colors_id_seq OWNED BY colors.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE images (
    id bigint NOT NULL,
    photo character varying,
    imagable_type character varying,
    imagable_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uuid character varying,
    weight integer DEFAULT 0
);


ALTER TABLE images OWNER TO mint;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE images_id_seq OWNER TO mint;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: kitables; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE kitables (
    id bigint NOT NULL,
    kit_id bigint,
    product_id bigint,
    variant_id bigint
);


ALTER TABLE kitables OWNER TO mint;

--
-- Name: kitables_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE kitables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kitables_id_seq OWNER TO mint;

--
-- Name: kitables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE kitables_id_seq OWNED BY kitables.id;


--
-- Name: kits; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE kits (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    theme_id bigint,
    title character varying,
    latest boolean DEFAULT false,
    state integer DEFAULT 0
);


ALTER TABLE kits OWNER TO mint;

--
-- Name: kits_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE kits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kits_id_seq OWNER TO mint;

--
-- Name: kits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE kits_id_seq OWNED BY kits.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE order_items (
    id bigint NOT NULL,
    order_id bigint,
    variant_id bigint,
    quantity integer,
    size integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    price numeric
);


ALTER TABLE order_items OWNER TO mint;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_items_id_seq OWNER TO mint;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE order_items_id_seq OWNED BY order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE orders (
    id bigint NOT NULL,
    state integer DEFAULT 0,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address text
);


ALTER TABLE orders OWNER TO mint;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO mint;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE products (
    id bigint NOT NULL,
    category_id bigint,
    price numeric,
    "desc" text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    colors character varying[],
    kind_id bigint,
    state integer DEFAULT 0,
    title character varying,
    sale boolean DEFAULT false,
    latest boolean DEFAULT false,
    price_last numeric,
    comp text
);


ALTER TABLE products OWNER TO mint;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_id_seq OWNER TO mint;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO mint;

--
-- Name: similarables; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE similarables (
    id bigint NOT NULL,
    product_id bigint,
    similar_product_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE similarables OWNER TO mint;

--
-- Name: similarables_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE similarables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE similarables_id_seq OWNER TO mint;

--
-- Name: similarables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE similarables_id_seq OWNED BY similarables.id;


--
-- Name: themables; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE themables (
    id bigint NOT NULL,
    product_id bigint,
    theme_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE themables OWNER TO mint;

--
-- Name: themables_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE themables_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE themables_id_seq OWNER TO mint;

--
-- Name: themables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE themables_id_seq OWNED BY themables.id;


--
-- Name: themes; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE themes (
    id bigint NOT NULL,
    title character varying,
    slug character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "desc" text,
    title_long character varying,
    weight integer DEFAULT 0,
    state integer DEFAULT 0
);


ALTER TABLE themes OWNER TO mint;

--
-- Name: themes_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE themes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE themes_id_seq OWNER TO mint;

--
-- Name: themes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE themes_id_seq OWNED BY themes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    remember_token character varying,
    phone character varying,
    name character varying,
    code integer,
    code_last timestamp without time zone
);


ALTER TABLE users OWNER TO mint;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO mint;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: variants; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE variants (
    id bigint NOT NULL,
    product_id bigint,
    color_id bigint,
    sizes jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    themes jsonb,
    category_id bigint,
    out_of_stock boolean DEFAULT false,
    state integer DEFAULT 1
);


ALTER TABLE variants OWNER TO mint;

--
-- Name: variants_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE variants_id_seq OWNER TO mint;

--
-- Name: variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE variants_id_seq OWNED BY variants.id;


--
-- Name: wishlists; Type: TABLE; Schema: public; Owner: mint
--

CREATE TABLE wishlists (
    id bigint NOT NULL,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    variant_id bigint
);


ALTER TABLE wishlists OWNER TO mint;

--
-- Name: wishlists_id_seq; Type: SEQUENCE; Schema: public; Owner: mint
--

CREATE SEQUENCE wishlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE wishlists_id_seq OWNER TO mint;

--
-- Name: wishlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mint
--

ALTER SEQUENCE wishlists_id_seq OWNED BY wishlists.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY carts ALTER COLUMN id SET DEFAULT nextval('carts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY colors ALTER COLUMN id SET DEFAULT nextval('colors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY kitables ALTER COLUMN id SET DEFAULT nextval('kitables_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY kits ALTER COLUMN id SET DEFAULT nextval('kits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY order_items ALTER COLUMN id SET DEFAULT nextval('order_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY similarables ALTER COLUMN id SET DEFAULT nextval('similarables_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY themables ALTER COLUMN id SET DEFAULT nextval('themables_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY themes ALTER COLUMN id SET DEFAULT nextval('themes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY variants ALTER COLUMN id SET DEFAULT nextval('variants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mint
--

ALTER TABLE ONLY wishlists ALTER COLUMN id SET DEFAULT nextval('wishlists_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2017-07-05 08:08:18.275365	2017-09-15 16:48:37.667878
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY carts (id, user_id, variant_id, quantity, size, created_at, updated_at) FROM stdin;
366	299	231	1	40	2017-10-21 12:44:57.695435	2017-10-21 12:44:57.695435
371	306	112	1	42	2017-10-22 12:42:44.28628	2017-10-22 12:42:44.28628
201	34	203	1	0	2017-09-27 09:14:53.318891	2017-09-27 09:14:53.318891
373	308	240	1	42	2017-10-22 18:36:09.226822	2017-10-22 18:36:09.226822
374	309	280	1	46	2017-10-22 19:58:36.711537	2017-10-22 19:58:36.711537
376	313	316	1	0	2017-10-23 19:52:48.134192	2017-10-23 19:52:48.134192
380	315	162	1	42	2017-10-24 08:18:38.957335	2017-10-24 08:18:38.957335
94	76	140	1	42	2017-09-21 13:20:06.807941	2017-09-21 13:20:06.807941
95	77	167	1	0	2017-09-21 15:54:10.79748	2017-09-21 15:54:10.79748
8	4	151	5	40	2017-09-15 13:09:24.396131	2017-09-15 13:56:41.233087
9	4	120	1	44	2017-09-15 13:57:37.53355	2017-09-15 13:57:37.53355
203	157	195	1	0	2017-09-27 09:51:59.715161	2017-09-27 09:51:59.715161
206	69	186	1	0	2017-09-27 13:22:55.753039	2017-09-27 13:22:55.753039
207	69	179	1	0	2017-09-27 13:23:19.418045	2017-09-27 13:23:19.418045
381	315	168	1	0	2017-10-24 08:20:20.288133	2017-10-24 08:20:20.288133
382	315	290	1	42	2017-10-24 08:20:41.144796	2017-10-24 08:20:41.144796
383	315	151	1	42	2017-10-24 08:22:56.614195	2017-10-24 08:22:56.614195
384	315	110	1	42	2017-10-24 08:23:27.524542	2017-10-24 08:23:27.524542
385	315	107	1	44	2017-10-24 08:23:47.401439	2017-10-24 08:23:47.401439
386	315	95	1	44	2017-10-24 08:24:03.487484	2017-10-24 08:24:03.487484
387	315	96	1	44	2017-10-24 08:24:21.404382	2017-10-24 08:24:21.404382
389	47	286	1	42	2017-10-25 12:33:51.363466	2017-10-25 12:33:51.363466
390	47	285	1	42	2017-10-25 12:34:22.586164	2017-10-25 12:34:22.586164
391	47	176	1	44	2017-10-25 12:35:03.979694	2017-10-25 12:35:03.979694
26	7	132	1	42	2017-09-15 18:20:01.925411	2017-09-15 18:20:01.925411
27	8	91	1	0	2017-09-15 18:21:06.994821	2017-09-15 18:21:06.994821
29	10	88	1	0	2017-09-15 18:27:22.610395	2017-09-15 18:27:22.610395
30	11	64	1	0	2017-09-15 18:30:14.494759	2017-09-15 18:30:14.494759
32	13	141	1	42	2017-09-15 18:32:53.39753	2017-09-15 18:32:53.39753
33	14	91	1	0	2017-09-15 18:38:09.892874	2017-09-15 18:38:09.892874
34	15	152	1	44	2017-09-15 18:47:17.993473	2017-09-15 18:47:17.993473
35	16	146	1	42	2017-09-15 18:59:16.385627	2017-09-15 18:59:16.385627
36	17	141	1	42	2017-09-15 19:00:46.302429	2017-09-15 19:00:46.302429
38	19	144	1	46	2017-09-15 19:04:55.40898	2017-09-15 19:04:55.40898
39	19	140	1	46	2017-09-15 19:05:16.094784	2017-09-15 19:05:16.094784
40	20	91	1	0	2017-09-15 19:09:46.219774	2017-09-15 19:09:46.219774
41	21	132	1	42	2017-09-15 19:15:16.438416	2017-09-15 19:15:16.438416
42	23	134	1	42	2017-09-15 19:44:29.254087	2017-09-15 19:44:29.254087
43	23	65	1	0	2017-09-15 19:47:42.105549	2017-09-15 19:47:42.105549
44	24	67	1	42	2017-09-15 20:00:54.564111	2017-09-15 20:00:54.564111
46	27	148	1	42	2017-09-15 21:25:55.68839	2017-09-15 21:25:55.68839
47	28	148	1	42	2017-09-15 21:41:36.985231	2017-09-15 21:41:36.985231
48	29	149	1	42	2017-09-15 22:29:53.895069	2017-09-15 22:29:53.895069
49	30	140	1	46	2017-09-16 00:48:31.274896	2017-09-16 00:48:31.274896
50	31	148	1	42	2017-09-16 01:59:16.788145	2017-09-16 01:59:16.788145
51	32	74	1	0	2017-09-16 05:11:51.755719	2017-09-16 05:11:51.755719
53	35	148	1	42	2017-09-16 06:59:40.300508	2017-09-16 06:59:40.300508
54	36	110	1	46	2017-09-16 07:13:00.226852	2017-09-16 07:13:00.226852
55	37	114	1	42	2017-09-16 07:26:20.096177	2017-09-16 07:26:20.096177
56	38	133	1	40	2017-09-16 08:28:37.994812	2017-09-16 08:28:37.994812
57	40	133	1	42	2017-09-16 09:18:19.773063	2017-09-16 09:18:19.773063
58	41	153	1	40	2017-09-16 09:31:26.748361	2017-09-16 09:31:26.748361
59	42	144	1	42	2017-09-16 10:27:51.964018	2017-09-16 10:27:51.964018
60	43	67	1	42	2017-09-16 10:52:37.478168	2017-09-16 10:52:37.478168
61	44	115	1	0	2017-09-16 12:03:40.062833	2017-09-16 12:03:40.062833
62	45	152	1	46	2017-09-16 12:42:54.089846	2017-09-16 12:42:54.089846
63	46	132	1	40	2017-09-16 13:33:14.445348	2017-09-16 13:33:14.445348
64	47	149	1	42	2017-09-16 13:39:35.211569	2017-09-16 13:39:35.211569
65	48	157	1	44	2017-09-16 15:27:24.268421	2017-09-16 15:27:24.268421
66	48	133	1	40	2017-09-16 15:28:27.624843	2017-09-16 15:28:27.624843
68	50	91	1	0	2017-09-17 04:18:01.606787	2017-09-17 04:18:01.606787
69	51	148	1	44	2017-09-17 06:58:34.455871	2017-09-17 06:58:34.455871
72	54	134	1	44	2017-09-18 04:49:54.172642	2017-09-18 04:49:54.172642
74	56	158	1	0	2017-09-18 09:05:14.118788	2017-09-18 09:05:14.118788
76	57	147	1	42	2017-09-18 09:27:00.108214	2017-09-18 09:27:00.108214
77	58	105	1	40	2017-09-18 12:05:53.900795	2017-09-18 12:05:53.900795
78	59	65	1	0	2017-09-18 14:45:08.885228	2017-09-18 14:45:08.885228
79	59	91	1	0	2017-09-18 14:46:03.618287	2017-09-18 14:46:03.618287
80	59	107	1	44	2017-09-18 14:46:23.482673	2017-09-18 14:46:23.482673
81	59	147	1	44	2017-09-18 14:48:33.774015	2017-09-18 14:48:33.774015
82	59	141	1	44	2017-09-18 14:49:02.56083	2017-09-18 14:49:02.56083
83	59	149	1	44	2017-09-18 14:49:07.90348	2017-09-18 14:49:07.90348
86	65	166	1	40	2017-09-19 17:23:33.540071	2017-09-19 17:23:33.540071
89	68	152	1	42	2017-09-20 13:47:57.816428	2017-09-20 13:47:57.816428
91	71	105	1	40	2017-09-21 07:33:07.655154	2017-09-21 07:33:07.655154
96	78	147	1	42	2017-09-21 16:17:59.599759	2017-09-21 16:17:59.599759
97	81	74	1	0	2017-09-21 20:41:40.494732	2017-09-21 20:41:40.494732
98	82	149	1	44	2017-09-21 20:59:06.831563	2017-09-21 20:59:06.831563
102	87	91	1	0	2017-09-22 10:19:24.271782	2017-09-22 10:19:24.271782
103	87	171	1	0	2017-09-22 10:19:43.074354	2017-09-22 10:19:43.074354
104	88	171	1	0	2017-09-22 10:45:49.732808	2017-09-22 10:45:49.732808
105	89	83	1	44	2017-09-22 10:47:38.316619	2017-09-22 10:47:38.316619
118	108	163	1	44	2017-09-23 10:37:57.413466	2017-09-23 10:37:57.413466
107	91	171	1	0	2017-09-22 12:27:05.455241	2017-09-22 12:27:05.455241
109	94	97	1	42	2017-09-22 13:33:37.8403	2017-09-22 13:33:37.8403
110	95	171	1	0	2017-09-22 14:18:14.78784	2017-09-22 14:18:14.78784
119	109	152	1	42	2017-09-23 11:33:54.490219	2017-09-23 11:33:54.490219
112	97	171	1	0	2017-09-22 15:35:23.548879	2017-09-22 15:35:23.548879
113	98	171	1	0	2017-09-22 15:36:23.518588	2017-09-22 15:36:23.518588
114	99	171	1	0	2017-09-22 17:10:38.902473	2017-09-22 17:10:38.902473
115	101	147	1	42	2017-09-23 08:40:46.479304	2017-09-23 08:40:46.479304
116	104	147	1	42	2017-09-23 08:43:17.072231	2017-09-23 08:43:17.072231
117	106	88	1	0	2017-09-23 10:14:15.902389	2017-09-23 10:14:15.902389
120	27	115	1	0	2017-09-23 13:27:00.384173	2017-09-23 13:27:00.384173
122	113	149	1	42	2017-09-23 18:52:30.367145	2017-09-23 18:52:30.367145
123	114	148	1	44	2017-09-23 20:54:11.243054	2017-09-23 20:54:11.243054
124	116	155	1	0	2017-09-24 08:14:11.271395	2017-09-24 08:14:11.271395
125	117	132	1	40	2017-09-24 09:14:23.762709	2017-09-24 09:14:23.762709
128	118	132	1	40	2017-09-24 14:24:40.720873	2017-09-24 14:24:40.720873
129	119	171	1	0	2017-09-24 14:57:18.013649	2017-09-24 14:57:18.013649
130	120	171	1	0	2017-09-24 14:58:35.007502	2017-09-24 14:58:35.007502
131	120	148	1	42	2017-09-24 14:59:14.329637	2017-09-24 14:59:14.329637
132	120	112	1	42	2017-09-24 14:59:40.843494	2017-09-24 14:59:40.843494
133	121	112	1	42	2017-09-24 15:02:51.033896	2017-09-24 15:02:51.033896
134	121	171	1	0	2017-09-24 15:03:06.822982	2017-09-24 15:03:06.822982
135	122	147	1	42	2017-09-24 18:47:03.933632	2017-09-24 18:47:03.933632
204	158	133	1	42	2017-09-27 10:32:28.894195	2017-09-27 10:32:28.894195
138	125	64	1	0	2017-09-25 12:27:55.291881	2017-09-25 12:27:55.291881
139	126	152	1	44	2017-09-25 18:13:07.087071	2017-09-25 18:13:07.087071
205	161	201	1	0	2017-09-27 11:48:17.296379	2017-09-27 11:48:17.296379
141	128	146	1	42	2017-09-25 21:02:21.278067	2017-09-25 21:02:21.278067
215	167	125	1	0	2017-09-28 06:44:27.316722	2017-09-28 06:44:27.316722
217	169	196	1	0	2017-09-28 10:50:40.82585	2017-09-28 10:50:40.82585
218	169	181	1	0	2017-09-28 10:51:38.00569	2017-09-28 10:51:38.00569
148	132	181	1	0	2017-09-26 04:38:10.607227	2017-09-26 04:38:10.607227
149	23	181	1	0	2017-09-26 11:54:43.411143	2017-09-26 11:54:43.411143
150	135	134	1	42	2017-09-26 14:16:00.184938	2017-09-26 14:16:00.184938
151	136	153	1	44	2017-09-26 14:17:23.318583	2017-09-26 14:17:23.318583
220	171	177	1	0	2017-09-28 11:58:05.343957	2017-09-28 11:58:05.343957
221	172	91	1	0	2017-09-28 12:15:31.28017	2017-09-28 12:15:31.28017
222	172	196	1	0	2017-09-28 12:17:10.612213	2017-09-28 12:17:10.612213
223	173	201	1	0	2017-09-28 12:18:47.970817	2017-09-28 12:18:47.970817
224	174	171	1	0	2017-09-28 12:35:19.572787	2017-09-28 12:35:19.572787
158	140	137	1	42	2017-09-26 18:18:42.231056	2017-09-26 18:18:42.231056
226	175	201	1	0	2017-09-28 16:00:33.623935	2017-09-28 16:00:33.623935
227	175	186	1	0	2017-09-28 16:01:24.871168	2017-09-28 16:01:24.871168
161	141	193	1	0	2017-09-26 19:20:49.600729	2017-09-26 19:20:49.600729
162	141	182	1	0	2017-09-26 19:26:55.287779	2017-09-26 19:26:55.287779
228	176	170	1	0	2017-09-28 20:41:05.953992	2017-09-28 20:41:05.953992
164	142	133	1	42	2017-09-26 19:31:59.779623	2017-09-26 19:31:59.779623
168	144	157	1	44	2017-09-26 20:50:42.855092	2017-09-26 20:50:42.855092
170	29	192	1	40	2017-09-26 21:35:30.630902	2017-09-26 21:35:30.630902
171	29	203	1	0	2017-09-26 21:36:25.599601	2017-09-26 21:36:25.599601
231	180	163	1	44	2017-09-29 09:11:30.071407	2017-09-29 09:11:30.071407
174	146	190	1	0	2017-09-26 23:05:21.086582	2017-09-26 23:05:21.086582
237	181	177	1	0	2017-09-29 15:25:51.297792	2017-09-29 15:25:51.297792
238	182	177	1	0	2017-09-29 18:04:21.325303	2017-09-29 18:04:21.325303
239	183	177	1	0	2017-09-29 18:05:37.079671	2017-09-29 18:05:37.079671
241	184	177	2	0	2017-09-29 19:02:07.119713	2017-09-29 19:07:25.433139
240	184	181	2	0	2017-09-29 19:01:43.835721	2017-09-29 19:07:30.437453
242	187	196	1	0	2017-09-30 08:51:29.769943	2017-09-30 08:51:29.769943
243	188	195	1	0	2017-09-30 11:37:49.033093	2017-09-30 11:37:49.033093
244	189	186	1	0	2017-09-30 13:48:05.671793	2017-09-30 13:48:05.671793
245	189	185	1	0	2017-09-30 13:50:12.787642	2017-09-30 13:50:12.787642
246	189	174	1	0	2017-09-30 13:51:30.910353	2017-09-30 13:51:30.910353
247	190	186	1	0	2017-09-30 15:57:18.187591	2017-09-30 15:57:18.187591
198	153	115	1	0	2017-09-27 08:23:19.424224	2017-09-27 08:23:19.424224
248	192	186	1	0	2017-10-01 09:40:34.346179	2017-10-01 09:40:34.346179
249	194	186	1	0	2017-10-01 10:52:24.501822	2017-10-01 10:52:24.501822
252	197	174	1	0	2017-10-02 04:37:30.115107	2017-10-02 04:37:30.115107
254	199	83	1	44	2017-10-02 18:40:03.464583	2017-10-02 18:40:03.464583
255	200	201	1	0	2017-10-02 19:25:56.716131	2017-10-02 19:25:56.716131
258	86	163	1	44	2017-10-04 08:23:57.71372	2017-10-04 08:23:57.71372
259	204	64	1	0	2017-10-04 09:18:58.536835	2017-10-04 09:18:58.536835
260	208	112	1	44	2017-10-05 08:27:09.117828	2017-10-05 08:27:09.117828
261	209	167	1	0	2017-10-05 11:12:37.267134	2017-10-05 11:12:37.267134
262	210	186	1	0	2017-10-05 13:35:08.016492	2017-10-05 13:35:08.016492
263	211	182	1	0	2017-10-05 18:50:16.099056	2017-10-05 18:50:16.099056
264	135	182	1	0	2017-10-05 19:04:43.319111	2017-10-05 19:04:43.319111
265	212	182	1	0	2017-10-05 19:05:05.8601	2017-10-05 19:05:05.8601
267	114	156	1	42	2017-10-06 04:03:13.38268	2017-10-06 04:03:13.38268
271	216	185	1	0	2017-10-06 08:53:48.490467	2017-10-06 08:53:48.490467
272	216	217	1	44	2017-10-06 08:55:32.644237	2017-10-06 08:55:32.644237
274	47	165	1	42	2017-10-06 09:51:53.955546	2017-10-06 09:51:53.955546
303	259	220	1	44	2017-10-12 06:56:56.409772	2017-10-12 06:56:56.409772
278	223	207	1	44	2017-10-06 21:28:46.973941	2017-10-06 21:28:46.973941
280	160	180	1	0	2017-10-07 10:20:49.84556	2017-10-07 10:20:49.84556
281	160	200	1	0	2017-10-07 10:21:21.546257	2017-10-07 10:21:21.546257
282	226	217	1	44	2017-10-07 10:44:00.072577	2017-10-07 10:44:00.072577
283	25	228	1	44	2017-10-07 14:27:43.536585	2017-10-07 14:27:43.536585
284	227	217	1	42	2017-10-07 16:22:19.631693	2017-10-07 16:22:19.631693
285	228	231	1	42	2017-10-08 09:07:16.494137	2017-10-08 09:07:16.494137
286	230	162	1	42	2017-10-08 16:44:18.004299	2017-10-08 16:44:18.004299
287	233	225	1	42	2017-10-08 20:16:09.706396	2017-10-08 20:16:09.706396
288	234	163	1	44	2017-10-08 20:46:14.025574	2017-10-08 20:46:14.025574
289	236	232	1	42	2017-10-09 12:01:26.168991	2017-10-09 12:01:26.168991
290	237	229	1	0	2017-10-09 13:37:26.347789	2017-10-09 13:37:26.347789
291	239	200	1	0	2017-10-09 18:59:29.295247	2017-10-09 18:59:29.295247
295	231	195	1	0	2017-10-10 09:52:29.41102	2017-10-10 09:52:29.41102
299	246	180	1	0	2017-10-10 15:01:12.372178	2017-10-10 15:01:12.372178
300	247	195	1	0	2017-10-10 16:08:50.30137	2017-10-10 16:08:50.30137
304	61	64	1	0	2017-10-12 12:48:24.362952	2017-10-12 12:48:24.362952
305	196	195	1	0	2017-10-12 13:59:44.020611	2017-10-12 13:59:44.020611
306	143	64	1	0	2017-10-12 19:46:18.178815	2017-10-12 19:46:18.178815
307	96	223	1	44	2017-10-13 05:38:03.040912	2017-10-13 05:38:03.040912
308	96	226	1	44	2017-10-13 05:44:53.792314	2017-10-13 05:44:53.792314
310	61	220	1	44	2017-10-13 12:04:52.022574	2017-10-13 12:04:52.022574
312	260	146	1	42	2017-10-13 16:38:24.250135	2017-10-13 16:38:24.250135
313	261	182	1	0	2017-10-13 18:30:35.179438	2017-10-13 18:30:35.179438
314	261	213	1	0	2017-10-13 18:31:26.001339	2017-10-13 18:31:26.001339
315	261	209	1	0	2017-10-13 18:31:34.435275	2017-10-13 18:31:34.435275
316	261	197	1	44	2017-10-13 18:31:53.171165	2017-10-13 18:31:53.171165
317	262	231	1	42	2017-10-13 18:34:07.267768	2017-10-13 18:34:07.267768
318	263	200	1	0	2017-10-13 18:38:26.385426	2017-10-13 18:38:26.385426
319	52	163	1	44	2017-10-13 20:25:51.943403	2017-10-13 20:25:51.943403
327	269	229	1	0	2017-10-14 13:56:53.006585	2017-10-14 13:56:53.006585
328	107	147	1	42	2017-10-15 13:23:07.355137	2017-10-15 13:23:07.355137
330	52	262	1	46	2017-10-15 17:48:03.803354	2017-10-15 17:48:03.803354
336	1	232	1	42	2017-10-16 11:44:53.279102	2017-10-16 11:44:53.279102
337	275	231	1	42	2017-10-16 12:24:01.553473	2017-10-16 12:24:01.553473
338	276	105	1	40	2017-10-16 12:35:58.300226	2017-10-16 12:35:58.300226
342	279	110	1	42	2017-10-17 13:35:24.417971	2017-10-17 13:35:24.417971
343	280	155	1	0	2017-10-17 16:34:07.761477	2017-10-17 16:34:07.761477
347	282	175	1	0	2017-10-18 17:47:38.213262	2017-10-18 17:47:38.213262
348	284	270	1	42	2017-10-19 08:17:32.904441	2017-10-19 08:17:32.904441
349	284	268	1	44	2017-10-19 08:17:57.20317	2017-10-19 08:17:57.20317
350	285	168	1	0	2017-10-19 09:31:59.300937	2017-10-19 09:31:59.300937
351	285	195	1	0	2017-10-19 09:32:28.573081	2017-10-19 09:32:28.573081
352	286	245	1	0	2017-10-19 09:34:20.779738	2017-10-19 09:34:20.779738
353	287	262	1	46	2017-10-19 11:58:43.821691	2017-10-19 11:58:43.821691
354	288	254	1	42	2017-10-19 16:19:08.315809	2017-10-19 16:19:08.315809
356	289	221	1	44	2017-10-19 17:19:07.652584	2017-10-19 17:19:07.652584
357	289	223	1	44	2017-10-19 17:19:29.626843	2017-10-19 17:19:29.626843
358	7	229	1	0	2017-10-19 20:01:37.962432	2017-10-19 20:01:37.962432
359	290	195	1	0	2017-10-20 10:28:53.808465	2017-10-20 10:28:53.808465
360	290	176	1	42	2017-10-20 10:29:42.713577	2017-10-20 10:29:42.713577
361	291	218	1	42	2017-10-20 10:36:44.181044	2017-10-20 10:36:44.181044
365	297	252	1	44	2017-10-21 07:21:45.223275	2017-10-21 07:21:45.223275
368	304	61	1	42	2017-10-22 05:59:37.977323	2017-10-22 05:59:37.977323
370	305	245	1	0	2017-10-22 11:09:56.500964	2017-10-22 11:09:56.500964
372	307	186	1	0	2017-10-22 16:19:02.994087	2017-10-22 16:19:02.994087
375	312	220	1	44	2017-10-23 16:41:41.807052	2017-10-23 16:41:41.807052
378	314	250	1	46	2017-10-24 06:34:33.649457	2017-10-24 06:34:33.649457
379	314	250	1	44	2017-10-24 06:34:58.2767	2017-10-24 06:34:58.2767
\.


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('carts_id_seq', 391, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY categories (id, title, "desc", created_at, updated_at, slug, parent_category_id, state, weight) FROM stdin;
14	Платья		2017-08-18 13:37:52.62718	2017-09-14 15:24:15.010487	dresses	35	1	0
24	Костюмы		2017-08-18 13:37:52.669701	2017-09-14 15:25:07.50112	suites	35	1	2
15	Пиджаки и жакеты		2017-08-18 13:37:52.635652	2017-09-14 15:25:12.541261	jackets	35	1	3
16	Блузы и рубашки		2017-08-18 13:37:52.64373	2017-09-14 15:25:16.907175	shirts	35	1	4
19	Свитера и водолазки		2017-08-18 13:37:52.653891	2017-09-14 15:25:24.928545	sweaters	35	1	5
20	Футболки		2017-08-18 13:37:52.656565	2017-09-14 15:25:38.461763	t-shirts	35	1	6
27	Джинсы		2017-08-18 13:50:56.633813	2017-08-18 13:50:56.633813	dzhinsy	18	1	0
28	Свитера		2017-08-18 15:20:22.255923	2017-08-18 15:20:22.255923	svitera	19	1	0
30	Брюки		2017-08-21 07:57:48.655808	2017-08-21 07:57:48.655808	bruki	18	1	0
31	Блуза		2017-08-21 07:59:48.941665	2017-08-21 07:59:48.941665	bluza	16	1	0
32	Жакет		2017-08-23 14:14:34.638177	2017-08-23 14:14:34.638177	zhaket	15	1	0
35	Одежда		2017-09-14 14:15:43.891094	2017-09-14 14:15:43.891094	clothing	\N	1	1
13	Верхняя одежда		2017-08-18 13:37:52.617244	2017-09-14 14:16:44.553461	outerwear	\N	1	2
23	Аксессуары		2017-08-18 13:37:52.667115	2017-09-14 14:17:01.913287	accessories	\N	1	4
21	Сумки		2017-08-18 13:37:52.661912	2017-09-14 14:17:12.900103	bags	23	1	0
22	Ремни		2017-08-18 13:37:52.66457	2017-09-14 14:17:45.524284	belts	23	1	0
37	Спортивная одежда		2017-09-14 14:36:42.149828	2017-09-14 14:36:42.149828	sportswear	\N	1	3
26	Пальто		2017-08-18 13:39:55.480716	2017-09-14 14:43:33.000749	palto	13	1	1
36	Тренчи		2017-09-14 14:25:10.935718	2017-09-14 14:43:46.471309	trench-coat	13	1	2
25	Куртки		2017-08-18 13:39:26.245464	2017-09-14 14:44:01.60335	puhoviki	13	1	3
29	Кардиганы		2017-08-18 15:20:31.498841	2017-09-14 14:44:12.458878	kardigany	13	1	4
17	Юбки		2017-08-18 13:37:52.646799	2017-09-15 11:27:50.957755	skirts	35	1	7
18	Брюки и джинсы		2017-08-18 13:37:52.649846	2017-09-15 11:27:57.119357	trousers	35	1	8
33	Свитшоты, худи и платья		2017-09-13 09:26:02.41189	2017-09-15 13:49:19.676017	svitshoty-i-hudi	37	1	1
39	Комплекты		2017-09-14 14:42:36.077561	2017-09-15 13:49:37.034945	sports-kits	37	1	3
41	Украшения		2017-09-26 09:16:49.236886	2017-09-27 10:13:24.238174	jewelry	23	1	0
40	Комбинезоны		2017-09-14 15:21:49.844957	2017-09-27 10:14:14.65087	overalls	35	1	1
42	Головные уборы		2017-10-04 10:16:18.760778	2017-10-08 20:00:51.711158	hats	23	1	0
43	Шарфы		2017-10-04 12:03:49.402205	2017-10-08 20:01:32.223288	scarves	23	1	0
45	Чехлы для гаджетов 		2017-10-09 15:46:02.839479	2017-10-09 16:08:46.947852	case	23	1	0
38	Брюки		2017-09-14 14:41:43.738289	2017-10-11 14:20:25.641178	sports-trousers	37	1	2
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('categories_id_seq', 45, true);


--
-- Data for Name: colors; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY colors (id, title, slug, "desc", parent_color_id, created_at, updated_at, color, image) FROM stdin;
11	Цветочный	flowers	\N	\N	2017-07-05 08:08:18.674302	2017-07-05 08:08:18.674302	\N	\N
13	Авангард	undef	\N	\N	2017-07-05 08:08:18.690964	2017-07-05 08:08:18.690964	\N	\N
9	Розовый	pink	Жизнь в розовом цвете	\N	2017-07-05 08:08:18.657568	2017-09-06 10:17:49.238525	#f2d6d3	\N
16	Бордовый	\N	\N	4	2017-09-06 10:31:28.400039	2017-09-06 10:31:28.400039	#7b3f3e	\N
7	Зелёный	green	Путешествие в тропики	\N	2017-07-05 08:08:18.64103	2017-09-06 10:36:19.626856	#597E6A	\N
8	Синий	blue	На волнах свободы	\N	2017-07-05 08:08:18.649329	2017-09-06 10:36:35.330287	#5C5F7B	\N
17	Клетчатый	\N	\N	\N	2017-09-06 12:36:16.873832	2017-09-06 12:36:16.873832	#999999	Untitled-1.jpg
1	Белый	white	Светлая пора	\N	2017-07-05 08:08:18.591923	2017-09-06 12:59:12.449121	#fdfdfd	\N
4	Красный	red	Красной нитью	\N	2017-07-05 08:08:18.61534	2017-09-06 13:03:54.676468	#b81424	\N
18	Песочный	\N	\N	1	2017-09-07 11:11:22.799814	2017-09-07 11:11:22.799814	#fff4e7	\N
2	Черный	black	Чёрное золото	\N	2017-07-05 08:08:18.598759	2017-09-08 08:32:56.497733	#171717	\N
6	Коричневый	brown	\N	\N	2017-07-05 08:08:18.632108	2017-09-08 08:36:02.047026	#7F5034	\N
19	Оливковый	\N	\N	7	2017-09-08 09:36:48.230677	2017-09-08 09:36:48.230677	#8F864E	\N
15	Темно-синий	\N	\N	8	2017-09-06 10:00:11.03882	2017-09-08 13:15:36.746213	#23293F	\N
20	Малиново-розовый	\N	\N	9	2017-09-08 16:57:48.692048	2017-09-08 16:57:48.692048	#b3446c	\N
22	Вишневый	\N	\N	4	2017-09-08 18:19:58.465675	2017-09-08 18:19:58.465675	#50000C	\N
23	Лиловый	\N	\N	8	2017-09-08 18:22:16.874428	2017-09-08 18:22:16.874428	#7B52AB	\N
24	Лавандовый	\N	\N	8	2017-09-08 18:24:04.412645	2017-09-08 18:24:04.412645	#9696F0	\N
28	Винный	\N	\N	16	2017-09-11 10:16:32.144379	2017-09-11 10:16:32.144379	#710038	\N
29	Винный	\N	\N	4	2017-09-11 10:17:53.303504	2017-09-11 10:17:53.303504	#79003d	\N
31	Интересный принт	\N	\N	\N	2017-09-13 10:36:03.281532	2017-09-13 10:36:03.281532		symphony.jpg
50	Кэмел	\N	\N	6	2017-09-19 13:18:42.729213	2017-09-19 13:18:42.729213	#000000	кэмел.jpg
34	Коричневая клетка	\N	\N	17	2017-09-14 12:46:46.882468	2017-09-14 12:57:28.329524	#000000	мята12сентября-4а.jpg
35	Серая клетка	\N	\N	17	2017-09-14 12:47:23.170233	2017-09-14 12:59:12.934247	#000000	мята12сентября-45аоргоп.jpg
36	Темно-серый	\N	\N	3	2017-09-15 03:45:33.351466	2017-09-15 03:45:33.351466	#3a3740	\N
37	Серебряный	\N	\N	3	2017-09-15 07:40:40.884472	2017-09-15 07:40:40.884472	#000000	silver-background-2.jpg
44	Зелено-желтая клетка	\N	\N	17	2017-09-15 11:30:02.970069	2017-09-15 11:32:53.26084	#000000	мята12сентября-8а.jpg
33	Золотая клетка	\N	\N	17	2017-09-13 15:42:01.682329	2017-09-15 11:35:46.947949	#000000	thumb_c881e034-f530-4c23-bc5e-174493cba6ec.jpg
51	Чёрно-белая клетка	\N	\N	17	2017-09-19 14:14:56.657927	2017-09-19 14:14:56.657927	#000000	чёрно-белая_клетка.jpg
21	Фиолетовый	\N	\N	\N	2017-09-08 17:04:04.655366	2017-09-15 08:40:51.529026	#bd91c7	\N
40	Дымчатый	\N	\N	3	2017-09-15 08:41:53.512309	2017-09-15 08:41:53.512309	#000000	принт_елочка.jpg
41	Оранжевый	\N	\N	\N	2017-09-15 08:44:16.777362	2017-09-15 08:44:16.777362	#FF822E	\N
52	Пурпурный	\N	\N	21	2017-09-19 15:22:40.7383	2017-09-19 15:22:40.7383	#000000	пурпурный.jpg
53	Горчичный	\N	\N	5	2017-09-19 15:26:33.964563	2017-09-19 15:26:33.964563	#000000	горчичный.jpg
14	Бежевый	\N	\N	1	2017-09-06 09:23:58.046622	2017-09-15 08:55:21.014552	#000000	бежевый.jpg
42	Рыжая клетка	\N	\N	17	2017-09-15 08:57:44.717656	2017-09-15 08:57:44.717656	#000000	K54A1848.jpg
26	Ягодный	\N	\N	9	2017-09-08 18:29:20.554854	2017-09-15 09:11:20.380902	#ffa67f	ягодный.jpg
43	Тёмно-оливковый	\N	\N	7	2017-09-15 09:20:47.309839	2017-09-15 09:20:47.309839	#000000	тёмно-оливковый.png
25	Черничный	\N	\N	21	2017-09-08 18:25:17.56075	2017-09-15 09:40:26.47617	#5870af	черника.gif
54	Несквик	\N	\N	3	2017-09-20 16:11:29.208685	2017-09-20 16:11:29.208685	#000000	несквик.jpg
10	Полосатый	stripe	\N	\N	2017-07-05 08:08:18.666028	2017-09-21 08:56:43.6995	#ffffff	полосатый.jpg
55	Мандариновый	\N	\N	41	2017-09-25 11:31:37.937446	2017-09-25 11:31:37.937446	#000000	мандарин_2.jpg
56	Мох	\N	\N	7	2017-09-25 12:14:47.565482	2017-09-25 12:14:47.565482	#000000	мох.jpg
57	Чайная роза	\N	\N	9	2017-09-25 12:29:03.771509	2017-09-25 12:29:03.771509	#000000	чайная_роза.jpg
30	Абрикосовый	\N	\N	41	2017-09-11 11:57:04.701126	2017-09-15 12:01:01.273611	#ff8b53	абрикос.jpg
3	Серый	gray	Небо Лондона	\N	2017-07-05 08:08:18.606958	2017-09-15 13:22:37.359661	#000000	серый_метал.jpg
45	Терракотовый	\N	\N	4	2017-09-15 13:31:36.333837	2017-09-15 13:31:36.333837	#000000	терракотовый.jpg
46	Светло-серый	\N	\N	3	2017-09-15 13:42:28.893747	2017-09-15 13:42:28.893747	#000000	светло-серый.jpg
47	Какао	\N	\N	6	2017-09-15 14:34:18.410905	2017-09-15 14:34:18.410905	#d6a88e	\N
48	Персиково-розовый	\N	\N	9	2017-09-15 16:13:47.577475	2017-09-15 16:13:47.577475	#000000	персиково-розовый.jpg
49	Изумрудный	\N	\N	7	2017-09-15 16:20:43.016042	2017-09-15 16:20:43.016042	#000000	Благородный_изуруд.jpg
58	Молочный	\N	\N	1	2017-09-25 12:37:34.202457	2017-09-25 12:37:34.202457	#000000	молочный.jpg
27	Пудровый	\N	\N	9	2017-09-11 10:11:19.969529	2017-09-15 16:41:44.459378	#f3b7ad	пудра.jpg
59	Тёмно-шоколадный	\N	\N	6	2017-09-25 12:43:29.423788	2017-09-25 12:43:29.423788	#000000	тёмно-шоколадный.jpg
69	Морской волны	\N	\N	8	2017-09-26 20:29:51.829676	2017-09-26 20:29:51.829676	#01d3d3	\N
60	Лесная малина	\N	\N	4	2017-09-25 12:57:29.57374	2017-09-25 12:57:29.57374	#000000	лесная_малина.png
61	Бутылочный	\N	\N	7	2017-09-25 13:31:44.917345	2017-09-25 13:31:44.917345	#000000	бутылочный.jpg
62	Лососевый	\N	\N	9	2017-09-25 13:52:17.472308	2017-09-25 13:52:17.472308	#000000	лосось.png
63	Синий джинс	\N	\N	8	2017-09-25 17:56:06.065516	2017-09-25 17:56:06.065516	#000000	синий_джинс.jpg
65	Горький розовый	\N	\N	9	2017-09-26 07:30:27.319659	2017-09-26 07:30:27.319659	#000000	горький_розовый.jpg
66	Марсала	\N	\N	4	2017-09-26 08:22:30.521504	2017-09-26 08:22:30.521504	#000000	марсала.jpg
67	Золото	\N	\N	5	2017-09-26 09:20:17.656053	2017-09-26 09:20:17.656053	#000000	золото.jpg
64	Ваниль	\N	\N	1	2017-09-25 18:03:08.259535	2017-09-26 19:55:14.060942	#fffff2	\N
68	Сахарная вата	\N	\N	9	2017-09-26 19:46:30.370814	2017-09-26 19:51:25.556176	#ffeaf4	\N
32	Голубой	\N	\N	8	2017-09-13 13:42:47.675314	2017-09-26 20:28:57.409681	#5badff	голубой.jpg
12	Черно-белый	mono	\N	\N	2017-07-05 08:08:18.682636	2017-10-20 10:29:35.213602	#000000	чёрно-белый.jpg
70	Жемчужный	\N	\N	1	2017-09-26 20:36:51.52368	2017-09-26 20:36:51.52368	#eaf9d9	\N
71	Хаки	\N	\N	7	2017-10-04 11:27:16.018987	2017-10-04 11:29:43.834197	#000000	хаки.jpg
72	Ментоловый	\N	\N	7	2017-10-04 13:18:52.426826	2017-10-04 13:18:52.426826	#000000	ментоловый.jpg
73	Бургундия	\N	\N	4	2017-10-15 11:53:23.510937	2017-10-15 11:53:23.510937	#840a06	\N
74	Синий в бело-красную полоску	\N	\N	8	2017-10-15 12:06:26.703014	2017-10-15 12:16:30.709216	#11185e	92115_40-48.jpg
75	Салатовый	\N	\N	7	2017-10-16 12:55:35.605174	2017-10-16 12:55:35.605174	#000000	Салатовый.jpg
76	Лайм	\N	\N	7	2017-10-16 12:57:42.839723	2017-10-16 12:57:42.839723	#000000	лайм.jpg
5	Жёлтый	yellow	Навстречу солнцу	\N	2017-07-05 08:08:18.623713	2017-10-16 13:59:41.266311	#000000	жёлтый.jpg
77	Голубой джинс	\N	\N	8	2017-10-16 14:11:41.860799	2017-10-16 14:11:41.860799	#000000	голубой.jpg
78	Охра	\N	\N	6	2017-10-16 14:33:23.364711	2017-10-16 14:33:23.364711	#000000	охра.jpg
79	Небесно-голубой	\N	\N	8	2017-10-17 14:40:48.944598	2017-10-17 14:40:48.944598	#000000	небесно_голубой.jpg
80	Клубничное мороженное	\N	\N	9	2017-10-17 14:44:54.587349	2017-10-17 14:44:54.587349	#000000	клубничное_мороженное.jpg
81	Банановый	\N	\N	5	2017-10-17 14:56:44.952376	2017-10-17 14:56:44.952376	#000000	банановый.jpg
\.


--
-- Name: colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('colors_id_seq', 81, true);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY images (id, photo, imagable_type, imagable_id, created_at, updated_at, uuid, weight) FROM stdin;
150	9b92ce64-1bf0-4b0c-b32c-defbace3125e.jpg	Variant	65	2017-09-04 21:46:24.173256	2017-10-04 05:35:07.75927	9b92ce64-1bf0-4b0c-b32c-defbace3125e	1
833	cc0b312e-b6dd-4b17-a47f-218017c110ac.JPG	Variant	177	2017-09-26 20:13:18.273794	2017-09-26 20:13:26.372923	cc0b312e-b6dd-4b17-a47f-218017c110ac	1
152	a5b6f586-b66c-43c2-8313-73e363c58550.jpg	Variant	65	2017-09-04 21:48:24.099982	2017-10-04 05:35:11.02256	a5b6f586-b66c-43c2-8313-73e363c58550	3
837	47b4ab79-6a4d-4fc7-a970-4dfb4c0c98b3.JPG	Variant	179	2017-09-26 20:15:36.592388	2017-09-26 20:17:09.712203	47b4ab79-6a4d-4fc7-a970-4dfb4c0c98b3	1
834	636d92df-a0a6-4783-a526-32e17b9062d2.JPG	Variant	177	2017-09-26 20:13:45.397018	2017-09-26 20:31:06.063799	636d92df-a0a6-4783-a526-32e17b9062d2	2
138	061cdf53-00af-49fa-9987-5a95e654a451.jpg	Variant	61	2017-09-04 20:58:47.143992	2017-09-15 12:54:16.152367	061cdf53-00af-49fa-9987-5a95e654a451	1
137	e6417fdf-6405-4c22-b3f4-b4081706ab6d.jpg	Variant	61	2017-09-04 20:54:21.089783	2017-09-15 12:54:19.043073	e6417fdf-6405-4c22-b3f4-b4081706ab6d	2
144	fc1f9aac-0474-4d31-a383-c9103b3668e6.jpg	Variant	61	2017-09-04 21:18:28.920498	2017-09-15 12:54:34.062243	fc1f9aac-0474-4d31-a383-c9103b3668e6	3
838	dda966b0-e560-417b-8a3c-4f1f6f481319.JPG	Variant	179	2017-09-26 20:15:42.602353	2017-09-26 20:17:16.232209	dda966b0-e560-417b-8a3c-4f1f6f481319	3
501	eef06971-bbf1-4f24-8808-5ada5af251ab.jpg	Variant	142	2017-09-14 22:37:28.851277	2017-09-26 20:30:26.926835	eef06971-bbf1-4f24-8808-5ada5af251ab	2
835	62790871-e0c0-4ea1-86eb-dacb0be41b6a.JPG	Variant	177	2017-09-26 20:13:51.784182	2017-09-26 20:31:10.654272	62790871-e0c0-4ea1-86eb-dacb0be41b6a	3
518	8afe0fc7-fa2d-4e4b-b394-3510fe309491.jpg	Variant	141	2017-09-15 13:57:59.54205	2017-09-15 13:58:29.161612	8afe0fc7-fa2d-4e4b-b394-3510fe309491	5
133	01da090e-09e3-44f6-89d8-a1fb971a0a1b.jpg	Variant	59	2017-09-04 20:28:01.401474	2017-09-04 20:28:01.401474	01da090e-09e3-44f6-89d8-a1fb971a0a1b	0
134	42402792-e716-4bf4-be8c-8ff24d267814.jpg	Variant	59	2017-09-04 20:38:46.149929	2017-09-04 20:38:46.149929	42402792-e716-4bf4-be8c-8ff24d267814	0
135	80873daa-a7b5-4218-9eb5-cdfaebb1fedf.jpg	Variant	59	2017-09-04 20:42:42.040464	2017-09-04 20:42:42.040464	80873daa-a7b5-4218-9eb5-cdfaebb1fedf	0
136	0a3f16c1-1b94-4fb7-bb93-b4f197c147e5.jpg	Variant	59	2017-09-04 20:43:41.780134	2017-09-04 20:43:41.780134	0a3f16c1-1b94-4fb7-bb93-b4f197c147e5	0
140	db78e0f9-a2f5-4492-b330-6ff835db187e.jpg	Variant	62	2017-09-04 21:16:44.405207	2017-09-04 21:16:44.405207	db78e0f9-a2f5-4492-b330-6ff835db187e	0
141	34733204-fdff-4d85-b8b2-9ad5e91d240e.jpg	Variant	62	2017-09-04 21:16:58.128492	2017-09-04 21:16:58.128492	34733204-fdff-4d85-b8b2-9ad5e91d240e	0
142	ee98beb8-8c5d-4c02-86ec-e907b8dc4e8c.jpg	Variant	62	2017-09-04 21:17:11.774996	2017-09-04 21:17:11.774996	ee98beb8-8c5d-4c02-86ec-e907b8dc4e8c	0
143	3bac2312-1ca4-437f-b2d0-d700f93283e3.jpg	Variant	62	2017-09-04 21:17:29.693651	2017-09-04 21:17:29.693651	3bac2312-1ca4-437f-b2d0-d700f93283e3	0
519	17e852fa-d0d3-45d2-bafb-65450997b3bb.jpg	Kit	35	2017-09-15 14:19:26.679246	2017-09-15 14:19:26.679246	17e852fa-d0d3-45d2-bafb-65450997b3bb	0
520	08877790-0cb9-4809-9108-af2e2afecd84.jpg	Variant	157	2017-09-15 14:24:28.503367	2017-09-15 14:24:28.503367	08877790-0cb9-4809-9108-af2e2afecd84	0
521	a30add32-2e26-4d99-a39a-f955883b5571.jpg	Variant	157	2017-09-15 14:25:37.229721	2017-09-15 14:25:37.229721	a30add32-2e26-4d99-a39a-f955883b5571	0
522	12174c70-39dd-4052-970c-70feb387681e.jpg	Variant	157	2017-09-15 14:25:57.35406	2017-09-15 14:25:57.35406	12174c70-39dd-4052-970c-70feb387681e	0
523	1429f52f-618a-4dca-b379-1d5b25f464ed.jpg	Variant	82	2017-09-15 14:26:45.727214	2017-09-15 14:27:17.831423	1429f52f-618a-4dca-b379-1d5b25f464ed	1
524	7a7945c6-93ff-4a3d-893a-718c2dbb253d.jpg	Variant	82	2017-09-15 14:27:02.724034	2017-09-15 14:27:19.078008	7a7945c6-93ff-4a3d-893a-718c2dbb253d	2
153	0f04a76f-a4c8-450b-b1ec-b9970b47dcc1.jpg	Variant	66	2017-09-04 21:59:39.694612	2017-09-14 14:34:47.798847	0f04a76f-a4c8-450b-b1ec-b9970b47dcc1	1
154	81a2a04c-45af-436c-ac6e-adea69480e9c.jpg	Variant	66	2017-09-04 21:59:47.375132	2017-09-14 14:34:49.822861	81a2a04c-45af-436c-ac6e-adea69480e9c	2
155	11fd5a1b-7ff8-42bc-875a-e9656756f633.jpg	Variant	66	2017-09-04 21:59:56.830695	2017-09-14 14:34:52.426027	11fd5a1b-7ff8-42bc-875a-e9656756f633	3
156	828eb281-cdfd-40c8-909e-3a6eee4951b3.jpg	Variant	66	2017-09-04 22:00:03.720404	2017-09-14 14:35:03.931037	828eb281-cdfd-40c8-909e-3a6eee4951b3	4
158	a77e2258-e654-4ca7-b060-2dfd33f951c7.jpg	Variant	67	2017-09-04 22:05:04.62945	2017-09-14 14:35:08.212505	a77e2258-e654-4ca7-b060-2dfd33f951c7	1
159	a961ce0e-dfe3-49ce-8a75-0fd8ba4193e7.jpg	Variant	67	2017-09-04 22:05:11.664369	2017-09-14 14:35:10.710006	a961ce0e-dfe3-49ce-8a75-0fd8ba4193e7	2
986	73b6f1d8-75db-44a2-83a6-578f34e4d82d.jpg	Variant	168	2017-10-04 05:41:06.727504	2017-10-04 05:42:28.737386	73b6f1d8-75db-44a2-83a6-578f34e4d82d	3
151	d7ca83c8-eb02-4579-8b48-a5375707f6f0.jpg	Variant	65	2017-09-04 21:46:58.421696	2017-09-14 16:48:00.47588	d7ca83c8-eb02-4579-8b48-a5375707f6f0	2
148	aba160a3-6f14-4e45-b201-85f4d102a2cd.jpg	Variant	64	2017-09-04 21:41:04.379565	2017-09-14 16:48:18.029304	aba160a3-6f14-4e45-b201-85f4d102a2cd	1
149	f1ca4c8a-438f-4394-a87a-ffa9b140c759.jpg	Variant	64	2017-09-04 21:41:10.624836	2017-09-14 16:48:22.910641	f1ca4c8a-438f-4394-a87a-ffa9b140c759	2
525	5612cb36-0aa6-4ceb-8039-dfce0e13bb47.jpg	Variant	158	2017-09-15 14:34:44.493066	2017-09-15 14:34:44.493066	5612cb36-0aa6-4ceb-8039-dfce0e13bb47	0
526	02f7c0bd-47dd-4455-9ba2-d625c1efa2a4.jpg	Variant	158	2017-09-15 14:35:31.818934	2017-09-15 14:35:31.818934	02f7c0bd-47dd-4455-9ba2-d625c1efa2a4	0
527	6136cebc-dd91-4be6-8eb7-c2d0127d5397.jpg	Variant	158	2017-09-15 14:35:38.253187	2017-09-15 14:35:38.253187	6136cebc-dd91-4be6-8eb7-c2d0127d5397	0
528	fa367764-bfbb-4ee3-b30b-9bcd1b65430e.jpg	Variant	158	2017-09-15 14:35:43.840844	2017-09-15 14:35:43.840844	fa367764-bfbb-4ee3-b30b-9bcd1b65430e	0
529	caac4f99-f89b-479c-a79c-0e110c63ee8c.jpg	Kit	36	2017-09-15 14:42:37.690343	2017-09-15 14:42:37.690343	caac4f99-f89b-479c-a79c-0e110c63ee8c	0
531	dad15bed-1c49-4ef4-b885-28b2a6edf93e.jpg	Variant	153	2017-09-15 14:44:51.289845	2017-09-15 15:21:19.046262	dad15bed-1c49-4ef4-b885-28b2a6edf93e	3
568	e4a96b6a-727e-478f-913d-ac178fbafb8f.jpg	Variant	166	2017-09-19 14:51:00.001799	2017-09-19 19:49:53.801182	e4a96b6a-727e-478f-913d-ac178fbafb8f	1
572	c2e2161e-6f72-4d82-aa21-61dfdc7c392d.jpg	Variant	166	2017-09-19 14:51:33.359487	2017-09-19 19:49:57.313743	c2e2161e-6f72-4d82-aa21-61dfdc7c392d	2
570	01bf12c0-2d70-4258-929c-b077c6bea2da.jpg	Variant	166	2017-09-19 14:51:06.942458	2017-09-19 19:50:04.589452	01bf12c0-2d70-4258-929c-b077c6bea2da	3
162	d4f15a1a-9832-4bf5-aafe-798eb6b51a4c.jpg	Kit	18	2017-09-05 10:44:09.253716	2017-09-05 10:44:09.253716	d4f15a1a-9832-4bf5-aafe-798eb6b51a4c	0
985	a96e32a2-c7a0-42eb-a6d1-33710d16cabb.jpg	Variant	168	2017-10-04 05:40:29.621645	2017-10-04 05:42:23.256857	a96e32a2-c7a0-42eb-a6d1-33710d16cabb	1
987	4b672ade-8021-430a-b86e-afaf4cf8f793.jpg	Variant	181	2017-10-04 05:44:05.316789	2017-10-04 05:44:05.316789	4b672ade-8021-430a-b86e-afaf4cf8f793	0
168	fb399e0a-4359-40d2-888c-48686de92634.jpg	Variant	70	2017-09-06 09:24:38.130095	2017-09-06 09:24:38.130095	fb399e0a-4359-40d2-888c-48686de92634	0
169	04b0d90e-f5cc-46c9-ba03-a8d9b317c99e.jpg	Variant	70	2017-09-06 09:25:39.432837	2017-09-06 09:25:39.432837	04b0d90e-f5cc-46c9-ba03-a8d9b317c99e	0
170	118390cd-c5a0-43de-a55c-06d2f5bd9a1c.jpg	Variant	70	2017-09-06 09:29:17.382619	2017-09-06 09:29:17.382619	118390cd-c5a0-43de-a55c-06d2f5bd9a1c	0
171	dc8a6d75-0ac5-4414-88b9-96e8cd1365b9.jpg	Variant	71	2017-09-06 09:42:21.286213	2017-09-06 09:42:21.286213	dc8a6d75-0ac5-4414-88b9-96e8cd1365b9	0
172	b3f0e280-eacd-4873-b91a-7c44127be6a0.jpg	Variant	71	2017-09-06 09:42:28.719853	2017-09-06 09:42:28.719853	b3f0e280-eacd-4873-b91a-7c44127be6a0	0
173	0b3b06b2-f909-42d1-a64c-deb965cddb4e.jpg	Variant	72	2017-09-06 09:48:15.405367	2017-09-06 09:48:15.405367	0b3b06b2-f909-42d1-a64c-deb965cddb4e	0
174	b9b21e7c-2413-439a-8693-209d098a07b8.jpg	Variant	72	2017-09-06 09:48:21.655535	2017-09-06 09:48:21.655535	b9b21e7c-2413-439a-8693-209d098a07b8	0
175	3330a22f-7f5e-455b-a0c9-db226b343619.jpg	Variant	72	2017-09-06 09:48:26.419924	2017-09-06 09:48:26.419924	3330a22f-7f5e-455b-a0c9-db226b343619	0
988	4624a057-f1a3-4dbb-bbe7-8b607b6c742e.jpg	Variant	181	2017-10-04 05:44:44.905312	2017-10-04 05:44:44.905312	4624a057-f1a3-4dbb-bbe7-8b607b6c742e	0
989	7a2ddced-c714-4588-8688-e57a349bb839.jpg	Variant	181	2017-10-04 05:45:25.903421	2017-10-04 05:45:25.903421	7a2ddced-c714-4588-8688-e57a349bb839	0
179	50f3493d-803a-4336-8269-77aec5f0eea6.jpg	Variant	74	2017-09-06 10:02:19.672343	2017-09-06 10:02:19.672343	50f3493d-803a-4336-8269-77aec5f0eea6	0
180	06bc2b8b-2800-4484-9b72-d6905342fb1a.jpg	Variant	74	2017-09-06 10:02:28.477235	2017-09-06 10:02:28.477235	06bc2b8b-2800-4484-9b72-d6905342fb1a	0
181	348e5dba-0a66-462a-812d-83ee6392b888.jpg	Variant	74	2017-09-06 10:02:33.499577	2017-09-06 10:02:33.499577	348e5dba-0a66-462a-812d-83ee6392b888	0
185	64344d12-6cc4-4484-9a8b-673e16acb443.jpg	Variant	76	2017-09-06 10:32:17.955787	2017-09-06 10:32:17.955787	64344d12-6cc4-4484-9a8b-673e16acb443	0
186	58d8f00f-4b37-4aa9-84c8-770a5c9ad0c3.jpg	Variant	76	2017-09-06 10:32:24.768595	2017-09-06 10:32:24.768595	58d8f00f-4b37-4aa9-84c8-770a5c9ad0c3	0
187	f9d80437-9619-4caa-8fd9-0a47709fb241.jpg	Variant	76	2017-09-06 10:32:30.145221	2017-09-06 10:32:30.145221	f9d80437-9619-4caa-8fd9-0a47709fb241	0
188	1ece1dde-3b4a-4295-84de-3e42afc581d1.jpg	Variant	76	2017-09-06 10:34:09.628731	2017-09-06 10:34:09.628731	1ece1dde-3b4a-4295-84de-3e42afc581d1	0
189	3a49da80-b411-42cd-aa5d-3021e8b4e033.jpg	Variant	77	2017-09-06 10:34:43.834856	2017-09-06 10:34:43.834856	3a49da80-b411-42cd-aa5d-3021e8b4e033	0
190	e73daadc-0ea4-4c39-b58f-3b1afca75157.jpg	Variant	77	2017-09-06 10:34:48.017245	2017-09-06 10:34:48.017245	e73daadc-0ea4-4c39-b58f-3b1afca75157	0
191	b8d86c7c-85fc-4440-b781-4a8522763709.jpg	Variant	77	2017-09-06 10:35:34.989791	2017-09-06 10:35:34.989791	b8d86c7c-85fc-4440-b781-4a8522763709	0
192	cc112c6d-7eb8-4a04-aa4f-37c23eb80f36.jpg	Kit	19	2017-09-06 10:46:36.813993	2017-09-06 10:46:36.813993	cc112c6d-7eb8-4a04-aa4f-37c23eb80f36	0
700	af09342f-b4c4-4ad5-a5f2-bead89db2e05.jpg	Variant	165	2017-09-26 06:32:35.593517	2017-09-26 06:32:59.610551	af09342f-b4c4-4ad5-a5f2-bead89db2e05	2
702	8af90e4a-709c-49fb-aa87-7298f89f3698.jpg	Variant	193	2017-09-26 06:37:32.946685	2017-09-26 06:37:32.946685	8af90e4a-709c-49fb-aa87-7298f89f3698	0
703	6da0e83c-cb6f-4f94-8f35-9c58abd31a7c.jpg	Variant	193	2017-09-26 06:37:36.61057	2017-09-26 06:37:36.61057	6da0e83c-cb6f-4f94-8f35-9c58abd31a7c	0
704	2271d7f5-480f-42ff-9ad4-fb0db26a28b5.jpg	Variant	193	2017-09-26 06:37:40.257193	2017-09-26 06:37:40.257193	2271d7f5-480f-42ff-9ad4-fb0db26a28b5	0
705	d93ef5d8-eb56-4ec9-be0c-7a4b7900baff.jpg	Kit	37	2017-09-26 06:40:06.900313	2017-09-26 06:40:06.900313	d93ef5d8-eb56-4ec9-be0c-7a4b7900baff	0
844	d2dc01f8-6414-4cd3-880d-f977825e84db.JPG	Variant	179	2017-09-26 20:17:26.500661	2017-09-26 20:18:19.263687	d2dc01f8-6414-4cd3-880d-f977825e84db	2
197	4515b8ac-82db-4e70-adc4-fd071ec933f7.jpg	Variant	81	2017-09-06 12:45:01.075311	2017-09-15 12:49:12.125883	4515b8ac-82db-4e70-adc4-fd071ec933f7	1
208	bdc54a3c-6060-40ee-8e28-e6b404d68983.jpg	Variant	83	2017-09-06 12:52:53.093211	2017-09-14 13:11:52.85572	bdc54a3c-6060-40ee-8e28-e6b404d68983	3
207	f42b2b14-e150-4063-b535-9af2f328adc8.jpg	Variant	83	2017-09-06 12:52:50.228422	2017-09-14 13:11:57.419466	f42b2b14-e150-4063-b535-9af2f328adc8	4
160	fa649e5e-30e4-4bb5-a681-48880d47ed99.jpg	Variant	67	2017-09-04 22:05:21.056193	2017-09-14 14:35:13.704447	fa649e5e-30e4-4bb5-a681-48880d47ed99	3
161	c69df705-1174-4e85-a4c1-e977e08a0988.jpg	Variant	67	2017-09-04 22:05:29.596783	2017-09-14 14:35:18.724868	c69df705-1174-4e85-a4c1-e977e08a0988	4
206	d84f9c11-8158-494b-b0d1-83308427a4c5.jpg	Variant	83	2017-09-06 12:52:46.203602	2017-09-15 10:08:12.140809	d84f9c11-8158-494b-b0d1-83308427a4c5	1
195	0c7c3bcb-c15e-44ce-8314-9dfeeb0db15e.jpg	Variant	81	2017-09-06 12:44:43.910853	2017-09-15 12:49:14.161772	0c7c3bcb-c15e-44ce-8314-9dfeeb0db15e	2
196	f9b37f36-e3c1-46a2-9423-215931518297.jpg	Variant	81	2017-09-06 12:44:57.751719	2017-09-15 12:49:16.426928	f9b37f36-e3c1-46a2-9423-215931518297	3
198	bba6cd28-831c-4faf-9104-57281ee6e0a9.jpg	Variant	81	2017-09-06 12:45:07.925479	2017-09-15 12:49:23.487595	bba6cd28-831c-4faf-9104-57281ee6e0a9	4
201	8b90f80f-6256-47f1-b44a-7d89a0d308a8.jpg	Variant	82	2017-09-06 12:48:39.607956	2017-09-15 14:27:23.218384	8b90f80f-6256-47f1-b44a-7d89a0d308a8	3
202	95071bc7-ed95-4555-b75b-df91eacfdb0a.jpg	Variant	82	2017-09-06 12:48:43.321936	2017-09-15 14:27:24.556195	95071bc7-ed95-4555-b75b-df91eacfdb0a	4
848	cbd51970-c922-47bd-836b-54d97cfecad1.JPG	Variant	198	2017-09-26 20:24:19.001729	2017-09-26 20:24:40.782033	cbd51970-c922-47bd-836b-54d97cfecad1	3
850	54a08430-c2cd-4a33-a06f-178c9af6476d.JPG	Variant	198	2017-09-26 20:24:29.350051	2017-09-26 20:24:42.878775	54a08430-c2cd-4a33-a06f-178c9af6476d	4
847	87eb1ca6-3bf8-4d37-8281-0b019c8155a1.JPG	Variant	198	2017-09-26 20:24:14.266502	2017-09-26 20:24:46.134607	87eb1ca6-3bf8-4d37-8281-0b019c8155a1	1
849	39a0fd55-5343-4617-9039-951c97c1d42f.JPG	Variant	198	2017-09-26 20:24:23.927091	2017-09-26 20:24:38.926335	39a0fd55-5343-4617-9039-951c97c1d42f	2
219	05d19355-c4d6-4aad-8288-f081273967bd.jpg	Variant	86	2017-09-06 13:08:57.066617	2017-09-06 13:08:57.066617	05d19355-c4d6-4aad-8288-f081273967bd	0
220	76716265-791e-4aeb-b605-070300fed31d.jpg	Variant	86	2017-09-06 13:08:59.398814	2017-09-06 13:08:59.398814	76716265-791e-4aeb-b605-070300fed31d	0
221	069d89ed-525b-435d-a22c-145a555597d7.jpg	Variant	86	2017-09-06 13:09:02.088234	2017-09-06 13:09:02.088234	069d89ed-525b-435d-a22c-145a555597d7	0
226	111e1f17-5283-48b5-88a5-f6e5e0c1c598.jpg	Variant	89	2017-09-07 09:48:48.776661	2017-09-07 09:48:48.776661	111e1f17-5283-48b5-88a5-f6e5e0c1c598	0
227	97bea1f1-f669-4caa-909b-9122515442b2.jpg	Variant	89	2017-09-07 09:48:56.458405	2017-09-07 09:48:56.458405	97bea1f1-f669-4caa-909b-9122515442b2	0
228	c82a64f9-00ec-44f7-acf5-1ac9eece258a.jpg	Variant	89	2017-09-07 09:49:12.051575	2017-09-07 09:49:12.051575	c82a64f9-00ec-44f7-acf5-1ac9eece258a	0
503	b06b7043-bef6-47e5-98cf-19530578cb74.jpg	Variant	120	2017-09-14 22:38:46.269672	2017-09-14 22:39:04.374073	b06b7043-bef6-47e5-98cf-19530578cb74	5
504	979cb331-2306-4253-b72c-3dcc92cb10d3.jpg	Variant	120	2017-09-14 22:38:48.809765	2017-09-14 22:39:11.965066	979cb331-2306-4253-b72c-3dcc92cb10d3	7
225	6e8eb522-db59-4588-8fde-9f73f0585d68.jpg	Variant	88	2017-09-07 09:44:07.972819	2017-09-15 03:31:11.67507	6e8eb522-db59-4588-8fde-9f73f0585d68	1
241	f565dcd0-eced-4c7f-961d-aca945cd3e24.jpg	Variant	93	2017-09-07 15:17:37.315644	2017-09-07 15:17:37.315644	f565dcd0-eced-4c7f-961d-aca945cd3e24	0
242	8db46d31-da15-45b3-b3ec-cfeb39eef860.jpg	Variant	93	2017-09-07 15:17:57.420938	2017-09-07 15:17:57.420938	8db46d31-da15-45b3-b3ec-cfeb39eef860	0
244	0209b1f8-a8bd-4a7c-95e4-4370ac7b2204.jpg	Variant	94	2017-09-07 15:23:38.102484	2017-09-07 15:23:38.102484	0209b1f8-a8bd-4a7c-95e4-4370ac7b2204	0
245	0ded5427-8cf2-4846-864d-46e5ba7cc544.jpg	Variant	94	2017-09-07 15:24:20.540234	2017-09-07 15:24:20.540234	0ded5427-8cf2-4846-864d-46e5ba7cc544	0
246	21cac650-e399-4ff2-b4c0-4dc51e3cdf6e.jpg	Kit	21	2017-09-07 15:28:13.099002	2017-09-07 15:28:13.099002	21cac650-e399-4ff2-b4c0-4dc51e3cdf6e	0
250	5081414b-60bf-48cc-9f66-476c15561967.jpg	Variant	96	2017-09-08 08:40:31.568871	2017-09-08 08:40:31.568871	5081414b-60bf-48cc-9f66-476c15561967	0
251	e798b5d6-a855-4359-8ae2-1179ec1a86a9.jpg	Variant	96	2017-09-08 08:40:35.443418	2017-09-08 08:40:35.443418	e798b5d6-a855-4359-8ae2-1179ec1a86a9	0
252	2fb87a59-87a8-4a0b-b1f4-374cc408ea90.jpg	Kit	22	2017-09-08 08:49:48.426767	2017-09-08 08:49:48.426767	2fb87a59-87a8-4a0b-b1f4-374cc408ea90	0
259	0d6c8b2b-8b8b-4981-837a-7d1b1510d044.jpg	Variant	96	2017-09-08 09:13:37.45779	2017-09-08 09:13:37.45779	0d6c8b2b-8b8b-4981-837a-7d1b1510d044	0
260	8402f767-1d1e-4a76-a12c-d969ef00d533.jpg	Variant	98	2017-09-08 09:37:33.783187	2017-09-08 09:37:33.783187	8402f767-1d1e-4a76-a12c-d969ef00d533	0
261	1b6f6447-b99e-413c-9837-de43c0358a55.jpg	Variant	98	2017-09-08 09:37:38.823944	2017-09-08 09:37:38.823944	1b6f6447-b99e-413c-9837-de43c0358a55	0
223	18a41b3d-727f-4e48-82e1-263462976189.jpg	Variant	88	2017-09-07 09:42:42.79605	2017-09-15 03:31:14.478403	18a41b3d-727f-4e48-82e1-263462976189	2
224	c8b481c0-dd51-4ede-8d28-6fbe5abb1446.jpg	Variant	88	2017-09-07 09:42:47.529784	2017-09-15 03:31:20.315531	c8b481c0-dd51-4ede-8d28-6fbe5abb1446	3
253	e93a955f-4cc8-484b-a6d4-c3ae60ec064a.jpg	Variant	97	2017-09-08 08:59:40.150745	2017-09-14 13:37:16.687732	e93a955f-4cc8-484b-a6d4-c3ae60ec064a	2
254	d8720c0b-0b0e-4d05-8e8c-729d95d25596.jpg	Variant	97	2017-09-08 08:59:43.817139	2017-09-14 18:14:03.515801	d8720c0b-0b0e-4d05-8e8c-729d95d25596	5
255	adf833f9-3d04-4be8-9782-1f0f197dc2e9.jpg	Variant	97	2017-09-08 08:59:49.246245	2017-09-14 18:13:43.727302	adf833f9-3d04-4be8-9782-1f0f197dc2e9	1
249	6f93c0af-5308-4879-bd98-47dedef3f19d.jpg	Variant	95	2017-09-08 08:30:39.143813	2017-09-15 03:58:39.189654	6f93c0af-5308-4879-bd98-47dedef3f19d	1
247	df13b614-c9c2-4edb-8604-c7087ff75fb4.jpg	Variant	95	2017-09-08 08:30:28.778603	2017-09-15 03:58:41.188962	df13b614-c9c2-4edb-8604-c7087ff75fb4	2
233	d33b5c30-b0fc-4e86-83f1-3df6844cc00e.jpg	Variant	91	2017-09-07 11:12:40.481476	2017-09-14 16:58:57.303817	d33b5c30-b0fc-4e86-83f1-3df6844cc00e	2
231	2747719b-0830-4fa5-a974-82e29cee5414.jpg	Variant	91	2017-09-07 11:12:27.836396	2017-09-14 16:59:03.892556	2747719b-0830-4fa5-a974-82e29cee5414	1
232	8ff9ea27-7e55-4d9f-bf35-e7dd798aac9e.jpg	Variant	91	2017-09-07 11:12:33.634666	2017-09-14 16:59:06.808314	8ff9ea27-7e55-4d9f-bf35-e7dd798aac9e	3
256	aa6aafc1-1819-489a-880e-08c689829022.jpg	Variant	97	2017-09-08 08:59:53.963656	2017-09-14 18:13:50.453987	aa6aafc1-1819-489a-880e-08c689829022	3
257	20cd0408-9017-4fec-82ef-906d49286c19.jpg	Variant	97	2017-09-08 08:59:58.484058	2017-09-14 18:13:53.369316	20cd0408-9017-4fec-82ef-906d49286c19	4
248	18c8ca02-09c5-427c-82a7-4cd62a1ea351.jpg	Variant	95	2017-09-08 08:30:33.870926	2017-09-15 03:58:45.723027	18c8ca02-09c5-427c-82a7-4cd62a1ea351	3
532	a89b590e-a74a-41ab-b441-4c5ae1da2731.jpg	Variant	153	2017-09-15 15:20:16.382016	2017-09-15 15:21:14.932301	a89b590e-a74a-41ab-b441-4c5ae1da2731	1
533	7defd71d-2e1e-4033-b45e-d31261494fc1.jpg	Variant	153	2017-09-15 15:21:00.169993	2017-09-15 15:21:17.06572	7defd71d-2e1e-4033-b45e-d31261494fc1	2
271	b741b829-a9be-4bce-a9bc-480a8ca7b199.jpg	Kit	24	2017-09-08 13:02:51.722704	2017-09-08 13:02:51.722704	b741b829-a9be-4bce-a9bc-480a8ca7b199	0
273	44fb82ff-4da9-468d-ac0f-29f90a5c6c89.jpg	Variant	98	2017-09-08 13:07:51.712713	2017-09-08 13:07:51.712713	44fb82ff-4da9-468d-ac0f-29f90a5c6c89	0
274	7d9d417c-cf71-4925-8b19-f65a10200191.jpg	Variant	104	2017-09-08 13:14:09.788064	2017-09-08 13:14:09.788064	7d9d417c-cf71-4925-8b19-f65a10200191	0
275	f6c3682e-ba6a-4c4a-ad3e-fac7f827c348.jpg	Variant	104	2017-09-08 13:14:14.14202	2017-09-08 13:14:14.14202	f6c3682e-ba6a-4c4a-ad3e-fac7f827c348	0
276	5ae5d66f-2cd0-406b-90d3-e882fd7511e4.jpg	Variant	104	2017-09-08 13:14:19.728019	2017-09-08 13:14:19.728019	5ae5d66f-2cd0-406b-90d3-e882fd7511e4	0
277	7935d4e1-5e7d-4455-880d-3fa525f16970.jpg	Variant	104	2017-09-08 13:14:22.696684	2017-09-08 13:14:22.696684	7935d4e1-5e7d-4455-880d-3fa525f16970	0
281	dacfdb93-f989-481e-86b0-cf78fd600e06.jpg	Variant	106	2017-09-08 13:33:06.651494	2017-09-08 13:33:06.651494	dacfdb93-f989-481e-86b0-cf78fd600e06	0
282	e7b68cd8-eec1-40cd-9095-1bc62a69647b.jpg	Variant	106	2017-09-08 13:33:09.528777	2017-09-08 13:33:09.528777	e7b68cd8-eec1-40cd-9095-1bc62a69647b	0
283	c778f6d3-67a5-4ae3-bab0-c6cc9f03edf1.jpg	Variant	106	2017-09-08 13:33:12.298996	2017-09-08 13:33:12.298996	c778f6d3-67a5-4ae3-bab0-c6cc9f03edf1	0
284	d2149712-ca59-4d62-ac23-3c39a2e46f79.jpg	Kit	25	2017-09-08 13:46:06.857183	2017-09-08 13:46:06.857183	d2149712-ca59-4d62-ac23-3c39a2e46f79	0
285	9c6946cb-8fce-4a5d-a495-a867de5c6343.jpg	Variant	107	2017-09-08 13:52:15.789826	2017-09-08 13:52:15.789826	9c6946cb-8fce-4a5d-a495-a867de5c6343	0
286	d1a4056d-f329-47e1-b859-272b095eafce.jpg	Variant	107	2017-09-08 13:52:19.14173	2017-09-08 13:52:19.14173	d1a4056d-f329-47e1-b859-272b095eafce	0
294	8de88491-1ff2-482b-bf65-1c4ac8d20897.jpg	Kit	26	2017-09-08 14:07:09.213932	2017-09-08 14:07:09.213932	8de88491-1ff2-482b-bf65-1c4ac8d20897	0
995	b15f4c96-6897-4455-bae6-905f8b0d365f.jpg	Variant	208	2017-10-04 10:10:43.571644	2017-10-04 10:13:26.086332	b15f4c96-6897-4455-bae6-905f8b0d365f	1
302	e39bddfa-d58f-4fad-a546-02346f662969.jpg	Variant	112	2017-09-08 14:42:31.405374	2017-09-08 14:42:31.405374	e39bddfa-d58f-4fad-a546-02346f662969	0
303	47c0ca83-be8b-4536-b959-017f91cc7871.jpg	Variant	112	2017-09-08 14:42:40.9833	2017-09-08 14:42:40.9833	47c0ca83-be8b-4536-b959-017f91cc7871	0
304	39ad2db1-6cfb-4713-8629-b3269686886d.jpg	Variant	112	2017-09-08 14:44:02.676008	2017-09-08 14:44:02.676008	39ad2db1-6cfb-4713-8629-b3269686886d	0
305	ff79dd2f-d4a5-4fbe-8022-00a0ede41dc0.jpg	Variant	113	2017-09-08 14:48:17.795343	2017-09-08 14:48:17.795343	ff79dd2f-d4a5-4fbe-8022-00a0ede41dc0	0
306	d940c866-500e-4e35-914f-b3d0a8c3b722.jpg	Variant	113	2017-09-08 14:48:22.531507	2017-09-08 14:48:22.531507	d940c866-500e-4e35-914f-b3d0a8c3b722	0
307	3622db28-4c9a-435c-8b08-e7fd9daef2e2.jpg	Variant	113	2017-09-08 14:48:28.067383	2017-09-08 14:48:28.067383	3622db28-4c9a-435c-8b08-e7fd9daef2e2	0
308	fb1e6bee-4b7e-434a-b748-d405a424c485.jpg	Variant	114	2017-09-08 15:04:25.436782	2017-09-08 15:04:25.436782	fb1e6bee-4b7e-434a-b748-d405a424c485	0
309	c881e034-f530-4c23-bc5e-174493cba6ec.jpg	Variant	114	2017-09-08 15:04:30.920673	2017-09-08 15:04:30.920673	c881e034-f530-4c23-bc5e-174493cba6ec	0
310	f7957b5b-cbdc-40e0-85eb-29e5d598568a.jpg	Variant	114	2017-09-08 15:04:36.69882	2017-09-08 15:04:36.69882	f7957b5b-cbdc-40e0-85eb-29e5d598568a	0
998	f5c9d735-cc98-4089-b4e1-593d29cc3dda.jpg	Variant	208	2017-10-04 10:10:50.075047	2017-10-04 10:13:39.748458	f5c9d735-cc98-4089-b4e1-593d29cc3dda	4
506	c2b65542-900a-4756-a98f-6daf960a9e9d.jpg	Kit	28	2017-09-15 09:23:19.241984	2017-09-15 09:23:19.241984	c2b65542-900a-4756-a98f-6daf960a9e9d	0
288	b8ac7f93-fb55-4090-ac38-c075e257c3e2.jpg	Variant	108	2017-09-08 13:56:15.976705	2017-09-15 11:14:12.938293	b8ac7f93-fb55-4090-ac38-c075e257c3e2	2
290	6ecd5426-8577-4aac-9b0f-1983f66ddc48.jpg	Variant	109	2017-09-08 14:04:25.012344	2017-09-14 13:14:03.870508	6ecd5426-8577-4aac-9b0f-1983f66ddc48	1
314	8a452dc6-8862-4262-af65-2abb30c8e098.jpg	Variant	115	2017-09-08 15:49:42.380587	2017-09-15 10:44:57.455288	8a452dc6-8862-4262-af65-2abb30c8e098	3
312	680f73d9-7d43-45a2-b59b-0fd80bd920d3.jpg	Variant	115	2017-09-08 15:49:27.671932	2017-09-14 13:12:43.649593	680f73d9-7d43-45a2-b59b-0fd80bd920d3	4
292	66d0a320-6b65-4127-b9ba-c822668cb9fd.jpg	Variant	109	2017-09-08 14:04:31.090048	2017-09-14 13:14:52.874738	66d0a320-6b65-4127-b9ba-c822668cb9fd	3
291	b4a46218-4c7c-4425-8d13-fbda503e24c2.jpg	Variant	109	2017-09-08 14:04:27.565719	2017-09-14 13:14:12.639882	b4a46218-4c7c-4425-8d13-fbda503e24c2	2
293	f88ebd5f-ee44-4b8c-9e55-27a40ccba780.jpg	Variant	109	2017-09-08 14:04:47.607139	2017-09-14 13:14:56.015642	f88ebd5f-ee44-4b8c-9e55-27a40ccba780	4
269	680fe05b-09cd-467e-901a-77346a8d0808.jpg	Variant	100	2017-09-08 11:11:55.355041	2017-09-14 13:21:47.555374	680fe05b-09cd-467e-901a-77346a8d0808	2
270	4b4c1833-4faa-4695-88b8-b748025bf486.jpg	Variant	100	2017-09-08 11:12:05.635269	2017-09-14 13:21:51.482383	4b4c1833-4faa-4695-88b8-b748025bf486	3
331	c28d9bfe-85c0-4711-aee5-a82a620c620d.jpg	Variant	120	2017-09-08 18:10:47.779941	2017-09-14 13:31:22.624371	c28d9bfe-85c0-4711-aee5-a82a620c620d	3
332	661ce510-dfc3-4b62-977c-4a63b7bbdde0.jpg	Variant	120	2017-09-08 18:11:13.064846	2017-09-14 13:31:20.656623	661ce510-dfc3-4b62-977c-4a63b7bbdde0	2
329	f10a6a4b-9616-482b-8297-e532ca0d61f0.jpg	Variant	120	2017-09-08 18:10:32.033167	2017-09-14 13:31:18.612903	f10a6a4b-9616-482b-8297-e532ca0d61f0	1
661	820f1633-e8eb-43bf-8549-3a0f359bf19a.jpg	Variant	188	2017-09-25 17:57:15.530683	2017-09-25 17:58:03.526539	820f1633-e8eb-43bf-8549-3a0f359bf19a	1
278	b2957fb2-71ae-474a-93a8-f3d1c10e054c.jpg	Variant	105	2017-09-08 13:21:45.019874	2017-09-14 16:54:11.627023	b2957fb2-71ae-474a-93a8-f3d1c10e054c	1
280	8e0b0859-ffcd-4a8f-ba22-f7fa6a478547.jpg	Variant	105	2017-09-08 13:21:57.607839	2017-09-14 16:54:13.974456	8e0b0859-ffcd-4a8f-ba22-f7fa6a478547	2
279	fa975a1f-7d47-4ba5-9d8f-51e8d31cc798.jpg	Variant	105	2017-09-08 13:21:54.874236	2017-09-14 16:54:28.410353	fa975a1f-7d47-4ba5-9d8f-51e8d31cc798	3
298	adb05481-5587-47f3-8c7c-48d71acb7a96.jpg	Variant	111	2017-09-08 14:36:33.346016	2017-09-14 17:16:00.044383	adb05481-5587-47f3-8c7c-48d71acb7a96	1
300	ba18e2f0-8e1f-4fc3-92dc-8f8737ea18b7.jpg	Variant	111	2017-09-08 14:36:41.703632	2017-09-14 17:16:02.511999	ba18e2f0-8e1f-4fc3-92dc-8f8737ea18b7	2
299	39df0041-3cca-4636-9bab-da70bcb6ee98.jpg	Variant	111	2017-09-08 14:36:38.019164	2017-09-14 17:16:05.053806	39df0041-3cca-4636-9bab-da70bcb6ee98	3
301	f06a3217-a808-4b60-9753-70e53eab136c.jpg	Variant	111	2017-09-08 14:36:46.89533	2017-09-14 17:16:10.020935	f06a3217-a808-4b60-9753-70e53eab136c	4
663	247cee05-c591-43e4-b5d8-5dc08c7ab1c9.jpg	Variant	188	2017-09-25 17:57:23.262774	2017-09-25 17:58:05.153417	247cee05-c591-43e4-b5d8-5dc08c7ab1c9	2
996	73359f52-dd80-40e7-adea-a7f1f2994ec0.jpg	Variant	208	2017-10-04 10:10:45.744483	2017-10-04 10:13:32.230819	73359f52-dd80-40e7-adea-a7f1f2994ec0	2
997	742ff0f8-8f8b-4c35-8614-7589418bca88.jpg	Variant	208	2017-10-04 10:10:47.807036	2017-10-04 10:13:33.775156	742ff0f8-8f8b-4c35-8614-7589418bca88	3
358	56cfcd48-230b-4583-9ed0-1dcdc1547602.jpg	Variant	132	2017-09-13 09:05:39.054722	2017-09-15 03:40:26.379936	56cfcd48-230b-4583-9ed0-1dcdc1547602	2
860	102da0d0-36bd-43b3-95bc-093e29e82870.JPG	Kit	53	2017-09-26 21:32:40.825564	2017-09-26 21:33:10.212877	102da0d0-36bd-43b3-95bc-093e29e82870	0
359	d28e70a4-2f81-440d-9cc5-24ed61bee38e.jpg	Variant	132	2017-09-13 09:05:43.74786	2017-09-15 03:40:41.807672	d28e70a4-2f81-440d-9cc5-24ed61bee38e	5
378	1109a3c5-0e20-4a7d-9079-345872ba232c.jpg	Variant	137	2017-09-13 11:10:51.901226	2017-10-15 10:23:44.792424	1109a3c5-0e20-4a7d-9079-345872ba232c	2
368	75b5f9c8-de10-44ba-8ee1-9033c6ac4e06.jpg	Variant	134	2017-09-13 10:13:09.715822	2017-09-15 03:48:38.222161	75b5f9c8-de10-44ba-8ee1-9033c6ac4e06	1
864	0f66bbbb-b508-43f7-b2e3-0604930641b7.jpg	Kit	54	2017-09-26 21:41:33.109893	2017-09-26 21:41:45.132806	0f66bbbb-b508-43f7-b2e3-0604930641b7	0
369	0c83e1a0-ee34-405a-948d-0f76a19cd2d0.jpg	Variant	134	2017-09-13 10:13:12.268421	2017-09-15 03:48:40.767687	0c83e1a0-ee34-405a-948d-0f76a19cd2d0	2
371	8b45e0ba-4dd5-487d-a39d-9eb290602437.jpg	Variant	134	2017-09-13 10:14:31.372727	2017-09-15 03:48:48.671095	8b45e0ba-4dd5-487d-a39d-9eb290602437	4
508	91e3f146-df9d-4055-83a2-7eb1b58d6629.jpg	Kit	30	2017-09-15 09:44:41.045016	2017-09-15 09:44:41.045016	91e3f146-df9d-4055-83a2-7eb1b58d6629	0
509	226fd357-2916-41ea-a69d-675a8d598f6f.jpg	Kit	31	2017-09-15 09:54:59.312573	2017-09-15 09:54:59.312573	226fd357-2916-41ea-a69d-675a8d598f6f	0
511	2a0feccf-181f-4e7d-949c-ec7e677dfec0.jpg	Kit	32	2017-09-15 10:14:53.442579	2017-09-15 10:14:53.442579	2a0feccf-181f-4e7d-949c-ec7e677dfec0	0
507	8ddddbd8-2d85-4394-a712-9b8afa2211f8.jpg	Kit	29	2017-09-15 09:32:08.007053	2017-09-15 11:12:37.323503	8ddddbd8-2d85-4394-a712-9b8afa2211f8	0
510	58f614e8-7e04-4ea0-9465-a7a2a9181d90.jpg	Variant	65	2017-09-15 09:57:50.163346	2017-09-15 11:17:34.492917	58f614e8-7e04-4ea0-9465-a7a2a9181d90	4
863	3c5bb92f-c71e-45b7-a984-29f13591e44b.jpg	Variant	110	2017-09-26 21:35:20.651369	2017-09-26 21:42:28.951945	3c5bb92f-c71e-45b7-a984-29f13591e44b	1
862	6c6bf951-50ad-497a-9f95-2235afcd624d.jpg	Variant	110	2017-09-26 21:35:15.850497	2017-09-26 21:42:32.246847	6c6bf951-50ad-497a-9f95-2235afcd624d	2
861	55711750-7247-423d-abef-f28adbe0de01.jpg	Variant	110	2017-09-26 21:35:11.142815	2017-09-26 21:42:37.010061	55711750-7247-423d-abef-f28adbe0de01	3
964	2d102b3e-5068-4d0f-9f0e-d73ee226ac49.jpg	Variant	164	2017-10-04 05:03:31.383631	2017-10-04 05:03:31.383631	2d102b3e-5068-4d0f-9f0e-d73ee226ac49	0
965	9546d4b3-a8ff-4216-a2e8-94830b717af4.jpg	Variant	164	2017-10-04 05:03:52.251616	2017-10-04 05:03:52.251616	9546d4b3-a8ff-4216-a2e8-94830b717af4	0
966	7f528fa8-2744-43d9-bade-a423ba2670db.jpg	Variant	164	2017-10-04 05:04:14.241252	2017-10-04 05:04:14.241252	7f528fa8-2744-43d9-bade-a423ba2670db	0
333	3012d3db-caf0-4183-b3c4-532fd54471b1.jpg	Variant	121	2017-09-08 18:20:40.98919	2017-09-14 13:34:55.866306	3012d3db-caf0-4183-b3c4-532fd54471b1	1
967	b5d58e37-1e8a-4665-b471-83addcda3e94.jpg	Variant	164	2017-10-04 05:04:43.553538	2017-10-04 05:04:43.553538	b5d58e37-1e8a-4665-b471-83addcda3e94	0
968	829522a9-532a-4308-a035-ac3e7430e43e.jpg	Variant	164	2017-10-04 05:05:22.221931	2017-10-04 05:05:22.221931	829522a9-532a-4308-a035-ac3e7430e43e	0
969	c0d8777a-4f89-4875-baa9-d82b042dfbe1.jpg	Variant	156	2017-10-04 05:15:01.693024	2017-10-04 05:15:01.693024	c0d8777a-4f89-4875-baa9-d82b042dfbe1	0
970	ca0f1106-6a72-4c17-8fe2-7cdbfbacc7f6.jpg	Variant	156	2017-10-04 05:15:22.647716	2017-10-04 05:15:22.647716	ca0f1106-6a72-4c17-8fe2-7cdbfbacc7f6	0
334	81723278-1359-4146-b77d-8cd00e185a37.jpg	Variant	121	2017-09-08 18:20:45.229675	2017-09-14 13:34:57.372899	81723278-1359-4146-b77d-8cd00e185a37	2
335	50b067cf-a8f3-4e4c-b61b-311a911ca37c.jpg	Variant	121	2017-09-08 18:20:50.723437	2017-09-14 13:35:03.161686	50b067cf-a8f3-4e4c-b61b-311a911ca37c	3
354	cfb804bb-6a93-4465-abff-1e5bc442ce37.jpg	Variant	126	2017-09-13 08:37:08.620449	2017-09-14 13:35:49.047053	cfb804bb-6a93-4465-abff-1e5bc442ce37	1
344	667d2c24-b7f0-4b3d-9510-569e35c4dbf9.jpg	Variant	126	2017-09-11 10:29:34.11559	2017-09-14 13:35:54.142293	667d2c24-b7f0-4b3d-9510-569e35c4dbf9	2
367	f4a3bdd1-5f3d-4fbb-b0bc-c7dcd83054cc.jpg	Variant	133	2017-09-13 09:15:39.29055	2017-09-14 19:34:57.593618	f4a3bdd1-5f3d-4fbb-b0bc-c7dcd83054cc	3
345	d2468778-cbb0-4127-8126-32dd05d087d1.jpg	Variant	126	2017-09-11 10:29:40.408399	2017-09-14 13:36:01.525975	d2468778-cbb0-4127-8126-32dd05d087d1	4
341	4824398d-42db-4792-af33-58828894fcea.jpg	Variant	125	2017-09-11 10:12:45.073007	2017-09-14 13:36:03.46171	4824398d-42db-4792-af33-58828894fcea	1
340	abe37322-d796-4282-b734-c627c50ebe5a.jpg	Variant	125	2017-09-11 10:12:40.080789	2017-09-14 13:36:05.790254	abe37322-d796-4282-b734-c627c50ebe5a	2
343	437268aa-c036-4557-b9cd-11a9da7f9e4f.jpg	Variant	125	2017-09-11 10:12:55.258192	2017-09-14 13:36:10.17757	437268aa-c036-4557-b9cd-11a9da7f9e4f	3
342	d4c4ca72-c6ba-42b7-aa74-7a93ac38ad56.jpg	Variant	125	2017-09-11 10:12:50.170334	2017-09-14 13:36:13.848295	d4c4ca72-c6ba-42b7-aa74-7a93ac38ad56	4
372	92274ef4-5bcb-457e-a134-8ac7eda6b554.jpg	Variant	135	2017-09-13 10:43:03.946651	2017-09-14 13:36:15.862905	92274ef4-5bcb-457e-a134-8ac7eda6b554	1
373	7e7c856b-16ec-4f6b-a0ca-885a7558914b.jpg	Variant	135	2017-09-13 10:43:18.296064	2017-09-14 13:36:17.600207	7e7c856b-16ec-4f6b-a0ca-885a7558914b	2
374	24c3b90f-fe30-4f9d-9fc1-a1f5fab7dec9.jpg	Variant	135	2017-09-13 10:43:40.754938	2017-09-14 13:36:24.852168	24c3b90f-fe30-4f9d-9fc1-a1f5fab7dec9	3
353	75836d1b-b94e-4d97-beb8-c14643db415d.jpg	Variant	128	2017-09-11 10:44:19.997377	2017-09-14 21:20:45.464807	75836d1b-b94e-4d97-beb8-c14643db415d	2
352	2cdb648e-51b6-4201-ab5e-70a4b36e6520.jpg	Variant	128	2017-09-11 10:44:13.000549	2017-09-14 21:20:47.301847	2cdb648e-51b6-4201-ab5e-70a4b36e6520	3
595	b6a0e8c9-29fe-41e1-9136-9b03d8098299.jpg	Variant	169	2017-09-19 15:16:21.22098	2017-09-19 15:28:31.686148	b6a0e8c9-29fe-41e1-9136-9b03d8098299	3
592	03ad110c-44e5-4267-b5ea-7401e753cbe0.jpg	Variant	169	2017-09-19 15:15:50.010307	2017-09-19 15:28:25.599225	03ad110c-44e5-4267-b5ea-7401e753cbe0	1
593	137faf80-1676-43e9-96b4-844c154bf334.jpg	Variant	169	2017-09-19 15:15:56.8734	2017-09-19 15:28:27.532852	137faf80-1676-43e9-96b4-844c154bf334	2
597	da16ff00-0f68-467d-81c0-af1d2787af38.jpg	Variant	170	2017-09-19 15:27:37.857582	2017-09-19 15:28:47.87335	da16ff00-0f68-467d-81c0-af1d2787af38	1
599	cc373aca-886d-4b63-89c7-3942bad1135e.jpg	Variant	170	2017-09-19 15:27:52.957835	2017-09-19 15:28:49.34872	cc373aca-886d-4b63-89c7-3942bad1135e	2
596	45c68741-de22-467a-a19f-3470a1f0d19a.jpg	Variant	170	2017-09-19 15:27:24.110552	2017-09-19 15:28:51.250056	45c68741-de22-467a-a19f-3470a1f0d19a	3
598	cd66e8e4-958e-4333-a212-baae6184f59a.jpg	Variant	170	2017-09-19 15:27:43.385024	2017-09-19 15:28:55.70412	cd66e8e4-958e-4333-a212-baae6184f59a	4
594	2405ccab-001f-4e2f-85f4-a0e9f1cbae40.jpg	Variant	169	2017-09-19 15:15:58.293041	2017-09-19 15:29:41.459339	2405ccab-001f-4e2f-85f4-a0e9f1cbae40	4
386	8581b94f-26f9-4218-97e8-3901234918b2.jpg	Variant	140	2017-09-13 13:22:33.801048	2017-09-13 13:22:33.801048	8581b94f-26f9-4218-97e8-3901234918b2	0
387	7faf2d8c-f280-44cf-8a37-36567747e5a3.jpg	Variant	140	2017-09-13 13:22:37.995172	2017-09-13 13:22:37.995172	7faf2d8c-f280-44cf-8a37-36567747e5a3	0
388	3e33660f-480d-4a67-a4e6-cc5ea825ac39.jpg	Variant	140	2017-09-13 13:22:42.721991	2017-09-13 13:22:42.721991	3e33660f-480d-4a67-a4e6-cc5ea825ac39	0
389	87bd0800-8d82-42f2-bb30-21a78b4eb791.jpg	Variant	140	2017-09-13 13:22:45.628286	2017-09-13 13:22:45.628286	87bd0800-8d82-42f2-bb30-21a78b4eb791	0
412	45cab3a2-add0-47a6-883b-10fec5566c62.jpg	Variant	147	2017-09-13 15:32:48.968562	2017-09-15 03:29:06.10366	45cab3a2-add0-47a6-883b-10fec5566c62	1
971	2e6ccedf-aa6b-4989-a867-b555d80654ac.jpg	Variant	156	2017-10-04 05:15:49.633732	2017-10-04 05:15:49.633732	2e6ccedf-aa6b-4989-a867-b555d80654ac	0
313	82b9bf47-01eb-4446-832d-585286be58de.jpg	Variant	115	2017-09-08 15:49:32.950471	2017-09-15 10:44:51.577881	82b9bf47-01eb-4446-832d-585286be58de	1
390	941cabd4-edfc-4b6a-abf8-d355b35f7d61.jpg	Variant	141	2017-09-13 13:29:03.292734	2017-09-15 11:45:04.40522	941cabd4-edfc-4b6a-abf8-d355b35f7d61	1
391	3df8e8fa-ce9c-4f48-a669-94ef5442ba8e.jpg	Variant	141	2017-09-13 13:29:08.653968	2017-09-15 11:45:07.14331	3df8e8fa-ce9c-4f48-a669-94ef5442ba8e	2
392	5fb7e093-0ff6-4390-98c0-7d3f3cc07951.jpg	Variant	141	2017-09-13 13:29:11.557463	2017-09-15 11:45:15.802872	5fb7e093-0ff6-4390-98c0-7d3f3cc07951	4
394	1d0882d9-d9cc-4bfd-a067-bfa90d6af534.jpg	Variant	142	2017-09-13 13:43:32.771902	2017-09-26 20:30:16.501545	1d0882d9-d9cc-4bfd-a067-bfa90d6af534	1
422	8503c283-67bf-40b1-bd58-c590c248d1d0.jpg	Variant	150	2017-09-14 08:59:55.514116	2017-09-26 20:31:43.672436	8503c283-67bf-40b1-bd58-c590c248d1d0	1
421	c7675cb8-9c89-4410-acd8-f84d9618972a.jpg	Variant	150	2017-09-14 08:59:51.380079	2017-09-26 20:31:48.089097	c7675cb8-9c89-4410-acd8-f84d9618972a	2
552	30f5394c-a0f6-4d23-bd8a-dd77f57fd40b.jpg	Variant	159	2017-09-19 14:12:27.362921	2017-09-19 19:47:16.80386	30f5394c-a0f6-4d23-bd8a-dd77f57fd40b	2
865	d7f78589-c346-4786-88db-b0afbff8ecda.jpg	Variant	205	2017-09-27 09:53:21.764189	2017-09-27 09:53:21.764189	d7f78589-c346-4786-88db-b0afbff8ecda	0
866	226b458c-3972-444d-8f16-4d3eda043eb9.jpg	Variant	205	2017-09-27 09:53:28.475551	2017-09-27 09:53:28.475551	226b458c-3972-444d-8f16-4d3eda043eb9	0
554	11b8279f-7275-416d-be1d-469536e227d6.jpg	Variant	159	2017-09-19 14:12:33.921412	2017-09-19 19:47:18.806729	11b8279f-7275-416d-be1d-469536e227d6	3
553	9990ddd9-0610-4f11-a6eb-635903930d3d.jpg	Variant	159	2017-09-19 14:12:32.795316	2017-09-19 19:47:21.018259	9990ddd9-0610-4f11-a6eb-635903930d3d	4
435	57654ef9-2586-4f00-89d2-7879637f0484.jpg	Variant	155	2017-09-14 10:42:58.450764	2017-09-14 10:42:58.450764	57654ef9-2586-4f00-89d2-7879637f0484	0
436	3c3e2215-8175-44ba-bac5-98a96269dc1a.jpg	Variant	155	2017-09-14 10:43:01.493237	2017-09-14 10:43:01.493237	3c3e2215-8175-44ba-bac5-98a96269dc1a	0
437	9009fb56-f06f-4825-b36f-2fea53c4f0d2.jpg	Variant	155	2017-09-14 10:43:03.758069	2017-09-14 10:43:03.758069	9009fb56-f06f-4825-b36f-2fea53c4f0d2	0
972	a2734ba4-5680-4578-b496-eec3cf281a48.jpg	Variant	156	2017-10-04 05:16:06.593043	2017-10-04 05:16:06.593043	a2734ba4-5680-4578-b496-eec3cf281a48	0
933	ffea9dc9-f214-4245-bbc4-3670d95e8344.jpg	Kit	69	2017-09-28 06:14:28.016309	2017-09-28 06:15:31.41277	ffea9dc9-f214-4245-bbc4-3670d95e8344	0
408	9cf97325-f8f2-459b-a6ab-fba35d74b091.jpg	Variant	146	2017-09-13 15:22:28.55399	2017-09-14 18:54:58.600824	9cf97325-f8f2-459b-a6ab-fba35d74b091	2
411	9cf7ae72-b2c9-44e0-ac17-027866afcedd.jpg	Variant	146	2017-09-13 15:22:41.554713	2017-09-14 18:55:15.530763	9cf7ae72-b2c9-44e0-ac17-027866afcedd	4
415	ec7f7186-8388-4e35-a93e-54b5ba049fa4.jpg	Variant	147	2017-09-13 15:33:05.467558	2017-09-14 17:17:41.051643	ec7f7186-8388-4e35-a93e-54b5ba049fa4	3
414	beb5ca63-c7ae-4b07-a0b2-a94d8f52f0ce.jpg	Variant	147	2017-09-13 15:33:02.21832	2017-09-14 17:17:46.71019	beb5ca63-c7ae-4b07-a0b2-a94d8f52f0ce	4
413	19516df0-0217-4624-8e9b-c7f4bf1d59b3.jpg	Variant	147	2017-09-13 15:32:57.060482	2017-09-14 17:17:54.03942	19516df0-0217-4624-8e9b-c7f4bf1d59b3	5
974	dcb1aeed-d616-4073-a2c8-8066b4f78371.jpg	Variant	162	2017-10-04 05:18:22.078862	2017-10-04 05:19:48.303766	dcb1aeed-d616-4073-a2c8-8066b4f78371	1
405	ceb700e2-859e-45a4-8ac9-179ba910f471.jpg	Variant	144	2017-09-13 14:59:38.366875	2017-09-14 20:23:00.755564	ceb700e2-859e-45a4-8ac9-179ba910f471	3
403	f4a00a50-dbb3-49d6-badc-779c58c51836.jpg	Variant	144	2017-09-13 14:59:32.442103	2017-09-14 20:23:07.712487	f4a00a50-dbb3-49d6-badc-779c58c51836	4
975	10d51610-5d84-4fa0-99f8-034e6275f96f.jpg	Variant	162	2017-10-04 05:18:34.389638	2017-10-04 05:19:51.013557	10d51610-5d84-4fa0-99f8-034e6275f96f	2
973	a86d4570-3e28-464d-8531-3213614bb911.jpg	Variant	162	2017-10-04 05:18:16.745615	2017-10-04 05:19:53.168109	a86d4570-3e28-464d-8531-3213614bb911	3
976	cd4131c9-3eb6-4392-96c9-2e12bdc53361.jpg	Variant	162	2017-10-04 05:18:53.597207	2017-10-04 05:19:55.687334	cd4131c9-3eb6-4392-96c9-2e12bdc53361	4
1002	95480240-7055-4e5b-9793-ed4d067e1caa.jpg	Variant	210	2017-10-04 10:31:37.002382	2017-10-04 10:41:11.430934	95480240-7055-4e5b-9793-ed4d067e1caa	1
1003	a4f75d11-f501-4ecc-9d2a-af6020c557be.jpg	Variant	210	2017-10-04 10:31:39.319431	2017-10-04 10:41:12.840646	a4f75d11-f501-4ecc-9d2a-af6020c557be	2
551	b2438a7a-8601-4f91-8342-a7de6cace522.jpg	Variant	159	2017-09-19 14:12:26.219244	2017-09-19 19:47:14.448225	b2438a7a-8601-4f91-8342-a7de6cace522	1
1004	b870a8da-950a-4e8e-a6c0-e6c751661586.jpg	Variant	210	2017-10-04 10:31:41.612356	2017-10-04 10:41:22.415417	b870a8da-950a-4e8e-a6c0-e6c751661586	3
932	0801a98a-78de-4997-823d-e7dc8e00e58e.jpg	Kit	68	2017-09-28 06:11:59.672049	2017-10-13 14:04:10.020486	0801a98a-78de-4997-823d-e7dc8e00e58e	1
410	15a076ac-b3b7-4ec9-a29a-3fdc1ee1e215.jpg	Variant	146	2017-09-13 15:22:35.700392	2017-10-14 09:07:13.474024	15a076ac-b3b7-4ec9-a29a-3fdc1ee1e215	1
601	10fff61d-a7ae-49ae-b1a1-c28d0be9c4b5.jpg	Variant	171	2017-09-20 16:08:21.752238	2017-09-20 16:13:06.108528	10fff61d-a7ae-49ae-b1a1-c28d0be9c4b5	3
600	610b97d9-1300-4d42-833d-fe2dd3ebb0ae.jpg	Variant	171	2017-09-20 16:08:20.593927	2017-09-20 16:12:36.546039	610b97d9-1300-4d42-833d-fe2dd3ebb0ae	1
602	3957a486-2a84-422c-ae3a-637b1cbb6c73.jpg	Variant	171	2017-09-20 16:08:22.936129	2017-09-20 16:13:08.894745	3957a486-2a84-422c-ae3a-637b1cbb6c73	2
515	48224f4a-f7a6-4d47-9547-f623faca2288.jpg	Variant	139	2017-09-15 11:26:42.764624	2017-09-15 16:23:33.455082	48224f4a-f7a6-4d47-9547-f623faca2288	4
500	45ef83bc-03ad-4f62-9405-cbf76165ad14.jpg	Variant	142	2017-09-14 22:37:24.13788	2017-09-14 22:37:50.06327	45ef83bc-03ad-4f62-9405-cbf76165ad14	3
464	f5eb1dcf-fb13-4eb7-8832-90d7d71002d6.jpg	Variant	147	2017-09-14 17:11:04.517673	2017-09-15 03:29:13.626069	f5eb1dcf-fb13-4eb7-8832-90d7d71002d6	2
268	2b192221-ff10-4657-93ef-437bec94820f.jpg	Variant	100	2017-09-08 11:11:43.216348	2017-09-14 13:21:47.519415	2b192221-ff10-4657-93ef-437bec94820f	1
487	713ad861-fea3-4052-906e-4658ed1c00fb.jpg	Variant	132	2017-09-14 19:54:42.692109	2017-09-15 03:40:07.736584	713ad861-fea3-4052-906e-4658ed1c00fb	1
489	03bfbd25-cfa1-4ad5-8d42-fe442642e1b9.jpg	Variant	132	2017-09-14 21:16:03.157737	2017-09-15 03:40:34.255708	03bfbd25-cfa1-4ad5-8d42-fe442642e1b9	3
441	6dd06dcb-2832-4d84-a0fe-07df129fb98b.jpg	Variant	126	2017-09-14 14:33:48.559352	2017-09-14 14:35:08.800247	6dd06dcb-2832-4d84-a0fe-07df129fb98b	3
490	951c64fb-c007-4bd0-9336-c44c3db9e44e.jpg	Variant	132	2017-09-14 21:16:56.285379	2017-09-15 03:40:36.423317	951c64fb-c007-4bd0-9336-c44c3db9e44e	4
488	02959825-0a29-44ac-a5af-60743f670ba9.jpg	Variant	134	2017-09-14 20:21:31.818999	2017-09-15 03:48:42.984919	02959825-0a29-44ac-a5af-60743f670ba9	3
209	d3fc00bf-92fe-48eb-9424-8e93e07c1fd1.jpg	Variant	83	2017-09-06 12:52:55.720626	2017-09-15 10:08:14.770548	d3fc00bf-92fe-48eb-9424-8e93e07c1fd1	2
311	7ba5aea6-2673-4c40-89ac-780c267080d1.jpg	Variant	115	2017-09-08 15:49:19.615732	2017-09-15 10:45:08.929279	7ba5aea6-2673-4c40-89ac-780c267080d1	2
513	13d9c343-e606-4f52-9324-e730d1d8b05c.jpg	Variant	108	2017-09-15 11:14:01.337946	2017-09-15 11:14:10.977364	13d9c343-e606-4f52-9324-e730d1d8b05c	1
868	4721ccc5-a747-40b3-a676-e6205d074035.JPG	Kit	56	2017-09-27 15:43:26.957593	2017-09-27 15:45:25.915495	4721ccc5-a747-40b3-a676-e6205d074035	0
462	35d73f90-bc47-455b-b19a-aea8111ffca2.jpg	Variant	149	2017-09-14 17:06:42.521465	2017-09-14 17:07:00.280035	35d73f90-bc47-455b-b19a-aea8111ffca2	2
514	c943531b-4e73-4406-97e1-087ea80716c5.jpg	Kit	34	2017-09-15 11:23:15.341411	2017-09-15 11:23:15.341411	c943531b-4e73-4406-97e1-087ea80716c5	0
491	d6038da6-0c34-4fab-a1de-932b03614da4.jpg	Variant	120	2017-09-14 21:19:44.527289	2017-09-14 21:19:54.259132	d6038da6-0c34-4fab-a1de-932b03614da4	4
493	25a41b89-3ac0-4b50-b6b2-82c86cc4a13c.jpg	Variant	141	2017-09-14 22:06:01.108963	2017-09-15 11:45:08.669153	25a41b89-3ac0-4b50-b6b2-82c86cc4a13c	3
496	408ada5b-9b6c-45a5-a801-f36ba90bbadf.jpg	Variant	139	2017-09-14 22:07:27.572519	2017-09-15 16:23:26.652841	408ada5b-9b6c-45a5-a801-f36ba90bbadf	2
1012	78a98a75-b10b-4844-ab11-831442c7192b.jpg	Variant	209	2017-10-04 10:38:17.990988	2017-10-04 10:41:00.214986	78a98a75-b10b-4844-ab11-831442c7192b	1
1013	4b1c0cf3-145a-48a1-bc4d-c134c6b83254.jpg	Variant	209	2017-10-04 10:38:20.115824	2017-10-04 10:41:02.059032	4b1c0cf3-145a-48a1-bc4d-c134c6b83254	2
495	14a51536-2f93-4188-9d5d-5bb8f2454cbf.jpg	Variant	139	2017-09-14 22:07:21.051995	2017-09-15 16:23:28.678202	14a51536-2f93-4188-9d5d-5bb8f2454cbf	3
1011	b67d80d9-1c6a-483a-936e-2e8729bd9af7.jpg	Variant	209	2017-10-04 10:38:15.527085	2017-10-04 10:41:08.591916	b67d80d9-1c6a-483a-936e-2e8729bd9af7	3
1008	8dc8b9b0-5e4f-4e37-9a8f-e95be717f663.jpg	Variant	211	2017-10-04 10:35:05.369066	2017-10-04 10:41:24.124855	8dc8b9b0-5e4f-4e37-9a8f-e95be717f663	1
870	52822d79-139a-4a29-805f-0b811e106dbf.jpg	Kit	57	2017-09-27 15:46:40.352084	2017-09-27 15:47:37.364635	52822d79-139a-4a29-805f-0b811e106dbf	0
1009	9f392a30-6399-4331-aee5-2f1e85b4f205.jpg	Variant	211	2017-10-04 10:35:17.96777	2017-10-04 10:41:25.970236	9f392a30-6399-4331-aee5-2f1e85b4f205	2
1010	2f60c747-d5f6-4ff4-a0d1-09a05570f001.jpg	Variant	211	2017-10-04 10:35:25.504833	2017-10-04 10:41:33.945905	2f60c747-d5f6-4ff4-a0d1-09a05570f001	3
463	46ba4768-7925-4747-8680-4f44e2248b0c.jpg	Variant	149	2017-09-14 17:06:45.039168	2017-09-14 17:07:03.82452	46ba4768-7925-4747-8680-4f44e2248b0c	1
873	56937579-fee8-4812-b40a-e971075e2401.jpg	Kit	0	2017-09-27 15:51:57.171779	2017-09-27 15:51:57.171779	56937579-fee8-4812-b40a-e971075e2401	0
465	05d491af-9aa7-4aea-8a06-e6e31899dee2.jpg	Variant	148	2017-09-14 17:27:04.409513	2017-09-14 17:27:04.409513	05d491af-9aa7-4aea-8a06-e6e31899dee2	0
466	1c15dc47-ce99-4e20-9899-76d16c437550.jpg	Variant	148	2017-09-14 17:27:06.969792	2017-09-14 17:27:06.969792	1c15dc47-ce99-4e20-9899-76d16c437550	0
467	e88cb2b7-1b16-47a7-8b26-5c4cedc13368.jpg	Variant	148	2017-09-14 17:27:14.122328	2017-09-14 17:27:14.122328	e88cb2b7-1b16-47a7-8b26-5c4cedc13368	0
1015	0ff6f032-7b38-4d69-a579-510a1515a24b.jpg	Variant	212	2017-10-04 11:06:06.133289	2017-10-04 11:09:17.081824	0ff6f032-7b38-4d69-a579-510a1515a24b	2
1016	470bb073-a4a4-465a-980c-e5b476bc3bce.jpg	Variant	213	2017-10-04 11:07:21.529295	2017-10-04 11:09:25.710158	470bb073-a4a4-465a-980c-e5b476bc3bce	1
473	3fab6307-bd36-432f-913a-8db79354e909.jpg	Variant	146	2017-09-14 17:59:01.286158	2017-09-14 18:54:55.613466	3fab6307-bd36-432f-913a-8db79354e909	1
469	6543031d-d002-4bd9-b564-f04064ed2f08.jpg	Variant	146	2017-09-14 17:49:41.001334	2017-09-14 18:55:01.137305	6543031d-d002-4bd9-b564-f04064ed2f08	3
482	76bf3626-c853-4da8-a9a8-947ef1213e2f.jpg	Variant	137	2017-09-14 19:18:12.572188	2017-10-15 10:23:48.22285	76bf3626-c853-4da8-a9a8-947ef1213e2f	3
876	d8766858-399a-42f1-84f9-31a3f7471eaf.jpg	Kit	59	2017-09-27 15:58:40.789613	2017-09-27 16:00:50.176153	d8766858-399a-42f1-84f9-31a3f7471eaf	0
878	59336131-0970-4cd6-9c88-74dbaf895732.jpg	Kit	0	2017-09-27 16:02:05.059309	2017-09-27 16:02:05.059309	59336131-0970-4cd6-9c88-74dbaf895732	0
484	2a8ca80c-061f-4dbf-ad32-65bd35fafdfe.jpg	Variant	133	2017-09-14 19:34:26.139812	2017-09-14 19:34:37.643043	2a8ca80c-061f-4dbf-ad32-65bd35fafdfe	1
486	175f4993-4a18-4afb-9ee6-35e5b2bb0951.jpg	Variant	133	2017-09-14 19:39:43.737748	2017-09-14 19:39:54.485974	175f4993-4a18-4afb-9ee6-35e5b2bb0951	2
483	48ded59e-7152-4410-8f85-17bbc126e948.jpg	Variant	151	2017-09-14 19:25:49.628109	2017-09-14 20:20:18.532314	48ded59e-7152-4410-8f85-17bbc126e948	1
475	eabdad90-8307-4f3d-bb7e-8443977c5d9d.jpg	Variant	151	2017-09-14 18:34:08.90001	2017-09-14 20:20:28.338344	eabdad90-8307-4f3d-bb7e-8443977c5d9d	2
476	08a9a105-9a65-44e7-b73f-33b8d28b6875.jpg	Variant	144	2017-09-14 18:57:20.860011	2017-09-14 20:22:54.772356	08a9a105-9a65-44e7-b73f-33b8d28b6875	1
477	6abac9e7-ea90-4475-85a4-e648612be8d1.jpg	Variant	144	2017-09-14 18:57:43.167171	2017-09-14 20:22:58.127543	6abac9e7-ea90-4475-85a4-e648612be8d1	2
492	a0b85a9b-7fcc-4f01-98a5-65309f92fd3d.jpg	Variant	128	2017-09-14 21:20:41.470754	2017-09-14 21:21:03.849835	a0b85a9b-7fcc-4f01-98a5-65309f92fd3d	1
494	2d16fc3c-f4ad-487a-99b2-3411a465bd42.jpg	Variant	139	2017-09-14 22:07:18.453421	2017-09-14 22:07:18.453421	2d16fc3c-f4ad-487a-99b2-3411a465bd42	0
450	f85f871b-eb88-4ae6-8ee3-da77692002ca.JPG	Variant	152	2017-09-14 15:40:10.982948	2017-09-27 19:58:41.872158	f85f871b-eb88-4ae6-8ee3-da77692002ca	1
984	1ff720d3-56ca-4601-a5e8-fbce76eaa28d.jpg	Variant	163	2017-10-04 05:23:02.750608	2017-10-04 05:25:06.46364	1ff720d3-56ca-4601-a5e8-fbce76eaa28d	4
1014	d1502abe-1d0f-44d5-afa7-c2d00cfea5f7.jpg	Variant	212	2017-10-04 11:06:02.520079	2017-10-04 11:09:15.399405	d1502abe-1d0f-44d5-afa7-c2d00cfea5f7	1
1017	11bfcdae-eff9-49b0-b8f1-baf5f741b389.jpg	Variant	213	2017-10-04 11:07:29.18727	2017-10-04 11:09:33.933255	11bfcdae-eff9-49b0-b8f1-baf5f741b389	2
664	607e508e-5b51-42cd-8edd-2df5517826ae.jpg	Variant	188	2017-09-25 17:57:27.572459	2017-09-25 17:58:09.159807	607e508e-5b51-42cd-8edd-2df5517826ae	3
665	0f5854b5-a901-4b90-9256-9ad1b233823c.jpg	Variant	188	2017-09-25 17:57:32.314439	2017-09-25 17:58:13.10539	0f5854b5-a901-4b90-9256-9ad1b233823c	4
1019	abeb36e6-9baa-443d-8c79-3262b31e4325.jpg	Variant	214	2017-10-04 11:07:58.735677	2017-10-04 11:16:07.760268	abeb36e6-9baa-443d-8c79-3262b31e4325	1
1018	191a4888-d095-4b9a-a59c-683bea1feedc.jpg	Variant	214	2017-10-04 11:07:56.491309	2017-10-04 11:16:09.582861	191a4888-d095-4b9a-a59c-683bea1feedc	2
943	50fa41ea-5c0e-4bf5-9be0-722ae7fcb368.JPG	Kit	0	2017-09-28 09:51:35.220307	2017-09-28 09:51:35.220307	50fa41ea-5c0e-4bf5-9be0-722ae7fcb368	0
1020	a52bf7bd-2990-46e1-b7d1-4b6cb9496cfb.jpg	Variant	212	2017-10-04 11:10:19.494098	2017-10-04 11:16:35.627119	a52bf7bd-2990-46e1-b7d1-4b6cb9496cfb	3
1021	3ca6eed2-b802-44a1-a57e-e018585b2de1.jpg	Variant	213	2017-10-04 11:10:32.688585	2017-10-04 11:16:43.740475	3ca6eed2-b802-44a1-a57e-e018585b2de1	3
939	7875ed00-e98e-45aa-aa0e-4968ba4cd704.jpg	Kit	0	2017-09-28 09:44:15.920708	2017-09-28 09:44:15.920708	7875ed00-e98e-45aa-aa0e-4968ba4cd704	0
938	72cfd9b5-e5c5-43ed-9684-7770870a1a6b.jpg	Kit	71	2017-09-28 09:43:35.816578	2017-09-28 09:44:16.030906	72cfd9b5-e5c5-43ed-9684-7770870a1a6b	0
1022	4d34e745-5ec5-4d52-a14f-792086617f73.jpg	Variant	214	2017-10-04 11:16:05.877398	2017-10-04 11:16:45.964762	4d34e745-5ec5-4d52-a14f-792086617f73	3
1053	b37fd725-a49d-4bd9-9528-d09b96fad683.jpg	Variant	220	2017-10-04 13:27:31.559339	2017-10-04 13:27:31.559339	b37fd725-a49d-4bd9-9528-d09b96fad683	0
1054	f174c5a7-1703-4e2b-bf80-0a444c3b7420.jpg	Variant	220	2017-10-04 13:27:34.047441	2017-10-04 13:27:34.047441	f174c5a7-1703-4e2b-bf80-0a444c3b7420	0
1055	4d47b7b7-5d9a-47ee-a826-d73897a5108d.jpg	Variant	220	2017-10-04 13:27:36.605147	2017-10-04 13:27:36.605147	4d47b7b7-5d9a-47ee-a826-d73897a5108d	0
1056	ccbd2308-1dd0-4a9d-b794-d37e143c8534.jpg	Variant	220	2017-10-04 13:27:39.285183	2017-10-04 13:27:39.285183	ccbd2308-1dd0-4a9d-b794-d37e143c8534	0
1050	8002f0b4-981a-4a48-9d02-58d2f59b1048.jpg	Variant	219	2017-10-04 13:26:37.792558	2017-10-04 13:28:37.761367	8002f0b4-981a-4a48-9d02-58d2f59b1048	1
1049	c1295d65-c068-412e-8c8e-cac53717153b.jpg	Variant	219	2017-10-04 13:26:35.241995	2017-10-04 13:28:39.967534	c1295d65-c068-412e-8c8e-cac53717153b	2
1051	1f91e8c2-560d-4654-a936-891430b955fc.jpg	Variant	219	2017-10-04 13:26:44.292812	2017-10-04 13:28:41.978961	1f91e8c2-560d-4654-a936-891430b955fc	3
937	c44503dc-7b1d-453a-9b35-dbf6b7bb7eda.jpg	Kit	70	2017-09-28 09:36:51.660445	2017-10-12 17:52:21.265131	c44503dc-7b1d-453a-9b35-dbf6b7bb7eda	1
981	e7e52d2a-a932-4c2d-9ecf-0731566eac6e.jpg	Variant	163	2017-10-04 05:22:01.990813	2017-10-04 05:24:21.378484	e7e52d2a-a932-4c2d-9ecf-0731566eac6e	1
1052	ef15b6ff-b6b1-4b33-8610-d16001b7400f.jpg	Variant	219	2017-10-04 13:26:47.514393	2017-10-04 13:28:45.725825	ef15b6ff-b6b1-4b33-8610-d16001b7400f	4
982	bf7f3db4-4236-4e98-b948-1dd18a762c35.jpg	Variant	163	2017-10-04 05:22:21.563295	2017-10-04 05:24:27.701421	bf7f3db4-4236-4e98-b948-1dd18a762c35	2
983	ad32054b-110e-4aff-8871-45687c7746ad.jpg	Variant	163	2017-10-04 05:22:41.467062	2017-10-04 05:24:29.833022	ad32054b-110e-4aff-8871-45687c7746ad	3
1058	2129885f-e0a0-4253-91da-8ae5d549a556.jpg	Variant	221	2017-10-04 13:42:32.91602	2017-10-04 13:43:14.443352	2129885f-e0a0-4253-91da-8ae5d549a556	1
1057	5f3366fe-ab96-41a8-bff1-0e6d3efaec52.jpg	Variant	221	2017-10-04 13:42:30.341065	2017-10-04 13:43:16.436535	5f3366fe-ab96-41a8-bff1-0e6d3efaec52	2
1059	915a4c8c-a58b-4fae-ac5e-10c816097e94.jpg	Variant	221	2017-10-04 13:42:36.063681	2017-10-04 13:43:17.977436	915a4c8c-a58b-4fae-ac5e-10c816097e94	3
1060	c673786d-7dba-4542-b921-f046bfbf13a9.jpg	Variant	221	2017-10-04 13:42:38.791573	2017-10-04 13:43:23.638565	c673786d-7dba-4542-b921-f046bfbf13a9	4
1061	03c13ed0-b2a4-4933-859a-936a0066ed57.jpg	Variant	222	2017-10-04 13:43:49.494765	2017-10-04 13:43:49.494765	03c13ed0-b2a4-4933-859a-936a0066ed57	0
1062	05b68d4c-7e37-4577-9183-4887ea47caf7.jpg	Variant	222	2017-10-04 13:43:57.557263	2017-10-04 13:43:57.557263	05b68d4c-7e37-4577-9183-4887ea47caf7	0
1063	4afe2ea5-a410-463a-b67a-3fb79af0411c.jpg	Variant	222	2017-10-04 13:44:00.264308	2017-10-04 13:44:00.264308	4afe2ea5-a410-463a-b67a-3fb79af0411c	0
696	aa2bb029-a3d9-4de7-bd48-5144d3394345.jpg	Variant	168	2017-09-26 06:30:27.032037	2017-09-26 06:30:44.660795	aa2bb029-a3d9-4de7-bd48-5144d3394345	2
699	36f303eb-03a5-409d-ac3c-c9f543064925.jpg	Variant	165	2017-09-26 06:32:31.773699	2017-09-26 06:32:56.88886	36f303eb-03a5-409d-ac3c-c9f543064925	1
701	d36092a0-8511-472b-9045-03217731aa1a.jpg	Variant	165	2017-09-26 06:32:39.510369	2017-09-26 06:33:01.662856	d36092a0-8511-472b-9045-03217731aa1a	3
883	578165d4-a1bb-4114-abb8-a54e7b1940fa.jpg	Kit	0	2017-09-27 16:05:53.443673	2017-09-27 16:05:53.443673	578165d4-a1bb-4114-abb8-a54e7b1940fa	0
884	0784b956-f5de-4b12-b636-251378670818.jpg	Kit	62	2017-09-27 16:07:40.921425	2017-09-27 16:07:40.921425	0784b956-f5de-4b12-b636-251378670818	0
949	d2738104-3862-4cc9-b328-e279f75b000a.jpg	Kit	69	2017-09-29 19:12:25.486314	2017-09-29 19:12:25.486314	d2738104-3862-4cc9-b328-e279f75b000a	0
950	cb176f3a-2175-4ba0-8587-7ad3408bb385.JPG	Kit	72	2017-09-29 19:13:39.111411	2017-09-29 19:13:39.111411	cb176f3a-2175-4ba0-8587-7ad3408bb385	0
951	d98f4614-948e-458a-bea6-85e2c1d94562.jpg	Kit	72	2017-09-29 19:14:33.321087	2017-09-29 19:14:33.321087	d98f4614-948e-458a-bea6-85e2c1d94562	0
1024	8197f0be-fb1f-417a-9e4f-d28269e27f9d.jpg	Variant	215	2017-10-04 11:27:52.443797	2017-10-04 11:28:06.798623	8197f0be-fb1f-417a-9e4f-d28269e27f9d	1
1025	36d70e15-5f3c-47b4-bf7c-15b1a0f8b870.jpg	Variant	215	2017-10-04 11:27:54.637173	2017-10-04 11:28:08.542519	36d70e15-5f3c-47b4-bf7c-15b1a0f8b870	2
1026	ec2f73e7-a1e2-4ee2-9650-ac1115427042.jpg	Variant	215	2017-10-04 11:27:56.754865	2017-10-04 11:28:09.923651	ec2f73e7-a1e2-4ee2-9650-ac1115427042	3
1027	b11afebf-a036-4a7e-85ea-2fcb10832f57.jpg	Variant	215	2017-10-04 11:27:59.2838	2017-10-04 11:28:17.087277	b11afebf-a036-4a7e-85ea-2fcb10832f57	4
1033	d8a431af-6553-4792-8804-9d230175fc16.jpg	Variant	207	2017-10-04 11:54:16.614759	2017-10-04 11:55:47.790287	d8a431af-6553-4792-8804-9d230175fc16	1
1034	eae6606b-0a67-4602-97c1-faef35ad5e6d.jpg	Variant	207	2017-10-04 11:54:18.695669	2017-10-04 11:55:49.241774	eae6606b-0a67-4602-97c1-faef35ad5e6d	2
1035	61092ea5-210e-468d-a2c2-41649ca744b6.jpg	Variant	207	2017-10-04 11:54:20.792873	2017-10-04 11:55:51.551467	61092ea5-210e-468d-a2c2-41649ca744b6	3
1039	fdc944c2-fe54-4344-b3f0-c16d1ec91cc1.jpg	Variant	207	2017-10-04 11:54:48.598414	2017-10-04 11:55:56.871876	fdc944c2-fe54-4344-b3f0-c16d1ec91cc1	4
1064	17fd1ceb-613f-4e16-96ab-d09bbfc22e69.jpg	Variant	222	2017-10-04 13:44:03.069027	2017-10-04 13:44:03.069027	17fd1ceb-613f-4e16-96ab-d09bbfc22e69	0
1066	183e53d0-7345-430d-96c5-4ae5dc2ef2ba.jpg	Variant	223	2017-10-04 13:45:06.05993	2017-10-04 13:46:41.119459	183e53d0-7345-430d-96c5-4ae5dc2ef2ba	1
1065	434b7d0e-0a49-460d-b4e6-b77dfd7b28e0.jpg	Variant	223	2017-10-04 13:45:03.388849	2017-10-04 13:46:42.575763	434b7d0e-0a49-460d-b4e6-b77dfd7b28e0	2
1067	923f394b-3729-4cf9-94b1-e03d5bd9b68a.jpg	Variant	223	2017-10-04 13:45:08.768899	2017-10-04 13:46:45.537887	923f394b-3729-4cf9-94b1-e03d5bd9b68a	3
1068	2ebddf91-a7ec-4b2f-98ac-40149ca4ed68.jpg	Variant	223	2017-10-04 13:45:11.415819	2017-10-04 13:46:48.612523	2ebddf91-a7ec-4b2f-98ac-40149ca4ed68	4
1070	ada98910-55ff-4678-8ecf-a01cd4725b2d.jpg	Variant	224	2017-10-04 13:51:28.446009	2017-10-04 13:52:20.544327	ada98910-55ff-4678-8ecf-a01cd4725b2d	1
742	e2f5af49-b9cc-4c33-a591-2290f4bd0bfa.jpg	Kit	40	2017-09-26 08:58:33.965927	2017-09-26 08:58:33.965927	e2f5af49-b9cc-4c33-a591-2290f4bd0bfa	0
744	e05aacb1-28fc-4dc1-8a2b-4735d23e2935.jpg	Variant	161	2017-09-26 09:02:14.440937	2017-09-26 09:06:51.289473	e05aacb1-28fc-4dc1-8a2b-4735d23e2935	1
743	11dfb2c8-db85-42e7-a80c-d140825174d7.jpg	Variant	161	2017-09-26 09:02:10.477562	2017-09-26 09:06:53.021549	11dfb2c8-db85-42e7-a80c-d140825174d7	2
745	9772ff8b-a0ba-4462-8914-8c7a46c85bb1.jpg	Variant	161	2017-09-26 09:02:19.146794	2017-09-26 09:06:56.920545	9772ff8b-a0ba-4462-8914-8c7a46c85bb1	3
1069	1179412b-cebc-4ab9-8ae2-6fea65366066.jpg	Variant	224	2017-10-04 13:51:25.757438	2017-10-04 13:52:22.921244	1179412b-cebc-4ab9-8ae2-6fea65366066	2
1071	a96a7a44-3717-4202-83fa-8b15391eeaac.jpg	Variant	224	2017-10-04 13:51:31.099093	2017-10-04 13:52:25.28957	a96a7a44-3717-4202-83fa-8b15391eeaac	3
1072	bdba7dc3-5b28-49c0-9ba6-b41ab4f467a2.jpg	Variant	224	2017-10-04 13:51:43.732141	2017-10-04 13:52:28.452272	bdba7dc3-5b28-49c0-9ba6-b41ab4f467a2	4
1073	c614a0cf-931f-46b1-833d-ae201326c8b5.jpg	Variant	224	2017-10-04 13:51:48.857952	2017-10-04 13:52:32.029857	c614a0cf-931f-46b1-833d-ae201326c8b5	5
1075	724b01d4-7b60-4104-805a-e66382e87cfe.jpg	Variant	225	2017-10-04 14:02:26.911576	2017-10-04 14:05:00.672696	724b01d4-7b60-4104-805a-e66382e87cfe	1
1074	00be992c-ab40-4b82-9e25-12fd271dc75c.jpg	Variant	225	2017-10-04 14:02:24.283021	2017-10-04 14:05:02.327487	00be992c-ab40-4b82-9e25-12fd271dc75c	2
1076	c503b5d7-7d9d-4931-8706-2d6f33f9b03d.jpg	Variant	225	2017-10-04 14:04:00.799554	2017-10-04 14:05:06.698871	c503b5d7-7d9d-4931-8706-2d6f33f9b03d	3
1077	9dfdbd99-e947-4fd4-a308-ad7ccb424cea.jpg	Variant	225	2017-10-04 14:04:38.146717	2017-10-04 14:05:09.802109	9dfdbd99-e947-4fd4-a308-ad7ccb424cea	4
754	2e19aa36-1115-4822-a633-2ef71bff7d76.jpg	Kit	46	2017-09-26 17:29:05.183641	2017-09-26 17:29:54.707609	2e19aa36-1115-4822-a633-2ef71bff7d76	0
756	a443eaaf-4e4f-4564-a8b4-1a9570c6f4f0.jpg	Kit	48	2017-09-26 17:32:15.025235	2017-09-26 17:33:25.847413	a443eaaf-4e4f-4564-a8b4-1a9570c6f4f0	0
758	21002a5f-5161-41ea-ae37-aa745153050b.jpg	Kit	50	2017-09-26 17:36:32.375265	2017-09-26 17:36:55.074649	21002a5f-5161-41ea-ae37-aa745153050b	0
1040	9d90f6db-826a-4ed5-b464-f6e7f5389027.jpg	Variant	217	2017-10-04 13:09:30.773693	2017-10-04 13:19:16.367225	9d90f6db-826a-4ed5-b464-f6e7f5389027	1
1041	82a156d8-a329-45fe-9035-1a7785eb43f2.jpg	Variant	217	2017-10-04 13:09:43.568566	2017-10-04 13:19:18.02953	82a156d8-a329-45fe-9035-1a7785eb43f2	2
1042	6ce4ebed-83da-49d8-9874-ac80d1406f65.jpg	Variant	217	2017-10-04 13:09:53.933946	2017-10-04 13:19:22.509276	6ce4ebed-83da-49d8-9874-ac80d1406f65	3
1043	45db848f-41f0-4189-b42f-24c723b14220.jpg	Variant	217	2017-10-04 13:09:58.688908	2017-10-04 13:19:30.883736	45db848f-41f0-4189-b42f-24c723b14220	4
800	9f76ef95-acd2-43ee-971e-4251e3909add.JPG	Variant	186	2017-09-26 19:32:41.098141	2017-10-06 11:26:39.630892	9f76ef95-acd2-43ee-971e-4251e3909add	3
788	aaef8d0e-bda2-4b19-b927-ae0b4c7f948c.JPG	Variant	196	2017-09-26 19:20:35.271106	2017-09-26 19:20:35.271106	aaef8d0e-bda2-4b19-b927-ae0b4c7f948c	0
789	04fc741d-74fc-4bac-864b-e3d36f0d3083.JPG	Variant	196	2017-09-26 19:20:40.171578	2017-09-26 19:20:40.171578	04fc741d-74fc-4bac-864b-e3d36f0d3083	0
790	c351a88c-b89c-4f3d-b07c-0772e8e9b564.JPG	Variant	196	2017-09-26 19:21:05.830603	2017-09-26 19:21:05.830603	c351a88c-b89c-4f3d-b07c-0772e8e9b564	0
791	a03d3b50-5d4a-4ceb-a016-47862b9512f3.JPG	Variant	196	2017-09-26 19:21:11.137229	2017-09-26 19:21:11.137229	a03d3b50-5d4a-4ceb-a016-47862b9512f3	0
804	38ba0be3-c969-4e18-96bd-b7e4be2a9a50.jpg	Variant	201	2017-09-26 19:34:38.249638	2017-09-26 19:34:38.249638	38ba0be3-c969-4e18-96bd-b7e4be2a9a50	0
805	3e666060-6aa9-458d-befd-503950e7469b.jpg	Variant	201	2017-09-26 19:34:43.103331	2017-09-26 19:34:43.103331	3e666060-6aa9-458d-befd-503950e7469b	0
806	a81b7e39-c614-4f35-aee2-f5c6ffe33fce.jpg	Variant	201	2017-09-26 19:34:47.92806	2017-09-26 19:34:47.92806	a81b7e39-c614-4f35-aee2-f5c6ffe33fce	0
810	7afecf23-2477-416c-a114-580b9bb10fd0.JPG	Variant	190	2017-09-26 19:42:48.293732	2017-09-26 19:44:52.889665	7afecf23-2477-416c-a114-580b9bb10fd0	1
813	a9e2221c-be0f-44fc-b034-8a48038db52f.JPG	Variant	190	2017-09-26 19:43:43.599893	2017-09-26 19:45:08.737726	a9e2221c-be0f-44fc-b034-8a48038db52f	3
812	84362888-6207-4282-8c84-67b98abea16e.JPG	Variant	190	2017-09-26 19:43:38.411077	2017-09-26 19:44:59.585126	84362888-6207-4282-8c84-67b98abea16e	4
811	7181b686-6acc-4bb3-9e2d-32e89201d2fb.JPG	Variant	190	2017-09-26 19:43:31.785206	2017-09-26 19:45:01.451597	7181b686-6acc-4bb3-9e2d-32e89201d2fb	2
809	b6299f01-a5e1-4c59-b1f3-4f87b526963f.JPG	Variant	189	2017-09-26 19:41:34.315066	2017-09-26 20:03:45.909596	b6299f01-a5e1-4c59-b1f3-4f87b526963f	4
814	0210d5e7-b7b6-45f8-833c-e5db0b5f9cf7.JPG	Variant	203	2017-09-26 19:48:45.680728	2017-09-26 20:04:21.95919	0210d5e7-b7b6-45f8-833c-e5db0b5f9cf7	1
890	1c4748cf-9550-40f8-859d-669aebd8af48.JPG	Kit	55	2017-09-27 18:47:02.835056	2017-09-27 18:47:02.835056	1c4748cf-9550-40f8-859d-669aebd8af48	0
891	357d1e82-d002-4329-afad-3969ac71eede.jpg	Kit	55	2017-09-27 18:49:28.278406	2017-09-27 18:49:28.278406	357d1e82-d002-4329-afad-3969ac71eede	0
826	9e9f9ff0-8b0d-47be-8779-1e956031e340.jpg	Variant	189	2017-09-26 20:03:01.618896	2017-09-26 20:03:23.713588	9e9f9ff0-8b0d-47be-8779-1e956031e340	1
825	1234c2c4-d809-4f83-ac21-65487f8ef1df.jpg	Variant	189	2017-09-26 20:02:56.358505	2017-09-26 20:03:37.955265	1234c2c4-d809-4f83-ac21-65487f8ef1df	2
808	cf9ca992-c4de-49f7-ada7-7a4006e07f10.JPG	Variant	189	2017-09-26 19:41:29.677546	2017-09-26 20:03:42.112096	cf9ca992-c4de-49f7-ada7-7a4006e07f10	3
821	ec3b470d-ad27-403c-a905-cdd9ecb153be.jpg	Variant	203	2017-09-26 20:01:13.762534	2017-09-26 20:04:13.611912	ec3b470d-ad27-403c-a905-cdd9ecb153be	2
815	c766cf46-b0d1-47ca-94b9-12c6c273c12d.JPG	Variant	203	2017-09-26 19:48:51.503201	2017-09-26 20:04:17.407808	c766cf46-b0d1-47ca-94b9-12c6c273c12d	3
892	7638ca28-86b6-4ad5-a986-4d70c85e39e3.jpg	Kit	56	2017-09-27 18:50:31.114558	2017-09-27 18:50:31.114558	7638ca28-86b6-4ad5-a986-4d70c85e39e3	0
962	10cf94d2-c704-42d7-b268-b6f4f4bcf545.jpg	Kit	73	2017-09-29 19:56:43.949769	2017-10-13 14:02:05.765731	10cf94d2-c704-42d7-b268-b6f4f4bcf545	2
893	2721d717-b927-4a6b-915c-bbf21c6ddcd9.jpg	Kit	58	2017-09-27 18:51:46.200474	2017-09-27 18:51:46.200474	2721d717-b927-4a6b-915c-bbf21c6ddcd9	0
827	e09a6318-9aa1-474d-b81d-bc6139075a45.JPG	Variant	202	2017-09-26 20:08:51.695906	2017-09-26 20:10:32.105553	e09a6318-9aa1-474d-b81d-bc6139075a45	2
954	14bdcdd2-4ae7-40b8-adb7-06e9c740cc59.jpg	Kit	70	2017-09-29 19:22:23.889507	2017-10-12 17:52:21.262216	14bdcdd2-4ae7-40b8-adb7-06e9c740cc59	2
894	a0c63cb0-8180-455d-8bbf-7e157cf713db.jpg	Kit	63	2017-09-27 18:53:12.024507	2017-09-27 18:53:59.709816	a0c63cb0-8180-455d-8bbf-7e157cf713db	0
895	d851f1ff-5a3a-41b0-a23e-366c9576ebea.jpg	Kit	63	2017-09-27 18:53:18.350942	2017-09-27 18:53:59.71254	d851f1ff-5a3a-41b0-a23e-366c9576ebea	0
901	f82a1929-476d-4607-8e6c-f8677edfed8c.jpg	Kit	66	2017-09-27 18:59:06.507866	2017-09-27 18:59:46.9353	f82a1929-476d-4607-8e6c-f8677edfed8c	0
902	2bedfbf5-44e2-48f7-ac2e-fc084b446022.jpg	Kit	66	2017-09-27 18:59:12.611033	2017-09-27 18:59:46.937946	2bedfbf5-44e2-48f7-ac2e-fc084b446022	0
903	f787f786-0d14-45a3-bdfa-33ffb6804095.jpg	Kit	65	2017-09-27 19:01:21.328038	2017-09-27 19:01:21.328038	f787f786-0d14-45a3-bdfa-33ffb6804095	0
904	ca3f20a8-ad32-4b6a-b0b7-d4dc45ba5217.jpg	Kit	65	2017-09-27 19:01:41.498892	2017-09-27 19:01:41.498892	ca3f20a8-ad32-4b6a-b0b7-d4dc45ba5217	0
905	c06269f1-38c3-4fa0-bba2-e32c3372117a.jpg	Kit	60	2017-09-27 19:02:39.880235	2017-09-27 19:02:39.880235	c06269f1-38c3-4fa0-bba2-e32c3372117a	0
908	7586adf5-b87e-48cf-ad7f-926f35ea1dfc.jpg	Kit	64	2017-09-27 19:04:46.876156	2017-09-27 19:04:46.876156	7586adf5-b87e-48cf-ad7f-926f35ea1dfc	0
909	52499e8c-2aaf-4b81-b1bd-27079467f47f.jpg	Kit	64	2017-09-27 19:05:08.004207	2017-09-27 19:05:08.004207	52499e8c-2aaf-4b81-b1bd-27079467f47f	0
910	69f30c6c-3699-49de-ada9-0d512f27801e.jpg	Kit	52	2017-09-27 19:08:26.282027	2017-09-27 19:08:26.282027	69f30c6c-3699-49de-ada9-0d512f27801e	0
911	78c8405d-1504-4df5-9a1e-4414bc5ebcf3.jpg	Kit	52	2017-09-27 19:09:10.154441	2017-09-27 19:09:10.154441	78c8405d-1504-4df5-9a1e-4414bc5ebcf3	0
912	85cc58ad-af68-46d0-a16e-fc569d94020e.JPG	Kit	51	2017-09-27 19:09:49.819157	2017-09-27 19:09:49.819157	85cc58ad-af68-46d0-a16e-fc569d94020e	0
914	a7bf4aaa-7945-4930-b89e-c60b145a888d.jpg	Kit	51	2017-09-27 19:11:44.00032	2017-09-27 19:11:44.00032	a7bf4aaa-7945-4930-b89e-c60b145a888d	0
915	aeec86a6-1ed8-4f39-af66-90b9434a8208.jpg	Kit	32	2017-09-27 19:21:57.49445	2017-09-27 19:21:57.49445	aeec86a6-1ed8-4f39-af66-90b9434a8208	0
916	51508798-7d85-4d0a-b8c1-2156cd8d5dbe.jpg	Kit	33	2017-09-27 19:24:02.451184	2017-09-27 19:24:02.451184	51508798-7d85-4d0a-b8c1-2156cd8d5dbe	0
917	a73618ea-35f4-4cba-ae47-3aa3080545a6.jpg	Kit	33	2017-09-27 19:24:44.409609	2017-09-27 19:24:44.409609	a73618ea-35f4-4cba-ae47-3aa3080545a6	0
920	fb88ad49-160f-4482-9a8b-d51c929b952f.JPG	Kit	29	2017-09-27 19:31:53.386911	2017-09-27 19:31:53.386911	fb88ad49-160f-4482-9a8b-d51c929b952f	0
923	11b26dc9-4efb-4054-ac2f-0c531c907a37.jpg	Kit	27	2017-09-27 19:43:42.226131	2017-09-27 19:43:42.226131	11b26dc9-4efb-4054-ac2f-0c531c907a37	0
924	b9fc6dd2-2d6a-4674-98d2-b2c9ac3be89d.jpg	Kit	27	2017-09-27 19:44:03.631765	2017-09-27 19:44:03.631765	b9fc6dd2-2d6a-4674-98d2-b2c9ac3be89d	0
925	8952c88f-71e6-4571-9cc1-f79aea3734b8.JPG	Variant	152	2017-09-27 19:58:37.926859	2017-09-27 19:58:54.258564	8952c88f-71e6-4571-9cc1-f79aea3734b8	2
926	ce4651c1-1d82-4aaf-80ff-1e11a19b3e1b.jpg	Variant	206	2017-09-27 20:01:07.720444	2017-09-27 20:01:07.720444	ce4651c1-1d82-4aaf-80ff-1e11a19b3e1b	0
927	97ff30c4-f513-417c-a9aa-b26c5ccb812b.JPG	Variant	206	2017-09-27 20:01:51.094923	2017-09-27 20:01:51.094923	97ff30c4-f513-417c-a9aa-b26c5ccb812b	0
928	f9e0ce08-5620-43a2-acab-ed4cd8928f38.JPG	Variant	206	2017-09-27 20:01:55.717644	2017-09-27 20:01:55.717644	f9e0ce08-5620-43a2-acab-ed4cd8928f38	0
952	ff7d9b4d-cd1d-45fa-97f2-1009911cfbf4.jpg	Kit	67	2017-09-29 19:19:20.547129	2017-09-29 19:19:20.547129	ff7d9b4d-cd1d-45fa-97f2-1009911cfbf4	0
953	c10e117d-bef6-4fd5-b292-2aee010cdd5a.jpg	Kit	67	2017-09-29 19:20:02.203557	2017-09-29 19:20:02.203557	c10e117d-bef6-4fd5-b292-2aee010cdd5a	0
958	19a96afb-6a8b-4782-aeda-bfe11156c0aa.jpg	Kit	58	2017-09-29 19:45:44.251563	2017-09-29 19:45:44.251563	19a96afb-6a8b-4782-aeda-bfe11156c0aa	0
959	15565ae0-6fde-49fe-8f0c-f8be5870e3ce.jpg	Kit	57	2017-09-29 19:47:06.090666	2017-09-29 19:47:06.090666	15565ae0-6fde-49fe-8f0c-f8be5870e3ce	0
960	eb6513c8-831e-4422-aab7-ac033a602243.jpg	Kit	59	2017-09-29 19:48:31.361208	2017-09-29 19:48:31.361208	eb6513c8-831e-4422-aab7-ac033a602243	0
1087	040b7147-cd84-4092-bc61-0523cca8f3c9.jpg	Variant	229	2017-10-04 14:33:30.491016	2017-10-04 14:33:30.491016	040b7147-cd84-4092-bc61-0523cca8f3c9	0
1111	9ddac318-07ac-49c9-b154-32e3e73488e9.jpg	Kit	43	2017-10-05 11:46:43.205207	2017-10-05 11:46:43.205207	9ddac318-07ac-49c9-b154-32e3e73488e9	0
1112	af34a8d5-e452-4cb4-a802-ce9cb0201631.jpg	Kit	42	2017-10-05 11:48:01.635539	2017-10-05 11:48:01.635539	af34a8d5-e452-4cb4-a802-ce9cb0201631	0
1113	54719237-c442-422a-a30e-d455cea3d5cf.jpg	Kit	41	2017-10-05 11:50:09.231426	2017-10-05 11:50:09.231426	54719237-c442-422a-a30e-d455cea3d5cf	0
1092	9de8fee9-c2c8-4fc3-8322-8e92ef8fd8f6.JPG	Variant	174	2017-10-05 10:59:18.207085	2017-10-05 10:59:18.207085	9de8fee9-c2c8-4fc3-8322-8e92ef8fd8f6	0
1093	f884fbb1-f230-44ee-b483-bb74b38df869.jpg	Variant	174	2017-10-05 11:00:14.253783	2017-10-05 11:00:14.253783	f884fbb1-f230-44ee-b483-bb74b38df869	0
1094	7bb33665-f949-47de-9a55-ee8db60f72b5.jpg	Variant	174	2017-10-05 11:02:05.504086	2017-10-05 11:02:05.504086	7bb33665-f949-47de-9a55-ee8db60f72b5	0
1095	3ef60bc7-7fc2-44d4-b6b4-93e7a83de03a.JPG	Variant	175	2017-10-05 11:04:01.895569	2017-10-05 11:04:01.895569	3ef60bc7-7fc2-44d4-b6b4-93e7a83de03a	0
1096	1fcd2376-794c-4383-b238-683a03336838.JPG	Variant	175	2017-10-05 11:04:31.696687	2017-10-05 11:04:31.696687	1fcd2376-794c-4383-b238-683a03336838	0
1097	2683b876-5c93-4c31-9f5b-f1f51c3f840c.JPG	Variant	176	2017-10-05 11:14:36.721174	2017-10-05 11:14:36.721174	2683b876-5c93-4c31-9f5b-f1f51c3f840c	0
1098	39d7b04d-72ad-43cd-9f64-1668fb221fde.JPG	Variant	176	2017-10-05 11:15:01.453708	2017-10-05 11:15:01.453708	39d7b04d-72ad-43cd-9f64-1668fb221fde	0
1099	011a51ed-4475-4fbd-be73-435ffa782144.JPG	Variant	183	2017-10-05 11:22:15.524767	2017-10-05 11:22:15.524767	011a51ed-4475-4fbd-be73-435ffa782144	0
1100	7ea9a298-7a2a-4aca-8498-d4df38176973.jpg	Variant	183	2017-10-05 11:22:43.423331	2017-10-05 11:22:43.423331	7ea9a298-7a2a-4aca-8498-d4df38176973	0
1114	c54f75f2-7dff-4f3c-a0bd-5509e4303052.JPG	Variant	176	2017-10-05 11:51:43.030987	2017-10-05 11:51:43.030987	c54f75f2-7dff-4f3c-a0bd-5509e4303052	0
1115	d0bd782e-7ac6-4ad6-a6e1-75dced1c3034.jpg	Variant	175	2017-10-05 12:02:46.070485	2017-10-05 12:02:46.070485	d0bd782e-7ac6-4ad6-a6e1-75dced1c3034	0
1101	6844b706-3995-424b-a375-1ebf559806d4.jpg	Variant	182	2017-10-05 11:31:10.364718	2017-10-05 11:33:19.122619	6844b706-3995-424b-a375-1ebf559806d4	1
1102	3782bd27-5c07-4469-b452-fd97ba72e2dd.jpg	Variant	182	2017-10-05 11:32:26.227021	2017-10-05 11:33:20.908995	3782bd27-5c07-4469-b452-fd97ba72e2dd	2
1103	fffd9c28-d696-44b0-83bc-95114d9f644a.jpg	Variant	182	2017-10-05 11:33:00.811579	2017-10-05 11:33:27.175343	fffd9c28-d696-44b0-83bc-95114d9f644a	3
1104	b80f7309-0dcc-4ad4-b798-843e7e325834.JPG	Variant	180	2017-10-05 11:34:39.221757	2017-10-05 11:37:13.7484	b80f7309-0dcc-4ad4-b798-843e7e325834	1
1105	dea0bc06-65ae-47bf-9a6b-5b8259bd4c4d.JPG	Variant	180	2017-10-05 11:35:07.164294	2017-10-05 11:37:13.788465	dea0bc06-65ae-47bf-9a6b-5b8259bd4c4d	2
1106	a0f81425-f56f-4fc2-ac23-0ef6dde87c3d.JPG	Variant	180	2017-10-05 11:35:38.773905	2017-10-05 11:37:14.030029	a0f81425-f56f-4fc2-ac23-0ef6dde87c3d	3
1107	8f817825-a4f2-4e55-a79c-1169b9d3296d.JPG	Variant	180	2017-10-05 11:36:47.419455	2017-10-05 11:37:17.462194	8f817825-a4f2-4e55-a79c-1169b9d3296d	4
1108	b8382808-980e-4718-ae43-069a74082240.JPG	Variant	199	2017-10-05 11:40:14.404084	2017-10-05 11:40:14.404084	b8382808-980e-4718-ae43-069a74082240	0
1109	789fcc65-9215-46bc-8605-0a7a3705c9de.JPG	Variant	199	2017-10-05 11:40:39.040469	2017-10-05 11:40:39.040469	789fcc65-9215-46bc-8605-0a7a3705c9de	0
1110	ec72a1ce-09be-4246-abe3-abfa2f4e330f.JPG	Variant	199	2017-10-05 11:42:06.092319	2017-10-05 11:42:06.092319	ec72a1ce-09be-4246-abe3-abfa2f4e330f	0
1124	96dcffe8-d38c-4cca-96b7-c19c8548caac.JPG	Kit	0	2017-10-06 05:24:38.621956	2017-10-06 05:24:38.621956	96dcffe8-d38c-4cca-96b7-c19c8548caac	0
1125	e43c37f7-88ba-48d7-9146-2db8af22696d.jpg	Kit	0	2017-10-06 05:25:27.452138	2017-10-06 05:25:27.452138	e43c37f7-88ba-48d7-9146-2db8af22696d	0
1126	2fa1ad54-deb0-4741-8c06-d79308df4099.JPG	Kit	0	2017-10-06 05:26:13.942481	2017-10-06 05:26:13.942481	2fa1ad54-deb0-4741-8c06-d79308df4099	0
1127	86f37fef-adb8-478d-b651-f752574e32fd.JPG	Kit	74	2017-10-06 05:27:10.383271	2017-10-06 05:28:41.415432	86f37fef-adb8-478d-b651-f752574e32fd	0
1128	73fadfc5-8857-4bc0-ae33-eec8e75efec3.jpg	Kit	74	2017-10-06 05:28:09.486978	2017-10-06 05:28:41.418133	73fadfc5-8857-4bc0-ae33-eec8e75efec3	0
1129	3b9657cc-dbce-41f9-8b7c-498e084f7f30.jpeg	Variant	232	2017-10-06 08:50:43.599989	2017-10-06 08:53:04.953563	3b9657cc-dbce-41f9-8b7c-498e084f7f30	1
1130	999d576e-a69f-41dd-abf9-c1d047d2c9c3.jpeg	Variant	232	2017-10-06 08:52:42.794352	2017-10-06 08:53:08.549797	999d576e-a69f-41dd-abf9-c1d047d2c9c3	2
1134	a02564f5-87a8-49d6-97c3-989c4bdd2d9a.jpg	Variant	172	2017-10-06 11:02:27.403436	2017-10-06 11:02:27.403436	a02564f5-87a8-49d6-97c3-989c4bdd2d9a	0
1131	d3ec0093-5dbc-4366-992e-12d108f6895d.jpeg	Variant	232	2017-10-06 08:52:44.90494	2017-10-06 08:53:14.994879	d3ec0093-5dbc-4366-992e-12d108f6895d	3
1133	fb84c6bf-a2dc-4ac6-85f9-ed60fde0365f.jpeg	Variant	232	2017-10-06 08:52:50.766753	2017-10-06 08:53:18.332984	fb84c6bf-a2dc-4ac6-85f9-ed60fde0365f	4
1135	5d6d33bc-dcbe-4cfb-bb08-6aec08970386.jpg	Variant	172	2017-10-06 11:02:32.509879	2017-10-06 11:02:32.509879	5d6d33bc-dcbe-4cfb-bb08-6aec08970386	0
1136	6d2a3986-35ef-48a8-a32e-828fa2b68c0b.jpg	Variant	172	2017-10-06 11:02:48.161291	2017-10-06 11:02:48.161291	6d2a3986-35ef-48a8-a32e-828fa2b68c0b	0
1137	cd6c7902-1945-456c-b419-150ba64e2c4e.jpg	Kit	38	2017-10-06 11:04:00.68139	2017-10-06 11:04:00.68139	cd6c7902-1945-456c-b419-150ba64e2c4e	0
1138	f8e16ce8-1eed-4dae-84aa-7e3267dc1b61.JPG	Variant	185	2017-10-06 11:22:56.254776	2017-10-06 11:22:56.254776	f8e16ce8-1eed-4dae-84aa-7e3267dc1b61	0
1139	0fb293ba-a880-44c0-8718-139ede599556.JPG	Variant	185	2017-10-06 11:23:12.409058	2017-10-06 11:23:12.409058	0fb293ba-a880-44c0-8718-139ede599556	0
1140	f4986fb1-22c8-46c7-ae36-43309e6e0bea.jpg	Variant	185	2017-10-06 11:23:45.889332	2017-10-06 11:23:45.889332	f4986fb1-22c8-46c7-ae36-43309e6e0bea	0
1141	60b79322-87fb-4ebe-bd66-d7285881dde4.JPG	Variant	186	2017-10-06 11:25:52.766347	2017-10-06 11:26:33.803607	60b79322-87fb-4ebe-bd66-d7285881dde4	1
1142	85fb17cb-c19f-4bff-90f3-9c054008e1dc.JPG	Variant	186	2017-10-06 11:26:15.82011	2017-10-06 11:26:35.741657	85fb17cb-c19f-4bff-90f3-9c054008e1dc	2
1143	fb8d04fb-76df-44f3-954f-6cbaf611c699.jpg	Kit	44	2017-10-06 11:37:04.058795	2017-10-06 11:37:04.058795	fb8d04fb-76df-44f3-954f-6cbaf611c699	0
1146	722d52fb-e8be-4791-a9c0-9881d6c6ab2d.JPG	Variant	195	2017-10-06 11:42:20.97827	2017-10-06 11:42:20.97827	722d52fb-e8be-4791-a9c0-9881d6c6ab2d	0
1147	0d9493c2-aa7d-49c0-b9df-5ea8966e920f.JPG	Variant	195	2017-10-06 11:42:34.277362	2017-10-06 11:42:34.277362	0d9493c2-aa7d-49c0-b9df-5ea8966e920f	0
1149	45913e57-5381-4a14-92fa-d00dd202ead2.JPG	Kit	45	2017-10-06 11:43:11.902434	2017-10-06 11:43:11.902434	45913e57-5381-4a14-92fa-d00dd202ead2	0
1150	6cb32dd2-557d-459c-85cd-e9fd3fac18fa.JPG	Variant	187	2017-10-06 11:43:56.214719	2017-10-06 11:43:56.214719	6cb32dd2-557d-459c-85cd-e9fd3fac18fa	0
1151	3dd08ff4-3501-4ef7-a36d-35478deda156.JPG	Variant	187	2017-10-06 11:44:08.954039	2017-10-06 11:44:08.954039	3dd08ff4-3501-4ef7-a36d-35478deda156	0
1152	ca1546ad-36da-42bf-a604-ffb0b4b1dae4.JPG	Variant	187	2017-10-06 11:44:42.917481	2017-10-06 11:44:42.917481	ca1546ad-36da-42bf-a604-ffb0b4b1dae4	0
1153	79a89688-138a-4e35-beac-ab8e5ff7e136.JPG	Kit	47	2017-10-06 11:45:24.275556	2017-10-06 11:45:24.275556	79a89688-138a-4e35-beac-ab8e5ff7e136	0
1154	25ca6003-418b-4fe7-967e-db5e34f75c29.JPG	Variant	195	2017-10-06 11:46:28.114246	2017-10-06 11:46:28.114246	25ca6003-418b-4fe7-967e-db5e34f75c29	0
1155	39159b8d-f01e-40cd-bf8f-ec108396843e.JPG	Kit	49	2017-10-06 11:47:31.068514	2017-10-06 11:47:31.068514	39159b8d-f01e-40cd-bf8f-ec108396843e	0
1156	d1cc83b0-087c-4c66-b460-f2b6401a1b2a.JPG	Variant	192	2017-10-06 11:48:48.899705	2017-10-06 11:48:48.899705	d1cc83b0-087c-4c66-b460-f2b6401a1b2a	0
1157	da250d32-1263-492c-a7a1-d59ef1261afd.JPG	Variant	192	2017-10-06 11:49:06.891185	2017-10-06 11:49:06.891185	da250d32-1263-492c-a7a1-d59ef1261afd	0
1158	b172a1f6-cfc4-4ed9-818c-da998de1b951.JPG	Variant	192	2017-10-06 11:49:23.45186	2017-10-06 11:49:23.45186	b172a1f6-cfc4-4ed9-818c-da998de1b951	0
1159	0cf2b952-ac4e-40e3-9baf-b3816be28ef1.JPG	Variant	192	2017-10-06 11:50:53.114806	2017-10-06 11:50:53.114806	0cf2b952-ac4e-40e3-9baf-b3816be28ef1	0
1160	890442c4-6558-4747-a95f-ef2916469571.JPG	Variant	191	2017-10-06 11:51:36.521635	2017-10-06 11:51:36.521635	890442c4-6558-4747-a95f-ef2916469571	0
1161	ad4c1467-ae74-49b3-830a-a045a0f6b959.JPG	Variant	191	2017-10-06 11:51:53.252274	2017-10-06 11:51:53.252274	ad4c1467-ae74-49b3-830a-a045a0f6b959	0
1162	d549b24d-5e16-4be3-a061-3f901048da7c.JPG	Variant	191	2017-10-06 11:52:18.982914	2017-10-06 11:52:18.982914	d549b24d-5e16-4be3-a061-3f901048da7c	0
1163	91c59feb-ebce-471a-95ff-68d23a64eee1.JPG	Variant	197	2017-10-06 11:53:01.053673	2017-10-06 11:53:01.053673	91c59feb-ebce-471a-95ff-68d23a64eee1	0
1164	8254efbc-6895-4c57-a670-1226f0a03749.JPG	Variant	197	2017-10-06 11:53:17.504395	2017-10-06 11:53:17.504395	8254efbc-6895-4c57-a670-1226f0a03749	0
1165	66de2b19-f96c-4e61-81f9-bdab176c1579.JPG	Variant	197	2017-10-06 11:53:29.769213	2017-10-06 11:53:29.769213	66de2b19-f96c-4e61-81f9-bdab176c1579	0
1166	37703eb2-e4c6-4e75-9565-255db39df28a.JPG	Variant	197	2017-10-06 11:54:11.358137	2017-10-06 11:54:11.358137	37703eb2-e4c6-4e75-9565-255db39df28a	0
1167	ac33cb0e-44fc-45d3-a148-8fa58b95cd20.JPG	Variant	200	2017-10-06 11:56:08.388557	2017-10-06 11:56:08.388557	ac33cb0e-44fc-45d3-a148-8fa58b95cd20	0
1168	5f2df31c-5058-4c84-bdfa-8943b57033d2.JPG	Variant	200	2017-10-06 11:56:39.550684	2017-10-06 11:56:39.550684	5f2df31c-5058-4c84-bdfa-8943b57033d2	0
1169	f2331755-4352-4a39-8017-610461e4e568.JPG	Variant	200	2017-10-06 11:56:57.532623	2017-10-06 11:56:57.532623	f2331755-4352-4a39-8017-610461e4e568	0
1170	1a266d3c-136e-4094-beeb-1101fa30d9c4.JPG	Variant	200	2017-10-06 11:58:14.488505	2017-10-06 11:58:14.488505	1a266d3c-136e-4094-beeb-1101fa30d9c4	0
1171	6b2e98fb-988e-4880-92dc-56202ad5de0a.JPG	Variant	167	2017-10-06 12:02:18.47837	2017-10-06 12:02:18.47837	6b2e98fb-988e-4880-92dc-56202ad5de0a	0
1172	1a3d4e81-736d-4343-a9d3-2dd0d4fad6dd.JPG	Variant	167	2017-10-06 12:02:33.632799	2017-10-06 12:02:33.632799	1a3d4e81-736d-4343-a9d3-2dd0d4fad6dd	0
1173	da441479-f41e-46cc-a119-73fe89f80349.JPG	Variant	167	2017-10-06 12:02:57.826886	2017-10-06 12:02:57.826886	da441479-f41e-46cc-a119-73fe89f80349	0
1174	ab7845e4-4b51-4147-861e-b3ab9654258c.JPG	Variant	167	2017-10-06 12:03:21.061821	2017-10-06 12:03:21.061821	ab7845e4-4b51-4147-861e-b3ab9654258c	0
1175	c7cb92b0-a807-4d8e-b861-bcce6e799054.JPG	Variant	202	2017-10-06 12:06:16.648796	2017-10-06 12:06:16.648796	c7cb92b0-a807-4d8e-b861-bcce6e799054	0
1145	275ffabb-4be2-440e-905f-561cc1d353ac.JPG	Variant	204	2017-10-06 11:40:59.772942	2017-10-07 00:28:32.146056	275ffabb-4be2-440e-905f-561cc1d353ac	1
1144	0d5e63ff-3124-4d91-9b43-b5dd4881a6c2.JPG	Variant	204	2017-10-06 11:40:33.674992	2017-10-07 00:28:38.165488	0d5e63ff-3124-4d91-9b43-b5dd4881a6c2	2
1177	31c232fb-33d6-4788-97c4-978a9700af0e.jpg	Variant	233	2017-10-11 15:11:38.041733	2017-10-11 15:11:38.041733	31c232fb-33d6-4788-97c4-978a9700af0e	0
1181	fcdf1142-147a-4d0e-b41f-185d23ee28bf.jpg	Variant	236	2017-10-11 15:18:41.460464	2017-10-11 15:18:41.460464	fcdf1142-147a-4d0e-b41f-185d23ee28bf	0
1183	e9031f0e-3527-42fe-b971-75ab37cac8c0.jpg	Variant	236	2017-10-11 15:24:57.542096	2017-10-11 15:24:57.542096	e9031f0e-3527-42fe-b971-75ab37cac8c0	0
1184	c48c6f5d-3ad3-47dc-9090-b231e9e4926c.jpg	Variant	237	2017-10-11 15:25:33.989198	2017-10-11 15:25:33.989198	c48c6f5d-3ad3-47dc-9090-b231e9e4926c	0
1185	af4a6b7c-c113-469a-beca-87876e903f4c.jpg	Variant	233	2017-10-11 15:31:02.014938	2017-10-11 15:31:02.014938	af4a6b7c-c113-469a-beca-87876e903f4c	0
1186	9e6fad7c-d94a-4bb8-bb2f-4d833608d1bf.jpg	Variant	233	2017-10-11 15:31:07.94308	2017-10-11 15:31:07.94308	9e6fad7c-d94a-4bb8-bb2f-4d833608d1bf	0
1187	6d849f7d-acb3-4f2b-b255-24a248794ac3.jpg	Variant	235	2017-10-11 15:33:17.1888	2017-10-11 15:33:17.1888	6d849f7d-acb3-4f2b-b255-24a248794ac3	0
1188	a58911ac-2dc9-40ad-86f1-4a2ff36da784.jpg	Variant	235	2017-10-11 15:33:45.191254	2017-10-11 15:33:45.191254	a58911ac-2dc9-40ad-86f1-4a2ff36da784	0
1189	6256126d-ac76-4b31-9a6b-1a410b8a9aec.jpg	Variant	235	2017-10-11 15:33:55.853976	2017-10-11 15:33:55.853976	6256126d-ac76-4b31-9a6b-1a410b8a9aec	0
1191	1483fd6c-a46a-460c-8983-1cae557088dd.jpg	Variant	237	2017-10-11 15:35:45.227871	2017-10-11 15:35:45.227871	1483fd6c-a46a-460c-8983-1cae557088dd	0
1192	67c8386f-4520-4453-a914-d5d06ed7af41.jpg	Variant	236	2017-10-11 15:36:18.785703	2017-10-11 15:36:18.785703	67c8386f-4520-4453-a914-d5d06ed7af41	0
1193	b28858ce-64b5-4bbb-99fb-0d052afe0aec.JPG	Variant	238	2017-10-12 16:14:08.508758	2017-10-12 16:16:25.480155	b28858ce-64b5-4bbb-99fb-0d052afe0aec	1
1194	ef3700f1-1dca-4032-897d-2ee7c0ef7bd9.JPG	Variant	238	2017-10-12 16:14:24.713555	2017-10-12 16:16:27.151412	ef3700f1-1dca-4032-897d-2ee7c0ef7bd9	2
1195	121889fd-9791-4474-bba0-847c0e722572.JPG	Variant	238	2017-10-12 16:15:32.2414	2017-10-12 16:16:30.041591	121889fd-9791-4474-bba0-847c0e722572	3
1197	f8c1ba06-7dcd-48f7-8d2c-93f0f2070d7a.JPG	Variant	239	2017-10-12 16:21:33.342927	2017-10-12 16:22:02.770495	f8c1ba06-7dcd-48f7-8d2c-93f0f2070d7a	1
1241	a31cdd09-eb87-4423-a4e3-a75b128e5fcd.JPG	Variant	243	2017-10-13 16:22:48.223958	2017-10-17 07:05:27.464918	a31cdd09-eb87-4423-a4e3-a75b128e5fcd	1
1198	e46c924b-23de-47c6-9ceb-c6d1455e18ac.JPG	Variant	240	2017-10-12 16:36:49.729362	2017-10-12 16:46:24.283793	e46c924b-23de-47c6-9ceb-c6d1455e18ac	1
1199	091eaa6e-f14c-4f9c-83e8-d51a2a925267.JPG	Variant	240	2017-10-12 16:37:47.980022	2017-10-12 16:46:25.222412	091eaa6e-f14c-4f9c-83e8-d51a2a925267	2
1200	92b1f97a-53f3-46b8-97da-5f3d8b584521.JPG	Variant	240	2017-10-12 16:38:14.288772	2017-10-12 16:46:26.989632	92b1f97a-53f3-46b8-97da-5f3d8b584521	3
1202	baf7b9ed-8255-4bb0-b5cd-ab8e8f485a7a.JPG	Variant	241	2017-10-12 16:53:53.498205	2017-10-12 16:55:58.193312	baf7b9ed-8255-4bb0-b5cd-ab8e8f485a7a	1
1201	bd7195c3-7623-4eae-9844-62c251864a25.JPG	Variant	241	2017-10-12 16:53:47.803012	2017-10-12 16:56:00.029856	bd7195c3-7623-4eae-9844-62c251864a25	2
1205	9711953c-b108-4c18-8b6d-b8addeec4966.JPG	Variant	242	2017-10-12 16:57:29.401859	2017-10-12 16:59:07.336406	9711953c-b108-4c18-8b6d-b8addeec4966	1
1204	186c1aba-f43b-40cf-a49f-43ed09f50a04.JPG	Variant	242	2017-10-12 16:57:23.673181	2017-10-12 16:59:08.779988	186c1aba-f43b-40cf-a49f-43ed09f50a04	2
1206	5ace041b-d548-43f8-ae6c-e0aa38ed3543.JPG	Variant	242	2017-10-12 16:58:08.895544	2017-10-12 16:59:11.405151	5ace041b-d548-43f8-ae6c-e0aa38ed3543	3
1207	5d03d1f2-c74f-4e83-8ac6-98555749d969.JPG	Variant	241	2017-10-12 17:00:35.680408	2017-10-12 17:01:14.206758	5d03d1f2-c74f-4e83-8ac6-98555749d969	3
1203	49fdefc9-1f5f-4190-b8f1-2116f73e748b.JPG	Variant	241	2017-10-12 16:54:25.193079	2017-10-12 17:01:17.012315	49fdefc9-1f5f-4190-b8f1-2116f73e748b	4
1208	ba2cfe72-dc25-4586-a074-e80c2bb773e4.JPG	Variant	242	2017-10-12 17:02:10.969067	2017-10-12 17:02:21.856913	ba2cfe72-dc25-4586-a074-e80c2bb773e4	4
1213	6c0d98af-13fa-492d-8a49-ddaa2905b43f.JPG	Kit	76	2017-10-12 17:46:52.5453	2017-10-12 17:46:52.5453	6c0d98af-13fa-492d-8a49-ddaa2905b43f	0
1214	94e71228-dfd8-474d-a5a4-79e7f1243b14.JPG	Kit	76	2017-10-12 17:50:07.856257	2017-10-12 17:50:07.856257	94e71228-dfd8-474d-a5a4-79e7f1243b14	0
1226	cf252362-fbe0-4855-bb32-a5c54370b55b.png	Kit	80	2017-10-12 20:28:50.565173	2017-10-12 20:28:50.565173	cf252362-fbe0-4855-bb32-a5c54370b55b	0
1218	58f49aaf-4254-4d76-bc0e-49ea6de45344.jpeg	Kit	78	2017-10-12 19:32:43.646476	2017-10-12 19:34:09.413383	58f49aaf-4254-4d76-bc0e-49ea6de45344	2
1217	97da929b-544a-4247-bd2f-5e28b6135c6c.jpeg	Kit	78	2017-10-12 19:32:15.886021	2017-10-12 19:34:09.416194	97da929b-544a-4247-bd2f-5e28b6135c6c	1
1216	3b72d9cf-da90-4a09-ad4c-53d9a718e7ce.jpeg	Kit	77	2017-10-12 19:26:45.668498	2017-10-12 19:34:22.238021	3b72d9cf-da90-4a09-ad4c-53d9a718e7ce	1
1215	86b6e82f-256b-48e4-82d2-88f5577aca74.jpeg	Kit	77	2017-10-12 19:26:19.764702	2017-10-12 19:34:22.240908	86b6e82f-256b-48e4-82d2-88f5577aca74	2
1247	8fbddde9-d471-4e12-b981-5343857290b4.jpg	Variant	244	2017-10-14 10:30:01.443	2017-10-14 10:30:01.443	8fbddde9-d471-4e12-b981-5343857290b4	0
1219	2cd3ff0b-054c-4b93-933b-ca90ee16a8d0.jpeg	Kit	79	2017-10-12 19:51:59.46099	2017-10-12 19:52:18.620376	2cd3ff0b-054c-4b93-933b-ca90ee16a8d0	2
1220	c596a397-1757-4458-9bc9-a2a929d8b4ce.jpeg	Kit	79	2017-10-12 19:52:05.338294	2017-10-12 19:52:18.622986	c596a397-1757-4458-9bc9-a2a929d8b4ce	1
1228	fd5f29bd-7944-4a65-9ebd-fa846f446bb8.jpeg	Kit	80	2017-10-12 20:31:01.24862	2017-10-12 20:31:01.24862	fd5f29bd-7944-4a65-9ebd-fa846f446bb8	0
1232	ce050c5a-d514-4cec-bce1-88dd8f13f700.jpeg	Kit	0	2017-10-12 20:39:05.949652	2017-10-12 20:39:05.949652	ce050c5a-d514-4cec-bce1-88dd8f13f700	0
1236	16ecce97-7189-4115-9f31-583bef022226.jpeg	Kit	82	2017-10-12 21:19:39.586055	2017-10-12 21:19:39.586055	16ecce97-7189-4115-9f31-583bef022226	0
1237	6c91fcba-3574-49ee-a97c-e4ea645bcda0.JPG	Kit	82	2017-10-13 10:21:44.718847	2017-10-13 10:21:44.718847	6c91fcba-3574-49ee-a97c-e4ea645bcda0	0
1229	b49f693f-2522-45ff-9864-e38f6e9987fa.jpeg	Kit	83	2017-10-12 20:35:07.42001	2017-10-13 17:33:07.6338	b49f693f-2522-45ff-9864-e38f6e9987fa	1
1211	d455c81e-b30f-4be8-ba52-91d26da9b449.JPG	Kit	75	2017-10-12 17:29:46.948528	2017-10-13 17:36:04.337802	d455c81e-b30f-4be8-ba52-91d26da9b449	2
1238	7ad3e245-32ad-44ff-b046-b4a7830a72b3.jpg	Kit	73	2017-10-13 14:01:51.743566	2017-10-13 14:02:05.762828	7ad3e245-32ad-44ff-b046-b4a7830a72b3	1
1239	d522172c-4bdf-49b2-8a50-5efae68ab66e.jpg	Kit	68	2017-10-13 14:03:18.334183	2017-10-13 14:04:10.017484	d522172c-4bdf-49b2-8a50-5efae68ab66e	2
1223	5d5216e0-311f-47f6-b087-b966e42af94c.jpeg	Kit	81	2017-10-12 20:18:30.105538	2017-10-13 17:31:53.770979	5d5216e0-311f-47f6-b087-b966e42af94c	2
1222	f8222304-5e14-45f9-9248-e2ac6a50f7e5.jpeg	Kit	81	2017-10-12 20:18:24.470955	2017-10-13 17:31:53.775435	f8222304-5e14-45f9-9248-e2ac6a50f7e5	1
1234	54f9f63d-e5ea-4123-8a7b-b8478655a02e.jpeg	Kit	84	2017-10-12 20:42:48.534842	2017-10-13 17:32:40.039329	54f9f63d-e5ea-4123-8a7b-b8478655a02e	1
1231	92f0364d-beb1-4457-9cc0-cfa58be23854.jpeg	Kit	84	2017-10-12 20:39:00.349459	2017-10-13 17:32:40.041784	92f0364d-beb1-4457-9cc0-cfa58be23854	2
1230	255a1d2f-a34f-441b-b8b8-26c2b50f1eeb.jpeg	Kit	83	2017-10-12 20:35:28.148077	2017-10-13 17:33:07.631299	255a1d2f-a34f-441b-b8b8-26c2b50f1eeb	2
1209	b096793c-a9ab-47e2-a944-11aade0a6732.JPG	Kit	75	2017-10-12 17:17:49.004647	2017-10-13 17:36:04.340446	b096793c-a9ab-47e2-a944-11aade0a6732	1
1245	d66c9a43-b7ff-46c6-888e-5e5d97b5859f.JPG	Variant	244	2017-10-14 10:28:29.403223	2017-10-14 10:28:29.403223	d66c9a43-b7ff-46c6-888e-5e5d97b5859f	0
1248	9e5cba27-fcb6-4508-99e3-8606701c15dc.JPG	Variant	244	2017-10-14 10:30:37.839372	2017-10-14 10:30:37.839372	9e5cba27-fcb6-4508-99e3-8606701c15dc	0
1249	a305d3c8-980a-49df-921d-e84b23183958.JPG	Variant	246	2017-10-14 14:32:02.813777	2017-10-14 14:32:02.813777	a305d3c8-980a-49df-921d-e84b23183958	0
1250	504d97c3-cadb-42f6-916f-34192283c5ba.JPG	Variant	246	2017-10-15 08:31:16.842581	2017-10-15 08:31:16.842581	504d97c3-cadb-42f6-916f-34192283c5ba	0
1251	52eac58b-4857-45c4-828e-53fa54c6b086.jpeg	Variant	227	2017-10-15 08:45:01.31348	2017-10-15 08:45:56.696208	52eac58b-4857-45c4-828e-53fa54c6b086	3
1196	482c52e4-9190-4673-ad8f-693db0681989.JPG	Variant	239	2017-10-12 16:21:09.28504	2017-10-17 07:04:22.91022	482c52e4-9190-4673-ad8f-693db0681989	2
1242	bb35b0c2-bda1-4fb1-ae26-01061d0dc6ed.JPG	Variant	243	2017-10-13 16:23:17.859299	2017-10-17 07:05:37.819835	bb35b0c2-bda1-4fb1-ae26-01061d0dc6ed	2
1243	c618d637-38b5-48d0-91d2-838dccae5c5b.JPG	Variant	243	2017-10-13 16:26:10.792103	2017-10-17 07:05:37.89049	c618d637-38b5-48d0-91d2-838dccae5c5b	3
1253	2f90c3f7-c2cb-4553-8043-7bc1ce975cb8.jpeg	Variant	227	2017-10-15 08:45:09.647694	2017-10-15 08:45:46.838079	2f90c3f7-c2cb-4553-8043-7bc1ce975cb8	1
1252	fa42ebe4-e21d-4610-89d8-f6e8d160ecf6.jpeg	Variant	227	2017-10-15 08:45:05.018452	2017-10-15 08:45:49.703868	fa42ebe4-e21d-4610-89d8-f6e8d160ecf6	2
1254	ffcb8228-e5d3-48fa-a589-26fe8d922847.jpeg	Variant	228	2017-10-15 08:45:35.216275	2017-10-15 08:45:59.972591	ffcb8228-e5d3-48fa-a589-26fe8d922847	1
1255	823b4480-80ec-4eaa-b991-e2722a3c365d.jpeg	Variant	228	2017-10-15 08:45:38.526206	2017-10-15 08:46:06.715892	823b4480-80ec-4eaa-b991-e2722a3c365d	2
1256	f45ea710-40b6-41f4-ae85-53e65e1244ad.jpeg	Variant	228	2017-10-15 08:46:27.982667	2017-10-15 08:47:17.048912	f45ea710-40b6-41f4-ae85-53e65e1244ad	3
1259	c95a4217-aea8-4df7-870d-12a304950744.jpeg	Variant	226	2017-10-15 08:47:01.053997	2017-10-15 08:47:20.314779	c95a4217-aea8-4df7-870d-12a304950744	1
1257	2950de2f-a98b-4c75-914d-ebe0a5ec33a0.jpeg	Variant	226	2017-10-15 08:46:50.19658	2017-10-15 08:47:22.855655	2950de2f-a98b-4c75-914d-ebe0a5ec33a0	2
1258	5a70fca3-3975-4fcd-aadb-e9b93752d6a3.jpeg	Variant	226	2017-10-15 08:46:55.193658	2017-10-15 08:47:26.697544	5a70fca3-3975-4fcd-aadb-e9b93752d6a3	3
379	4a11e5ec-4ba4-41a8-815a-d7bbf3426049.jpg	Variant	137	2017-09-13 11:10:56.759713	2017-10-15 10:23:41.437494	4a11e5ec-4ba4-41a8-815a-d7bbf3426049	1
1263	9fc2d173-5b97-4257-b9f6-2343a447bd35.jpeg	Variant	247	2017-10-15 11:48:07.847229	2017-10-15 11:48:23.972951	9fc2d173-5b97-4257-b9f6-2343a447bd35	1
1262	a478f23d-f6ed-4d6f-9398-59c42e8c131d.jpeg	Variant	247	2017-10-15 11:48:04.662787	2017-10-15 11:48:27.010013	a478f23d-f6ed-4d6f-9398-59c42e8c131d	2
1261	15fbddb4-690c-443e-96df-2da48653d85b.jpeg	Variant	247	2017-10-15 11:48:01.448022	2017-10-15 11:48:32.428707	15fbddb4-690c-443e-96df-2da48653d85b	3
1260	84cf6022-4b52-4760-bc3a-a645a9126894.jpeg	Variant	247	2017-10-15 11:47:58.065721	2017-10-15 11:48:36.195608	84cf6022-4b52-4760-bc3a-a645a9126894	4
1265	088b22c9-0cea-4001-80eb-3a6e107701e6.jpeg	Variant	248	2017-10-15 11:49:13.516939	2017-10-15 11:50:39.671475	088b22c9-0cea-4001-80eb-3a6e107701e6	2
1266	55004fe0-3ccb-4829-b301-0a727c70fe5d.jpeg	Variant	248	2017-10-15 11:49:19.539433	2017-10-15 11:50:43.177961	55004fe0-3ccb-4829-b301-0a727c70fe5d	4
1268	8d0c0495-6db5-4820-a8c5-a5b33a52843a.jpeg	Variant	248	2017-10-15 11:50:34.323957	2017-10-15 12:47:05.917802	8d0c0495-6db5-4820-a8c5-a5b33a52843a	1
1272	6dfbe286-81ee-4f49-a313-93dd3b447382.jpeg	Variant	250	2017-10-15 11:55:10.484756	2017-10-15 11:55:32.668453	6dfbe286-81ee-4f49-a313-93dd3b447382	1
1273	90d9dac1-7499-43f4-ab96-dabf0ce9b1d2.jpeg	Variant	250	2017-10-15 11:55:14.453801	2017-10-15 11:55:42.729831	90d9dac1-7499-43f4-ab96-dabf0ce9b1d2	2
1269	06e58731-cc3e-4c5e-98cd-b23dedaab2cb.jpeg	Variant	250	2017-10-15 11:54:58.063239	2017-10-15 11:55:46.194904	06e58731-cc3e-4c5e-98cd-b23dedaab2cb	3
1271	015b4ddc-323e-4c37-92e2-1916fb4c671f.jpeg	Variant	250	2017-10-15 11:55:06.547469	2017-10-15 11:55:49.354736	015b4ddc-323e-4c37-92e2-1916fb4c671f	4
1270	7904034a-d76b-4bd0-85b5-98e0120bcb4f.jpeg	Variant	250	2017-10-15 11:55:01.862934	2017-10-15 11:55:53.624476	7904034a-d76b-4bd0-85b5-98e0120bcb4f	5
1286	bc700a79-ea8c-4f70-a8ca-95b74d616390.jpeg	Variant	256	2017-10-15 12:27:55.530459	2017-10-15 12:28:11.949486	bc700a79-ea8c-4f70-a8ca-95b74d616390	1
1287	dd878768-7a50-489b-bd4f-1c86c3832281.jpeg	Variant	256	2017-10-15 12:27:58.748442	2017-10-15 12:28:14.524599	dd878768-7a50-489b-bd4f-1c86c3832281	2
1288	7150ef5a-6a96-4360-b760-cc2d4a7f4d18.jpeg	Variant	256	2017-10-15 12:28:02.121028	2017-10-15 12:28:17.707778	7150ef5a-6a96-4360-b760-cc2d4a7f4d18	3
1285	60ad5859-6000-4768-8553-584efe0fe8f5.jpeg	Variant	256	2017-10-15 12:27:51.932423	2017-10-15 12:28:25.228983	60ad5859-6000-4768-8553-584efe0fe8f5	4
1281	b00cc72f-6bf6-48c3-8b26-70607255cfa5.jpeg	Variant	251	2017-10-15 12:23:18.129696	2017-10-15 12:23:36.124982	b00cc72f-6bf6-48c3-8b26-70607255cfa5	1
1279	4a6d9982-fb1a-4975-9956-e7eccae9bb61.jpeg	Variant	251	2017-10-15 12:23:11.313169	2017-10-15 12:23:41.702744	4a6d9982-fb1a-4975-9956-e7eccae9bb61	2
1278	6713a719-4d25-4dfe-ac23-b6789a258d58.jpeg	Variant	251	2017-10-15 12:23:07.960241	2017-10-15 12:23:45.176645	6713a719-4d25-4dfe-ac23-b6789a258d58	3
1280	767a7b05-ddfe-42a5-a183-6964aa4cbc73.jpeg	Variant	251	2017-10-15 12:23:14.664441	2017-10-15 12:23:51.238506	767a7b05-ddfe-42a5-a183-6964aa4cbc73	4
1283	fc481fe0-cd1c-4d06-90f5-9db966433f41.jpeg	Variant	252	2017-10-15 12:25:04.311727	2017-10-15 12:25:21.543397	fc481fe0-cd1c-4d06-90f5-9db966433f41	1
1284	ac534c1f-b067-4cd5-afe9-aa23c56e0215.jpeg	Variant	252	2017-10-15 12:25:10.243126	2017-10-15 12:25:24.469373	ac534c1f-b067-4cd5-afe9-aa23c56e0215	2
1282	0c77ab7b-dc50-4ab1-ae8c-b63630a86358.jpeg	Variant	252	2017-10-15 12:25:00.701461	2017-10-15 12:25:28.255909	0c77ab7b-dc50-4ab1-ae8c-b63630a86358	3
1289	acf877ed-5292-4a35-b006-c097d1ec74e5.jpeg	Variant	253	2017-10-15 12:30:32.16667	2017-10-15 12:30:32.16667	acf877ed-5292-4a35-b006-c097d1ec74e5	0
1290	fb939287-8762-4c43-b230-a922f020482d.jpeg	Variant	253	2017-10-15 12:30:35.385909	2017-10-15 12:30:35.385909	fb939287-8762-4c43-b230-a922f020482d	0
1291	b5d8907b-f232-40e0-9549-9f0007be2830.jpeg	Variant	253	2017-10-15 12:30:38.680048	2017-10-15 12:30:38.680048	b5d8907b-f232-40e0-9549-9f0007be2830	0
1292	9e75a01a-a8f5-47c6-9562-53b206da9c9f.jpeg	Variant	253	2017-10-15 12:30:41.733385	2017-10-15 12:30:41.733385	9e75a01a-a8f5-47c6-9562-53b206da9c9f	0
1296	16ebdcb0-e25a-46c2-bf8f-d9e4646eeef7.jpeg	Variant	255	2017-10-15 12:34:42.795287	2017-10-15 12:35:07.952468	16ebdcb0-e25a-46c2-bf8f-d9e4646eeef7	1
1293	24520538-c5d8-4a80-9612-8c3597674c0b.jpeg	Variant	255	2017-10-15 12:34:16.241908	2017-10-15 12:35:10.950347	24520538-c5d8-4a80-9612-8c3597674c0b	2
1294	5e20627c-90f4-44ad-bad4-28db3b4cffa1.jpeg	Variant	255	2017-10-15 12:34:19.784219	2017-10-15 12:35:14.830644	5e20627c-90f4-44ad-bad4-28db3b4cffa1	3
1297	4b52ad7d-e10a-40f0-a694-ef37648f4a7b.jpeg	Variant	255	2017-10-15 12:34:57.720771	2017-10-15 12:35:17.264567	4b52ad7d-e10a-40f0-a694-ef37648f4a7b	4
1300	b1d720cb-60c4-4a17-82f3-cae38921f92e.jpeg	Variant	257	2017-10-15 12:37:42.684104	2017-10-15 12:38:10.969592	b1d720cb-60c4-4a17-82f3-cae38921f92e	1
1299	f2bc4f6f-81d3-42c3-ae75-10078dd28d1a.jpeg	Variant	257	2017-10-15 12:37:18.629292	2017-10-15 12:38:14.100752	f2bc4f6f-81d3-42c3-ae75-10078dd28d1a	2
1298	226aa23b-7166-4f05-a4c5-ef88c4f05cb6.jpeg	Variant	257	2017-10-15 12:37:15.34705	2017-10-15 12:38:17.753056	226aa23b-7166-4f05-a4c5-ef88c4f05cb6	3
1301	09c1efbd-cd3a-409e-9ea2-971451a9f503.jpeg	Variant	257	2017-10-15 12:37:46.469245	2017-10-15 12:38:21.444295	09c1efbd-cd3a-409e-9ea2-971451a9f503	4
1302	eae83633-a58e-4a5b-b887-819d9af0243c.jpeg	Variant	249	2017-10-15 12:41:28.097034	2017-10-15 12:42:07.9057	eae83633-a58e-4a5b-b887-819d9af0243c	4
1304	63dea0e8-1ff8-4f63-bb2a-e95da12f3bf1.jpeg	Variant	249	2017-10-15 12:41:34.792159	2017-10-15 12:42:11.691691	63dea0e8-1ff8-4f63-bb2a-e95da12f3bf1	5
1267	ec9b6c60-e933-4c51-be7d-5e6047636c0b.jpeg	Variant	248	2017-10-15 11:49:22.7347	2017-10-15 12:47:09.617272	ec9b6c60-e933-4c51-be7d-5e6047636c0b	3
1305	6234a0f8-eabc-49bb-b932-678ff42eebf6.jpeg	Variant	249	2017-10-15 12:41:38.026361	2017-10-15 12:42:02.660459	6234a0f8-eabc-49bb-b932-678ff42eebf6	3
1309	7975cfcf-69ec-4599-9426-16b12c76eaff.jpeg	Variant	254	2017-10-15 12:42:46.838613	2017-10-15 12:42:57.766119	7975cfcf-69ec-4599-9426-16b12c76eaff	1
1307	749d63c9-4148-4ed7-a2c1-7de5b68b91ac.jpeg	Variant	254	2017-10-15 12:42:39.902411	2017-10-15 12:43:01.080992	749d63c9-4148-4ed7-a2c1-7de5b68b91ac	2
1308	8a45496e-9cf4-4fb0-a2ce-a68fe3b0381a.jpeg	Variant	254	2017-10-15 12:42:43.41394	2017-10-15 12:43:04.873215	8a45496e-9cf4-4fb0-a2ce-a68fe3b0381a	3
1303	4d5689a5-770c-4466-a69d-e983b25425e2.jpeg	Variant	249	2017-10-15 12:41:31.437916	2017-10-15 12:43:43.292408	4d5689a5-770c-4466-a69d-e983b25425e2	1
1306	2d729d60-dad7-4c79-8d19-c1228673ef6e.jpeg	Variant	249	2017-10-15 12:41:41.071735	2017-10-15 12:43:47.023212	2d729d60-dad7-4c79-8d19-c1228673ef6e	2
1310	11fa3257-b6ad-46aa-8233-f84a4857e2ad.jpeg	Variant	258	2017-10-15 12:49:08.917421	2017-10-15 12:49:34.846403	11fa3257-b6ad-46aa-8233-f84a4857e2ad	1
1312	6987c1ff-c48d-4603-a6eb-f21b26055c45.jpeg	Variant	258	2017-10-15 12:49:15.276274	2017-10-15 12:49:37.637621	6987c1ff-c48d-4603-a6eb-f21b26055c45	2
1311	726018bd-f09a-47cb-a719-1d0f4e49aa29.jpeg	Variant	258	2017-10-15 12:49:12.000569	2017-10-15 12:49:40.640852	726018bd-f09a-47cb-a719-1d0f4e49aa29	3
1313	2ef5834b-1ff8-48d2-8b87-cf1abbc843df.jpeg	Variant	258	2017-10-15 12:49:19.256108	2017-10-15 12:49:43.837318	2ef5834b-1ff8-48d2-8b87-cf1abbc843df	4
1315	981b3ec0-ee1c-4164-b1a3-b94409fc9c7e.jpeg	Variant	259	2017-10-15 14:11:26.489272	2017-10-15 14:11:55.867374	981b3ec0-ee1c-4164-b1a3-b94409fc9c7e	1
1314	a7142044-f325-4124-9614-b4830fc9a6d4.jpeg	Variant	259	2017-10-15 14:11:22.689165	2017-10-15 14:11:59.90497	a7142044-f325-4124-9614-b4830fc9a6d4	2
1317	f35e3a47-66a9-4405-87bb-4902580138b3.jpeg	Variant	259	2017-10-15 14:11:33.477519	2017-10-15 14:12:04.334563	f35e3a47-66a9-4405-87bb-4902580138b3	3
1316	2cecd310-6988-4143-906d-fee3b0fe2ffa.jpeg	Variant	259	2017-10-15 14:11:30.221628	2017-10-15 14:12:08.132755	2cecd310-6988-4143-906d-fee3b0fe2ffa	4
1318	6ad3d7cd-31f9-44ff-8ff5-0bf70e39be6f.jpeg	Variant	264	2017-10-15 14:15:06.253597	2017-10-15 14:15:06.253597	6ad3d7cd-31f9-44ff-8ff5-0bf70e39be6f	0
1320	79958d60-8fbf-4b31-9da5-ba6ad8c4ca5a.jpeg	Variant	264	2017-10-15 14:15:12.641499	2017-10-15 14:15:12.641499	79958d60-8fbf-4b31-9da5-ba6ad8c4ca5a	0
1321	60a294f6-1c56-4e6b-9240-dcef05c01634.jpeg	Variant	264	2017-10-15 14:15:36.420104	2017-10-15 14:15:36.420104	60a294f6-1c56-4e6b-9240-dcef05c01634	0
1322	f92f2856-0425-4a5a-bc00-c2792018933c.jpeg	Variant	264	2017-10-15 14:16:15.216753	2017-10-15 14:16:15.216753	f92f2856-0425-4a5a-bc00-c2792018933c	0
1319	8bddd2dc-de1d-460d-9cb5-0e7d741490e7.jpeg	Variant	264	2017-10-15 14:15:09.411388	2017-10-15 14:16:26.321581	8bddd2dc-de1d-460d-9cb5-0e7d741490e7	\N
1325	a2cfbaad-717a-4387-9191-5f3559a4e638.jpeg	Variant	263	2017-10-15 14:26:43.276977	2017-10-15 14:27:02.5759	a2cfbaad-717a-4387-9191-5f3559a4e638	1
1326	8c6504cd-2c79-49b9-8aac-85798bffca7c.jpeg	Variant	263	2017-10-15 14:26:46.532937	2017-10-15 14:27:06.748666	8c6504cd-2c79-49b9-8aac-85798bffca7c	2
1324	422a0ad2-fc2d-4e35-b099-716143a0aaa9.jpeg	Variant	263	2017-10-15 14:26:40.069427	2017-10-15 14:27:11.522319	422a0ad2-fc2d-4e35-b099-716143a0aaa9	3
1327	7b2fce06-28c4-4951-aac4-4e197bfdd7f4.jpeg	Variant	263	2017-10-15 14:26:49.821298	2017-10-15 14:27:15.965987	7b2fce06-28c4-4951-aac4-4e197bfdd7f4	4
1323	1718f9b2-3aa7-493b-824d-d558ad7791b6.jpeg	Variant	263	2017-10-15 14:26:36.64445	2017-10-15 14:27:19.892361	1718f9b2-3aa7-493b-824d-d558ad7791b6	5
1329	d07d4f48-7f5e-4e6d-bcae-d55004d03c12.jpeg	Variant	262	2017-10-15 14:28:48.117005	2017-10-15 14:29:07.050909	d07d4f48-7f5e-4e6d-bcae-d55004d03c12	1
1331	2c2f6d07-a76c-499c-929e-469447398756.jpeg	Variant	262	2017-10-15 14:28:54.873129	2017-10-15 14:29:19.185299	2c2f6d07-a76c-499c-929e-469447398756	2
1328	d6a54f78-33c9-49a3-a116-c4e900d570b5.jpeg	Variant	262	2017-10-15 14:28:44.913417	2017-10-15 14:29:23.911574	d6a54f78-33c9-49a3-a116-c4e900d570b5	3
1330	2dfbdb08-0b45-40da-91da-aef13ec386c4.jpeg	Variant	262	2017-10-15 14:28:51.650939	2017-10-15 14:29:27.965252	2dfbdb08-0b45-40da-91da-aef13ec386c4	4
1332	572327b3-bc0a-45a7-a292-d84864952348.jpeg	Variant	261	2017-10-15 14:32:33.474086	2017-10-15 14:32:33.474086	572327b3-bc0a-45a7-a292-d84864952348	0
1333	eac4b10c-e87d-4813-835b-b4a3c70d4360.jpeg	Variant	261	2017-10-15 14:32:37.002614	2017-10-15 14:32:37.002614	eac4b10c-e87d-4813-835b-b4a3c70d4360	0
1334	647398d3-9461-437b-ad9e-f409b670bf8f.jpeg	Variant	261	2017-10-15 14:32:40.613602	2017-10-15 14:32:40.613602	647398d3-9461-437b-ad9e-f409b670bf8f	0
1335	2adcde5e-353e-49c8-a676-61afc7eea0f2.jpeg	Variant	261	2017-10-15 14:34:09.193216	2017-10-15 14:34:09.193216	2adcde5e-353e-49c8-a676-61afc7eea0f2	0
1338	1d92310c-e7b0-4b6e-a79f-e66fcda23408.jpeg	Variant	260	2017-10-15 14:37:23.061657	2017-10-15 14:37:34.078856	1d92310c-e7b0-4b6e-a79f-e66fcda23408	1
1337	e188adb9-fe02-4df9-adcf-861a61d871b9.jpeg	Variant	260	2017-10-15 14:37:19.72194	2017-10-15 14:37:37.113435	e188adb9-fe02-4df9-adcf-861a61d871b9	2
1336	a7e95a6c-c56e-4863-9ca4-195d9937d167.jpeg	Variant	260	2017-10-15 14:37:16.559543	2017-10-15 14:37:41.186147	a7e95a6c-c56e-4863-9ca4-195d9937d167	3
1339	4b3f8426-6512-47c2-a9d4-5fcf8c092683.JPG	Variant	265	2017-10-16 12:47:58.427303	2017-10-16 12:47:58.427303	4b3f8426-6512-47c2-a9d4-5fcf8c092683	0
1340	0690cd29-cf17-44b1-8358-ee893b2f4419.JPG	Variant	265	2017-10-16 12:48:10.653945	2017-10-16 12:48:10.653945	0690cd29-cf17-44b1-8358-ee893b2f4419	0
1341	20d2e81f-a613-4012-a5cd-8536d4c19838.jpg	Variant	265	2017-10-16 12:48:23.132825	2017-10-16 12:48:23.132825	20d2e81f-a613-4012-a5cd-8536d4c19838	0
1342	6391a050-4410-4827-b963-1ad3751179dd.JPG	Variant	265	2017-10-16 12:48:46.981448	2017-10-16 12:48:46.981448	6391a050-4410-4827-b963-1ad3751179dd	0
1343	b0928f69-d447-4c14-ae1d-1fa932dc315c.JPG	Variant	266	2017-10-16 12:51:45.220743	2017-10-16 12:51:45.220743	b0928f69-d447-4c14-ae1d-1fa932dc315c	0
1344	683d9698-9709-4ea2-ba15-d2119e084ec6.JPG	Variant	266	2017-10-16 12:52:00.06412	2017-10-16 12:52:00.06412	683d9698-9709-4ea2-ba15-d2119e084ec6	0
1345	631371c1-d00c-4cf6-9dee-cd1d6fbd2053.JPG	Variant	267	2017-10-16 13:01:34.78681	2017-10-16 13:01:34.78681	631371c1-d00c-4cf6-9dee-cd1d6fbd2053	0
1346	979b0a5d-c400-4bf0-ae5a-76f5f35db292.JPG	Variant	267	2017-10-16 13:01:47.007962	2017-10-16 13:01:47.007962	979b0a5d-c400-4bf0-ae5a-76f5f35db292	0
1347	328b1155-ff59-408c-bb0d-bd0e30bd6f96.JPG	Variant	268	2017-10-16 13:08:29.415554	2017-10-16 13:08:29.415554	328b1155-ff59-408c-bb0d-bd0e30bd6f96	0
1348	8897b55f-52a1-465c-afbc-6555afd5031b.JPG	Variant	268	2017-10-16 13:08:56.086061	2017-10-16 13:08:56.086061	8897b55f-52a1-465c-afbc-6555afd5031b	0
1349	f708ed2c-71a2-4746-9453-d339dbbf5344.JPG	Variant	268	2017-10-16 13:09:29.290861	2017-10-16 13:09:29.290861	f708ed2c-71a2-4746-9453-d339dbbf5344	0
1350	8b5cf1b8-761c-4b63-a028-1ee8b5b379ce.JPG	Variant	269	2017-10-16 13:12:06.497062	2017-10-16 13:12:06.497062	8b5cf1b8-761c-4b63-a028-1ee8b5b379ce	0
1351	a94416e7-98d0-4982-b05c-ff31b98833d6.JPG	Variant	269	2017-10-16 13:12:19.535759	2017-10-16 13:12:19.535759	a94416e7-98d0-4982-b05c-ff31b98833d6	0
1352	1df3cf95-d759-45e1-98cb-2c94d0483113.JPG	Variant	270	2017-10-16 13:16:28.591259	2017-10-16 13:16:28.591259	1df3cf95-d759-45e1-98cb-2c94d0483113	0
1353	1c9a4843-feb0-40e6-99f5-cea225cda6ef.JPG	Variant	270	2017-10-16 13:16:46.076407	2017-10-16 13:16:46.076407	1c9a4843-feb0-40e6-99f5-cea225cda6ef	0
1354	00a5ee95-2606-4791-a7e8-3b18c2ec2250.JPG	Variant	270	2017-10-16 13:17:15.737215	2017-10-16 13:17:15.737215	00a5ee95-2606-4791-a7e8-3b18c2ec2250	0
1355	08449c74-3657-4751-9ebd-f63a5cab487a.JPG	Variant	270	2017-10-16 13:18:41.114928	2017-10-16 13:18:41.114928	08449c74-3657-4751-9ebd-f63a5cab487a	0
1356	4251d6d2-1179-4140-ba90-c16d0d85f367.JPG	Variant	271	2017-10-16 13:27:59.490131	2017-10-16 13:27:59.490131	4251d6d2-1179-4140-ba90-c16d0d85f367	0
1357	6aded8e5-0208-4137-8b2a-9c1f0d782d79.JPG	Variant	271	2017-10-16 13:28:32.364106	2017-10-16 13:28:32.364106	6aded8e5-0208-4137-8b2a-9c1f0d782d79	0
1358	70dd8551-4f8e-4f4c-bca2-7b82932ba52d.JPG	Variant	271	2017-10-16 13:29:35.608106	2017-10-16 13:29:35.608106	70dd8551-4f8e-4f4c-bca2-7b82932ba52d	0
1359	fbf0969b-f867-4cbb-9bf2-54a942ca54af.JPG	Variant	272	2017-10-16 13:33:18.378229	2017-10-16 13:33:18.378229	fbf0969b-f867-4cbb-9bf2-54a942ca54af	0
1360	5f95ab51-e466-4529-909b-b0d9bc0ab045.JPG	Variant	272	2017-10-16 13:33:56.698031	2017-10-16 13:33:56.698031	5f95ab51-e466-4529-909b-b0d9bc0ab045	0
1365	409439ea-8941-4385-b41c-96add52fd3b5.JPG	Variant	273	2017-10-16 13:40:58.204729	2017-10-16 13:41:43.223656	409439ea-8941-4385-b41c-96add52fd3b5	1
1366	4e635c99-b950-46a5-93cc-70e3da6d285d.JPG	Variant	273	2017-10-16 13:41:30.060169	2017-10-16 13:41:45.235576	4e635c99-b950-46a5-93cc-70e3da6d285d	2
1364	eda11598-37fd-4667-a4a4-9db3b10a35b7.JPG	Variant	273	2017-10-16 13:39:01.100706	2017-10-16 13:41:46.735063	eda11598-37fd-4667-a4a4-9db3b10a35b7	3
1367	442d2833-6534-47f5-9248-121ba3bc977e.JPG	Variant	274	2017-10-16 13:43:59.1477	2017-10-16 13:43:59.1477	442d2833-6534-47f5-9248-121ba3bc977e	0
1368	7d094302-5c19-4e09-9f6d-215a3eb695c7.JPG	Variant	274	2017-10-16 13:44:39.518408	2017-10-16 13:44:39.518408	7d094302-5c19-4e09-9f6d-215a3eb695c7	0
1369	4c05af6b-b9c6-4874-af84-9fa9dce3e9ac.JPG	Variant	274	2017-10-16 13:44:58.007082	2017-10-16 13:44:58.007082	4c05af6b-b9c6-4874-af84-9fa9dce3e9ac	0
1370	710a4910-ce50-4177-8573-6ae7ab46caea.JPG	Variant	274	2017-10-16 13:49:49.904874	2017-10-16 13:49:49.904874	710a4910-ce50-4177-8573-6ae7ab46caea	0
1371	84f94f8a-be36-4dea-82fc-ea00e8a59211.JPG	Variant	275	2017-10-16 13:52:01.15019	2017-10-16 13:52:01.15019	84f94f8a-be36-4dea-82fc-ea00e8a59211	0
1372	7ae337f1-de7b-4e5b-8987-7107dfc44590.JPG	Variant	275	2017-10-16 13:52:37.100663	2017-10-16 13:52:37.100663	7ae337f1-de7b-4e5b-8987-7107dfc44590	0
1373	9400bb06-44d4-4264-9f9c-6cbf60e3e401.JPG	Variant	275	2017-10-16 13:53:42.402894	2017-10-16 13:53:42.402894	9400bb06-44d4-4264-9f9c-6cbf60e3e401	0
1374	75ee4658-ef5b-4f01-b6d8-502358fe12f5.JPG	Variant	276	2017-10-16 13:55:17.110416	2017-10-16 13:55:17.110416	75ee4658-ef5b-4f01-b6d8-502358fe12f5	0
1375	4eb94b7e-5b67-4b68-8d7e-e96a86ea050c.JPG	Variant	276	2017-10-16 13:55:51.984269	2017-10-16 13:55:51.984269	4eb94b7e-5b67-4b68-8d7e-e96a86ea050c	0
1377	5ce3cc6c-89b0-4762-b714-94e1f531f2b9.JPG	Variant	278	2017-10-16 14:04:24.369977	2017-10-16 14:04:24.369977	5ce3cc6c-89b0-4762-b714-94e1f531f2b9	0
1378	d21af84e-52b6-4a4c-a6d5-346e80ed3711.JPG	Variant	278	2017-10-16 14:05:50.217201	2017-10-16 14:05:50.217201	d21af84e-52b6-4a4c-a6d5-346e80ed3711	0
1379	5bc96386-d4dc-4e41-928a-2011311c5ac5.JPG	Variant	278	2017-10-16 14:06:08.181515	2017-10-16 14:06:08.181515	5bc96386-d4dc-4e41-928a-2011311c5ac5	0
1380	a1cbe5b8-a866-4bf1-be20-934053a56629.JPG	Variant	279	2017-10-16 14:15:20.36047	2017-10-16 14:15:20.36047	a1cbe5b8-a866-4bf1-be20-934053a56629	0
1381	effb0466-d892-40cf-bde8-58ae939333b8.JPG	Variant	279	2017-10-16 14:24:31.556551	2017-10-16 14:24:31.556551	effb0466-d892-40cf-bde8-58ae939333b8	0
1382	52469586-fe2f-43fe-8679-5558f18d4bdc.JPG	Variant	279	2017-10-16 14:25:13.202825	2017-10-16 14:25:13.202825	52469586-fe2f-43fe-8679-5558f18d4bdc	0
1383	499806a6-85c4-4c23-bce6-18ff655617ca.JPG	Variant	280	2017-10-16 14:31:19.91023	2017-10-16 14:31:19.91023	499806a6-85c4-4c23-bce6-18ff655617ca	0
1384	8365ddf3-6427-401f-9b83-26e913b43046.JPG	Variant	280	2017-10-16 14:31:56.643198	2017-10-16 14:31:56.643198	8365ddf3-6427-401f-9b83-26e913b43046	0
1385	832f98bb-bbb1-4532-a426-eb5aaaa01bd5.JPG	Variant	280	2017-10-16 14:32:32.3681	2017-10-16 14:32:32.3681	832f98bb-bbb1-4532-a426-eb5aaaa01bd5	0
1392	9867bd38-b81e-4e2f-95e0-8aa17c638e9f.JPG	Variant	269	2017-10-17 07:13:06.829462	2017-10-17 07:13:06.829462	9867bd38-b81e-4e2f-95e0-8aa17c638e9f	0
1387	26fa4402-02c0-4a5e-9fda-6bf5a216fe54.JPG	Variant	239	2017-10-17 07:03:54.499738	2017-10-17 07:04:19.209654	26fa4402-02c0-4a5e-9fda-6bf5a216fe54	3
1388	77459559-19cc-4b7f-97f1-b751f3723163.JPG	Variant	243	2017-10-17 07:05:37.770691	2017-10-17 07:05:49.773947	77459559-19cc-4b7f-97f1-b751f3723163	4
1389	0d70b62b-48d6-413c-93b9-e5e72106472e.JPG	Variant	246	2017-10-17 07:06:45.511046	2017-10-17 07:06:45.511046	0d70b62b-48d6-413c-93b9-e5e72106472e	0
1390	cec78ddf-4bea-4799-a652-8e042ba613da.JPG	Variant	266	2017-10-17 07:10:31.512195	2017-10-17 07:10:31.512195	cec78ddf-4bea-4799-a652-8e042ba613da	0
1391	32a95217-10fc-42d5-962a-da7783f94947.JPG	Variant	267	2017-10-17 07:11:27.10941	2017-10-17 07:11:27.10941	32a95217-10fc-42d5-962a-da7783f94947	0
1393	d43d43f0-5e3b-4ab6-b196-acffd6ecab14.JPG	Variant	272	2017-10-17 07:14:26.964176	2017-10-17 07:14:26.964176	d43d43f0-5e3b-4ab6-b196-acffd6ecab14	0
1394	8a6d53bf-c520-4eda-b158-f0086f336121.JPG	Variant	277	2017-10-17 07:16:58.100768	2017-10-17 07:23:21.354365	8a6d53bf-c520-4eda-b158-f0086f336121	1
1376	c8add9b2-3a49-4be8-9c63-ebd97370d0f4.JPG	Variant	277	2017-10-16 14:02:25.110539	2017-10-17 07:23:21.373721	c8add9b2-3a49-4be8-9c63-ebd97370d0f4	2
1395	becaa808-b72c-4cde-af0e-b09b36892532.JPG	Variant	277	2017-10-17 07:17:05.556247	2017-10-17 07:23:24.718518	becaa808-b72c-4cde-af0e-b09b36892532	3
1396	fcfb66c5-df53-4ea3-946e-74d0ec71da70.JPG	Variant	278	2017-10-17 07:24:10.738073	2017-10-17 07:24:10.738073	fcfb66c5-df53-4ea3-946e-74d0ec71da70	0
1397	46569906-239f-4234-882b-930f70fa06f2.JPG	Variant	245	2017-10-17 07:26:47.430965	2017-10-17 07:27:12.500414	46569906-239f-4234-882b-930f70fa06f2	1
1386	2a94ff5a-cbbe-4846-8cd6-3b56c73e1bf4.JPG	Variant	245	2017-10-16 15:19:42.09458	2017-10-17 07:27:14.588381	2a94ff5a-cbbe-4846-8cd6-3b56c73e1bf4	2
1398	2246215b-b819-43e1-a898-587defce7bdb.JPG	Variant	245	2017-10-17 07:26:56.342103	2017-10-17 07:27:16.563977	2246215b-b819-43e1-a898-587defce7bdb	3
1399	eb4dd3ee-f37e-4111-9791-eb6635ff728e.jpeg	Variant	281	2017-10-17 14:46:24.266917	2017-10-17 14:48:08.366098	eb4dd3ee-f37e-4111-9791-eb6635ff728e	1
1401	d77f8e9b-fe72-4df3-a28a-501aaba6f186.jpeg	Variant	281	2017-10-17 14:46:36.89921	2017-10-17 14:48:19.345589	d77f8e9b-fe72-4df3-a28a-501aaba6f186	3
1404	20d2a3dd-93bd-4b77-8c03-acc3e0c8dcb0.jpeg	Variant	281	2017-10-17 14:47:22.275371	2017-10-17 14:48:21.535619	20d2a3dd-93bd-4b77-8c03-acc3e0c8dcb0	4
1405	12306445-a8a3-45a7-9b9d-b4a9a6bb3c50.jpeg	Variant	281	2017-10-17 14:47:33.019893	2017-10-17 14:48:27.838952	12306445-a8a3-45a7-9b9d-b4a9a6bb3c50	5
1406	b89544c3-0ea6-4932-a8ed-fd8309ef5dca.jpeg	Variant	282	2017-10-17 14:50:28.327943	2017-10-17 14:50:28.327943	b89544c3-0ea6-4932-a8ed-fd8309ef5dca	0
1407	d2e99854-c1f8-4516-ab0c-1705c8e1b995.jpeg	Variant	282	2017-10-17 14:50:30.699971	2017-10-17 14:50:30.699971	d2e99854-c1f8-4516-ab0c-1705c8e1b995	0
1408	283de850-391d-4eca-8794-84e4b2285e2a.jpeg	Variant	282	2017-10-17 14:50:33.176405	2017-10-17 14:50:33.176405	283de850-391d-4eca-8794-84e4b2285e2a	0
1409	d37c321c-00ac-4b0c-86e2-03b315b76a19.jpeg	Variant	282	2017-10-17 14:50:35.705595	2017-10-17 14:50:35.705595	d37c321c-00ac-4b0c-86e2-03b315b76a19	0
1410	25282148-43cf-42d9-8828-90f9240a0f00.JPG	Variant	283	2017-10-17 14:54:24.178396	2017-10-17 14:54:24.178396	25282148-43cf-42d9-8828-90f9240a0f00	0
1411	a23b8e6a-c8fc-48cc-8e2f-35306a8830e5.JPG	Variant	283	2017-10-17 14:54:51.736727	2017-10-17 14:54:51.736727	a23b8e6a-c8fc-48cc-8e2f-35306a8830e5	0
1412	6891b5c0-f839-4d6a-bc73-9c3b1d301741.jpg	Variant	284	2017-10-19 14:11:36.120132	2017-10-19 14:11:36.120132	6891b5c0-f839-4d6a-bc73-9c3b1d301741	0
1413	43958a7d-5241-46a7-a8cd-e63b3f60d684.jpg	Variant	284	2017-10-19 14:12:42.096959	2017-10-19 14:12:42.096959	43958a7d-5241-46a7-a8cd-e63b3f60d684	0
1414	d6db6716-368d-4a15-8a74-2a81694a4595.jpg	Variant	284	2017-10-19 14:17:43.766367	2017-10-19 14:17:43.766367	d6db6716-368d-4a15-8a74-2a81694a4595	0
1417	46f49043-ca8a-4ed1-b70e-b79e3b92cd7b.jpg	Variant	286	2017-10-19 14:22:37.718185	2017-10-19 14:22:37.718185	46f49043-ca8a-4ed1-b70e-b79e3b92cd7b	0
1419	410783bd-38a0-4d24-b7fe-ddf747453750.jpg	Variant	286	2017-10-19 14:24:51.662506	2017-10-19 14:24:51.662506	410783bd-38a0-4d24-b7fe-ddf747453750	0
1420	8b5872a5-190c-473f-93ee-6959d9650c45.jpg	Variant	286	2017-10-19 14:25:18.961097	2017-10-19 14:25:18.961097	8b5872a5-190c-473f-93ee-6959d9650c45	0
1421	778c70cf-484c-4ab1-88af-04d2ab1939f4.jpg	Variant	286	2017-10-19 14:25:52.149997	2017-10-19 14:25:52.149997	778c70cf-484c-4ab1-88af-04d2ab1939f4	0
1425	0faa9ef1-3d86-4c43-a5eb-ae9731634674.jpg	Variant	295	2017-10-19 14:35:44.4702	2017-10-19 14:35:44.4702	0faa9ef1-3d86-4c43-a5eb-ae9731634674	0
1426	5f932042-4c34-4b08-86b3-114a8229528b.jpg	Variant	295	2017-10-19 14:36:13.780713	2017-10-19 14:36:13.780713	5f932042-4c34-4b08-86b3-114a8229528b	0
1427	2fbbb988-4c6b-4883-8e6f-9caa746f04b1.jpg	Variant	295	2017-10-19 14:36:48.007454	2017-10-19 14:36:48.007454	2fbbb988-4c6b-4883-8e6f-9caa746f04b1	0
1428	382b4b42-bdd4-4295-bcfd-6d25a92de46d.jpg	Variant	295	2017-10-19 14:39:40.174031	2017-10-19 14:39:40.174031	382b4b42-bdd4-4295-bcfd-6d25a92de46d	0
1429	12035eac-a6d5-4026-8911-ed64d2c329bc.jpg	Variant	294	2017-10-19 14:51:53.706525	2017-10-19 14:51:53.706525	12035eac-a6d5-4026-8911-ed64d2c329bc	0
1430	4d8bdcc5-40c7-46fe-bc53-c311856f1a5d.jpg	Variant	294	2017-10-19 14:52:38.799397	2017-10-19 14:52:38.799397	4d8bdcc5-40c7-46fe-bc53-c311856f1a5d	0
1431	0c1f9fac-6d32-442f-b646-392c0b7d1455.jpg	Variant	294	2017-10-19 14:53:11.700088	2017-10-19 14:53:11.700088	0c1f9fac-6d32-442f-b646-392c0b7d1455	0
1439	abac03ae-34be-4ad9-a857-97a0b6322a38.jpg	Variant	296	2017-10-19 15:02:16.536216	2017-10-19 15:03:03.535534	abac03ae-34be-4ad9-a857-97a0b6322a38	1
1437	88d369ea-f0c5-4942-a4b8-7650bad6dcf1.jpg	Variant	296	2017-10-19 15:00:11.249313	2017-10-19 15:03:04.955883	88d369ea-f0c5-4942-a4b8-7650bad6dcf1	2
1438	777210b7-4b46-4662-b377-f9452ca0efee.jpg	Variant	296	2017-10-19 15:00:38.308233	2017-10-19 15:03:06.786301	777210b7-4b46-4662-b377-f9452ca0efee	3
1440	fbffcd11-7735-455d-9358-8fb1bcfb6770.jpg	Variant	296	2017-10-19 15:02:45.649924	2017-10-19 15:03:09.674206	fbffcd11-7735-455d-9358-8fb1bcfb6770	4
1441	042c5fbc-820b-4717-b8e0-ebd8a191ab2a.jpg	Variant	294	2017-10-19 15:06:59.655857	2017-10-19 15:06:59.655857	042c5fbc-820b-4717-b8e0-ebd8a191ab2a	0
1442	ec243856-677e-47d8-b491-fdfa92851c9a.jpeg	Variant	291	2017-10-19 20:20:33.805548	2017-10-19 20:28:38.724562	ec243856-677e-47d8-b491-fdfa92851c9a	1
1443	7b1f0637-0d60-42cc-b3ce-abe2bfe1e59b.jpeg	Variant	291	2017-10-19 20:20:40.378582	2017-10-19 20:28:41.853537	7b1f0637-0d60-42cc-b3ce-abe2bfe1e59b	2
1444	ff695d76-6496-4e98-944c-5ef5a0a9ab45.jpeg	Variant	291	2017-10-19 20:28:22.294726	2017-10-19 20:28:44.870759	ff695d76-6496-4e98-944c-5ef5a0a9ab45	3
1445	a8532b8e-b937-4924-80b0-54c106be82bf.jpeg	Variant	291	2017-10-19 20:28:29.231981	2017-10-19 20:29:08.092288	a8532b8e-b937-4924-80b0-54c106be82bf	4
1448	f19062b8-9b6c-4bc6-9e73-541d46cdfa3b.jpeg	Variant	289	2017-10-19 20:30:52.163492	2017-10-19 21:10:29.819893	f19062b8-9b6c-4bc6-9e73-541d46cdfa3b	1
1423	51f5b733-4ccb-4ceb-99a5-fe60af12dd1d.jpg	Variant	218	2017-10-19 14:30:55.118689	2017-10-20 06:36:06.419007	51f5b733-4ccb-4ceb-99a5-fe60af12dd1d	1
1447	f018e6d8-8978-43ce-a1f6-cdb377ed82a4.jpeg	Variant	289	2017-10-19 20:30:45.148346	2017-10-19 20:31:13.310912	f018e6d8-8978-43ce-a1f6-cdb377ed82a4	3
1446	6d6ae42d-2477-44a5-8c40-ed850bf11a6c.jpeg	Variant	289	2017-10-19 20:30:20.626352	2017-10-19 21:10:26.176865	6d6ae42d-2477-44a5-8c40-ed850bf11a6c	2
1450	ad8b6807-2216-419c-99e5-434c91274d1b.jpeg	Variant	290	2017-10-19 20:31:52.904149	2017-10-19 20:41:29.370284	ad8b6807-2216-419c-99e5-434c91274d1b	2
1451	4034cdf6-55d4-4da8-9604-b1f6c1f4eb13.jpeg	Variant	290	2017-10-19 20:31:59.613507	2017-10-19 20:32:35.453861	4034cdf6-55d4-4da8-9604-b1f6c1f4eb13	3
1452	45a6623b-2d35-4686-861e-43693a7f3d99.jpeg	Variant	290	2017-10-19 20:32:08.168775	2017-10-19 20:32:48.210729	45a6623b-2d35-4686-861e-43693a7f3d99	4
1453	569b4836-0cdf-4533-87b5-8fe95cec0637.jpeg	Variant	292	2017-10-19 20:39:31.629954	2017-10-19 20:39:31.629954	569b4836-0cdf-4533-87b5-8fe95cec0637	0
1454	c26cc0ff-f3b8-4d18-ab9b-6036ed744a0b.jpeg	Variant	292	2017-10-19 20:39:38.46405	2017-10-19 20:39:38.46405	c26cc0ff-f3b8-4d18-ab9b-6036ed744a0b	0
1455	5f0bf253-8fc1-43ac-9573-e2cbf46a8490.jpeg	Variant	292	2017-10-19 20:39:45.210626	2017-10-19 20:39:45.210626	5f0bf253-8fc1-43ac-9573-e2cbf46a8490	0
1456	063aa4cf-18ec-437f-9ef6-87dad5fbe621.jpeg	Variant	292	2017-10-19 20:39:52.869321	2017-10-19 20:39:52.869321	063aa4cf-18ec-437f-9ef6-87dad5fbe621	0
1457	b632a87c-5e3e-4d35-b9f1-6bb06a05630e.jpeg	Variant	292	2017-10-19 20:40:01.319126	2017-10-19 20:40:01.319126	b632a87c-5e3e-4d35-b9f1-6bb06a05630e	0
1422	b51034ee-672f-4d9e-97df-fd9b4181daae.jpg	Variant	218	2017-10-19 14:30:26.883153	2017-10-20 06:36:11.348487	b51034ee-672f-4d9e-97df-fd9b4181daae	2
1424	b1e67f17-c5de-4542-9b35-1cdab30fa1a0.jpg	Variant	218	2017-10-19 14:31:48.038852	2017-10-20 06:36:15.557204	b1e67f17-c5de-4542-9b35-1cdab30fa1a0	3
1418	349e3ce9-8904-45d1-b337-0e00fb8eb2a2.jpg	Variant	285	2017-10-19 14:24:17.145942	2017-10-20 06:58:10.192431	349e3ce9-8904-45d1-b337-0e00fb8eb2a2	1
1415	2dea2c9c-ac51-4be7-8518-cf1d03b2cfa3.jpg	Variant	285	2017-10-19 14:18:00.424459	2017-10-20 06:58:13.057328	2dea2c9c-ac51-4be7-8518-cf1d03b2cfa3	2
1416	bd4bc6ff-084b-4a31-84e7-91dc4147eb85.jpg	Variant	285	2017-10-19 14:22:10.85547	2017-10-20 06:58:19.777825	bd4bc6ff-084b-4a31-84e7-91dc4147eb85	3
1458	375007ac-99bd-4195-adf0-985978518025.jpeg	Variant	292	2017-10-19 20:40:09.343628	2017-10-19 20:40:09.343628	375007ac-99bd-4195-adf0-985978518025	0
1449	5ff02133-623a-4edc-a01d-98dcc96f9272.jpeg	Variant	290	2017-10-19 20:31:46.470967	2017-10-19 20:41:24.209772	5ff02133-623a-4edc-a01d-98dcc96f9272	1
1459	e79b9a1c-4223-429f-a7ba-3c68cb868db2.jpeg	Variant	289	2017-10-19 21:10:05.843821	2017-10-19 21:10:22.784349	e79b9a1c-4223-429f-a7ba-3c68cb868db2	4
1461	d361560d-dea7-48c9-9835-438897826cd9.jpeg	Kit	85	2017-10-20 04:51:56.614169	2017-10-20 04:52:07.004473	d361560d-dea7-48c9-9835-438897826cd9	2
1460	4898afde-7a04-45df-a303-35cd9c0826fe.jpeg	Kit	85	2017-10-20 04:51:46.533105	2017-10-20 04:52:07.00622	4898afde-7a04-45df-a303-35cd9c0826fe	1
1462	40cd8a46-235d-47cf-8bdd-ecbd9508d9eb.jpeg	Kit	86	2017-10-20 04:52:57.397578	2017-10-20 04:53:51.567049	40cd8a46-235d-47cf-8bdd-ecbd9508d9eb	2
1463	7aaa7b5e-a599-493c-b772-c88e5cb784c7.jpeg	Kit	86	2017-10-20 04:53:06.205981	2017-10-20 04:53:51.569595	7aaa7b5e-a599-493c-b772-c88e5cb784c7	1
1464	95c2dee7-698e-4d97-abac-61894e952b93.jpeg	Kit	87	2017-10-20 04:55:58.017892	2017-10-20 04:56:38.522375	95c2dee7-698e-4d97-abac-61894e952b93	0
1465	ef378604-29df-4425-9849-01816f1ad361.jpeg	Kit	87	2017-10-20 04:56:06.4388	2017-10-20 04:56:38.524228	ef378604-29df-4425-9849-01816f1ad361	0
1467	7291b634-9c62-4491-aeef-797b051a424d.jpeg	Kit	88	2017-10-20 05:21:33.327916	2017-10-20 05:22:36.989956	7291b634-9c62-4491-aeef-797b051a424d	1
1468	6682d5fc-0cbe-49d1-a014-c889b1a972fb.jpeg	Kit	89	2017-10-20 05:26:21.49847	2017-10-20 05:26:49.332492	6682d5fc-0cbe-49d1-a014-c889b1a972fb	1
1469	7e62b3a4-1abf-4288-bbde-4def92a72e70.jpeg	Kit	89	2017-10-20 05:26:30.204522	2017-10-20 05:26:49.334716	7e62b3a4-1abf-4288-bbde-4def92a72e70	2
1471	0485783e-3fa4-4db6-a6ee-917478e146ba.JPG	Kit	90	2017-10-20 06:55:37.095524	2017-10-20 06:56:49.658159	0485783e-3fa4-4db6-a6ee-917478e146ba	1
1470	03ce9ed9-092d-4f03-9a94-3f1f349c1466.jpeg	Kit	90	2017-10-20 06:30:23.164914	2017-10-20 06:56:49.660869	03ce9ed9-092d-4f03-9a94-3f1f349c1466	2
1472	ffb4d417-8e4c-486b-916c-c1c2e8ae444d.JPG	Kit	88	2017-10-20 06:57:42.955793	2017-10-20 06:57:42.955793	ffb4d417-8e4c-486b-916c-c1c2e8ae444d	0
1473	d2087e28-f16d-46ea-b4f3-00743461ffa2.jpg	Variant	216	2017-10-20 09:46:15.463159	2017-10-20 09:46:15.463159	d2087e28-f16d-46ea-b4f3-00743461ffa2	0
1474	d5ad95e7-922a-41ba-8865-13c3be56b90d.jpg	Variant	216	2017-10-20 09:48:43.943391	2017-10-20 09:48:43.943391	d5ad95e7-922a-41ba-8865-13c3be56b90d	0
1485	ec595cae-dcc4-4d01-8f98-8525eba3ab5c.jpg	Variant	230	2017-10-20 10:01:20.870994	2017-10-22 10:57:06.327359	ec595cae-dcc4-4d01-8f98-8525eba3ab5c	3
1480	8ef383e8-1d4c-4416-93bb-1dc31ba4889a.jpg	Variant	297	2017-10-20 09:58:23.724643	2017-10-20 09:59:38.769267	8ef383e8-1d4c-4416-93bb-1dc31ba4889a	2
1482	af109ceb-2d8f-4522-94a4-03447bf9ade4.jpg	Variant	297	2017-10-20 09:58:59.611604	2017-10-20 09:59:40.17311	af109ceb-2d8f-4522-94a4-03447bf9ade4	3
1483	4af2a56b-1b32-451f-8189-3e62bc366cc0.jpg	Variant	297	2017-10-20 09:59:15.81853	2017-10-20 09:59:44.596314	4af2a56b-1b32-451f-8189-3e62bc366cc0	4
1488	16ef3f7a-2889-458c-87b5-38bf0c0dcd97.jpg	Variant	298	2017-10-20 10:22:21.975164	2017-10-20 10:22:21.975164	16ef3f7a-2889-458c-87b5-38bf0c0dcd97	0
1489	e06cf4e8-42dd-4f09-ad44-070273b47a20.jpg	Variant	298	2017-10-20 10:22:40.669397	2017-10-20 10:22:40.669397	e06cf4e8-42dd-4f09-ad44-070273b47a20	0
1490	cbde6874-a85d-4065-9c1d-93881df9a41f.jpg	Variant	298	2017-10-20 10:23:06.452837	2017-10-20 10:23:06.452837	cbde6874-a85d-4065-9c1d-93881df9a41f	0
1491	a77187c9-40ca-4d6f-832c-ac3ea0f543bf.jpg	Variant	298	2017-10-20 10:23:36.364416	2017-10-20 10:23:36.364416	a77187c9-40ca-4d6f-832c-ac3ea0f543bf	0
1492	7f9f6431-ee6c-4ced-a396-ec9e95330970.jpg	Variant	299	2017-10-20 10:25:53.783008	2017-10-20 10:25:53.783008	7f9f6431-ee6c-4ced-a396-ec9e95330970	0
1493	1da1275b-a91c-4aa4-a8f8-2ed77b7c1ac0.jpg	Variant	299	2017-10-20 10:26:13.403187	2017-10-20 10:26:13.403187	1da1275b-a91c-4aa4-a8f8-2ed77b7c1ac0	0
1496	e1b97931-424d-4fec-88da-6c7418c3c87d.jpg	Variant	299	2017-10-20 10:27:46.115324	2017-10-20 10:27:46.115324	e1b97931-424d-4fec-88da-6c7418c3c87d	0
1497	1cd11d2d-3eae-485a-8100-b1fc4fa0fb76.jpg	Variant	299	2017-10-20 10:28:12.916211	2017-10-20 10:28:12.916211	1cd11d2d-3eae-485a-8100-b1fc4fa0fb76	0
1478	69d09f64-1c60-40e6-9277-72d058186c9f.jpg	Variant	231	2017-10-20 09:55:11.050865	2017-10-22 10:56:21.393696	69d09f64-1c60-40e6-9277-72d058186c9f	1
1475	778e7062-db72-4f70-ae3f-d8ffc688b8c0.jpg	Variant	231	2017-10-20 09:53:47.765967	2017-10-22 10:56:25.957841	778e7062-db72-4f70-ae3f-d8ffc688b8c0	2
1476	213590b2-eb05-4f39-9567-8db0ba0a1d2d.jpg	Variant	231	2017-10-20 09:54:20.424847	2017-10-22 10:56:28.929838	213590b2-eb05-4f39-9567-8db0ba0a1d2d	3
1477	c6d332c1-f6bc-4b6f-b766-8a24c20009c3.jpg	Variant	231	2017-10-20 09:54:40.016433	2017-10-22 10:56:37.869675	c6d332c1-f6bc-4b6f-b766-8a24c20009c3	4
1481	f3e72e4b-6c4d-441e-a0ed-90de7722dd8a.jpg	Variant	297	2017-10-20 09:58:39.973586	2017-10-22 10:56:45.144653	f3e72e4b-6c4d-441e-a0ed-90de7722dd8a	3
1486	1a46c0ca-2e84-4e99-a3bf-c48c0bad0058.jpg	Variant	230	2017-10-20 10:01:36.751134	2017-10-22 10:57:03.988466	1a46c0ca-2e84-4e99-a3bf-c48c0bad0058	1
1484	4bffc0c2-71d7-453e-851b-d293787f8d37.jpg	Variant	230	2017-10-20 10:00:57.874742	2017-10-22 10:57:17.802226	4bffc0c2-71d7-453e-851b-d293787f8d37	2
1487	d040477f-0aa5-45b0-94a9-4bafd421606f.jpg	Variant	230	2017-10-20 10:02:03.749054	2017-10-22 10:57:25.452819	d040477f-0aa5-45b0-94a9-4bafd421606f	4
1499	516eef52-b676-41d2-9d03-d1f932c2fa77.jpeg	Variant	300	2017-10-22 12:20:43.33266	2017-10-22 12:20:43.33266	516eef52-b676-41d2-9d03-d1f932c2fa77	0
1500	c3cb0955-1919-47a8-a73b-97405d8c8f02.jpg	Variant	301	2017-10-22 13:12:03.752187	2017-10-22 13:12:03.752187	c3cb0955-1919-47a8-a73b-97405d8c8f02	0
1501	544f8aa9-d10a-4515-8b6c-ae4ed85f5fd6.jpg	Variant	302	2017-10-22 13:33:25.923672	2017-10-22 13:33:25.923672	544f8aa9-d10a-4515-8b6c-ae4ed85f5fd6	0
1502	fab87966-37e0-49e6-86c5-e31fa751bd9e.jpg	Variant	303	2017-10-22 13:36:58.513989	2017-10-22 13:36:58.513989	fab87966-37e0-49e6-86c5-e31fa751bd9e	0
1503	a534d6f8-3ecd-401f-bb0e-76703e3ddcbf.jpg	Variant	304	2017-10-22 13:48:08.567495	2017-10-22 13:48:08.567495	a534d6f8-3ecd-401f-bb0e-76703e3ddcbf	0
1504	ed18df17-8e58-4994-a670-f9f235473723.jpg	Variant	305	2017-10-22 14:20:51.931279	2017-10-22 14:20:51.931279	ed18df17-8e58-4994-a670-f9f235473723	0
1505	cabf4d93-f970-44d4-8aeb-fe08465b8de5.jpg	Variant	306	2017-10-22 14:31:52.568423	2017-10-22 14:31:52.568423	cabf4d93-f970-44d4-8aeb-fe08465b8de5	0
1506	887aab1d-931a-435a-a05d-4cd368eb3d82.jpg	Variant	307	2017-10-22 14:38:18.363809	2017-10-22 14:38:18.363809	887aab1d-931a-435a-a05d-4cd368eb3d82	0
1507	a01d7629-a10c-496a-9297-1d5043156056.jpg	Variant	308	2017-10-23 08:57:32.25664	2017-10-23 08:57:32.25664	a01d7629-a10c-496a-9297-1d5043156056	0
1508	3d3e0055-3e41-4d7a-b29d-20ed89b6f1fe.jpg	Variant	309	2017-10-23 09:11:12.131368	2017-10-23 09:11:12.131368	3d3e0055-3e41-4d7a-b29d-20ed89b6f1fe	0
1509	f05038e2-fd19-4992-bab7-e78697c4a609.jpg	Variant	310	2017-10-23 09:14:39.83831	2017-10-23 09:14:39.83831	f05038e2-fd19-4992-bab7-e78697c4a609	0
1510	e1755195-77b4-4979-80ed-5e4008e2735f.jpg	Variant	311	2017-10-23 10:05:38.419189	2017-10-23 10:05:38.419189	e1755195-77b4-4979-80ed-5e4008e2735f	0
1511	17cfe414-0645-4743-82cd-01134a51d442.jpg	Variant	312	2017-10-23 10:10:53.90707	2017-10-23 10:10:53.90707	17cfe414-0645-4743-82cd-01134a51d442	0
1512	2d4b122f-984f-43e3-9ebf-d86663b9eeed.jpg	Variant	313	2017-10-23 10:17:33.949853	2017-10-23 10:17:33.949853	2d4b122f-984f-43e3-9ebf-d86663b9eeed	0
1513	1642a535-fcea-4f65-a85f-dd878f874175.jpg	Variant	314	2017-10-23 10:24:32.604278	2017-10-23 10:24:32.604278	1642a535-fcea-4f65-a85f-dd878f874175	0
1514	a1e6c04d-02bd-487b-a373-3d309f22c50a.jpg	Variant	315	2017-10-23 10:36:01.064914	2017-10-23 10:36:01.064914	a1e6c04d-02bd-487b-a373-3d309f22c50a	0
1515	95f5e9ce-b998-4c0e-92d1-ef45b1fb0359.jpg	Variant	316	2017-10-23 10:39:17.318373	2017-10-23 10:39:17.318373	95f5e9ce-b998-4c0e-92d1-ef45b1fb0359	0
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('images_id_seq', 1515, true);


--
-- Data for Name: kitables; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY kitables (id, kit_id, product_id, variant_id) FROM stdin;
626	75	\N	163
627	75	\N	153
628	75	\N	186
629	73	\N	249
630	73	\N	187
631	73	\N	175
285	56	\N	165
286	56	\N	137
287	56	\N	175
632	66	\N	157
633	66	\N	187
634	66	\N	139
288	55	\N	171
289	55	\N	128
635	66	\N	175
659	89	\N	105
660	89	\N	151
473	69	\N	64
363	18	\N	64
364	18	\N	62
375	45	\N	187
376	45	\N	191
550	74	\N	165
551	74	\N	137
552	74	\N	175
677	33	\N	83
678	33	\N	137
474	69	\N	144
602	81	\N	110
603	81	\N	224
679	80	\N	175
680	80	\N	148
681	79	\N	250
682	79	\N	207
683	79	\N	182
267	62	\N	113
268	62	\N	100
604	84	\N	110
605	84	\N	176
510	59	\N	121
606	84	\N	223
377	45	\N	188
378	43	\N	180
379	43	\N	182
380	41	\N	175
381	41	\N	177
382	41	\N	176
383	41	\N	181
384	60	\N	191
385	60	\N	162
386	60	\N	192
387	50	\N	196
388	50	\N	197
389	49	\N	193
390	49	\N	167
391	49	\N	197
392	46	\N	163
393	46	\N	161
394	46	\N	188
395	42	\N	179
396	42	\N	183
397	31	\N	65
398	31	\N	64
399	31	\N	139
400	28	\N	93
401	28	\N	150
402	28	\N	228
416	54	\N	110
417	54	\N	156
418	53	\N	152
419	53	\N	206
420	53	\N	228
421	37	\N	193
422	37	\N	165
423	37	\N	164
424	36	\N	108
425	36	\N	153
511	59	\N	185
609	83	\N	137
610	83	\N	208
621	78	\N	100
622	78	\N	226
623	78	\N	250
54	26	83	107
55	26	84	108
56	26	85	109
57	27	83	107
58	27	84	108
60	27	113	151
365	19	\N	59
366	19	\N	76
636	63	\N	108
637	63	\N	205
638	63	\N	182
66	30	99	134
67	30	98	133
68	30	84	108
639	82	\N	81
640	82	\N	227
71	32	63	83
72	32	62	82
643	85	\N	112
76	34	95	120
77	34	98	133
644	85	\N	207
403	24	\N	98
404	24	\N	100
405	24	\N	139
406	21	\N	93
407	21	\N	134
408	48	\N	195
409	48	\N	200
410	48	\N	162
665	86	\N	113
566	67	\N	108
567	67	\N	199
568	58	\N	195
569	58	\N	147
570	58	\N	163
571	72	\N	62
572	72	\N	106
411	47	\N	195
412	47	\N	202
413	47	\N	200
573	72	\N	88
666	86	\N	66
414	44	\N	186
415	44	\N	185
577	70	\N	62
578	70	\N	182
579	52	\N	193
580	52	\N	164
581	52	\N	192
669	90	\N	218
670	90	\N	285
584	68	\N	95
585	68	\N	120
586	68	\N	96
587	61	\N	113
588	61	\N	100
589	65	\N	193
590	65	\N	93
591	65	\N	168
596	64	\N	120
597	64	\N	149
598	64	\N	166
599	64	\N	228
600	57	\N	188
491	76	\N	137
492	76	\N	208
601	57	\N	168
673	87	\N	155
674	87	\N	215
675	88	\N	162
676	88	\N	279
333	40	\N	161
334	40	\N	192
342	35	\N	141
343	35	\N	149
532	77	\N	226
347	29	\N	115
348	29	\N	91
533	77	\N	225
184	71	144	198
185	71	99	134
352	25	\N	106
353	25	\N	105
541	51	\N	165
542	51	\N	172
543	51	\N	152
544	51	\N	181
357	22	\N	95
358	22	\N	96
\.


--
-- Name: kitables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('kitables_id_seq', 683, true);


--
-- Data for Name: kits; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY kits (id, created_at, updated_at, theme_id, title, latest, state) FROM stdin;
18	2017-09-05 10:44:09.247386	2017-09-05 10:44:09.247386	13	Свитер «плюшевый» и джинсы с бахромой	f	1
41	2017-09-26 09:08:29.903381	2017-10-12 09:49:44.242631	17	\N	t	2
60	2017-09-27 16:02:29.596954	2017-10-12 09:50:38.495847	12	\N	t	2
26	2017-09-08 14:07:09.208053	2017-09-08 14:07:09.208053	13	На красный свет	f	1
50	2017-09-26 17:36:55.067112	2017-10-12 09:51:12.989898	12	\N	t	2
49	2017-09-26 17:35:11.374245	2017-10-12 09:51:33.992752	12	\N	t	2
46	2017-09-26 17:29:54.69848	2017-10-12 09:53:28.645745	12	\N	t	2
67	2017-09-28 06:10:44.491748	2017-10-13 13:46:33.901055	12	Знакомый почерк	t	1
42	2017-09-26 17:22:11.536573	2017-10-12 09:53:52.85437	12	\N	t	2
84	2017-10-12 20:40:12.593969	2017-10-13 13:05:56.56399	11	Бархатный сезон	t	1
31	2017-09-15 09:54:59.308944	2017-10-12 09:54:06.713492	12	Прогулки по парижу	f	2
83	2017-10-12 20:34:30.466031	2017-10-13 13:08:51.419665	11	РАЗГОВОРЫ О ЛЮБВИ	t	1
28	2017-09-15 09:23:19.237595	2017-10-12 09:54:21.785411	12	Сладкий сентябрь	f	2
24	2017-09-08 13:02:51.717655	2017-10-12 09:54:33.800915	12	Сезон благоволит клетке, так что клетчатым моделям — все внимание	f	2
21	2017-09-07 15:28:13.095457	2017-10-12 09:54:58.970502	12	Космически красивая	f	2
48	2017-09-26 17:33:25.839842	2017-10-12 09:55:33.562233	16	\N	t	2
79	2017-10-12 19:52:18.61458	2017-10-13 13:14:31.340095	11	Чувственный лад	t	1
71	2017-09-28 09:44:16.025988	2017-09-28 09:44:16.025988	12	\N	t	0
47	2017-09-26 17:31:28.499954	2017-10-12 09:55:52.937155	16	\N	t	2
27	2017-09-15 09:06:24.069389	2017-09-26 11:41:36.3263	17	Яркое начало	f	1
90	2017-10-20 06:22:46.354716	2017-10-20 06:33:04.218164	16	Морозная мята 	t	1
44	2017-09-26 17:26:24.668178	2017-10-12 09:56:09.808036	16	\N	t	2
89	2017-10-20 05:26:49.327492	2017-10-20 06:33:36.622651	16	Нотки джаза 	t	1
56	2017-09-27 15:45:25.907675	2017-09-27 15:45:25.907675	17	\N	t	0
86	2017-10-20 04:53:51.56008	2017-10-20 06:52:41.106532	16	Классика жанра 	t	1
87	2017-10-20 04:56:38.518119	2017-10-20 07:01:38.230272	16	Шоколад с мятой 	t	1
54	2017-09-26 21:41:45.126596	2017-10-12 10:43:20.49208	11	\N	f	2
77	2017-10-12 19:26:51.533689	2017-10-13 13:26:46.353381	11	Что? Где? Когда?	t	1
58	2017-09-27 15:55:19.688891	2017-10-13 13:48:00.88092	12	Бегущая по волнам 	t	1
72	2017-09-28 09:53:46.785096	2017-10-13 13:50:57.446717	12	Тишь да гладь	t	1
57	2017-09-27 15:47:37.356128	2017-10-13 13:51:56.132537	12	Имбирный чай	t	1
62	2017-09-27 16:07:05.034357	2017-09-27 19:13:16.789318	12	\N	f	0
53	2017-09-26 21:33:10.206838	2017-10-12 10:48:59.219866	11	\N	f	2
37	2017-09-26 06:40:06.875173	2017-10-12 10:51:15.22744	11	\N	t	2
33	2017-09-15 10:32:26.168673	2017-09-27 19:24:47.721265	12	Петербургская скромница	t	1
88	2017-10-20 05:22:36.976299	2017-10-20 07:02:12.331613	16	Навстречу ночи	t	1
80	2017-10-12 20:07:16.622778	2017-10-21 13:26:50.537687	11	Простые истины	t	2
81	2017-10-12 20:18:33.894784	2017-10-13 13:28:36.028394	11	Неслучайные попутчики 	t	1
70	2017-09-28 09:32:09.777711	2017-10-13 13:53:43.429651	12	На шаг впереди	t	1
34	2017-09-15 11:23:15.336074	2017-09-29 19:59:57.122372	12	Свободная от условностей	f	2
40	2017-09-26 08:58:33.960991	2017-09-29 20:02:28.6115	12	\N	f	2
25	2017-09-08 13:46:06.853692	2017-09-29 20:03:55.157893	12	Европейский шик и американская спортивность	f	2
22	2017-09-08 08:49:48.421584	2017-09-29 20:05:18.300545	12	Стильная духом	f	2
30	2017-09-15 09:44:41.040664	2017-09-29 20:06:01.786433	12	Модная свобода	f	2
39	2017-09-26 08:55:16.144244	2017-09-29 20:09:20.846935	16	\N	f	2
55	2017-09-27 15:13:20.709702	2017-09-29 20:10:40.005828	16	\N	f	2
38	2017-09-26 08:36:47.066255	2017-09-29 20:12:04.484707	15	\N	t	1
32	2017-09-15 10:14:53.439237	2017-10-01 12:20:11.108014	11	Художник по костюмам	f	2
35	2017-09-15 14:19:26.672707	2017-10-01 12:23:04.34348	11	Мягкость без слов	f	2
29	2017-09-15 09:32:08.003633	2017-10-11 14:10:28.941212	17	Модное искушение	f	2
19	2017-09-06 10:46:36.806098	2017-10-11 14:18:39.736188	17	В них можно закутаться, как в одеяло, а можно кокетливо накинуть на плечи	f	2
45	2017-09-26 17:27:42.220293	2017-10-12 09:31:17.965484	17	\N	t	2
43	2017-09-26 17:24:19.180182	2017-10-12 09:32:10.149157	17	\N	t	2
36	2017-09-15 14:42:37.684689	2017-10-12 10:51:40.336176	11	Уверенность в каждом штрихе	f	2
69	2017-09-28 06:15:31.406696	2017-10-12 19:36:04.808229	11	\N	t	2
76	2017-10-12 17:41:45.583698	2017-10-12 20:34:41.789762	11	\N	t	2
52	2017-09-26 17:54:09.521766	2017-10-13 13:59:47.752217	17	С мужского плеча	t	1
59	2017-09-27 16:00:50.168115	2017-10-13 09:43:15.936783	12		t	2
75	2017-10-12 16:36:39.842624	2017-10-13 10:55:29.965396	11	Ягодный дресс-код	t	1
78	2017-10-12 19:31:47.841552	2017-10-13 13:30:06.786554	11	Легенды осени	t	1
66	2017-09-27 18:59:46.928058	2017-10-13 13:32:33.600733	17	Правило сезона	t	1
51	2017-09-26 17:51:33.153132	2017-10-13 13:34:27.017478	17	Соцветия осени	t	1
73	2017-09-28 10:10:53.18652	2017-10-13 13:36:18.022295	12	Чистые силы	t	1
74	2017-10-06 05:28:41.408469	2017-10-13 13:38:35.538607	17	Осенний листопад	t	1
65	2017-09-27 18:58:41.659532	2017-10-13 13:41:22.541473	17	Ловец райских птиц	t	1
63	2017-09-27 18:53:59.700326	2017-10-13 13:41:47.072855	17	День в Париже	f	1
64	2017-09-27 18:55:04.542772	2017-10-13 13:42:15.323939	17	Поэзия будней	t	1
68	2017-09-28 06:13:34.50006	2017-10-13 13:44:03.8433	12	Окно в мир	t	1
61	2017-09-27 16:05:00.281977	2017-10-13 14:24:21.314806	15		t	1
82	2017-10-12 20:26:19.978698	2017-10-18 15:39:26.296596	11	Грозди рябины	f	2
85	2017-10-20 03:00:57.614943	2017-10-20 03:00:57.614943	16	Северное сияние 	t	1
\.


--
-- Name: kits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('kits_id_seq', 90, true);


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY order_items (id, order_id, variant_id, quantity, size, created_at, updated_at, price) FROM stdin;
1	3	142	1	40	2017-09-15 16:24:47.734827	2017-09-15 16:24:47.734827	\N
2	3	133	1	42	2017-09-15 16:24:47.737712	2017-09-15 16:24:47.737712	\N
3	3	120	1	40	2017-09-15 16:24:47.73972	2017-09-15 16:24:47.73972	\N
4	4	158	1	0	2017-09-15 16:25:26.822743	2017-09-15 16:25:26.822743	\N
5	4	157	1	42	2017-09-15 16:25:26.824904	2017-09-15 16:25:26.824904	\N
6	5	158	1	0	2017-09-15 16:26:00.353617	2017-09-15 16:26:00.353617	\N
7	5	157	1	42	2017-09-15 16:26:00.356502	2017-09-15 16:26:00.356502	\N
8	6	158	1	0	2017-09-15 16:55:43.991452	2017-09-15 16:55:43.991452	\N
9	6	134	1	42	2017-09-15 16:55:43.993987	2017-09-15 16:55:43.993987	\N
10	6	149	1	42	2017-09-15 16:55:43.995897	2017-09-15 16:55:43.995897	\N
11	7	148	1	42	2017-09-15 16:57:16.741292	2017-09-15 16:57:16.741292	\N
12	8	158	1	0	2017-09-15 17:03:41.739544	2017-09-15 17:03:41.739544	\N
13	8	157	1	44	2017-09-15 17:03:41.742356	2017-09-15 17:03:41.742356	\N
14	9	148	1	42	2017-09-15 17:07:04.795842	2017-09-15 17:07:04.795842	\N
15	9	98	1	42	2017-09-15 17:07:04.798889	2017-09-15 17:07:04.798889	\N
16	9	134	1	42	2017-09-15 17:07:04.801232	2017-09-15 17:07:04.801232	\N
17	11	148	1	42	2017-09-15 18:23:25.943253	2017-09-15 18:23:25.943253	\N
18	56	120	1	40	2017-09-19 12:22:20.529581	2017-09-19 12:22:20.529581	\N
19	60	155	1	0	2017-09-20 10:51:11.02795	2017-09-20 10:51:11.02795	\N
20	61	155	1	0	2017-09-20 10:52:50.869087	2017-09-20 10:52:50.869087	\N
21	73	171	1	0	2017-09-22 08:17:26.003614	2017-09-22 08:17:26.003614	\N
22	78	171	1	0	2017-09-22 13:07:58.624979	2017-09-22 13:07:58.624979	\N
23	77	128	3	0	2017-09-22 15:19:40.337898	2017-09-22 15:19:40.337898	\N
24	88	132	1	42	2017-09-23 14:34:32.677251	2017-09-23 14:34:32.677251	\N
25	109	83	1	44	2017-09-26 14:21:43.547927	2017-09-26 14:21:43.547927	\N
26	109	137	1	42	2017-09-26 14:21:43.550917	2017-09-26 14:21:43.550917	\N
27	96	147	1	42	2017-09-26 14:47:02.944899	2017-09-26 14:47:02.944899	\N
28	97	132	1	44	2017-09-26 14:48:19.872843	2017-09-26 14:48:19.872843	\N
29	97	139	1	44	2017-09-26 14:48:35.566909	2017-09-26 14:48:35.566909	\N
30	115	198	2	42	2017-09-26 21:34:50.985315	2017-09-26 21:34:50.985315	\N
31	67	198	1	42	2017-09-27 03:53:08.084125	2017-09-27 03:53:08.084125	\N
32	67	108	1	44	2017-09-27 03:53:08.086937	2017-09-27 03:53:08.086937	\N
33	118	198	1	42	2017-09-27 04:48:38.012645	2017-09-27 04:48:38.012645	\N
34	118	190	1	0	2017-09-27 04:48:38.015146	2017-09-27 04:48:38.015146	\N
35	116	199	1	0	2017-09-27 05:57:02.295615	2017-09-27 05:57:02.295615	\N
36	116	181	1	0	2017-09-27 05:57:02.298019	2017-09-27 05:57:02.298019	\N
37	122	185	1	0	2017-09-27 08:01:28.663428	2017-09-27 08:01:28.663428	\N
38	122	189	1	0	2017-09-27 08:01:28.665854	2017-09-27 08:01:28.665854	\N
39	122	177	1	0	2017-09-27 08:01:28.667961	2017-09-27 08:01:28.667961	\N
40	125	190	1	0	2017-09-27 08:35:55.69184	2017-09-27 08:35:55.69184	\N
41	126	189	1	0	2017-09-27 09:00:40.69929	2017-09-27 09:00:40.69929	\N
42	123	203	2	0	2017-09-27 10:09:36.163529	2017-09-27 10:09:36.163529	\N
43	120	198	1	42	2017-09-27 12:27:14.685335	2017-09-27 12:27:14.685335	\N
44	132	196	1	0	2017-09-27 19:10:18.836934	2017-09-27 19:10:18.836934	\N
45	127	115	1	0	2017-09-28 12:45:31.10136	2017-09-28 12:45:31.10136	\N
46	142	197	1	42	2017-09-29 07:40:50.529519	2017-09-29 07:40:50.529519	\N
47	144	174	1	0	2017-09-29 15:15:15.333543	2017-09-29 15:15:15.333543	8900.0
48	144	148	1	42	2017-09-29 15:15:15.336696	2017-09-29 15:15:15.336696	7600.0
49	153	201	1	0	2017-10-01 11:18:24.686761	2017-10-01 11:18:24.686761	3500.0
50	114	177	1	0	2017-10-02 08:54:15.893998	2017-10-02 08:54:15.893998	3500.0
51	114	188	1	44	2017-10-02 08:54:15.896941	2017-10-02 08:54:15.896941	3100.0
52	164	231	1	44	2017-10-05 21:15:05.597558	2017-10-05 21:15:05.597558	23900.0
53	158	195	1	0	2017-10-06 04:48:52.694893	2017-10-06 04:48:52.694893	3900.0
54	165	231	1	44	2017-10-06 07:42:47.639561	2017-10-06 07:42:47.639561	23900.0
55	170	231	1	40	2017-10-06 11:53:36.686041	2017-10-06 11:53:36.686041	23900.0
56	182	199	1	0	2017-10-09 22:53:47.415894	2017-10-09 22:53:47.415894	5500.0
57	182	88	1	0	2017-10-09 22:53:47.418782	2017-10-09 22:53:47.418782	2200.0
58	184	181	1	0	2017-10-10 07:39:27.662688	2017-10-10 07:39:27.662688	3800.0
59	130	198	1	44	2017-10-10 14:25:12.40179	2017-10-10 14:25:12.40179	8700.0
60	188	231	1	44	2017-10-11 20:47:13.834115	2017-10-11 20:47:13.834115	23900.0
61	198	137	1	42	2017-10-14 07:07:19.199726	2017-10-14 07:07:19.199726	9800.0
62	198	208	1	42	2017-10-14 07:07:19.202644	2017-10-14 07:07:19.202644	20900.0
63	197	200	1	0	2017-10-14 15:58:06.921546	2017-10-14 15:58:06.921546	3500.0
64	197	226	1	42	2017-10-14 15:58:06.923955	2017-10-14 15:58:06.923955	3150.0
65	204	262	1	46	2017-10-15 18:02:31.88197	2017-10-15 18:02:31.88197	8500.0
66	206	242	1	44	2017-10-15 19:46:44.894928	2017-10-15 19:46:44.894928	4699.0
67	210	242	1	44	2017-10-16 16:54:59.30556	2017-10-16 16:54:59.30556	4699.0
68	121	229	1	0	2017-10-17 06:45:02.532319	2017-10-17 06:45:02.532319	1500.0
69	213	217	1	42	2017-10-17 08:38:59.255373	2017-10-17 08:38:59.255373	7600.0
70	224	231	1	42	2017-10-20 16:57:18.265954	2017-10-20 16:57:18.265954	23900.0
71	243	297	1	44	2017-10-24 09:29:27.498566	2017-10-24 09:29:27.498566	23900.0
\.


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('order_items_id_seq', 71, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY orders (id, state, user_id, created_at, updated_at, address) FROM stdin;
1	0	1	2017-09-12 09:47:13.122234	2017-09-12 09:47:13.122234	\N
2	0	4	2017-09-15 13:09:41.125999	2017-09-15 13:09:41.125999	\N
70	0	79	2017-09-21 17:41:16.441082	2017-09-21 17:41:16.441082	\N
3	1	5	2017-09-15 16:24:22.339486	2017-09-15 16:24:47.758563	бпечерская
71	0	81	2017-09-21 20:41:42.864318	2017-09-21 20:41:42.864318	\N
4	1	5	2017-09-15 16:25:20.072228	2017-09-15 16:25:26.838234	Бпечерская
72	0	82	2017-09-21 20:59:09.964436	2017-09-21 20:59:09.964436	\N
5	1	5	2017-09-15 16:25:56.794491	2017-09-15 16:26:00.377097	ьвапвапва
6	1	6	2017-09-15 16:54:53.256623	2017-09-15 16:55:44.015227	ТЕСТОВЫЙ ЗАКАЗ. Связываться не нужно. Но нужно позвонить по телефону чтобы подтвердить получение заказа и его содержимого. 
82	0	101	2017-09-23 08:40:50.13456	2017-09-23 08:40:50.13456	\N
7	1	6	2017-09-15 16:56:51.850359	2017-09-15 16:57:16.756758	ТЕСТОВЫЙ ЗАКАЗ. Связываться не нужно. Но нужно позвонить по телефону чтобы подтвердить получение заказа и его содержимого. 
73	1	85	2017-09-22 08:16:07.501426	2017-09-22 08:17:26.018895	Москва,овчинниковская набережная, 20, стр.1
8	1	6	2017-09-15 16:59:34.124538	2017-09-15 17:03:41.763116	ТЕСТОВЫЙ ЗАКАЗ. Связываться не нужно. Но нужно позвонить по телефону чтобы подтвердить получение заказа и его содержимого. 
74	0	86	2017-09-22 08:28:43.600412	2017-09-22 08:28:43.600412	\N
9	1	6	2017-09-15 17:07:01.702151	2017-09-15 17:07:04.819571	ТЕСТОВЫЙ ЗАКАЗ. Связываться не нужно. Но нужно позвонить по телефону чтобы подтвердить получение заказа и его содержимого. 
10	0	8	2017-09-15 18:21:09.633256	2017-09-15 18:21:09.633256	\N
75	0	87	2017-09-22 10:19:45.12956	2017-09-22 10:19:45.12956	\N
11	1	9	2017-09-15 18:23:07.284087	2017-09-15 18:23:25.958503	ТЕСТ
12	0	10	2017-09-15 18:27:26.585187	2017-09-15 18:27:26.585187	\N
13	0	13	2017-09-15 18:32:54.901833	2017-09-15 18:32:54.901833	\N
14	0	14	2017-09-15 18:38:11.774399	2017-09-15 18:38:11.774399	\N
15	0	15	2017-09-15 18:48:21.838057	2017-09-15 18:48:21.838057	\N
16	0	16	2017-09-15 18:59:22.300638	2017-09-15 18:59:22.300638	\N
17	0	17	2017-09-15 19:00:48.520131	2017-09-15 19:00:48.520131	\N
18	0	18	2017-09-15 19:01:08.831572	2017-09-15 19:01:08.831572	\N
19	0	23	2017-09-15 19:44:32.960907	2017-09-15 19:44:32.960907	\N
20	0	24	2017-09-15 20:01:09.991627	2017-09-15 20:01:09.991627	\N
21	0	25	2017-09-15 20:24:35.581788	2017-09-15 20:24:35.581788	\N
22	0	27	2017-09-15 21:25:57.153769	2017-09-15 21:25:57.153769	\N
23	0	28	2017-09-15 21:41:39.199562	2017-09-15 21:41:39.199562	\N
24	0	30	2017-09-16 00:48:42.471025	2017-09-16 00:48:42.471025	\N
25	0	31	2017-09-16 01:59:18.928807	2017-09-16 01:59:18.928807	\N
26	0	32	2017-09-16 05:11:56.349691	2017-09-16 05:11:56.349691	\N
27	0	34	2017-09-16 05:23:00.090807	2017-09-16 05:23:00.090807	\N
28	0	35	2017-09-16 06:59:42.937127	2017-09-16 06:59:42.937127	\N
29	0	36	2017-09-16 07:13:04.004479	2017-09-16 07:13:04.004479	\N
30	0	37	2017-09-16 07:26:22.35808	2017-09-16 07:26:22.35808	\N
31	0	38	2017-09-16 08:28:40.791119	2017-09-16 08:28:40.791119	\N
32	0	39	2017-09-16 09:06:55.365329	2017-09-16 09:06:55.365329	\N
33	0	40	2017-09-16 09:18:21.630908	2017-09-16 09:18:21.630908	\N
34	0	41	2017-09-16 09:31:29.912483	2017-09-16 09:31:29.912483	\N
35	0	42	2017-09-16 10:27:54.222351	2017-09-16 10:27:54.222351	\N
36	0	43	2017-09-16 10:52:39.699638	2017-09-16 10:52:39.699638	\N
37	0	44	2017-09-16 12:03:45.921442	2017-09-16 12:03:45.921442	\N
38	0	45	2017-09-16 12:42:56.857029	2017-09-16 12:42:56.857029	\N
39	0	47	2017-09-16 13:39:37.77515	2017-09-16 13:39:37.77515	\N
40	0	48	2017-09-16 15:29:43.968067	2017-09-16 15:29:43.968067	\N
41	0	49	2017-09-16 16:44:34.923241	2017-09-16 16:44:34.923241	\N
42	0	50	2017-09-17 04:18:03.440762	2017-09-17 04:18:03.440762	\N
43	0	51	2017-09-17 06:58:37.449977	2017-09-17 06:58:37.449977	\N
44	0	52	2017-09-17 10:25:20.699687	2017-09-17 10:25:20.699687	\N
45	0	53	2017-09-17 13:55:22.735189	2017-09-17 13:55:22.735189	\N
46	0	54	2017-09-18 04:49:57.368544	2017-09-18 04:49:57.368544	\N
47	0	55	2017-09-18 07:42:43.008472	2017-09-18 07:42:43.008472	\N
48	0	56	2017-09-18 09:05:15.14932	2017-09-18 09:05:15.14932	\N
49	0	26	2017-09-18 09:15:56.693492	2017-09-18 09:15:56.693492	\N
50	0	57	2017-09-18 09:27:02.287512	2017-09-18 09:27:02.287512	\N
51	0	58	2017-09-18 12:05:55.81137	2017-09-18 12:05:55.81137	\N
52	0	59	2017-09-18 14:50:45.353645	2017-09-18 14:50:45.353645	\N
53	0	61	2017-09-18 19:39:28.68506	2017-09-18 19:39:28.68506	\N
54	0	62	2017-09-18 21:23:12.043973	2017-09-18 21:23:12.043973	\N
55	0	19	2017-09-19 07:06:00.046038	2017-09-19 07:06:00.046038	\N
76	0	89	2017-09-22 10:47:43.014724	2017-09-22 10:47:43.014724	\N
56	1	64	2017-09-19 12:20:43.488634	2017-09-19 12:22:20.544804	Тестируем работоспособность сервиса. Lucky Pike. Перезванивать не нужно.
57	0	64	2017-09-19 12:22:35.933579	2017-09-19 12:22:35.933579	\N
58	0	65	2017-09-19 17:23:36.663132	2017-09-19 17:23:36.663132	\N
59	0	66	2017-09-20 08:13:31.37979	2017-09-20 08:13:31.37979	\N
60	1	67	2017-09-20 10:49:33.333806	2017-09-20 10:51:11.043495	пл Горького, 2
61	1	67	2017-09-20 10:52:26.664599	2017-09-20 10:52:50.884587	пл Горького 2
62	0	67	2017-09-20 10:52:58.172199	2017-09-20 10:52:58.172199	\N
63	0	68	2017-09-20 13:47:44.389036	2017-09-20 13:47:44.389036	\N
64	0	69	2017-09-20 20:33:54.697411	2017-09-20 20:33:54.697411	\N
65	0	70	2017-09-21 03:06:38.959667	2017-09-21 03:06:38.959667	\N
66	0	71	2017-09-21 07:33:09.857647	2017-09-21 07:33:09.857647	\N
68	0	75	2017-09-21 13:11:56.469165	2017-09-21 13:11:56.469165	\N
69	0	76	2017-09-21 13:20:42.276937	2017-09-21 13:20:42.276937	\N
83	0	102	2017-09-23 08:42:32.270525	2017-09-23 08:42:32.270525	\N
78	1	93	2017-09-22 13:02:47.41684	2017-09-22 13:07:58.640354	Улица Бринского, дом 3, квартира 53
79	0	96	2017-09-22 15:10:59.058882	2017-09-22 15:10:59.058882	\N
84	0	103	2017-09-23 08:42:32.462172	2017-09-23 08:42:32.462172	\N
77	1	90	2017-09-22 12:00:38.534709	2017-09-22 15:19:40.353539	Санкт-Петербург, ул Коллонтай, дом 6, корпус 2, кв782
80	0	97	2017-09-22 15:35:29.07765	2017-09-22 15:35:29.07765	\N
81	0	98	2017-09-22 15:36:39.12184	2017-09-22 15:36:39.12184	\N
85	0	104	2017-09-23 08:42:47.727161	2017-09-23 08:42:47.727161	\N
86	0	105	2017-09-23 08:44:47.664691	2017-09-23 08:44:47.664691	\N
87	0	109	2017-09-23 11:33:58.145105	2017-09-23 11:33:58.145105	\N
89	0	111	2017-09-23 15:43:47.83461	2017-09-23 15:43:47.83461	\N
88	1	110	2017-09-23 14:33:41.588605	2017-09-23 14:34:32.692621	
90	0	112	2017-09-23 16:42:12.523586	2017-09-23 16:42:12.523586	\N
91	0	114	2017-09-23 20:54:13.629595	2017-09-23 20:54:13.629595	\N
92	0	116	2017-09-24 08:14:12.79648	2017-09-24 08:14:12.79648	\N
93	0	117	2017-09-24 09:14:26.243346	2017-09-24 09:14:26.243346	\N
94	0	118	2017-09-24 14:24:41.994233	2017-09-24 14:24:41.994233	\N
95	0	121	2017-09-24 15:03:36.204053	2017-09-24 15:03:36.204053	\N
97	1	123	2017-09-24 19:17:26.494685	2017-09-26 14:48:42.022534	\N
67	1	73	2017-09-21 08:34:32.705362	2017-09-27 03:53:08.107962	
98	0	125	2017-09-25 12:27:57.030063	2017-09-25 12:27:57.030063	\N
99	0	126	2017-09-25 18:13:10.032319	2017-09-25 18:13:10.032319	\N
100	0	128	2017-09-25 21:01:58.830536	2017-09-25 21:01:58.830536	\N
101	0	129	2017-09-25 21:02:59.552385	2017-09-25 21:02:59.552385	\N
102	0	130	2017-09-25 21:56:31.997229	2017-09-25 21:56:31.997229	\N
103	0	131	2017-09-25 21:58:49.043309	2017-09-25 21:58:49.043309	\N
104	0	132	2017-09-26 04:44:51.275118	2017-09-26 04:44:51.275118	\N
105	0	133	2017-09-26 14:12:26.549666	2017-09-26 14:12:26.549666	\N
106	0	134	2017-09-26 14:13:28.237266	2017-09-26 14:13:28.237266	\N
107	0	135	2017-09-26 14:16:01.508281	2017-09-26 14:16:01.508281	\N
108	0	136	2017-09-26 14:17:25.020912	2017-09-26 14:17:25.020912	\N
109	1	137	2017-09-26 14:21:24.276436	2017-09-26 14:21:43.571491	
96	1	122	2017-09-24 18:47:06.529874	2017-09-26 14:47:13.813297	\N
110	0	138	2017-09-26 14:53:20.119206	2017-09-26 14:53:20.119206	\N
111	0	139	2017-09-26 17:43:14.700369	2017-09-26 17:43:14.700369	\N
112	0	140	2017-09-26 18:18:43.636466	2017-09-26 18:18:43.636466	\N
113	0	142	2017-09-26 19:32:03.381753	2017-09-26 19:32:03.381753	\N
185	0	231	2017-10-10 09:53:22.320451	2017-10-10 09:53:22.320451	\N
115	1	145	2017-09-26 21:27:36.607328	2017-09-26 21:34:51.000761	Кировская область, город Киров, улица ленина, дом 184, квартира 311 
117	0	146	2017-09-26 23:02:29.262851	2017-09-26 23:02:29.262851	\N
164	1	213	2017-10-05 21:14:42.374665	2017-10-05 21:15:05.613036	
118	1	123	2017-09-27 04:47:59.000684	2017-09-27 04:48:38.028155	
119	0	123	2017-09-27 04:48:46.854979	2017-09-27 04:48:46.854979	\N
182	1	241	2017-10-09 22:52:08.563458	2017-10-09 22:53:47.43961	Москва, Зеленоград, никольский проезд, корп 526, кв 94, под 5, эт 9
116	1	3	2017-09-26 22:10:36.806478	2017-09-27 05:57:02.311073	Москва народного ополчения 34с3
158	1	203	2017-10-04 07:56:18.171497	2017-10-06 04:48:52.71035	Ленинградский прт, 76/3, кв 125
122	1	150	2017-09-27 07:54:41.347115	2017-09-27 08:01:28.687211	Москва. Ул. Таллинская д2 кв271
124	0	153	2017-09-27 08:23:29.183794	2017-09-27 08:23:29.183794	\N
125	1	154	2017-09-27 08:33:46.605087	2017-09-27 08:35:55.707348	г. Москва, ул. Яблочкова, 23-20
183	0	242	2017-10-10 01:26:51.661211	2017-10-10 01:26:51.661211	\N
126	1	156	2017-09-27 08:54:03.602676	2017-09-27 09:00:40.714736	
165	1	213	2017-10-06 07:42:35.105206	2017-10-06 07:42:47.654952	
123	1	152	2017-09-27 08:22:06.280077	2017-09-27 10:09:36.178915	Нижний Новгород Суетинская 13-40
128	0	158	2017-09-27 10:33:23.03744	2017-09-27 10:33:23.03744	\N
129	0	161	2017-09-27 11:48:38.753983	2017-09-27 11:48:38.753983	\N
166	0	215	2017-10-06 08:36:25.707709	2017-10-06 08:36:25.707709	\N
120	1	148	2017-09-27 04:51:32.489842	2017-09-27 12:27:14.700762	
131	0	3	2017-09-27 14:45:56.185576	2017-09-27 14:45:56.185576	\N
167	0	216	2017-10-06 08:55:47.223137	2017-10-06 08:55:47.223137	\N
132	1	165	2017-09-27 19:09:26.140121	2017-09-27 19:10:18.852229	Г.киров,мира 33
133	0	169	2017-09-28 10:52:22.28516	2017-09-28 10:52:22.28516	\N
134	0	167	2017-09-28 11:24:42.644832	2017-09-28 11:24:42.644832	\N
135	0	171	2017-09-28 11:58:09.231075	2017-09-28 11:58:09.231075	\N
136	0	173	2017-09-28 12:18:51.120042	2017-09-28 12:18:51.120042	\N
137	0	174	2017-09-28 12:35:20.940205	2017-09-28 12:35:20.940205	\N
168	0	217	2017-10-06 09:36:32.376632	2017-10-06 09:36:32.376632	\N
127	1	127	2017-09-27 09:22:35.187735	2017-09-28 12:45:31.117265	160022, г. Вологда, ул. Пошехонское шоссе, д.26, кв.109
138	0	175	2017-09-28 16:00:36.218093	2017-09-28 16:00:36.218093	\N
139	0	177	2017-09-28 21:31:10.711279	2017-09-28 21:31:10.711279	\N
140	0	178	2017-09-29 00:28:21.530341	2017-09-29 00:28:21.530341	\N
141	0	179	2017-09-29 01:18:44.319706	2017-09-29 01:18:44.319706	\N
169	0	219	2017-10-06 10:39:03.07973	2017-10-06 10:39:03.07973	\N
142	1	145	2017-09-29 07:39:40.979787	2017-09-29 07:40:50.544964	Кировская область, город Киров, улица ленина, дом 284. Квартира 311
143	0	180	2017-09-29 09:11:32.469027	2017-09-29 09:11:32.469027	\N
144	1	6	2017-09-29 15:14:17.992661	2017-09-29 15:15:15.35678	ТЕСТ
145	0	184	2017-09-29 19:03:29.143224	2017-09-29 19:03:29.143224	\N
146	0	185	2017-09-29 19:20:47.156818	2017-09-29 19:20:47.156818	\N
147	0	186	2017-09-30 06:21:59.661676	2017-09-30 06:21:59.661676	\N
148	0	95	2017-09-30 11:49:51.085227	2017-09-30 11:49:51.085227	\N
149	0	189	2017-09-30 13:53:29.285375	2017-09-30 13:53:29.285375	\N
150	0	190	2017-09-30 15:57:22.487856	2017-09-30 15:57:22.487856	\N
151	0	193	2017-10-01 10:03:48.839198	2017-10-01 10:03:48.839198	\N
152	0	194	2017-10-01 10:52:49.048782	2017-10-01 10:52:49.048782	\N
153	1	195	2017-10-01 11:16:51.271327	2017-10-01 11:18:24.702384	194355, Санкт-Петербург, композиторов 12-174
154	0	198	2017-10-02 08:27:14.570595	2017-10-02 08:27:14.570595	\N
170	1	220	2017-10-06 11:43:26.779137	2017-10-06 11:53:36.701641	Санкт Петербург , пр Космонавтов 37-970
114	1	84	2017-09-26 20:18:59.949212	2017-10-02 08:54:15.917821	Поселок Дружный 6-45
155	0	199	2017-10-02 18:40:05.786352	2017-10-02 18:40:05.786352	\N
156	0	201	2017-10-03 01:18:30.867785	2017-10-03 01:18:30.867785	\N
157	0	202	2017-10-03 08:27:15.865795	2017-10-03 08:27:15.865795	\N
159	0	205	2017-10-04 20:04:59.299893	2017-10-04 20:04:59.299893	\N
160	0	206	2017-10-04 21:26:37.501512	2017-10-04 21:26:37.501512	\N
161	0	207	2017-10-04 21:35:36.203151	2017-10-04 21:35:36.203151	\N
162	0	208	2017-10-05 08:27:12.261019	2017-10-05 08:27:12.261019	\N
163	0	212	2017-10-05 19:05:06.897483	2017-10-05 19:05:06.897483	\N
171	0	221	2017-10-06 19:27:05.947011	2017-10-06 19:27:05.947011	\N
172	0	225	2017-10-07 02:13:11.673444	2017-10-07 02:13:11.673444	\N
173	0	226	2017-10-07 12:50:49.206491	2017-10-07 12:50:49.206491	\N
174	0	229	2017-10-08 10:19:51.372476	2017-10-08 10:19:51.372476	\N
175	0	232	2017-10-08 16:52:17.682038	2017-10-08 16:52:17.682038	\N
176	0	233	2017-10-08 20:16:13.235125	2017-10-08 20:16:13.235125	\N
177	0	235	2017-10-08 21:16:30.537261	2017-10-08 21:16:30.537261	\N
178	0	236	2017-10-09 12:01:27.756037	2017-10-09 12:01:27.756037	\N
179	0	237	2017-10-09 13:37:31.827874	2017-10-09 13:37:31.827874	\N
180	0	238	2017-10-09 14:22:38.047875	2017-10-09 14:22:38.047875	\N
181	0	240	2017-10-09 19:47:40.158145	2017-10-09 19:47:40.158145	\N
186	0	244	2017-10-10 12:27:59.730146	2017-10-10 12:27:59.730146	\N
184	1	243	2017-10-10 07:37:03.746294	2017-10-10 07:39:27.67827	
187	0	254	2017-10-11 18:51:53.210453	2017-10-11 18:51:53.210453	\N
130	1	148	2017-09-27 12:27:23.842418	2017-10-10 14:25:12.418073	
189	0	256	2017-10-12 03:15:02.411292	2017-10-12 03:15:02.411292	\N
188	1	255	2017-10-11 20:45:58.606131	2017-10-11 20:47:13.849487	г.Химки, МО\nул. Молодежная, д.36-а, кв. 185
190	0	257	2017-10-12 03:33:47.544418	2017-10-12 03:33:47.544418	\N
191	0	258	2017-10-12 03:34:59.156174	2017-10-12 03:34:59.156174	\N
192	0	196	2017-10-12 13:59:46.647269	2017-10-12 13:59:46.647269	\N
193	0	143	2017-10-12 19:46:35.379674	2017-10-12 19:46:35.379674	\N
194	0	239	2017-10-13 04:51:34.779653	2017-10-13 04:51:34.779653	\N
195	0	264	2017-10-13 19:09:14.763871	2017-10-13 19:09:14.763871	\N
196	0	265	2017-10-13 20:00:31.224851	2017-10-13 20:00:31.224851	\N
121	1	12	2017-09-27 06:42:02.229508	2017-10-17 06:45:02.572616	
198	1	164	2017-10-14 07:06:14.572392	2017-10-14 07:07:19.223699	Мещерскийбульвар д.9кв.264 подъезд5
199	0	164	2017-10-14 07:07:35.600742	2017-10-14 07:07:35.600742	\N
200	0	267	2017-10-14 08:03:43.001442	2017-10-14 08:03:43.001442	\N
201	0	268	2017-10-14 08:50:13.121125	2017-10-14 08:50:13.121125	\N
202	0	269	2017-10-14 13:57:02.725691	2017-10-14 13:57:02.725691	\N
197	1	266	2017-10-14 02:24:34.765821	2017-10-14 15:58:06.937336	Красноярский край город Минусинск улица Трегубенко 66а-25
203	0	270	2017-10-15 05:02:50.2303	2017-10-15 05:02:50.2303	\N
204	1	166	2017-10-15 17:58:29.983021	2017-10-15 18:02:31.897915	
205	0	272	2017-10-15 19:11:07.655319	2017-10-15 19:11:07.655319	\N
206	1	273	2017-10-15 19:45:18.215438	2017-10-15 19:46:44.910759	Москва, ул Каргопольская, 13,к1, кв44
207	0	274	2017-10-15 21:45:43.428578	2017-10-15 21:45:43.428578	\N
208	0	271	2017-10-16 10:42:20.922059	2017-10-16 10:42:20.922059	\N
209	0	276	2017-10-16 12:36:05.49526	2017-10-16 12:36:05.49526	\N
210	1	273	2017-10-16 16:54:15.483549	2017-10-16 16:54:59.354192	Москва, Каргопольская 13, к1, кв44
211	0	277	2017-10-16 17:35:18.203969	2017-10-16 17:35:18.203969	\N
212	0	12	2017-10-17 07:02:35.74305	2017-10-17 07:02:35.74305	\N
213	1	278	2017-10-17 08:37:38.940007	2017-10-17 08:38:59.270718	160024 г. Вологда, ул. Дальняя, дом 18 В, кв. 17
214	0	280	2017-10-17 16:34:16.577097	2017-10-17 16:34:16.577097	\N
215	0	281	2017-10-17 20:34:41.549662	2017-10-17 20:34:41.549662	\N
216	0	283	2017-10-18 20:05:46.562982	2017-10-18 20:05:46.562982	\N
217	0	284	2017-10-19 08:20:11.358308	2017-10-19 08:20:11.358308	\N
218	0	286	2017-10-19 09:34:24.280864	2017-10-19 09:34:24.280864	\N
219	0	288	2017-10-19 16:19:10.735109	2017-10-19 16:19:10.735109	\N
220	0	291	2017-10-20 10:36:47.962898	2017-10-20 10:36:47.962898	\N
221	0	289	2017-10-20 11:55:17.480437	2017-10-20 11:55:17.480437	\N
222	0	292	2017-10-20 12:11:42.312881	2017-10-20 12:11:42.312881	\N
223	0	293	2017-10-20 16:40:44.980816	2017-10-20 16:40:44.980816	\N
224	1	294	2017-10-20 16:56:21.211094	2017-10-20 16:57:18.281553	Трехпрудный переулок 11/13 к.2 кв 47 \n123001
225	0	295	2017-10-20 20:24:39.178515	2017-10-20 20:24:39.178515	\N
226	0	296	2017-10-20 20:40:40.929881	2017-10-20 20:40:40.929881	\N
227	0	297	2017-10-21 07:21:52.634466	2017-10-21 07:21:52.634466	\N
228	0	298	2017-10-21 07:57:46.534944	2017-10-21 07:57:46.534944	\N
229	0	299	2017-10-21 12:45:17.709907	2017-10-21 12:45:17.709907	\N
230	0	300	2017-10-21 12:51:59.224754	2017-10-21 12:51:59.224754	\N
231	0	301	2017-10-21 12:54:28.604056	2017-10-21 12:54:28.604056	\N
232	0	302	2017-10-21 18:40:56.348086	2017-10-21 18:40:56.348086	\N
233	0	303	2017-10-21 18:40:56.537307	2017-10-21 18:40:56.537307	\N
234	0	304	2017-10-22 05:56:49.338445	2017-10-22 05:56:49.338445	\N
235	0	145	2017-10-22 08:46:04.04594	2017-10-22 08:46:04.04594	\N
236	0	305	2017-10-22 11:09:59.450751	2017-10-22 11:09:59.450751	\N
237	0	307	2017-10-22 16:19:06.6424	2017-10-22 16:19:06.6424	\N
238	0	310	2017-10-23 09:21:13.941232	2017-10-23 09:21:13.941232	\N
239	0	311	2017-10-23 11:57:52.034772	2017-10-23 11:57:52.034772	\N
240	0	312	2017-10-23 16:41:45.628147	2017-10-23 16:41:45.628147	\N
241	0	147	2017-10-23 20:58:27.889796	2017-10-23 20:58:27.889796	\N
242	0	314	2017-10-24 06:34:58.973575	2017-10-24 06:34:58.973575	\N
243	1	316	2017-10-24 09:26:41.007281	2017-10-24 09:29:27.547604	Ул. Ижорская,18,49
244	0	317	2017-10-24 10:18:27.043129	2017-10-24 10:18:27.043129	\N
245	0	318	2017-10-25 02:41:20.619118	2017-10-25 02:41:20.619118	\N
246	0	319	2017-10-25 10:22:01.989865	2017-10-25 10:22:01.989865	\N
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('orders_id_seq', 246, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY products (id, category_id, price, "desc", created_at, updated_at, colors, kind_id, state, title, sale, latest, price_last, comp) FROM stdin;
63	26	11500.0	Рекомендуемая температура: от +15 до -10	2017-09-06 12:51:46.238118	2017-10-22 14:48:19.564362	\N	\N	1	Пальто с закруглённым воротником	f	f	\N	60% шерсть, 40 п/э
151	42	3500.0	Классическая шапка объемной вязки станет прекрасным продолжением уютного и теплого осеннего образа	2017-10-04 10:28:46.231841	2017-10-04 12:01:34.641971	\N	\N	1	Шапка	f	t	\N	56% акрил, 18% мохер, 18% шерсть, 8% полиамид
154	20	3900.0	Футболка станет отличной основой для образа как с жакетом с мужского плеча, так и с модным объёным кардиганом. 	2017-10-04 11:41:05.515992	2017-10-04 11:49:50.403388	\N	\N	1	Футболка Slim c вышивкой	f	t	\N	92% хлопок, 8% эластан
87	24	9800.0		2017-09-08 14:34:09.590881	2017-10-15 12:53:34.94489	\N	\N	2	Костюм из шерсти и вискозы	f	f	\N	50% шерсть, 30% вискоза, 20%  п/э
153	14	14800.0	Трикотажное платье-миди выгодно подчеркивает фигуру и станет незаменимым базовым элементом гардероба. 	2017-10-04 11:27:34.725166	2017-10-09 15:43:56.372536	\N	\N	1	Платье из плотного трикотажа	f	t	\N	70% вискоза, 30% полиэстер
80	14	7900.0		2017-09-08 13:13:56.736543	2017-10-03 11:48:01.220337	\N	\N	1	Платье-рубашка с асимметричным подолом	f	f	\N	84% модал, 16% п/э
83	19	3500.0		2017-09-08 13:51:52.166736	2017-10-03 11:54:37.453792	\N	\N	1	Трикотажный джемпер в полоску	f	f	\N	 70% пан, 30% шерсть
58	29	4950.0	Материал: 56% акрил, 18% мохер, 18% шерсть, 8% полиамид	2017-09-06 10:31:55.62946	2017-10-06 12:28:02.288046	\N	\N	1	Удлиненный кардиган с карманами	f	f	\N	\N
81	14	6800.0		2017-09-08 13:21:28.449158	2017-10-03 11:48:24.913866	\N	\N	1	Платье с металлизированной нитью	f	f	\N	80% хлопок, 20% лайкра
55	29	4400.0	Материал: 70% акрилик, 10% мохер, 10% нейлон, 10% альпака	2017-09-06 09:47:59.763776	2017-09-15 13:47:38.414292	\N	\N	2	Кардиган крупной вязки	f	f	\N	\N
152	43	3500.0	Шарф объемной вязки - идеальная пара к шапке.	2017-10-04 11:05:42.591086	2017-10-05 20:59:14.304381	\N	\N	1	Шарф 	f	t	\N	56% акрил, 18% мохер, 18% шерсть, 8% полиамид
76	33	4200.0		2017-09-08 09:37:13.802042	2017-10-03 11:54:51.72436	\N	\N	1	Оливковый джемпер	f	f	\N	66% хлопок, 30% п/э, 4% спандерс
161	22	1500.0		2017-10-04 14:33:15.907191	2017-10-06 11:36:00.498665	\N	\N	1	Ремень	f	t	\N	
73	33	4500.0		2017-09-08 08:29:43.546111	2017-10-03 11:55:06.664534	\N	\N	1	Джемпер с молнией	f	f	\N	100% хлопок
50	27	6200.0		2017-09-04 20:48:40.262638	2017-10-06 12:24:35.188649	\N	\N	1	Джинсы с бахромой	t	f	4960.0	 98% хлопок, 2% эластан
56	29	4400.0	Материал: 42% вискоза, 30% полиамид, 28% п/э	2017-09-06 10:02:02.08061	2017-10-06 12:28:33.352108	\N	\N	2	Кардиган с карманами 	f	f	\N	
90	14	7500.0		2017-09-08 15:04:07.901118	2017-10-03 11:48:40.357019	\N	\N	1	Платье-футляр с поясом	f	f	\N	63% п/э, 32% вискоза, 5% спандекс
85	36	9500.0	Рекомендуемая температура от +15 до +5	2017-09-08 14:00:55.297274	2017-10-09 11:49:50.962409	\N	\N	1	Красный тренч	f	f	7600.0	 64% п/э, 31% вискоза, 5% эластан
66	17	5800.0		2017-09-06 13:08:19.289244	2017-09-15 13:11:55.804177	\N	\N	2	Юбка в полоску	f	f	\N	\N
72	19	4400.0	Состав: 100% хлопок	2017-09-07 15:22:44.396238	2017-10-11 14:26:20.226201	\N	\N	2	Джемпер  удлинённый на молнии	f	f	\N	
164	45	1890.0		2017-10-11 15:07:35.890125	2017-10-11 15:37:22.641822	\N	\N	1	Чехол для iPhone	t	f	945.0	100% кожа
89	14	7100.0		2017-09-08 14:48:01.826838	2017-10-20 15:22:05.353232	\N	\N	1	Платье мини с бахромой	f	f	\N	 55% вискоза, 45% п/э
165	45	1690.0		2017-10-11 15:12:33.367664	2017-10-11 15:37:38.185082	\N	\N	1	Чехол для iPhone	t	f	845.0	100% кожа
91	26	18000.0	Элегантное пальто-халат из шерсти станет отличной базой для любого гардероба. Изделие имеет спущенную пройму и два боковых кармана\r\nСостав: 50% шерсть, 50% п/э \r\nПодклад: 65% вискоза, 35% п/э\r\nРекомендуемая температура: от +15 до -10	2017-09-08 15:48:56.468304	2017-10-01 13:22:00.364172	\N	\N	2	Пальто-халат в ёлочку 	f	f	\N	\N
166	45	2390.0		2017-10-11 15:17:48.712316	2017-10-11 15:37:53.510058	\N	\N	1	Чехол для iPad	t	f	1195.0	100% кожа
68	29	4400.0		2017-09-07 09:48:29.077251	2017-10-01 13:23:13.533989	\N	\N	2	Уютный зеленый кардиган	f	f	\N	\N
74	38	3550.0		2017-09-08 08:36:17.81915	2017-10-03 11:55:45.989502	\N	\N	1	Спортивные брюки	f	f	\N	100% хлопок
82	25	12800.0	Состав: 100% п/э	2017-09-08 13:32:47.584584	2017-10-13 14:47:25.376662	\N	\N	1	Укороченная куртка с капюшоном	f	f	\N	\N
75	25	14200.0	Рекомендуемая температура от +5 до -15	2017-09-08 08:57:17.045936	2017-10-03 11:36:29.368777	\N	\N	1	Удлиненная куртка с капюшоном	f	f	\N	100% п/э
62	24	11600.0	Состав: 29% вискоза, 3% эластан, 68% п/э	2017-09-06 12:46:25.992932	2017-09-29 10:47:14.678482	\N	\N	2	Брючный костюм в клетку	f	f	\N	\N
88	14	6800.0		2017-09-08 14:42:11.8116	2017-10-03 11:48:49.739269	\N	\N	1	Платье-футляр с белой строчкой	f	f	\N	100% п/э
67	31	2200.0		2017-09-07 09:42:15.91038	2017-10-03 11:51:35.632106	\N	\N	1	Блуза	f	f	\N	95% хлопок, 5% металлисеская нить
54	19	4200.0	Материал: 56% акрил, 18% мохер, 18% шерсть, 8% полиамид	2017-09-06 09:22:54.121885	2017-09-15 13:27:14.950123	\N	\N	2	Кардиган удлиненный	f	f	\N	\N
69	14	4500.0	Состав: 41% полиамид, 31% вискоза, 28% п/э	2017-09-07 10:29:04.201753	2017-09-29 10:52:32.835614	\N	\N	2	Трикотажное платье	f	f	\N	\N
84	30	4050.0		2017-09-08 13:55:54.856228	2017-10-03 12:00:58.379228	\N	\N	1	Кожаные брюки	f	f	\N	68% хлопок, 28% п/э, 4% эластан
52	24	22100.0		2017-09-04 21:52:20.012635	2017-10-03 11:45:26.743349	\N	\N	1	Костюм без застежек	t	f	17680.0	65% нейлон, 15% шёлк, 15% вискоза, 5% лайкра\r\nПодкладка: 100% вискоза
86	16	4700.0		2017-09-08 14:21:42.824118	2017-10-03 11:51:44.969236	\N	\N	1	Хлопковая рубашка	f	f	\N	 97% хлопок, 3% эластан
61	24	12100.0		2017-09-06 12:36:35.588087	2017-10-14 13:51:17.958895	\N	\N	2	Клетчатый брючный костюм	f	f	\N	65% п/э, 34% вискоза, 3% эластан
112	29	4400.0		2017-09-14 08:59:37.852703	2017-10-06 12:30:41.391307	\N	\N	1	Вязаный кардиган	t	f	3520.0	70% акрилик, 10% мохер, 10% нейлон, 10% альпака
101	14	9800.0	Платье-рубашка - базовая модель и несомненный фаворит уже многих сезонов. Этой осенью платье представлено в стильной зелено-желтой клетке.\r\n\r\n	2017-09-13 11:10:27.85294	2017-10-20 12:33:39.417609	\N	\N	2	Платье-рубашка в клетку	f	f	\N	 80% хлопок, 20% акрил
167	17	7500.0		2017-10-12 16:12:01.130354	2017-10-12 16:16:05.178165	\N	\N	1	Юбка перфорация	t	f	3750.0	
111	28	2950.0	Состав: 50% хлопок, 50% пан	2017-09-13 17:44:05.520779	2017-10-13 14:40:30.033003	\N	\N	1	Джемпер с воротом	f	f	\N	\N
155	14	7600.0	Романтичное платье из шифона, длинна миди. 	2017-10-04 13:08:49.473632	2017-10-24 16:05:52.304067	\N	\N	1	Платье с цветочным принтом	f	t	\N	100% полиэстер
71	17	4500.0		2017-09-07 15:16:39.62328	2017-10-24 10:17:00.975241	\N	\N	1	Юбка с молнией	f	f	\N	100% п/э
119	15	7400.0		2017-09-15 14:24:12.601173	2017-10-21 13:20:37.68584	\N	\N	2	Двубортный пиджак в клетку	f	f	\N	29% вискоза, 3% эластан, 68% п/э
51	28	4300.0		2017-09-04 21:36:54.691016	2017-10-22 09:03:36.135378	\N	\N	2	Свитер «плюшевый»	f	f	\N	50% акрилик, 19% шерсть, 29% нейлон, 2% эластан 
109	14	7600.0		2017-09-13 15:22:05.130122	2017-10-21 13:21:27.715724	\N	\N	2	Платье-футляр с пуговками	f	f	\N	 25%  шерсть, 25% вискоза, 26% акрил, 24% хлопок
120	26	18000.0	Женственное пальто длины миди с подчеркнутой линией талии. Модель имеет два кармана и пояс\r\nСостав: 50% шерсть, 50% п/э\r\nПодклад: 65% вискоза, 35% п/э\r\nРекомендуемая температура: от +15 до -10	2017-09-15 14:34:27.545473	2017-10-01 13:21:00.474995	\N	\N	2	Пальто халат	f	f	\N	\N
99	33	4400.0		2017-09-13 10:12:49.029873	2017-10-03 11:54:16.571159	\N	\N	1	Удлиненное худи с молнией	f	f	\N	100% хлопок
117	26	7700.0	Рекомендуемая температура от +15 до +5	2017-09-14 10:42:11.970328	2017-10-03 11:35:12.873905	\N	\N	1	Вязаное пальто с поясом	t	f	6160.0	60% акрилик, 20% п/э, 15% шерсть, 5% альпака
110	24	9800.0		2017-09-13 15:32:26.993609	2017-10-03 11:46:20.692689	\N	\N	1	Костюм в клетку с необычным воротом	f	f	\N	50% вискоза, 50% п/э
49	30	4500.0	Состав: 95% хлопок, 5% эластан, 54% полиуретан, 46% полиэстер	2017-09-04 16:16:46.762022	2017-09-15 13:55:14.631683	\N	\N	2	Зеленые брюки	f	f	\N	\N
94	26	18000.0	Объемное двубортное пальто длины макси создаёт образ "с характером" и делает любой комплект совершенно уникальным\r\nСостав: 50% шерсть, 50% п/э\r\nПодклад: 65% вискоза, 35% п/э\r\nРекомендуемая температура: от +15 до -10	2017-09-08 17:23:32.846548	2017-10-03 09:46:20.179669	\N	\N	2	Пальто-халат	f	f	\N	
107	24	9500.0	Состав: 50% п/э, 34% вискоза, 3% эластан	2017-09-13 14:59:01.669745	2017-10-02 11:22:14.338033	\N	\N	2	Костюм с брюками на резинке	f	f	\N	
98	33	6196.0	Состав: 65% вискоза, 31% п/э, 4% спандекс	2017-09-13 09:15:04.995821	2017-10-01 13:18:53.254919	\N	\N	2	Трикотажное платье с молнией	f	f	\N	\N
105	14	9900.0	Платье-мини без рукавов - отличная база для осеннего гардероба. Хорошо сочетается с блузой или водолазкой.\r\nСостав: 39% шерсть, 33% полиэстр, 14% вискоза, 13% полиамид, 1% эластан\r\nПодкладка: 50% вискоза, 50% полиэстр	2017-09-13 13:28:51.183076	2017-10-01 12:24:23.222974	\N	\N	2	Платье с воланом	f	f	\N	\N
114	15	8100.0		2017-09-14 09:24:41.741726	2017-10-03 11:49:48.12658	\N	\N	1	Приталенный пиджак 	f	f	\N	 91% хлопок, 6% п/э, 3% эластан
115	31	6500.0	Блуза приталенного кроя идеальна под заправку. Сочетаем с любыми юбками и брюками либо с платьем без рукавов. \r\n	2017-09-14 09:37:17.739197	2017-10-03 11:51:58.555307	\N	\N	1	Блуза в полоску	f	f	\N	100% хлопок
102	28	3700.0	Состав: 50% шерсть, 30% п/э, 20% хлопок	2017-09-13 12:41:26.817247	2017-10-01 12:12:44.930753	\N	\N	2	Джемпер-водолазка	f	f	\N	\N
92	26	16500.0	Пальто средней длины с воротником стойкой. Универсальный вариант на каждый день, подходящий и для офисного дресс-кода и для образов в стиле casual\r\nСостав: 90% шерсть, 10% п/э\r\nПодклад: 65% вискоза, 35% п/э\r\nРекомендуемая температура: от +15 до -10	2017-09-08 15:59:04.003395	2017-10-01 13:21:36.920769	\N	\N	2	Пальто со стойкой	f	f	\N	\N
104	24	10500.0	Состав костюма: 66% п/э, 32% вискоза, 2% спандекс\r\nФутболка: 92% хлопок, 8% эластан	2017-09-13 13:22:21.033561	2017-10-01 12:14:12.584628	\N	\N	2	Костюм тройка	f	f	\N	\N
106	36	7200.0	Рекомендуемая температура от  +15 до +5	2017-09-13 13:43:16.962756	2017-10-03 11:20:15.217155	\N	\N	1	Тренч "Морячка"	t	f	4320.0	100% хлопок
103	27	4900.0		2017-09-13 12:57:32.591341	2017-10-03 12:01:08.571884	\N	\N	1	Джинсы с высокой талией	f	f	\N	99% хлопок, 1% эластан
113	15	7500.0		2017-09-14 09:09:52.738611	2017-10-03 11:50:59.278881	\N	\N	1	Двубортный приталенный пиджак	f	f	\N	64% п/э, 31% вискоза, 5% эластан
118	40	8100.0		2017-09-14 18:33:31.7537	2017-10-03 12:00:05.980029	\N	\N	1	Комбинезон 	f	t	\N	51% хлопок, 46% нейлон, 3% спандекс
123	28	8500.0	Уютный джемпер с круглым вырезом отлично сочетается как с мини-юбками, так и с любыми брюками и джинсами\r\nСостав: 35% альпака, 30% меринос, 35% высокообъемный акрил	2017-09-19 13:01:20.240224	2017-09-29 20:02:05.685832	\N	\N	2	Объёмный свитер	f	f	\N	\N
168	20	6900.0		2017-10-12 16:19:55.670277	2017-10-23 11:24:37.059881	\N	\N	1	Топ перфорация	t	f	3450.0	
133	19	3900.0		2017-09-25 12:38:52.066985	2017-10-03 11:53:48.913293	\N	\N	1	Пуловер	f	t	\N	66% вискоза, 29% тонкая шерсть, 5% эластан
131	17	3500.0		2017-09-25 12:15:48.080862	2017-10-04 11:25:35.316387	\N	\N	1	Юбка плиссе на резинке	f	t	\N	15% шерсть, 50% акрил, 35% п/э
134	30	3200.0		2017-09-25 12:45:01.838212	2017-10-03 12:01:34.720185	\N	\N	1	Вельветовые брюки	f	t	\N	 98% хлопок, 2% эластан
129	14	5800.0	Универсальное платье на каждый день, сделано из хлопка самого высокого качества, неприхотливо в носке и уходе. Займёт достойное место в вашем гардеробе, сочетается с кроссовками, ботильонами, сапогами или грубыми ботинками.\r\nСостав: 100% хлопок	2017-09-20 16:08:08.622354	2017-09-29 16:15:10.011739	\N	\N	2	Платье-свитшот с кружевом	f	f	\N	\N
125	32	12900.0	Ультрамодный в этом сезоне двубортный oversize жакет отлично сочетается с юбкой-мини либо с прямыми или брюками-бананами. Взятая за основу классическая модель "с мужского плеча" дополнена поясом, чтобы подчеркнуть талию.\r\n	2017-09-19 13:40:10.52249	2017-10-03 11:49:10.502333	\N	\N	1	Жакет с поясом	f	t	\N	80% шерсть, 20% полиамид
136	17	3500.0		2017-09-25 13:18:01.522652	2017-10-04 11:27:52.48791	\N	\N	1	Юбка А-силуэта на резинке	f	t	\N	 15% шерсть, 50% акрил, 35% п/э
126	30	8500.0	Брюки-бананы на высокой посадке представлены в классическом костюмном цвете - кэмел. Идеально сочетаются с жакетом, а также с блузками и трикотажем.\r\n	2017-09-19 14:18:12.647381	2017-10-03 12:01:22.523411	\N	\N	1	Брюки-бананы	f	t	\N	 80% шерсть, 20% полиамид
140	27	3100.0		2017-09-25 17:56:47.72256	2017-10-13 14:49:59.249866	\N	\N	2	Джинсы skinny	f	t	\N	 98% хлопок, 2% эластан
148	41	2000.0		2017-09-27 09:52:53.442187	2017-09-27 09:52:53.442187	\N	\N	1	Подвеска с помпонами	f	t	\N	\N
141	24	5900.0	Состав: 30% полиамид, 30% вискоза, 20% модал, 20% эластан	2017-09-25 18:03:29.663147	2017-09-27 12:28:54.949412	\N	\N	2	Трикотажный костюм с юбкой	f	t	\N	\N
130	28	2700.0		2017-09-25 11:32:44.10357	2017-10-16 09:44:36.725142	\N	\N	1	Джемпер "Пушистик"	f	t	\N	100% п/э
135	29	3500.0	Состав: 60% акрил, 20% мохер, 10% нейлон, 10% шерсть	2017-09-25 12:59:54.012166	2017-10-01 13:22:53.145143	\N	\N	2	Кардиган с геометрическим принтом	f	t	\N	\N
156	14	5050.0	Платье прямого кроя с V-образным вырезом на спине и длинными рукавами. Пояс съёмный.	2017-10-04 13:26:13.103943	2017-10-05 10:22:09.156049	\N	\N	1	Платье в V-образным вырезом на спине	f	t	\N	45% шерсть, 55% п/э
160	28	3150.0	Водолазка с высоким воротником и длинными рукавами прекрасная база Вашего гардероба	2017-10-04 14:24:49.035603	2017-10-05 10:30:32.219217	\N	\N	1	Водолазка	f	t	\N	60% шерсть, 30% вискоза, 5% полиэстер, 5% эластан
144	26	8700.0	Состав: 100% п/э	2017-09-26 08:13:13.947941	2017-10-09 12:09:09.122384	\N	\N	1	Стеганное пальто	f	t	\N	
138	19	6400.0		2017-09-25 13:34:18.435086	2017-10-03 11:53:37.815865	\N	\N	1	Джемпер с фигурным рукавом	f	t	\N	 62% вискоза, 30% п/э, 8% ангора
169	14	10900.0		2017-10-12 16:36:13.581161	2017-10-12 16:36:13.581161	\N	\N	1	Сарафан мини с кружевом	t	f	5450.0	
132	14	8900.0		2017-09-25 12:31:57.988442	2017-10-03 11:47:13.259046	\N	\N	1	Платье с V-образным вырезом	f	t	\N	63% вискоза, 37% полиамид
147	41	2800.0		2017-09-26 20:35:01.730533	2017-10-09 15:06:54.797759	\N	\N	2	Серьги с фианитами и майоркой	f	f	\N	
139	20	5900.0		2017-09-25 13:38:04.409508	2017-10-03 11:57:59.578914	\N	\N	1	Матроска с вышивкой	f	f	\N	95% хлопок, 5% вискоза
145	21	5500.0		2017-09-26 08:18:39.187108	2017-10-11 13:08:46.208841	\N	\N	2	Сумка мешок	f	t	\N	100% натуральная замша
137	21	7600.0		2017-09-25 13:27:19.144541	2017-10-13 09:48:31.280118	\N	\N	2	Сумка с золотой пряжкой	t	f	3800.0	100% кожа
170	14	11700.0		2017-10-12 16:41:52.439621	2017-10-12 16:41:58.324988	\N	\N	1	Платье макси на широких бретелях	t	f	5850.0	
127	17	7700.0	Юбка-мини на высокой посадке безупречно подчеркивает талию за счет широкого пояса с обтяжной пряжкой. Идеально сочетается с любой блузой или джемпером. Подобный образ подойдет как для офиса, так и для романтического свидания.	2017-09-19 14:50:47.888029	2017-10-13 09:44:44.988985	\N	\N	1	Юбка-мини с поясом	f	f	\N	\N
142	27	2950.0		2017-09-25 18:16:40.586584	2017-10-03 12:02:06.065062	\N	\N	1	Джинсы бойфренды	f	t	\N	 98% хлопок, 2% эластан
172	14	10500.0		2017-10-13 16:22:11.925923	2017-10-13 16:27:45.795055	\N	\N	1	Платье с воланами 	t	f	5250.0	
175	14	12000.0		2017-10-14 14:29:55.692127	2017-10-15 10:14:44.855815	\N	\N	1	Платье-мини на тонких бретелях	t	f	6000.0	
146	41	4000.0		2017-09-26 10:08:46.762747	2017-10-16 09:42:42.874092	\N	\N	2	Подвеска с Буддой	f	t	\N	
199	24	6800.0		2017-10-16 13:16:03.305736	2017-10-16 13:18:51.548622	\N	\N	1	Костюм в полоску (топ и брюки)	t	f	3400.0	
143	20	2500.0		2017-09-26 06:37:09.400285	2017-10-19 14:10:36.119614	\N	\N	2	Футболка "Head in the clouds"	f	f	\N	97% хлопок, 3% эластан
181	33	4200.0	Оригинальный свитшот прямого силуэта из мягкого трикотажа. Приспущенная линия плеча, длинные рукава из яркой желтой плащевой ткани. Окончательную выразительность свитшоту придает необычная декоративная деталь на спинке - люверсы.	2017-10-15 11:28:25.870408	2017-10-15 11:28:25.870408	\N	\N	1	Свитшот с рукавами из плащевой ткани	f	t	\N	70% п/э, 30% хлопок
121	32	14900.0	Классическая модель "с мужского плеча" дополнена поясом, чтобы подчеркнуть талию. Создаст ультрамодный комплект с юбкой-мини либо более спокойный офисный образ - с прямыми или брюками-бананами\r\nСостав: 70% шерсть, 15% полиэстер, 10% акрил, 4% полиамид, 1% эластан\r\n	2017-09-19 12:47:35.416346	2017-09-29 16:16:06.603166	\N	\N	2	Двубортный жакет мужского кроя	f	f	\N	\N
149	27	5500.0		2017-09-27 20:00:23.489801	2017-10-09 09:59:58.814812	\N	\N	2	Брюки с лампасами	f	f	\N	 91% хлопок, 6% п/э, 3% эластан
182	16	4500.0	Классическая рубашка прямого силуэта из стрейчевой хлопковой ткани декорированная яркими контрастными линиями. 	2017-10-15 11:33:56.841249	2017-10-15 11:33:56.841249	\N	\N	1	Рубашка прямого силуэта 	f	t	\N	76% хлопок, 22% п/э, 2% спандекс
157	28	3700.0	Горловина на свитере обработана планкой. Модель прекрасно сочетается с джинсами, брюками и юбкой-карандашом.	2017-10-04 13:42:11.58713	2017-10-05 10:25:47.90582	\N	\N	1	Объемный свитер с планкой 	f	t	\N	48% шерсть, 27% полиэстер, 20% вискоза, 5% эластан
159	24	9350.0	Пиджак свободного кроя на пуговицах. Съемный пояс.\r\nБрюки с высокой посадкой прямого кроя со стрелками. 	2017-10-04 14:01:07.863594	2017-10-05 10:28:05.964633	\N	\N	1	Брючный костюм в полоску	f	t	\N	40% шерсть, 22% вискоза, 22% полиэстер, 16% полиамид
128	29	11500.0	Объемный кардиган - лучший выбор на раннюю осень, он с легкостью заменит тонкое пальто или плащ. Сочетается с нежными платьями и обувью на каблуке, либо дополнит более спортивный образ с кроссовками.\r\n	2017-09-19 15:12:13.700505	2017-10-12 10:15:52.808951	\N	\N	1	Объемный кардиган	f	t	\N	 35% альпака, 30% шерсть, 35% акрил
158	24	8300.0	Комплект из костюмной ткани. Рубашка с рукавом летучая мышь. Юбка-карандаш с разрезом спереди. Отдельная деталь в комплекте: пояс-сумка на подкладке.	2017-10-04 13:51:05.159231	2017-10-05 10:29:31.492959	\N	\N	1	Комплект с сумкой на поясе	f	t	\N	97% хлопок, 3% эластан
162	26	20900.0	Благодаря спортивному стилю,  длине миди, воротнику-стойке и крупной декоративной отстрочке, пуховик  выглядит остромодно!Представлен в стильной клетке. За счет высокотехнологичного утеплителя Shelter пуховик гарантирует, что вы не замерзнете, даже когда на улице -20.  	2017-10-05 13:27:51.229416	2017-10-05 13:49:38.537373	\N	\N	1	Пальто клетчатое	f	t	\N	70% шерсть, 30% полиэстер
150	26	20900.0	Длинное пальто-халат дополнено отстегивающейся утепленной подкладкой, чтобы носить его и ранней, и поздней осенью. За счет высокотехнологичного утеплителя Shelter пальто можно носить также всю зиму, что делает его универсальным. 	2017-10-04 09:50:51.375581	2017-10-22 08:33:07.889022	\N	\N	1	Пальто-халат	f	t	\N	78% шерсть, 22% полиамид
173	14	9500.0		2017-10-14 10:27:36.382274	2017-10-14 10:27:36.382274	\N	\N	1	Платье-мини на одно плечо	t	f	5700.0	
176	39	6800.0		2017-10-15 10:39:38.118198	2017-10-15 10:39:38.118198	\N	\N	1	Костюм с журавлем	f	t	\N	98% хлопок, 2% эластан
177	39	6000.0		2017-10-15 10:41:44.88895	2017-10-15 10:41:44.88895	\N	\N	1	Костюм с гейшей	f	t	\N	98% хлопок, 2% эластан
183	19	3700.0	Теплый свитшот силуэта трапеция из мягкого плотного трикотажа c красивым широким воротником-стойкой.  Фигурная линия низа: перед короче спинки-еще одна особенность у этой модели.	2017-10-15 12:00:47.017176	2017-10-15 12:58:37.189467	\N	\N	1	Джемпер с объемным воротником 	f	t	\N	64% п/э, 34% вискоза, 2% спандекс
179	24	11700.0	Стильный однобортный жакет прямого силуэта и удобные брюки из мягкой костюмной ткани. Оригинальность модели придают большие накладные карманы с дизайнерской репсовой тесьмой и небольшая нашивка на спинке жакета.\r\n \r\n	2017-10-15 11:16:28.253132	2017-10-15 12:52:13.252786	\N	\N	1	Костюм с декором на карманах 	f	t	\N	65% п/э, 32% вискоза, 3% спандекс\r\n
178	25	8820.0		2017-10-15 10:45:56.477579	2017-10-15 12:57:20.869671	\N	\N	1	Куртка с рыжими застежками 	f	t	\N	100% полиэстер
194	14	13100.0		2017-10-16 12:47:26.802497	2017-10-16 12:52:11.848595	\N	\N	1	Платье с волами ассиметрия	t	f	5440.0	
195	14	11000.0		2017-10-16 12:51:19.077481	2017-10-16 12:55:42.058092	\N	\N	1	Платье с объемным принтом	t	f	5500.0	
196	14	13000.0		2017-10-16 13:01:14.009433	2017-10-16 13:03:25.931176	\N	\N	1	Платье с окантовкой	t	f	6500.0	
197	14	6600.0		2017-10-16 13:08:04.762501	2017-10-16 13:09:29.329984	\N	\N	1	Платье на одно плечо 	t	f	3300.0	
171	14	9400.0		2017-10-12 16:45:41.731901	2017-10-16 17:16:46.189963	\N	\N	2	Платье с воланами 	t	f	4699.0	
184	16	5100.0	Стильная двусторонняя хлопковая рубашка свободного силуэта с фигурной линией низа и разрезами по бокам. Оригинальность модели придаёт необычное расположение застёжки - по линии плеча, а также интересный воротник- стойка с одной стороны и рубашечный с другой, что позволяет экспериментировать с образами.	2017-10-15 12:15:56.145415	2017-10-15 12:15:56.145415	\N	\N	1	Удлиненная блузка	f	t	\N	67% хлопок, 29% нейлон, 4% спандекс
180	33	4900.0	Свободный свитшот с капюшоном из мягкого трикотажа и фигурной линией низа. Яркость образу придадут длинные цельнокроеные рукава с яркими оригинальными линиями.	2017-10-15 11:21:58.487927	2017-10-15 12:24:13.272513	\N	\N	1	Свитшот с полосками на рукавах	f	t	\N	70% п/э, 30% хлопок
186	33	4900.0	Свитшот модного силуэта oversize из хлопкового трикотажа, создающего эффект мерцания с оригинальным дизайнерским принтом. Длинные рукава-реглан с  неширокой линией из нежного ажурного кружева розового цвета.	2017-10-15 12:26:44.837404	2017-10-15 12:26:44.837404	\N	\N	1	Свитшот со вставками из кружева	f	t	\N	96% п/э, 4% спандекс
185	33	5300.0	 Стильный свитшот из мягкого хлопкового трикотажа с оригинальной дизайнерской печатью. Рукава длинные с манжетами, а капюшон со шнуровкой-утяжкой.	2017-10-15 12:23:51.509781	2017-10-15 12:28:40.158436	\N	\N	1	Свитшот с капюшоном 	f	t	\N	97% п/э, 3% спандекс
187	39	8300.0	Удобный свитшот свободного силуэта из плотного трикотажа с фактурной полосой. Пояс брюк на эластичной тесьме. 	2017-10-15 12:38:15.546794	2017-10-15 12:38:51.632156	\N	\N	1	Костюм из фактурной ткани	f	t	\N	62% п/э, 38% вискоза
97	39	11700.0	Уютный костюм из футера - укороченная толстовка и брюки идеален для тех, кто не хочет расставаться с комфортом. \r\nСостав: 50% хлопок, 50% п/э	2017-09-13 09:05:18.151425	2017-10-15 13:01:59.377449	\N	\N	2	Костюм из футера	f	f	\N	
188	27	4600.0	 Джинсы boyfriend модной длины 7/8 из стрейчевой джинсовой ткани. Сзади  присутствуют большие накладные карманы с декоративными строчками.	2017-10-15 13:15:57.167113	2017-10-15 13:15:57.167113	\N	\N	1	Джинсы мужского кроя	f	t	\N	55%  хлопок, 40% п/э, 5% эластан
189	30	4900.0	Прямые брюки модной длины 7/8 из стрейчевой костюмной ткани со стрелками. Оригинальность модели придают лампасы из итальянской тесьмы в яркую красно-желтую полоску.	2017-10-15 13:18:43.898146	2017-10-15 13:18:43.898146	\N	\N	1	Брюки с лампасами	f	t	\N	97% п/э, 3% спандекс
190	17	4700.0	Стильная юбка силуэта трапеция и длиной миди из плотной костюмной ткани. Оригинальность модели придают необычные заложенные складки. 	2017-10-15 13:23:14.840493	2017-10-15 13:23:14.840493	\N	\N	1	Юбка миди	f	t	\N	96% п/э, 4% спандекс
191	14	8500.0	Необычное платье длиной до колена, расширенное книзу, из плотной хлопковой ткани с оригинальным принтом.	2017-10-15 14:04:43.094159	2017-10-15 14:04:43.094159	\N	\N	1	Платье в белый горошек	f	t	\N	49% п/э, 48% хлопок, 3% спандекс
193	25	8500.0	Свободная куртка с капюшоном из плащевой ткани с водоотталкивающим покрытием и бельгийским утеплителем. Оригинальность модели придают тоненькие репсовые ленточки с дизайнерской печатью. 	2017-10-15 14:10:43.316559	2017-10-22 14:48:45.357862	\N	\N	1	Куртка с капюшоном	f	t	\N	100% п/э
192	25	10400.0	Стильная укороченная куртка модного силуэта с красивым дизайнерским принтом на спинке и вышивкой спереди. Внутри - бельгийский утеплитель . Необычность модели придаёт плотно прилегающий к телу потайной пояс с застежкой на кнопки. 	2017-10-15 14:08:59.420033	2017-10-22 14:48:55.135677	\N	\N	1	Куртка с надписью	f	t	\N	100% п/э
198	14	8700.0		2017-10-16 13:11:39.274884	2017-10-16 13:17:09.198207	\N	\N	1	Платье футляр в белый горох	t	f	4350.0	
200	31	9900.0		2017-10-16 13:27:35.13064	2017-10-16 13:29:37.783324	\N	\N	1	Блуза в полоску	t	f	7920.0	
201	20	4800.0		2017-10-16 13:32:45.247484	2017-10-16 13:33:27.781543	\N	\N	1	Топ с асимметричным низом 	t	f	2400.0	
202	17	7700.0		2017-10-16 13:34:43.00681	2017-10-16 13:39:40.047285	\N	\N	1	Юбка-мини кружевная	t	f	3850.0	
204	17	5700.0		2017-10-16 13:51:27.251358	2017-10-16 13:53:44.994733	\N	\N	1	Юбка-мини с карманами	t	f	2850.0	
206	32	7400.0		2017-10-16 14:01:22.151018	2017-10-16 14:06:45.160368	\N	\N	1	Джинсовый жилет	t	f	3700.0	
205	17	7500.0		2017-10-16 13:54:44.954289	2017-10-17 14:52:13.323554	\N	\N	2	Юбка-миди перфорация	t	f	3750.0	
203	31	5200.0		2017-10-16 13:43:25.330438	2017-10-17 15:03:13.401859	\N	\N	1	Блуза перфорация с разрезом на спине	t	f	2600.0	
207	31	6200.0		2017-10-16 14:03:50.009369	2017-10-20 10:30:59.280791	\N	\N	2	Блуза 	t	f	3100.0	
208	14	14700.0		2017-10-16 14:14:54.921383	2017-10-16 14:23:56.392809	\N	\N	1	Платье	t	f	11760.0	
209	24	13050.0		2017-10-16 14:30:41.540984	2017-10-16 14:30:41.540984	\N	\N	1	Костюм (жакет и шорты)	t	f	6525.0	
163	26	23900.0	Тёплое стеганное пальто в длине миди, с пряжкой на поясе. За счет высокотехнологичного утеплителя пальто можно носить также всю зиму. \r\nРекомендуемая температура: от 0 до -25	2017-10-05 13:47:09.15286	2017-10-24 10:15:42.141949	\N	\N	1	Стеганное пальто 	f	t	\N	Верх: 80% шерсти, 20% п/э\r\nПодкладка: 52% вискоза, 48% п/э\r\nУтеплитель: 100% п/э\r\n
211	29	8250.0	Прекрасный вариант на холодную погоду-блейзер из ангоры с длинным рукавом. V-образный вырез на подкладке, застегивается на кнопочки. 	2017-10-18 16:11:17.692292	2017-10-18 16:11:39.74025	\N	\N	1	Блейзер из ангоры	f	t	\N	100% ангора
213	39	8250.0	Кардиган из плотного трикотажа на пуговицах. Имеет на себе два кармашка спереди. Добавляют в образ женственности такие детали как пояс и манжеты на рукавах и брючках.\r\n	2017-10-18 16:29:00.189097	2017-10-18 16:29:00.189097	\N	\N	1	Комплект из кардигана и брюк	f	t	\N	50% хлопок, 50% акрил
212	19	10.0		2017-10-18 16:20:23.137426	2017-10-18 16:37:38.54221	\N	\N	1	Водолазка с узором	f	f	\N	
210	28	7250.0	Нежного оттенка водолазка фактурной вязки из приятного трикотажа с добавлением кашемира.	2017-10-17 14:45:45.647465	2017-10-18 16:38:19.09219	\N	\N	1	Водолазка с узором	f	t	\N	10% кашемир, 40% шерсть мериноса, 30% вискоза, 20% полиамид
214	24	9350.0	Классический костюм из вельвета. Однобортный пиджак на подкладке, застегивается на одну пуговицу.	2017-10-18 16:46:05.795265	2017-10-18 16:46:05.795265	\N	\N	1	Костюм из вельвета	f	t	\N	90% хлопок, 10% п/э
78	26	9900.0	\r\nРекомендуемая температура: от +15 до -10	2017-09-08 09:58:54.238771	2017-10-22 14:48:09.882758	\N	\N	1	Пальто на молнии с вышивкой 	f	f	\N	 65 % п/э, 33% лайкра, 2% эластан
218	29	4900.0		2017-10-19 14:35:11.683672	2017-10-19 14:35:11.683672	\N	\N	1	Кардиган с разрезом	t	f	3920.0	70% акрил, 30% шерсть
217	24	17000.0		2017-10-19 14:31:34.794522	2017-10-19 14:35:56.411726	\N	\N	1	Костюм (бомбер+брюки)	t	f	13600.0	95% хлопок,5% лайкра
222	41	2800.0	Красивое и лаконичное колье с использованием натурального крупного серого жемчуга.	2017-10-22 12:16:20.076053	2017-10-22 12:16:20.076053	\N	\N	1	Колье с натуральным серым жемчугом	f	t	\N	
219	32	12500.0		2017-10-19 14:40:32.959168	2017-10-19 14:50:43.402652	\N	\N	1	Укороченный жакет с бантом	t	f	8750.0	63% п/э, 33% рэйон, 4% спандекс
216	27	4400.0	Прямые джинсы с завышенной талией и подворотами снизу. Имеют на себе боковые и задние накладные карманы.\r\n	2017-10-18 16:52:41.244617	2017-10-19 20:18:51.436864	\N	\N	0	Джинсы с завышенной талией	f	t	\N	100% хлопок
215	24	8580.0		2017-10-18 16:49:47.980486	2017-10-19 20:40:45.640156	\N	\N	1	Комплект из джинсы 	f	t	\N	100% хлопок
220	14	12600.0		2017-10-20 10:21:43.989813	2017-10-20 10:23:38.711956	\N	\N	1	Платье в пол с бантом	t	f	10080.0	
221	40	19800.0		2017-10-20 10:25:20.157963	2017-10-20 10:28:16.032275	\N	\N	1	Комбинезон 	t	f	5940.0	
224	41	2000.0	Подвеска с маленькими натуральными жемчужинами подойдет под любой ваш образ.	2017-10-22 13:17:29.901459	2017-10-22 20:14:30.520786	\N	\N	1	Подвеска с белым жемчугом 	f	t	\N	
174	21	6100.0		2017-10-14 10:57:40.968993	2017-10-23 13:24:57.015952	\N	\N	2	Сумка с ремешком на плечо 	f	f	3050.0	
95	26	20500.0	Новинка сезона - укороченное пальто-трансформер, включает в себя жакет и жилет. Модель с прорезными карманами, отстрочкой в тон, удобной застежкой на магнитах на жакете.\r\n\r\nРекомендуемая температура: от +15 до -10	2017-09-08 18:10:05.07688	2017-10-22 14:47:52.942941	\N	\N	1	Пальто-комбинация	f	f	\N	 70% шерсть, 20% п/а, 10% кашемир
225	41	1800.0	Аккуратный сверкающий браслет с хамсой и натуральной жемчужиной.	2017-10-22 13:36:49.205645	2017-10-22 20:13:11.971082	\N	\N	1	Браслет с хамсой 	f	t	\N	
223	41	3000.0	Комплект браслетов из натурального серого жемчуга и белой майорки. Особенность комплекту добавляет  такая деталь как роза, находящаяся на одном из браслетов.	2017-10-22 12:32:46.677556	2017-10-22 20:13:00.66664	\N	\N	1	Комплект браслетов из жемчуга и майорки	f	t	\N	
226	41	3500.0	Нежный комплект с кварцем, палочкой из кристаллов Сваровски и подвеской с пальмой.	2017-10-22 13:47:38.456542	2017-10-22 20:13:25.774223	\N	\N	1	Комплект с кварцем и подвесками	f	t	\N	
227	41	3500.0	Комплект подвесок из натурального агата с капелькой Сваровски.	2017-10-22 14:20:42.305719	2017-10-22 20:14:10.050603	\N	\N	1	Комплект подвесок из агата и капелькой Сваровски	f	t	\N	
124	26	18500.0	Модель выполнена из мягкой уютной ткани. Пальто формирует красивый лаконичный силуэт, при этом, всегда можно подчеркнуть линию талии поясом. Идеально сочетается с обувью и аксессуарами как в спортивном стиле, так и классическом, так что вы сможете носить его как в офисные будни так и в выходные!\r\n\r\nРекомендуемая температура: от +15 до -10	2017-09-19 13:19:04.059876	2017-10-22 14:47:43.084974	\N	\N	1	Пальто-кокон с поясом	f	t	\N	 72% шерсть, 28% хлопок
229	41	3500.0	Сет браслетов с агатом, сердечками Сваровски в оправе и кожаным шнурочком в цвете бордо.	2017-10-22 14:38:11.208666	2017-10-22 20:13:45.398748	\N	\N	1	Комплект браслетов с агатом, сердечками Сваровски и кожаным шнурком	f	t	\N	
228	41	3000.0	Комплект брошей ручной работы с помпонами, шелковыми лентами, жемчугом и перламутром подчеркнет вашу нежность.	2017-10-22 14:31:44.245925	2017-10-22 20:13:55.822297	\N	\N	1	Броши ручной работы с бежевыми помпонами 	f	t	\N	
238	41	2300.0	Изящное сердечко Сваровски на тонкой леске будет приковывать взгляды своим сиянием.	2017-10-23 10:39:09.446123	2017-10-23 15:32:43.492326	\N	\N	1	Сердце Сваровски на леске	f	t	\N	
230	41	3500.0	 Комплект браслетов с натуральным граненым агатом, мадагаскарским розовым кварцем, перламутровыми звездочками и натуральным жемчугом.	2017-10-23 08:57:03.823302	2017-10-23 15:33:18.920116	\N	\N	1	Комплект браслетов из граненого агата, кварца и перламутровых звездочек	f	t	\N	
231	41	2500.0	Красивая ручка-хамса Сваровски с натуральной белой жемчужиной на цепочке.	2017-10-23 09:10:57.53779	2017-10-23 15:33:25.621348	\N	\N	1	Подвеска с хамсой и натуральным жемчугом	f	t	\N	
232	41	3500.0	Комплект из двух подвесок с натуральным жемчугом.	2017-10-23 09:14:32.393007	2017-10-23 15:33:31.81042	\N	\N	1	Комплект подвесок с монеткой и жемчугом	f	t	\N	
233	41	3500.0	Натуральный розовый жемчуг, изящный розовый бисер и подвески peace&star с россыпью Сваровски.	2017-10-23 10:05:30.399307	2017-10-23 15:33:38.533786	\N	\N	1	Комплект браслетов из жемчуга, бисера и подвесок Сваровски	f	t	\N	
234	41	3000.0	Нежная подвеска с натуральным жемчугом и балийским перламутром. 	2017-10-23 10:10:46.641158	2017-10-23 15:33:46.782678	\N	\N	1	Подвеска с жемчугом и перламутровым сердцем	f	t	\N	
235	41	3000.0	Браслеты с розовым жемчугом Майорка, сердечками Сваровски и солнечным камнем на кожаном шнурочке. 	2017-10-23 10:17:26.955131	2017-10-23 15:33:54.964179	\N	\N	1	Комплект браслетов из органического жемчуга, сердец Сваровски и солнечного камня	f	t	\N	
236	41	2000.0	Брошь с помпоном, шелковой лентой и натуральным жемчугом сможет легко и красиво подчеркнуть лацканы жакетов и свитеры.	2017-10-23 10:24:23.383261	2017-10-23 15:34:00.654945	\N	\N	1	Брошь с помпоном и натуральным жемчугом	f	t	\N	
237	41	3000.0	Комплект брошей с натуральным жемчугом, шелковыми лентами и милейшим помпоном.	2017-10-23 10:35:52.424596	2017-10-23 15:34:05.867517	\N	\N	1	Комплект брошей ручной работы с помпоном и жемчугом	f	t	\N	
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('products_id_seq', 238, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY schema_migrations (version) FROM stdin;
20170413115308
20170413115313
20170413132022
20170414141443
20170414145209
20170415054419
20170421111339
20170424090812
20170505144933
20170505151426
20170506043402
20170510091423
20170510105946
20170510122153
20170615145308
20170628145212
20170704144949
20170704150006
20170704194848
20170704201807
20170814135425
20170814143346
20170814143454
20170814160629
20170815081345
20170817081640
20170817094221
20170817094256
20170817145145
20170818125950
20170818131617
20170818131637
20170821090405
20170904094148
20170906092522
20170906141027
20170907090825
20170907093805
20170911095619
20170911140121
20170911141012
20170911161016
20170913150347
20170914104047
20170914111646
20170914131922
20170915143334
20170919113259
20170925201216
20170929092403
20170929134529
20171001152538
20171002095818
20171003101817
\.


--
-- Data for Name: similarables; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY similarables (id, product_id, similar_product_id, created_at, updated_at) FROM stdin;
1	62	61	2017-09-19 14:55:21.280214	2017-09-19 14:55:21.280214
2	62	110	2017-09-19 14:55:21.284469	2017-09-19 14:55:21.284469
3	97	185	2017-10-15 13:01:59.34189	2017-10-15 13:01:59.34189
4	114	113	2017-10-23 11:17:56.356575	2017-10-23 11:17:56.356575
5	110	159	2017-10-23 11:19:20.416548	2017-10-23 11:19:20.416548
6	159	110	2017-10-23 11:20:17.611521	2017-10-23 11:20:17.611521
8	217	52	2017-10-23 11:23:22.20012	2017-10-23 11:23:22.20012
9	179	52	2017-10-23 11:25:07.173485	2017-10-23 11:25:07.173485
10	52	179	2017-10-23 11:25:41.229003	2017-10-23 11:25:41.229003
11	52	217	2017-10-23 11:26:55.332092	2017-10-23 11:26:55.332092
12	219	113	2017-10-23 11:28:48.924419	2017-10-23 11:28:48.924419
13	219	114	2017-10-23 11:28:48.928122	2017-10-23 11:28:48.928122
14	113	114	2017-10-23 11:29:37.846595	2017-10-23 11:29:37.846595
15	113	219	2017-10-23 11:29:37.848958	2017-10-23 11:29:37.848958
16	114	219	2017-10-23 11:30:18.06742	2017-10-23 11:30:18.06742
17	86	200	2017-10-23 11:31:07.723539	2017-10-23 11:31:07.723539
18	86	182	2017-10-23 11:31:07.725909	2017-10-23 11:31:07.725909
19	115	182	2017-10-23 11:32:02.054585	2017-10-23 11:32:02.054585
20	115	86	2017-10-23 11:32:02.057791	2017-10-23 11:32:02.057791
21	182	200	2017-10-23 11:32:51.053553	2017-10-23 11:32:51.053553
22	182	86	2017-10-23 11:32:51.055705	2017-10-23 11:32:51.055705
23	184	200	2017-10-23 11:33:42.513526	2017-10-23 11:33:42.513526
24	200	184	2017-10-23 11:34:07.969895	2017-10-23 11:34:07.969895
25	210	160	2017-10-23 11:35:04.68155	2017-10-23 11:35:04.68155
26	160	212	2017-10-23 11:35:29.661458	2017-10-23 11:35:29.661458
27	160	210	2017-10-23 11:35:29.663569	2017-10-23 11:35:29.663569
28	138	183	2017-10-23 11:35:58.585762	2017-10-23 11:35:58.585762
29	183	138	2017-10-23 11:36:15.996789	2017-10-23 11:36:15.996789
30	139	154	2017-10-23 11:37:05.453477	2017-10-23 11:37:05.453477
31	154	139	2017-10-23 12:03:17.844149	2017-10-23 12:03:17.844149
32	167	190	2017-10-23 12:08:07.380135	2017-10-23 12:08:07.380135
33	190	205	2017-10-23 12:09:11.589086	2017-10-23 12:09:11.589086
34	142	188	2017-10-23 12:15:08.237064	2017-10-23 12:15:08.237064
35	188	142	2017-10-23 12:18:46.777506	2017-10-23 12:18:46.777506
36	221	118	2017-10-23 12:19:50.694794	2017-10-23 12:19:50.694794
37	221	221	2017-10-23 12:19:50.697415	2017-10-23 12:19:50.697415
38	118	118	2017-10-23 12:21:15.26386	2017-10-23 12:21:15.26386
39	118	221	2017-10-23 12:21:15.267505	2017-10-23 12:21:15.267505
40	63	95	2017-10-23 12:24:39.755848	2017-10-23 12:24:39.755848
41	95	63	2017-10-23 12:25:50.217874	2017-10-23 12:25:50.217874
42	78	95	2017-10-23 12:26:12.373163	2017-10-23 12:26:12.373163
43	95	78	2017-10-23 12:26:30.477847	2017-10-23 12:26:30.477847
44	193	192	2017-10-23 12:26:57.296929	2017-10-23 12:26:57.296929
45	192	193	2017-10-23 12:27:15.038543	2017-10-23 12:27:15.038543
46	180	185	2017-10-23 12:27:57.226923	2017-10-23 12:27:57.226923
47	185	180	2017-10-23 12:51:36.373792	2017-10-23 12:51:36.373792
48	180	186	2017-10-23 12:52:34.176796	2017-10-23 12:52:34.176796
49	180	181	2017-10-23 12:52:50.144866	2017-10-23 12:52:50.144866
50	181	186	2017-10-23 12:53:25.051798	2017-10-23 12:53:25.051798
51	181	180	2017-10-23 12:53:25.054996	2017-10-23 12:53:25.054996
52	186	180	2017-10-23 12:53:43.81824	2017-10-23 12:53:43.81824
53	186	181	2017-10-23 12:53:43.820522	2017-10-23 12:53:43.820522
54	187	177	2017-10-23 12:54:34.874691	2017-10-23 12:54:34.874691
55	187	176	2017-10-23 12:54:34.878438	2017-10-23 12:54:34.878438
56	177	187	2017-10-23 12:55:12.45251	2017-10-23 12:55:12.45251
57	177	176	2017-10-23 12:55:12.455842	2017-10-23 12:55:12.455842
58	176	187	2017-10-23 12:55:41.264798	2017-10-23 12:55:41.264798
59	176	177	2017-10-23 12:55:41.268097	2017-10-23 12:55:41.268097
\.


--
-- Name: similarables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('similarables_id_seq', 59, true);


--
-- Data for Name: themables; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY themables (id, product_id, theme_id, created_at, updated_at) FROM stdin;
210	105	11	2017-09-26 21:24:01.392771	2017-09-26 21:24:01.392771
167	104	11	2017-09-13 13:22:21.036188	2017-09-13 13:22:21.036188
56	50	13	2017-09-04 20:48:40.265834	2017-09-04 20:48:40.265834
59	52	11	2017-09-04 21:52:20.015286	2017-09-04 21:52:20.015286
172	107	11	2017-09-13 14:59:01.673027	2017-09-13 14:59:01.673027
66	55	17	2017-09-06 09:47:59.768275	2017-09-06 09:47:59.768275
176	109	11	2017-09-13 15:22:05.132895	2017-09-13 15:22:05.132895
177	110	11	2017-09-13 15:32:26.996116	2017-09-13 15:32:26.996116
72	58	17	2017-09-06 10:31:55.63436	2017-09-06 10:31:55.63436
77	61	11	2017-09-06 12:36:35.59079	2017-09-06 12:36:35.59079
78	62	11	2017-09-06 12:46:25.995545	2017-09-06 12:46:25.995545
185	87	15	2017-09-14 17:15:33.870538	2017-09-14 17:15:33.870538
187	118	16	2017-09-14 18:33:31.75659	2017-09-14 18:33:31.75659
92	73	12	2017-09-08 08:29:43.549412	2017-09-08 08:29:43.549412
93	74	12	2017-09-08 08:36:17.821731	2017-09-08 08:36:17.821731
95	76	12	2017-09-08 09:37:13.804693	2017-09-08 09:37:13.804693
191	71	12	2017-09-15 03:37:45.664964	2017-09-15 03:37:45.664964
109	86	11	2017-09-08 14:21:42.826713	2017-09-08 14:21:42.826713
114	89	16	2017-09-08 15:11:14.161899	2017-09-08 15:11:14.161899
203	78	12	2017-09-22 11:23:43.072996	2017-09-22 11:23:43.072996
204	88	11	2017-09-26 19:05:21.089502	2017-09-26 19:05:21.089502
205	90	11	2017-09-26 19:05:49.645343	2017-09-26 19:05:49.645343
206	132	16	2017-09-26 19:26:08.99427	2017-09-26 19:26:08.99427
159	101	11	2017-09-13 11:10:27.85555	2017-09-13 11:10:27.85555
\.


--
-- Name: themables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('themables_id_seq', 210, true);


--
-- Data for Name: themes; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY themes (id, title, slug, created_at, updated_at, "desc", title_long, weight, state) FROM stdin;
11	Офисный шик	business	2017-09-04 09:51:12.617376	2017-09-29 18:16:40.366881	Открытая, смелая, уверенная в себе, успешная и, безусловно, стильная — твой идеальный образ сегодня.	Бизнес-леди нашего времени	3	1
12	Стильная прогулка	active	2017-09-04 09:51:12.621645	2017-09-29 18:16:40.397139	Хочется в любой момент чувствовать себя на высоте, даже если на вас надета спортивная одежда.	Быть всегда красивой	1	1
17	Время знаний	young	2017-09-04 09:51:12.636304	2017-10-02 11:12:19.859568	Впитывать в себя новое, прекрасное и никогда не останавливаться на достигнутом.	Открываться навстречу неизведанному	0	1
13	Свобода мысли	walk	2017-09-04 09:51:12.624905	2017-09-14 11:52:14.028766	Считать шаги, открывать новые места, наслаждаться моментом и быть собой — все это готовят нам путешествия.	Затеряться в узких улочках средневековых городов	5	0
14	Морской бриз	holiday	2017-09-04 09:51:12.627927	2017-09-14 11:52:14.037155	Сбежать бы из огромного мегаполиса поближе к морю, где любые звуки исчезают в шуме волн.	Записать звуки моря на диктофон	6	1
15	Навстречу искусству	party	2017-09-04 09:51:12.63075	2017-09-26 13:56:06.113952	Кружиться в вихре театральных масок или погружаться в мир картин — идеальный вариант для вечера.	Впитывать искусство, чтобы творить	4	0
16	Особый случай	special	2017-09-04 09:51:12.633333	2017-09-26 13:56:06.123292	Ловить на себе восторженные взгляды, нежиться в свете ярких огней и дарить белоснежную улыбку гостям.	Королевами вечера становятся	2	1
\.


--
-- Name: themes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('themes_id_seq', 17, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, remember_token, phone, name, code, code_last) FROM stdin;
1	we+mint@luckypike.com	$2a$11$rY7rVc3BLUY.BKR8zcR9xueI2kod01bvjUI0T2bATDYjMomACZrUm	\N	\N	\N	20	2017-10-19 13:01:30.439805	2017-10-12 11:46:36.688933	89.109.5.147	89.109.5.147	2017-08-14 14:01:02.852328	2017-10-20 14:20:25.936313	\N	0123456789	\N	\N	\N
10	guest_gg8vxab7bx@mint-store.ru		\N	\N	2017-09-15 18:27:22.588573	1	2017-09-15 18:27:22.595086	2017-09-15 18:27:22.595086	5.164.200.59	5.164.200.59	2017-09-15 18:27:22.557388	2017-09-15 18:27:22.596007	yuahcaETQPQ-MjuK6N1Q	\N	\N	\N	\N
31	guest_av1ufoc8e-@mint-store.ru		\N	\N	2017-09-16 01:59:16.748732	1	2017-09-16 01:59:16.761882	2017-09-16 01:59:16.761882	185.52.142.159	185.52.142.159	2017-09-16 01:59:16.719252	2017-09-16 01:59:16.762766	iaTUthCRfrvYWsw3SDys	\N	\N	\N	\N
3	mint-store@mail.ru	$2a$11$S5a.mPRqVpMf4q0QWAt0muZzFox7vhgYjVHOMzBDzDp9h9rIcknT6	\N	\N	2017-10-07 09:45:46.545634	111	2017-10-25 10:19:24.822425	2017-10-24 19:45:18.955982	109.194.226.11	5.101.14.134	2017-09-14 12:46:49.706056	2017-10-25 10:19:24.823834	VZ99quQztF26UanULBTz	\N	\N	\N	\N
24	guest_i1ypfx2vzy@mint-store.ru		\N	\N	2017-09-15 20:00:54.542213	1	2017-09-15 20:00:54.548857	2017-09-15 20:00:54.548857	95.37.128.164	95.37.128.164	2017-09-15 20:00:54.524424	2017-09-15 20:00:54.549818	MBckDtpvdXBRtCjwmtPr	\N	\N	\N	\N
33	guest_czfwm74wog@mint-store.ru		\N	\N	2017-09-16 05:13:43.661481	7	2017-10-20 12:31:50.221568	2017-10-19 11:28:07.560694	85.140.3.47	94.198.237.254	2017-09-16 05:13:43.642987	2017-10-20 12:31:50.22228	uAzEPmr-xACYfsnn9Xd-	\N	\N	\N	\N
36	guest_5vvazg1ez8@mint-store.ru		\N	\N	2017-09-16 07:13:00.20485	1	2017-09-16 07:13:00.211367	2017-09-16 07:13:00.211367	5.164.196.21	5.164.196.21	2017-09-16 07:13:00.183268	2017-09-16 07:13:00.212286	wvEyJ8UfCCNGFELsXhZk	\N	\N	\N	\N
32	guest_rxrc6j6fvv@mint-store.ru		\N	\N	2017-09-16 05:11:51.729897	1	2017-09-16 05:11:51.736432	2017-09-16 05:11:51.736432	91.79.252.218	91.79.252.218	2017-09-16 05:11:51.711993	2017-09-16 05:11:51.737347	99DdnUWzhkxt2H-t-tJk	\N	\N	\N	\N
34	guest_8qdjnlhpyk@mint-store.ru		\N	\N	2017-09-16 05:22:57.885682	7	2017-10-15 19:14:50.494382	2017-10-06 08:51:41.50138	5.166.200.6	176.213.4.19	2017-09-16 05:22:57.860779	2017-10-15 19:14:50.495452	Y8dRdyJdaTsbMZrYyVQX	\N	\N	\N	\N
18	guest_u5uypmyuzg@mint-store.ru		\N	\N	2017-09-15 19:00:51.946526	5	2017-10-06 13:05:37.179284	2017-10-06 13:02:33.714313	79.126.4.180	79.126.4.180	2017-09-15 19:00:51.928882	2017-10-06 13:05:37.18033	pSFY3ETHA3zN-Ljtx6t3	\N	\N	\N	\N
4	guest_kgvs-hvmdj@mint-store.ru		\N	\N	2017-09-15 13:09:24.355215	1	2017-09-15 13:09:24.368602	2017-09-15 13:09:24.368602	89.109.5.147	89.109.5.147	2017-09-15 13:09:24.326624	2017-09-15 13:09:24.369496	eZZi-goX-pSAmHsNsz4H	\N	\N	\N	\N
2	ilinavershinina@mail.ru	$2a$11$balJZKtlakXY8ZHlMW.dPO.za8mCMpj1GYc4lke9IOnn28FGkZ3oe	\N	\N	2017-09-10 18:45:15.10593	55	2017-10-25 10:21:27.73159	2017-10-21 06:18:30.708605	109.194.226.11	109.184.216.79	2017-09-10 18:44:23.397392	2017-10-25 10:21:27.732576	K6B4wppRXVYVcQ-KxFVq	\N	\N	\N	\N
15	guest_splpc5rkps@mint-store.ru		\N	\N	2017-09-15 18:47:17.945971	1	2017-09-15 18:47:17.967802	2017-09-15 18:47:17.967802	31.173.86.139	31.173.86.139	2017-09-15 18:47:17.916139	2017-09-15 18:47:17.968723	52stqzbB6vbyQ-MBE__h	\N	\N	\N	\N
5	ab+test@luckypike.com		\N	\N	2017-09-15 16:24:08.006901	1	2017-09-15 16:24:08.020324	2017-09-15 16:24:08.020324	89.109.5.147	89.109.5.147	2017-09-15 16:24:07.991118	2017-09-15 16:24:47.667278	9gDKCMtenotMvsjAEcbq	123456789	Андрей	\N	\N
14	guest_bgxehbxbqn@mint-store.ru		\N	\N	2017-09-15 18:38:09.871279	2	2017-09-17 18:54:52.251024	2017-09-15 18:38:09.877929	31.134.142.40	31.134.142.40	2017-09-15 18:38:09.843522	2017-09-17 18:54:52.252559	G2dAGQczRCXreVeiv-my	\N	\N	\N	\N
7	guest_y9quto7kdw@mint-store.ru		\N	\N	2017-09-15 18:20:01.89688	19	2017-10-20 11:15:02.2875	2017-10-19 20:00:18.026093	109.184.26.100	109.184.26.100	2017-09-15 18:20:01.880251	2017-10-20 11:15:02.288556	_yCe_srncDeb_dE8-Fxa	\N	\N	\N	\N
8	guest_fjqsdxhqrw@mint-store.ru		\N	\N	2017-09-15 18:21:06.972606	1	2017-09-15 18:21:06.979291	2017-09-15 18:21:06.979291	109.201.125.186	109.201.125.186	2017-09-15 18:21:06.960184	2017-09-15 18:21:06.980229	Lez84FTNazn3kk_adbdM	\N	\N	\N	\N
17	guest_zrnbw2xrxv@mint-store.ru		\N	\N	2017-09-15 19:00:46.280583	1	2017-09-15 19:00:46.287108	2017-09-15 19:00:46.287108	176.213.30.153	176.213.30.153	2017-09-15 19:00:46.263852	2017-09-15 19:00:46.287992	261ZmeVoGLRCD18y8b2a	\N	\N	\N	\N
13	guest_a2sgt2dz-c@mint-store.ru		\N	\N	2017-09-15 18:32:53.375378	21	2017-10-19 22:43:59.422028	2017-10-16 11:16:34.354754	5.164.207.56	93.183.126.71	2017-09-15 18:32:53.347448	2017-10-19 22:43:59.422612	QFmfyXRJY45czkhUVU8e	\N	\N	\N	\N
27	guest_scaaswzr7s@mint-store.ru		\N	\N	2017-09-15 21:25:55.666081	3	2017-10-06 13:14:20.868799	2017-09-23 13:26:40.092981	83.149.47.146	83.149.44.132	2017-09-15 21:25:55.640071	2017-10-06 13:14:20.869871	rm6BC1F-iAoLUTryuqto	\N	\N	\N	\N
26	guest_9nxkxka1a4@mint-store.ru		\N	\N	2017-09-15 20:46:13.084457	5	2017-10-13 05:33:02.162272	2017-10-04 10:42:35.22029	83.149.37.28	31.173.101.133	2017-09-15 20:46:13.066593	2017-10-13 05:33:02.163373	8fvwPyzxfcCntt_NSgzX	\N	\N	\N	\N
20	guest__y-zsp11oa@mint-store.ru		\N	\N	2017-09-15 19:09:46.197868	1	2017-09-15 19:09:46.20447	2017-09-15 19:09:46.20447	82.208.126.90	82.208.126.90	2017-09-15 19:09:46.179688	2017-09-15 19:09:46.205364	D7xDN2_sMC1BM_W_yZoS	\N	\N	\N	\N
28	guest_hah-ydnkx_@mint-store.ru		\N	\N	\N	5	2017-09-25 19:55:56.305858	2017-09-23 21:40:31.25663	95.79.31.156	95.79.31.156	2017-09-15 21:41:36.943331	2017-09-25 20:29:11.803707	\N	\N	\N	\N	\N
21	guest_yjfmjmuk2j@mint-store.ru		\N	\N	2017-09-15 19:15:16.417294	1	2017-09-15 19:15:16.424239	2017-09-15 19:15:16.424239	5.166.208.12	5.166.208.12	2017-09-15 19:15:16.403386	2017-09-15 19:15:16.424914	P4PVaCjiwhxJX4EWBt6K	\N	\N	\N	\N
22	guest_m-scu4q1qy@mint-store.ru		\N	\N	2017-09-15 19:34:23.829395	1	2017-09-15 19:34:23.836114	2017-09-15 19:34:23.836114	92.242.88.51	92.242.88.51	2017-09-15 19:34:23.797646	2017-09-15 19:34:23.837037	Rx56VRCyp19kCeABzbJs	\N	\N	\N	\N
6	brg@li.ru		\N	\N	\N	4	2017-09-29 15:14:03.95399	2017-09-29 11:21:14.913478	89.109.5.147	89.109.5.147	2017-09-15 16:54:34.736499	2017-10-12 06:34:11.622686	\N	79202516125	Андрей	7107	2017-09-29 15:13:56.320756
19	guest_yrszyjhwr-@mint-store.ru		\N	\N	2017-09-15 19:04:54.491209	19	2017-10-25 13:43:44.02882	2017-10-23 11:24:32.926069	82.208.124.136	109.194.233.156	2017-09-15 19:04:54.474236	2017-10-25 13:43:44.030272	mEzTWr8MZK3MYksrxHDJ	\N	\N	\N	\N
12	strahova86@mail.ru		\N	\N	2017-09-15 18:30:57.653511	1	2017-09-15 18:30:57.658856	2017-09-15 18:30:57.658856	82.208.101.214	82.208.101.214	2017-09-15 18:30:57.617545	2017-10-17 06:45:02.481702	JHcBtV23dawV-wmLeSeU	79108750819	Дарья	\N	\N
41	guest_rn9ayxarse@mint-store.ru		\N	\N	2017-09-16 09:31:26.726776	1	2017-09-16 09:31:26.733517	2017-09-16 09:31:26.733517	213.87.157.123	213.87.157.123	2017-09-16 09:31:26.702034	2017-09-16 09:31:26.734327	XdWU6sbpHQN9GSsw-JMJ	\N	\N	\N	\N
25	guest_qtzrwz1kdl@mint-store.ru		\N	\N	2017-09-15 20:24:33.62043	4	2017-10-07 14:06:48.094668	2017-09-26 11:40:28.002446	78.36.120.62	178.68.170.158	2017-09-15 20:24:33.608543	2017-10-07 14:06:48.096112	vtNnmxTU1uzBpTg2bX1v	\N	\N	\N	\N
37	guest_sdpzhfpm9n@mint-store.ru		\N	\N	2017-09-16 07:26:20.073309	1	2017-09-16 07:26:20.080067	2017-09-16 07:26:20.080067	85.140.2.24	85.140.2.24	2017-09-16 07:26:20.043653	2017-09-16 07:26:20.081017	xpdSGG56LXHz7yNRsERD	\N	\N	\N	\N
16	guest_wa8vjkikz_@mint-store.ru		\N	\N	2017-09-15 18:59:16.363669	9	2017-10-04 12:20:50.988117	2017-09-29 17:23:18.079089	178.140.241.136	178.140.157.194	2017-09-15 18:59:16.347926	2017-10-04 12:20:50.98929	QFDxMXConBYXViiiqo7w	\N	\N	\N	\N
11	guest_x_s49qfrqs@mint-store.ru		\N	\N	2017-09-15 18:30:14.473033	2	2017-09-23 06:53:55.818373	2017-09-15 18:30:14.479431	176.213.0.21	176.213.0.59	2017-09-15 18:30:14.442034	2017-09-23 06:53:55.819435	fuAq5ALqyRJijYW8ymPN	\N	\N	\N	\N
35	guest_kjmbnscf9n@mint-store.ru		\N	\N	2017-09-16 06:59:40.265788	1	2017-09-16 06:59:40.284486	2017-09-16 06:59:40.284486	95.79.62.142	95.79.62.142	2017-09-16 06:59:40.229693	2017-09-16 06:59:40.285495	5p_T8qCHUFhuxay8zY8G	\N	\N	\N	\N
39	guest_swccxzuvxu@mint-store.ru		\N	\N	2017-09-16 09:06:55.345343	1	2017-09-16 09:06:55.351609	2017-09-16 09:06:55.351609	66.249.76.55	66.249.76.55	2017-09-16 09:06:55.303543	2017-09-16 09:06:55.352608	G8mHWrHw29foQgqHPxTF	\N	\N	\N	\N
40	guest_sie4w5_pfg@mint-store.ru		\N	\N	2017-09-16 09:18:19.741216	1	2017-09-16 09:18:19.755557	2017-09-16 09:18:19.755557	171.33.253.101	171.33.253.101	2017-09-16 09:18:19.707929	2017-09-16 09:18:19.756413	bi3rnpv-SfXGnLXSMzzX	\N	\N	\N	\N
38	guest_wx4tgcbjii@mint-store.ru		\N	\N	2017-09-16 08:28:37.972442	1	2017-09-16 08:28:37.978932	2017-09-16 08:28:37.978932	91.107.14.184	91.107.14.184	2017-09-16 08:28:37.945177	2017-09-16 08:28:37.979923	qkBzuVXouaQjir6VNzVv	\N	\N	\N	\N
42	guest_yjqsyu939s@mint-store.ru		\N	\N	2017-09-16 10:27:51.941694	1	2017-09-16 10:27:51.948363	2017-09-16 10:27:51.948363	178.252.80.36	178.252.80.36	2017-09-16 10:27:51.925183	2017-09-16 10:27:51.949268	nPvyk6kSMSpD8DVKY8Ue	\N	\N	\N	\N
30	guest_a6cuyezbnk@mint-store.ru		\N	\N	2017-09-16 00:48:31.253042	12	2017-10-20 09:11:29.704643	2017-10-17 18:35:49.410165	85.140.3.74	5.164.236.51	2017-09-16 00:48:31.236373	2017-10-20 09:11:29.705691	AgTC9KFRN799HaF6qxys	\N	\N	\N	\N
43	guest_k3cyqgwahx@mint-store.ru		\N	\N	2017-09-16 10:52:37.456186	1	2017-09-16 10:52:37.462796	2017-09-16 10:52:37.462796	176.59.116.97	176.59.116.97	2017-09-16 10:52:37.437895	2017-09-16 10:52:37.463727	EisY23C3ake9sQfBszPk	\N	\N	\N	\N
44	guest_lcjcslus2p@mint-store.ru		\N	\N	2017-09-16 12:03:40.040882	1	2017-09-16 12:03:40.047475	2017-09-16 12:03:40.047475	194.0.219.5	194.0.219.5	2017-09-16 12:03:40.023111	2017-09-16 12:03:40.048373	LdF_g7qDXox6T7qYUZd-	\N	\N	\N	\N
29	guest_97-wo77pz-@mint-store.ru		\N	\N	2017-09-15 22:29:53.873131	12	2017-10-15 21:51:09.465212	2017-10-05 23:25:40.016377	185.33.236.207	185.33.236.207	2017-09-15 22:29:53.855426	2017-10-15 21:51:09.466164	PLKuqANZCZzd48tyqjMP	\N	\N	\N	\N
45	guest_o-h8d6bmuw@mint-store.ru		\N	\N	2017-09-16 12:42:54.067595	1	2017-09-16 12:42:54.074127	2017-09-16 12:42:54.074127	95.28.59.27	95.28.59.27	2017-09-16 12:42:54.049876	2017-09-16 12:42:54.075046	xQzTpBzxrxRtRPfvoY8w	\N	\N	\N	\N
46	guest_xszq6uqyz-@mint-store.ru		\N	\N	2017-09-16 13:33:14.42396	1	2017-09-16 13:33:14.430399	2017-09-16 13:33:14.430399	213.87.134.252	213.87.134.252	2017-09-16 13:33:14.409869	2017-09-16 13:33:14.431188	mdJwABXpjB3YMSnnrAxA	\N	\N	\N	\N
9	guest_svrtf2u3cg@mint-store.ru		\N	\N	2017-09-15 18:23:05.94678	4	2017-09-21 06:14:26.240532	2017-09-17 11:44:46.303413	95.79.31.156	95.79.31.156	2017-09-15 18:23:05.920052	2017-09-21 06:14:26.242043	SF2HGDCsbzWyCy74zjsG	888888	Эрик	\N	\N
23	guest_uhspgrdq8s@mint-store.ru		\N	\N	2017-09-15 19:44:29.232454	16	2017-10-12 21:14:16.300179	2017-10-12 13:59:41.327188	5.164.246.106	5.164.246.106	2017-09-15 19:44:29.218559	2017-10-12 21:14:16.301006	15eRmaiW-vJQDcT7ixVa	\N	\N	\N	\N
78	guest_vc5fjrnj8a@mint-store.ru		\N	\N	2017-09-21 16:17:59.577451	1	2017-09-21 16:17:59.584186	2017-09-21 16:17:59.584186	5.164.206.222	5.164.206.222	2017-09-21 16:17:59.548434	2017-09-21 16:17:59.585084	YsnXRQEVTGMz5zQhoLsn	\N	\N	\N	\N
72	guest_8d1h7s7er2@mint-store.ru		\N	\N	2017-09-21 08:28:43.844296	1	2017-09-21 08:28:43.850855	2017-09-21 08:28:43.850855	85.140.1.9	85.140.1.9	2017-09-21 08:28:43.820236	2017-09-21 08:28:43.851843	KgZ1-uKscRZgXmhUtc8y	\N	\N	\N	\N
48	guest_ykbyzt8nk2@mint-store.ru		\N	\N	2017-09-16 15:27:24.246086	1	2017-09-16 15:27:24.252702	2017-09-16 15:27:24.252702	109.194.231.19	109.194.231.19	2017-09-16 15:27:24.2254	2017-09-16 15:27:24.25368	k7yAg9fYL7JvPwKGvffU	\N	\N	\N	\N
86	guest_ec-b_egfnh@mint-store.ru		\N	\N	2017-09-22 08:25:01.928412	2	2017-10-04 08:22:27.205789	2017-09-22 08:25:01.935133	109.194.227.25	109.194.227.25	2017-09-22 08:25:01.914646	2017-10-04 08:22:27.206866	ZLFBsesTczxyxxX8srRL	\N	\N	\N	\N
49	guest_xxnejq-y_a@mint-store.ru		\N	\N	2017-09-16 16:44:32.988896	1	2017-09-16 16:44:32.995825	2017-09-16 16:44:32.995825	82.208.112.67	82.208.112.67	2017-09-16 16:44:32.969154	2017-09-16 16:44:32.996692	oxG_pWXPRAhHdJ4w3dtp	\N	\N	\N	\N
50	guest_wfvvtvxy2a@mint-store.ru		\N	\N	2017-09-17 04:18:01.566281	1	2017-09-17 04:18:01.579272	2017-09-17 04:18:01.579272	109.252.20.137	109.252.20.137	2017-09-17 04:18:01.534564	2017-09-17 04:18:01.580129	ZqVU6Q_tcm1wiYwyy9Wx	\N	\N	\N	\N
51	guest_nns6vgxsj_@mint-store.ru		\N	\N	2017-09-17 06:58:34.416051	1	2017-09-17 06:58:34.429137	2017-09-17 06:58:34.429137	217.118.93.164	217.118.93.164	2017-09-17 06:58:34.398183	2017-09-17 06:58:34.42998	qkiKGcF5u2ipn6CuXHAz	\N	\N	\N	\N
65	guest_igo-sftd7p@mint-store.ru		\N	\N	2017-09-19 17:23:33.49874	1	2017-09-19 17:23:33.511903	2017-09-19 17:23:33.511903	92.242.59.6	92.242.59.6	2017-09-19 17:23:33.466708	2017-09-19 17:23:33.512807	uZ4oDDuD2-2yzuyKxC6w	\N	\N	\N	\N
53	guest_vth3row73z@mint-store.ru		\N	\N	2017-09-17 13:55:22.697897	1	2017-09-17 13:55:22.704441	2017-09-17 13:55:22.704441	87.250.224.50	87.250.224.50	2017-09-17 13:55:22.684823	2017-09-17 13:55:22.705409	JMPPNouPx652qcGniS1-	\N	\N	\N	\N
66	guest_xt76hlgzzu@mint-store.ru		\N	\N	2017-09-20 08:13:31.344254	1	2017-09-20 08:13:31.350718	2017-09-20 08:13:31.350718	87.250.224.50	87.250.224.50	2017-09-20 08:13:31.327994	2017-09-20 08:13:31.351619	r78ZwMUw99KrWE_dmeQE	\N	\N	\N	\N
85	olgamishina18@gmail.com		\N	\N	2017-09-22 08:16:05.377322	1	2017-09-22 08:16:05.383892	2017-09-22 08:16:05.383892	217.67.187.26	217.67.187.26	2017-09-22 08:16:05.350035	2017-09-22 08:17:25.940937	EZREKN-HT6dEmC_QK9Uf	89859616931	Ольга мишина	\N	\N
63	guest_st2ysteatg@mint-store.ru		\N	\N	2017-09-19 11:50:04.783481	8	2017-10-06 13:05:51.027403	2017-10-05 20:51:11.095434	95.37.222.49	95.37.222.49	2017-09-19 11:50:04.764428	2017-10-06 13:05:51.028399	_-8t8apxxvuquafzh1Pd	\N	\N	\N	\N
93	guest_7-aa2hnypm@mint-store.ru		\N	\N	2017-09-22 13:02:44.79521	20	2017-10-22 16:02:19.071701	2017-10-20 05:09:43.245148	93.120.159.71	93.120.143.10	2017-09-22 13:02:44.764973	2017-10-22 16:02:19.073193	-K4PxNzgA79euycNMPEH	89040536721	Екатерина	\N	\N
54	guest_7ynm7uis7t@mint-store.ru		\N	\N	2017-09-18 04:49:54.129295	3	2017-09-26 11:20:01.565725	2017-09-21 09:15:44.216743	178.216.222.184	83.149.47.169	2017-09-18 04:49:54.107096	2017-09-26 11:20:01.566727	mzxCcvk5m2dc5kG9747A	\N	\N	\N	\N
79	guest_4fu_-gtbjk@mint-store.ru		\N	\N	2017-09-21 17:41:16.421025	1	2017-09-21 17:41:16.427508	2017-09-21 17:41:16.427508	87.250.224.50	87.250.224.50	2017-09-21 17:41:16.393688	2017-09-21 17:41:16.428424	-TqD8rtE-yGqDCYhVp_d	\N	\N	\N	\N
58	guest_mmgvfywujw@mint-store.ru		\N	\N	2017-09-18 12:05:53.878582	1	2017-09-18 12:05:53.885164	2017-09-18 12:05:53.885164	217.118.93.133	217.118.93.133	2017-09-18 12:05:53.863821	2017-09-18 12:05:53.885996	zLyd3WRPGZbjdeXxr4pm	\N	\N	\N	\N
74	guest_qhssxqwp1d@mint-store.ru		\N	\N	2017-09-21 08:37:11.206483	1	2017-09-21 08:37:11.212932	2017-09-21 08:37:11.212932	213.87.153.183	213.87.153.183	2017-09-21 08:37:11.161939	2017-09-21 08:37:11.213918	ZPF5g8kToYM5zwuSGnX4	\N	\N	\N	\N
69	guest_drysj7v9_p@mint-store.ru		\N	\N	2017-09-20 20:33:51.54608	14	2017-10-16 20:55:41.149126	2017-10-06 11:24:27.027472	109.184.11.221	83.149.45.172	2017-09-20 20:33:51.518388	2017-10-16 20:55:41.150224	cStJxxaEaSJKNo5Dik-M	\N	\N	\N	\N
68	guest_lostehb-1h@mint-store.ru		\N	\N	2017-09-20 13:47:44.367502	1	2017-09-20 13:47:44.373459	2017-09-20 13:47:44.373459	89.109.5.147	89.109.5.147	2017-09-20 13:47:44.342641	2017-09-20 13:47:44.37481	ssX3K2wjwMLNvgXBmczJ	\N	\N	\N	\N
89	guest_tjh_tcmgfe@mint-store.ru		\N	\N	2017-09-22 10:47:38.286666	2	2017-09-24 22:02:28.77157	2017-09-22 10:47:38.3016	185.14.4.43	83.149.45.164	2017-09-22 10:47:38.270864	2017-09-24 22:02:28.773664	z5eCHRNRehzz7y6yCarM	\N	\N	\N	\N
62	guest_k3bf878zai@mint-store.ru		\N	\N	2017-09-18 21:23:12.024156	1	2017-09-18 21:23:12.030751	2017-09-18 21:23:12.030751	87.250.224.50	87.250.224.50	2017-09-18 21:23:12.011609	2017-09-18 21:23:12.031619	wam7TpsK33vRx3EWWKQJ	\N	\N	\N	\N
61	guest_s4xzezy7wn@mint-store.ru		\N	\N	2017-09-18 19:39:26.497173	14	2017-10-18 20:22:55.427684	2017-10-13 14:12:08.865348	5.3.201.188	5.164.194.22	2017-09-18 19:39:26.478401	2017-10-18 20:22:55.42874	AouyF2k-WWJddwyk_vBJ	\N	\N	\N	\N
82	guest_3wqbxmkbv3@mint-store.ru		\N	\N	2017-09-21 20:59:06.801597	1	2017-09-21 20:59:06.816614	2017-09-21 20:59:06.816614	89.169.95.188	89.169.95.188	2017-09-21 20:59:06.775463	2017-09-21 20:59:06.81738	PvbgYp7PDM58pWpMbxzg	\N	\N	\N	\N
59	guest_54avifnrde@mint-store.ru		\N	\N	\N	5	2017-09-21 18:11:26.523075	2017-09-21 02:50:21.516743	95.79.30.130	95.79.30.130	2017-09-18 14:45:08.819363	2017-09-21 18:20:26.509126	\N	\N	\N	\N	\N
56	guest_ihnefpacyx@mint-store.ru		\N	\N	\N	1	2017-09-18 09:05:14.103744	2017-09-18 09:05:14.103744	89.109.5.147	89.109.5.147	2017-09-18 09:05:14.080287	2017-09-19 12:18:51.145299	\N	\N	\N	\N	\N
70	guest_7xmy5sve-o@mint-store.ru		\N	\N	2017-09-21 03:06:38.918144	1	2017-09-21 03:06:38.93106	2017-09-21 03:06:38.93106	144.217.66.151	144.217.66.151	2017-09-21 03:06:38.903178	2017-09-21 03:06:38.93199	zPYcqbpbzckNmiafJmeY	\N	\N	\N	\N
84	guest_bg5grs_ax_@mint-store.ru		\N	\N	2017-09-22 07:34:41.112783	25	2017-10-24 06:09:58.499969	2017-10-21 11:26:52.471298	217.118.93.145	176.115.149.217	2017-09-22 07:34:41.096577	2017-10-24 06:09:58.501129	Qgbx-vRACvLxSvHn3AzC	79601706301	Татьяна 	\N	\N
55	guest_zpyylby7tt@mint-store.ru		\N	\N	2017-09-18 07:41:41.239933	2	2017-09-30 11:32:23.931844	2017-09-18 07:41:41.246074	5.101.14.211	5.101.14.211	2017-09-18 07:41:41.213684	2017-09-30 11:32:23.93294	CGmbNp1k2Ajwao9AKy5Q	\N	\N	\N	\N
76	guest_wpbhts197e@mint-store.ru		\N	\N	2017-09-21 13:20:06.785636	1	2017-09-21 13:20:06.792137	2017-09-21 13:20:06.792137	95.140.27.12	95.140.27.12	2017-09-21 13:20:06.772556	2017-09-21 13:20:06.793104	JL7x6ZGxxgtRah31vdXD	\N	\N	\N	\N
47	guest_aehtq8aybx@mint-store.ru		\N	\N	2017-09-16 13:39:35.189137	13	2017-10-25 12:28:39.13249	2017-10-16 14:00:54.453455	212.92.173.211	88.81.41.114	2017-09-16 13:39:35.162609	2017-10-25 12:28:39.133986	pxMEqx_Ex4gzzEPjY-zL	\N	\N	\N	\N
83	guest_kqljhszvhp@mint-store.ru		\N	\N	2017-09-22 04:48:22.951227	1	2017-09-22 04:48:22.96811	2017-09-22 04:48:22.96811	5.164.248.38	5.164.248.38	2017-09-22 04:48:22.91134	2017-09-22 04:48:22.969049	dGmFzkDVEs3uxzDkjDxR	\N	\N	\N	\N
87	guest_lbpddmgnyx@mint-store.ru		\N	\N	2017-09-22 10:19:24.249286	2	2017-10-06 10:14:32.336	2017-09-22 10:19:24.255617	95.79.53.112	95.79.53.112	2017-09-22 10:19:24.221562	2017-10-06 10:14:32.336993	osnV7tcEcWUr1Xsy-_QR	\N	\N	\N	\N
77	guest_jwzpneladd@mint-store.ru		\N	\N	2017-09-21 15:54:10.774919	1	2017-09-21 15:54:10.781364	2017-09-21 15:54:10.781364	213.87.156.50	213.87.156.50	2017-09-21 15:54:10.745913	2017-09-21 15:54:10.782343	kAsW2e-5dxfEWZsGPvuh	\N	\N	\N	\N
64	guest_ogagx4-mhv@mint-store.ru		\N	\N	\N	1	2017-09-19 12:20:41.561656	2017-09-19 12:20:41.561656	89.109.5.147	89.109.5.147	2017-09-19 12:20:41.517244	2017-09-29 11:17:48.5372	\N	79201112688	Сергей	\N	\N
88	guest_d9yemltwrb@mint-store.ru		\N	\N	2017-09-22 10:45:49.70416	1	2017-09-22 10:45:49.719592	2017-09-22 10:45:49.719592	5.101.14.215	5.101.14.215	2017-09-22 10:45:49.684269	2017-09-22 10:45:49.720237	GsW6v5jz7EBzmaw_yF_V	\N	\N	\N	\N
71	guest_xmfeu1aa9r@mint-store.ru		\N	\N	2017-09-21 07:33:07.633058	2	2017-09-30 00:27:08.804601	2017-09-21 07:33:07.639583	83.220.239.7	83.220.239.135	2017-09-21 07:33:07.619809	2017-09-30 00:27:08.80603	SEjHmef-YyJjxpNCRSza	\N	\N	\N	\N
52	guest_xk77qjqu-e@mint-store.ru		\N	\N	2017-09-17 10:24:16.448845	15	2017-10-23 18:25:20.165418	2017-10-22 10:59:33.540223	94.25.167.80	149.62.23.106	2017-09-17 10:24:16.435358	2017-10-23 18:25:20.166527	sssePb-WGGrA6yDMX1Z6	\N	\N	\N	\N
75	guest__yyraa3pyg@mint-store.ru		\N	\N	2017-09-21 13:11:47.864556	27	2017-10-22 07:54:32.112581	2017-10-21 18:03:46.104273	37.147.195.128	37.147.195.128	2017-09-21 13:11:47.84476	2017-10-22 07:54:32.113423	Mavfp5eEv4CkQ65ARQZD	\N	\N	\N	\N
80	guest_ksyqukjqfq@mint-store.ru		\N	\N	2017-09-21 19:05:15.208893	11	2017-10-19 12:57:55.585997	2017-10-17 06:34:11.789632	89.109.5.147	89.109.5.147	2017-09-21 19:05:15.18246	2017-10-19 12:57:55.587056	toJ7we9qg_F3-qreULTJ	\N	\N	\N	\N
81	guest_uq35-xtrgc@mint-store.ru		\N	\N	2017-09-21 20:41:40.47237	2	2017-09-23 11:17:03.956729	2017-09-21 20:41:40.479101	176.213.10.152	176.213.10.152	2017-09-21 20:41:40.443531	2017-09-23 11:17:03.957791	2wbyzMDygjvL-Vsfjw63	\N	\N	\N	\N
57	guest_neirt7xeyq@mint-store.ru		\N	\N	2017-09-18 09:27:00.08624	3	2017-09-27 07:20:36.358386	2017-09-26 07:23:30.178167	217.118.93.172	217.118.93.172	2017-09-18 09:27:00.056672	2017-09-27 07:20:36.359447	irQL8ta2PFexjCEzAyJC	\N	\N	\N	\N
60	guest_pinhdks6iu@mint-store.ru		\N	\N	2017-09-18 17:03:45.137633	2	2017-09-25 10:37:38.672887	2017-09-18 17:03:45.150292	213.150.92.173	213.150.94.5	2017-09-18 17:03:45.102809	2017-09-25 10:37:38.674443	fsHDXwsyxVeq8opfzw2j	\N	\N	\N	\N
91	guest_kpxhfte7kq@mint-store.ru		\N	\N	2017-09-22 12:27:05.432611	1	2017-09-22 12:27:05.439234	2017-09-22 12:27:05.439234	83.220.236.15	83.220.236.15	2017-09-22 12:27:05.405263	2017-09-22 12:27:05.440159	cJ2yyDz9a-DuvYYouCr8	\N	\N	\N	\N
92	guest_ohy4qykgnf@mint-store.ru		\N	\N	2017-09-22 12:30:52.020364	1	2017-09-22 12:30:52.02698	2017-09-22 12:30:52.02698	217.118.93.156	217.118.93.156	2017-09-22 12:30:51.991098	2017-09-22 12:30:52.027962	fe4ezJsHpNxwAXLYs3Jy	\N	\N	\N	\N
90	galushkina.alina9@gmail.com		\N	\N	2017-09-22 12:00:36.519907	2	2017-09-22 12:03:59.134378	2017-09-22 12:00:36.526286	217.66.156.91	217.66.156.91	2017-09-22 12:00:36.47737	2017-09-22 15:19:40.307159	opCD1jscfzxbF73oYFiv	89816886759	Алина	\N	\N
67	tatyanakyznetsova89@yandex.ru		\N	\N	2017-09-20 10:49:08.814001	1	2017-09-20 10:49:08.820758	2017-09-20 10:49:08.820758	109.184.2.49	109.184.2.49	2017-09-20 10:49:08.783562	2017-10-20 10:25:55.641895	seQ28mJvZMQjdfSZ7wfB		Татьяна	6338	2017-10-20 10:25:55.641089
94	guest_enobzwszs5@mint-store.ru		\N	\N	2017-09-22 13:33:37.818076	1	2017-09-22 13:33:37.824808	2017-09-22 13:33:37.824808	5.142.82.218	5.142.82.218	2017-09-22 13:33:37.787043	2017-09-22 13:33:37.825786	PNo6tMmcdZaRyz-f5XtA	\N	\N	\N	\N
95	guest_dazwrqpmzb@mint-store.ru		\N	\N	2017-09-22 14:18:14.766129	1	2017-09-22 14:18:14.772736	2017-09-22 14:18:14.772736	5.164.220.9	5.164.220.9	2017-09-22 14:18:14.746975	2017-09-22 14:18:14.773665	DgHhs9UWs5Tou3zqBG34	\N	\N	\N	\N
112	guest_cmtm8zwyyk@mint-store.ru		\N	\N	2017-09-23 16:42:12.478719	1	2017-09-23 16:42:12.491727	2017-09-23 16:42:12.491727	87.250.224.50	87.250.224.50	2017-09-23 16:42:12.461116	2017-09-23 16:42:12.492649	xmPYQVgSyyG275hd3Diz	\N	\N	\N	\N
104	guest_716onxw2zh@mint-store.ru		\N	\N	2017-09-23 08:42:47.707536	2	2017-09-23 17:11:45.794363	2017-09-23 08:42:47.714132	85.140.2.130	85.140.1.101	2017-09-23 08:42:47.688601	2017-09-23 17:11:45.795962	cEK5FAbhxKxk-i_KmG_m	\N	\N	\N	\N
123	goroh-nn@mail.ru		\N	\N	2017-09-24 19:12:33.774118	3	2017-09-30 10:12:03.350838	2017-09-27 04:44:21.587286	82.208.124.217	82.208.100.134	2017-09-24 19:12:33.758139	2017-09-30 10:12:03.351901	2an_KzFGJRoZd28saxZs	79056618108	Анна	\N	\N
98	guest_85fpw2zgr9@mint-store.ru		\N	\N	2017-09-22 15:36:23.496665	1	2017-09-22 15:36:23.503464	2017-09-22 15:36:23.503464	5.164.204.49	5.164.204.49	2017-09-22 15:36:23.478338	2017-09-22 15:36:23.504476	Pvxiy2yz1nix2Bu7BdVH	\N	\N	\N	\N
97	guest_q5ova-tya9@mint-store.ru		\N	\N	\N	1	2017-09-22 15:35:23.533619	2017-09-22 15:35:23.533619	213.87.126.225	213.87.126.225	2017-09-22 15:35:23.451576	2017-09-22 15:41:15.71398	\N	\N	\N	\N	\N
130	guest_ys2p94b5mo@mint-store.ru		\N	\N	2017-09-25 21:56:31.955155	1	2017-09-25 21:56:31.96772	2017-09-25 21:56:31.96772	37.17.172.122	37.17.172.122	2017-09-25 21:56:31.935796	2017-09-25 21:56:31.968752	vxRty3x6NAkaTpWsJ3b3	\N	\N	\N	\N
100	guest_a4xd12dxa6@mint-store.ru		\N	\N	2017-09-22 19:11:13.636701	1	2017-09-22 19:11:13.649687	2017-09-22 19:11:13.649687	83.149.45.161	83.149.45.161	2017-09-22 19:11:13.607413	2017-09-22 19:11:13.650701	Hev6QivszfFekyNZ9TRU	\N	\N	\N	\N
99	guest_y_9f2otbxf@mint-store.ru		\N	\N	2017-09-22 17:10:38.867857	2	2017-09-24 17:51:17.453142	2017-09-22 17:10:38.886432	5.164.252.29	176.213.4.13	2017-09-22 17:10:38.814223	2017-09-24 17:51:17.454755	EEgzvAQxxCUAyyGYgjAC	\N	\N	\N	\N
101	guest_tgxuxmcid9@mint-store.ru		\N	\N	2017-09-23 08:40:42.301283	1	2017-09-23 08:40:42.307667	2017-09-23 08:40:42.307667	85.140.1.101	85.140.1.101	2017-09-23 08:40:42.283746	2017-09-23 08:40:42.308537	16hYhJaw7DopQimAZ1sx	\N	\N	\N	\N
102	guest_9gzztpyqeg@mint-store.ru		\N	\N	2017-09-23 08:42:32.250725	1	2017-09-23 08:42:32.257293	2017-09-23 08:42:32.257293	85.140.1.101	85.140.1.101	2017-09-23 08:42:32.229215	2017-09-23 08:42:32.258198	bX_Er1fMz2Q6nowazxYt	\N	\N	\N	\N
103	guest_t-zqaw6eqm@mint-store.ru		\N	\N	2017-09-23 08:42:32.442376	1	2017-09-23 08:42:32.44892	2017-09-23 08:42:32.44892	85.140.1.101	85.140.1.101	2017-09-23 08:42:32.431659	2017-09-23 08:42:32.449818	9be_kM9Fgz9QRq84KwbB	\N	\N	\N	\N
115	guest_wvsc7mp8mj@mint-store.ru		\N	\N	2017-09-24 00:16:14.909375	1	2017-09-24 00:16:14.938901	2017-09-24 00:16:14.938901	5.227.7.67	5.227.7.67	2017-09-24 00:16:14.893141	2017-09-24 00:16:14.939902	x9Si_HdR1qx_sLusYjk-	\N	\N	\N	\N
105	guest_xxrfbdgc45@mint-store.ru		\N	\N	2017-09-23 08:44:47.64584	1	2017-09-23 08:44:47.653052	2017-09-23 08:44:47.653052	85.140.2.179	85.140.2.179	2017-09-23 08:44:47.620981	2017-09-23 08:44:47.653652	WzdRN4-9uUYmYSfyC51Q	\N	\N	\N	\N
106	guest_a1zfzdmjz8@mint-store.ru		\N	\N	2017-09-23 10:14:15.879801	1	2017-09-23 10:14:15.88647	2017-09-23 10:14:15.88647	91.78.32.144	91.78.32.144	2017-09-23 10:14:15.847728	2017-09-23 10:14:15.88743	DAvc1Ms7UtgUZRETz5_p	\N	\N	\N	\N
118	guest_698_esvdrs@mint-store.ru		\N	\N	2017-09-24 14:24:40.672435	3	2017-10-10 03:11:11.804133	2017-10-07 03:01:22.994038	66.9.167.110	108.220.27.131	2017-09-24 14:24:40.64448	2017-10-10 03:11:11.804813	deSP-mTzEPQt9WFTyp5A	\N	\N	\N	\N
116	guest_5p_nd5rxxm@mint-store.ru		\N	\N	2017-09-24 08:14:11.231663	1	2017-09-24 08:14:11.24502	2017-09-24 08:14:11.24502	217.118.93.155	217.118.93.155	2017-09-24 08:14:11.198073	2017-09-24 08:14:11.245939	ZaRa_H8Hbc6jgZmKvoZh	\N	\N	\N	\N
108	guest_fajzvhjgk2@mint-store.ru		\N	\N	2017-09-23 10:37:57.391613	1	2017-09-23 10:37:57.398403	2017-09-23 10:37:57.398403	85.140.2.153	85.140.2.153	2017-09-23 10:37:57.381384	2017-09-23 10:37:57.399217	hEHp72i8JW6N9ZWRKpzV	\N	\N	\N	\N
109	guest_qmkyu-9tkk@mint-store.ru		\N	\N	2017-09-23 11:33:54.468265	1	2017-09-23 11:33:54.47483	2017-09-23 11:33:54.47483	91.228.124.5	91.228.124.5	2017-09-23 11:33:54.451193	2017-09-23 11:33:54.475746	hNK79XeAden8mzaWbwgy	\N	\N	\N	\N
117	guest_zzn6wfstkj@mint-store.ru		\N	\N	2017-09-24 09:14:23.740877	1	2017-09-24 09:14:23.747418	2017-09-24 09:14:23.747418	80.65.25.97	80.65.25.97	2017-09-24 09:14:23.727488	2017-09-24 09:14:23.748287	UYYJzcjzEHD9zocECBLt	\N	\N	\N	\N
110	lumbik71@mail.ru		\N	\N	2017-09-23 14:33:38.750513	1	2017-09-23 14:33:38.763752	2017-09-23 14:33:38.763752	149.62.16.108	149.62.16.108	2017-09-23 14:33:38.728948	2017-09-23 14:34:32.616255	Lyn-iYVkZE32eT3wemx1	89050114852	Наталья	\N	\N
113	guest_yjqnqr9hxc@mint-store.ru		\N	\N	2017-09-23 18:52:30.344206	2	2017-09-24 11:04:19.371042	2017-09-23 18:52:30.350637	95.37.39.186	95.37.99.50	2017-09-23 18:52:30.273525	2017-09-24 11:04:19.372317	n5yLBtrFWYwF3c-Ew-gf	\N	\N	\N	\N
111	guest_assszkl2gx@mint-store.ru		\N	\N	2017-09-23 15:43:47.795372	1	2017-09-23 15:43:47.804595	2017-09-23 15:43:47.804595	88.198.66.230	88.198.66.230	2017-09-23 15:43:47.770863	2017-09-23 15:43:47.805767	ysh43vypd1rndkCGGaoT	\N	\N	\N	\N
126	guest_23_qxemuwp@mint-store.ru		\N	\N	2017-09-25 18:13:05.56181	3	2017-10-13 09:21:19.041617	2017-10-03 10:26:28.569308	85.140.2.133	85.140.2.158	2017-09-25 18:13:05.550308	2017-10-13 09:21:19.042541	3th1qyzPgs5UbVp6nzDp	\N	\N	\N	\N
96	guest_z1syb3lkyn@mint-store.ru		\N	\N	2017-09-22 15:04:35.371089	23	2017-10-13 18:02:25.381974	2017-10-13 05:33:34.308179	95.79.30.130	95.79.30.130	2017-09-22 15:04:35.341683	2017-10-13 18:02:25.383071	rHsBQ21saj_GwLUPgVwf	\N	\N	\N	\N
119	guest_9-uoc-widf@mint-store.ru		\N	\N	2017-09-24 14:57:17.991604	1	2017-09-24 14:57:17.998077	2017-09-24 14:57:17.998077	5.227.15.227	5.227.15.227	2017-09-24 14:57:17.974481	2017-09-24 14:57:17.999033	QC4Uxhjs4bf-k-LRyowp	\N	\N	\N	\N
132	guest_23172wzhd4@mint-store.ru		\N	\N	2017-09-26 04:38:08.438452	19	2017-10-25 06:22:35.39929	2017-10-23 16:24:24.254466	95.79.74.77	85.140.2.238	2017-09-26 04:38:08.423589	2017-10-25 06:22:35.400626	8N6bhwzJintSxwVQbnxC	\N	\N	\N	\N
120	guest_jt4vzrh_gy@mint-store.ru		\N	\N	\N	1	2017-09-24 14:58:34.991096	2017-09-24 14:58:34.991096	5.227.15.227	5.227.15.227	2017-09-24 14:58:34.955465	2017-09-24 15:00:51.057713	\N	\N	\N	\N	\N
124	guest_urkpmtjmza@mint-store.ru		\N	\N	2017-09-25 08:35:46.277943	1	2017-09-25 08:35:46.292038	2017-09-25 08:35:46.292038	213.87.122.128	213.87.122.128	2017-09-25 08:35:46.262334	2017-09-25 08:35:46.293768	b6i-utgdm5jzuHETPpx9	\N	\N	\N	\N
131	guest_xqk551gxhq@mint-store.ru		\N	\N	2017-09-25 21:58:49.023512	1	2017-09-25 21:58:49.029982	2017-09-25 21:58:49.029982	37.17.172.122	37.17.172.122	2017-09-25 21:58:48.995849	2017-09-25 21:58:49.030954	jPmvDdTmvrYNwq_qFyyK	\N	\N	\N	\N
125	guest_ia2h1sd1yn@mint-store.ru		\N	\N	2017-09-25 12:27:55.26958	1	2017-09-25 12:27:55.276131	2017-09-25 12:27:55.276131	109.73.36.254	109.73.36.254	2017-09-25 12:27:55.257788	2017-09-25 12:27:55.276992	jxFkSYPyTs7PP-isg3Ze	\N	\N	\N	\N
127	pavliv.vika@gmail.com		\N	\N	2017-09-25 19:13:58.661595	4	2017-09-28 12:43:25.048918	2017-09-27 09:22:20.396999	91.202.199.103	91.202.199.103	2017-09-25 19:13:58.629376	2017-09-29 11:17:48.592339	YQxjLRzzqxiriysTpF5f	79815075866	Вика	\N	\N
129	guest_y-n7ewc-td@mint-store.ru		\N	\N	2017-09-25 21:02:52.455543	12	2017-10-23 20:14:45.148738	2017-10-14 20:30:56.512413	95.0.144.244	95.79.31.156	2017-09-25 21:02:52.426534	2017-10-23 20:14:45.149726	R4xyZCKidzsEhg-Eh9H9	\N	\N	\N	\N
134	guest_8pydqolbwc@mint-store.ru		\N	\N	2017-09-26 14:13:28.209604	1	2017-09-26 14:13:28.224501	2017-09-26 14:13:28.224501	84.201.148.33	84.201.148.33	2017-09-26 14:13:28.193356	2017-09-26 14:13:28.225349	2Tdmx1x9b_sQsxyey-yj	\N	\N	\N	\N
133	guest_yvbrx8ochs@mint-store.ru		\N	\N	2017-09-26 14:12:26.508849	1	2017-09-26 14:12:26.521885	2017-09-26 14:12:26.521885	84.201.148.33	84.201.148.33	2017-09-26 14:12:26.474923	2017-09-26 14:12:26.522844	Yj3SyPX1dWsF12_ppWXQ	\N	\N	\N	\N
128	guest_jss1fe-fsv@mint-store.ru		\N	\N	\N	2	2017-09-26 14:15:35.394373	2017-09-25 21:01:54.909225	89.109.5.147	95.79.31.156	2017-09-25 21:01:54.865397	2017-09-26 14:15:40.442859	\N	\N	\N	\N	\N
137	guest__9i4utfyj9@mint-store.ru		\N	\N	\N	2	2017-09-29 11:02:05.300409	2017-09-26 14:21:15.331901	89.109.5.147	89.109.5.147	2017-09-26 14:21:15.295665	2017-09-29 11:18:08.246053	\N	79991110000	Андрей	\N	\N
114	guest_dcalnsf61d@mint-store.ru		\N	\N	2017-09-23 20:54:11.203093	4	2017-10-16 02:40:28.120978	2017-10-06 04:02:47.349986	172.56.22.96	172.58.216.246	2017-09-23 20:54:11.177383	2017-10-16 02:40:28.12197	41mzwm2WNKaQigcZkppk	\N	\N	\N	\N
107	guest_qsjzxd3j1j@mint-store.ru		\N	\N	2017-09-23 10:32:29.388417	3	2017-10-15 13:22:26.634365	2017-10-06 10:04:39.795452	5.166.208.33	5.164.212.22	2017-09-23 10:32:29.374363	2017-10-15 13:22:26.635394	42AKm3TxHtPQeVbz54p8	\N	\N	\N	\N
138	guest_lydtemazym@mint-store.ru		\N	\N	2017-09-26 14:53:20.093198	1	2017-09-26 14:53:20.106393	2017-09-26 14:53:20.106393	87.250.224.50	87.250.224.50	2017-09-26 14:53:20.06246	2017-09-26 14:53:20.107228	-zqJ6BcyGVa1gf8znGCD	\N	\N	\N	\N
135	guest_nfnuvktal7@mint-store.ru		\N	\N	\N	3	2017-10-05 19:04:37.876801	2017-09-27 14:31:06.575462	95.79.31.156	89.109.5.147	2017-09-26 14:16:00.150087	2017-10-05 19:04:54.640553	\N	+7 (920) 251-61-25	Андрей	\N	\N
139	guest_g2zqraezkb@mint-store.ru		\N	\N	2017-09-26 17:43:12.136579	1	2017-09-26 17:43:12.143251	2017-09-26 17:43:12.143251	176.213.6.16	176.213.6.16	2017-09-26 17:43:12.105483	2017-09-26 17:43:12.144131	MJ7tEzQCxv2yLRczhvS8	\N	\N	\N	\N
140	guest_egb3h-kcc9@mint-store.ru		\N	\N	2017-09-26 18:18:42.209172	1	2017-09-26 18:18:42.21586	2017-09-26 18:18:42.21586	5.164.228.56	5.164.228.56	2017-09-26 18:18:42.190837	2017-09-26 18:18:42.216815	gf8fa7LaVMPhZmyey3Bm	\N	\N	\N	\N
121	guest_uu2qf_z7s8@mint-store.ru		\N	\N	2017-09-24 15:02:50.986364	3	2017-09-26 19:40:46.821147	2017-09-25 14:51:36.611201	5.227.14.66	82.208.70.154	2017-09-24 15:02:50.954004	2017-09-26 19:40:46.82222	cRGxuuk8zRy5h_uTDv9e	\N	\N	\N	\N
122	11leo89@mail.ru		\N	\N	2017-09-24 18:47:03.906185	3	2017-09-30 13:13:47.292002	2017-09-25 07:50:08.478584	46.138.61.188	79.139.156.13	2017-09-24 18:47:03.874553	2017-09-30 13:13:47.292816	PJJbpzJU6bAFKqGzH3UD	79689667636	Наталья 	\N	\N
136	guest_n_asyqjbta@mint-store.ru		\N	\N	\N	1	2017-09-26 14:17:23.303218	2017-09-26 14:17:23.303218	89.109.5.147	89.109.5.147	2017-09-26 14:17:23.277199	2017-09-29 11:17:48.604069	\N	79202516126	Андрей	\N	\N
141	guest_upthr3tard@mint-store.ru		\N	\N	2017-09-26 19:20:49.561638	1	2017-09-26 19:20:49.567975	2017-09-26 19:20:49.567975	37.147.198.0	37.147.198.0	2017-09-26 19:20:49.525528	2017-09-26 19:20:49.56887	e4iG3seWSxxgEC4zqfPv	\N	\N	\N	\N
157	guest_rxqj4clrmw@mint-store.ru		\N	\N	2017-09-27 09:51:59.693231	1	2017-09-27 09:51:59.699894	2017-09-27 09:51:59.699894	83.149.44.155	83.149.44.155	2017-09-27 09:51:59.680718	2017-09-27 09:51:59.70076	y-FA8q6UkcsJK5xPKkSG	\N	\N	\N	\N
142	guest_dlr2c9da4z@mint-store.ru		\N	\N	2017-09-26 19:31:16.171628	1	2017-09-26 19:31:16.178436	2017-09-26 19:31:16.178436	5.164.240.8	5.164.240.8	2017-09-26 19:31:16.1599	2017-09-26 19:31:16.179191	RUbWBADBmayJJZXxpySs	\N	\N	\N	\N
144	guest_9dfze51yed@mint-store.ru		\N	\N	2017-09-26 20:50:42.832788	1	2017-09-26 20:50:42.839062	2017-09-26 20:50:42.839062	217.66.158.86	217.66.158.86	2017-09-26 20:50:42.8115	2017-09-26 20:50:42.84005	MiUPnFZXeTdQFS8AUPmF	\N	\N	\N	\N
158	guest_fn6q-xumeo@mint-store.ru		\N	\N	2017-09-27 10:32:28.871979	1	2017-09-27 10:32:28.878621	2017-09-27 10:32:28.878621	77.108.98.2	77.108.98.2	2017-09-27 10:32:28.840965	2017-09-27 10:32:28.879523	AFY1oiu4f3E4xm128_Vf	\N	\N	\N	\N
146	guest_nq2k9pv7jh@mint-store.ru		\N	\N	2017-09-26 23:01:17.586767	1	2017-09-26 23:01:17.593141	2017-09-26 23:01:17.593141	87.117.185.184	87.117.185.184	2017-09-26 23:01:17.560612	2017-09-26 23:01:17.593948	SUzqv4nCK2xDwhEZ8vUy	\N	\N	\N	\N
175	guest_hdvkwibjyf@mint-store.ru		\N	\N	2017-09-28 16:00:33.600982	5	2017-10-24 07:23:21.74979	2017-10-20 02:21:50.12256	2.61.190.71	2.61.190.71	2017-09-28 16:00:33.569535	2017-10-24 07:23:21.751418	9tRFYMkpjXHKZw4E7mKv	\N	\N	\N	\N
159	guest_eeipgc_szn@mint-store.ru		\N	\N	2017-09-27 10:37:01.48035	1	2017-09-27 10:37:01.48713	2017-09-27 10:37:01.48713	95.79.99.118	95.79.99.118	2017-09-27 10:37:01.466587	2017-09-27 10:37:01.487922	xAQCbhzNyDTDBRYGnnK3	\N	\N	\N	\N
171	guest_e3j-k3n68d@mint-store.ru		\N	\N	2017-09-28 11:58:05.310901	1	2017-09-28 11:58:05.325808	2017-09-28 11:58:05.325808	95.24.139.47	95.24.139.47	2017-09-28 11:58:05.2954	2017-09-28 11:58:05.326724	g9Cp48HVRL8tXZ4mysG1	\N	\N	\N	\N
150	free.555@yandex.ru		\N	\N	2017-09-27 07:46:37.253234	6	2017-10-20 15:13:08.673173	2017-10-16 21:22:46.712797	188.32.113.94	188.32.113.94	2017-09-27 07:46:37.22265	2017-10-20 15:13:08.674647	nh4wcSBibLAZp564JWi8	79153011080	Ирина	\N	\N
149	guest_xas6zqzr_v@mint-store.ru		\N	\N	2017-09-27 05:56:04.175971	1	2017-09-27 05:56:04.182639	2017-09-27 05:56:04.182639	115.249.121.221	115.249.121.221	2017-09-27 05:56:04.144798	2017-09-27 05:56:04.183578	SLopjrUZqmzio24ACbrt	\N	\N	\N	\N
160	guest_xszcyrr8z2@mint-store.ru		\N	\N	2017-09-27 11:24:53.942146	1	2017-09-27 11:24:53.948759	2017-09-27 11:24:53.948759	91.214.142.23	91.214.142.23	2017-09-27 11:24:53.929119	2017-09-27 11:24:53.949587	jXpGzb2qoftfDQLGstGy	\N	\N	\N	\N
165	guest_jw1kxwgkea@mint-store.ru		\N	\N	2017-09-27 19:04:50.208296	14	2017-10-22 20:07:25.676466	2017-10-22 12:20:08.870305	83.149.37.160	31.173.103.233	2017-09-27 19:04:50.181418	2017-10-22 20:07:25.677525	DMs2fGwzLDBmj6hzMptz	79229606592	Анна	\N	\N
151	guest_dkbs7qny1u@mint-store.ru		\N	\N	2017-09-27 08:14:57.405641	2	2017-10-06 09:00:53.106467	2017-09-27 08:14:57.412777	217.66.156.29	217.66.159.144	2017-09-27 08:14:57.374655	2017-10-06 09:00:53.107722	yzTtwvZooEq92kupqhuG	\N	\N	\N	\N
172	guest_yr4hed_e3w@mint-store.ru		\N	\N	2017-09-28 12:15:31.257562	1	2017-09-28 12:15:31.26416	2017-09-28 12:15:31.26416	109.194.227.205	109.194.227.205	2017-09-28 12:15:31.226561	2017-09-28 12:15:31.26533	hmydGLsNgQw1JxRkuX8c	\N	\N	\N	\N
162	guest_d_txmsbhiz@mint-store.ru		\N	\N	2017-09-27 12:02:45.627711	1	2017-09-27 12:02:45.634417	2017-09-27 12:02:45.634417	93.120.188.133	93.120.188.133	2017-09-27 12:02:45.613667	2017-09-27 12:02:45.635254	_sb77yjR7m_zcmyzssS8	\N	\N	\N	\N
167	guest_bwqhz5mjj7@mint-store.ru		\N	\N	2017-09-28 06:44:27.294509	6	2017-10-06 17:52:08.516919	2017-10-05 18:48:36.145435	178.22.194.74	178.22.194.74	2017-09-28 06:44:27.281059	2017-10-06 17:52:08.517897	Drv8Xycfkuh-9-uqQchL	\N	\N	\N	\N
164	abra40@mail.ru		\N	\N	2017-09-27 12:17:36.271586	1	2017-09-27 12:17:36.278169	2017-09-27 12:17:36.278169	82.208.101.236	82.208.101.236	2017-09-27 12:17:36.259058	2017-10-14 07:07:19.131121	5SAJrsH35UCLvoEGrJbe	79036038326	Дарья	\N	\N
163	guest_b3xrfzm4na@mint-store.ru		\N	\N	2017-09-27 12:17:17.564861	1	2017-09-27 12:17:17.571476	2017-09-27 12:17:17.571476	37.230.255.252	37.230.255.252	2017-09-27 12:17:17.550648	2017-09-27 12:17:17.572394	jbiGkiXGpk_ZvMxQWSxB	\N	\N	\N	\N
181	guest_a4gfviszwk@mint-store.ru		\N	\N	2017-09-29 15:25:50.267996	1	2017-09-29 15:25:50.281209	2017-09-29 15:25:50.281209	213.79.85.254	213.79.85.254	2017-09-29 15:25:50.253024	2017-09-29 15:25:50.282194	a1XghWNqkcdY-6k-xaPc	\N	\N	\N	\N
161	guest_2usw9q9ycg@mint-store.ru		\N	\N	2017-09-27 11:48:17.273742	6	2017-10-25 11:52:59.507934	2017-10-17 09:20:07.312855	178.209.117.194	178.209.117.194	2017-09-27 11:48:17.245211	2017-10-25 11:52:59.509258	2LwsXsqd7TkojNNV1GEz	\N	\N	\N	\N
168	guest_4sp47c-xtr@mint-store.ru		\N	\N	2017-09-28 10:43:59.989968	1	2017-09-28 10:43:59.996649	2017-09-28 10:43:59.996649	82.208.127.154	82.208.127.154	2017-09-28 10:43:59.959931	2017-09-28 10:43:59.997487	2gEXoxaQxeF3XXk5G1a4	\N	\N	\N	\N
153	guest_wd9tysjxqs@mint-store.ru		\N	\N	2017-09-27 08:23:19.402303	11	2017-10-23 09:29:47.244807	2017-10-15 18:55:17.795521	176.65.114.197	217.66.157.222	2017-09-27 08:23:19.375566	2017-10-23 09:29:47.245694	CQJi-b_eskh8ZRtFgz9M	\N	\N	\N	\N
156	saffo4ka@bk.ru		\N	\N	2017-09-27 08:54:01.735804	1	2017-09-27 08:54:01.742376	2017-09-27 08:54:01.742376	85.143.3.212	85.143.3.212	2017-09-27 08:54:01.704312	2017-09-29 11:17:48.667003	MnyqbWMr3m9dYgsi_xoz	79625148520	Светлана 	\N	\N
169	guest_xoy8h5_nzw@mint-store.ru		\N	\N	2017-09-28 10:50:40.803576	1	2017-09-28 10:50:40.810252	2017-09-28 10:50:40.810252	93.188.122.27	93.188.122.27	2017-09-28 10:50:40.78034	2017-09-28 10:50:40.811097	iQPyv551CiqGQFT8E9ZZ	\N	\N	\N	\N
170	guest_voefbugpe_@mint-store.ru		\N	\N	2017-09-28 10:55:36.337226	1	2017-09-28 10:55:36.343528	2017-09-28 10:55:36.343528	82.208.101.183	82.208.101.183	2017-09-28 10:55:36.310536	2017-09-28 10:55:36.344491	HLp8NPWEzBDxsWc2gswP	\N	\N	\N	\N
178	guest_yzkx2j7xgy@mint-store.ru		\N	\N	2017-09-29 00:28:21.489976	1	2017-09-29 00:28:21.502571	2017-09-29 00:28:21.502571	180.76.15.157	180.76.15.157	2017-09-29 00:28:21.430877	2017-09-29 00:28:21.503538	8HqVa81xWct7X2v8LxuS	\N	\N	\N	\N
176	guest_kx8antnlsx@mint-store.ru		\N	\N	2017-09-28 20:41:05.911337	1	2017-09-28 20:41:05.924539	2017-09-28 20:41:05.924539	95.37.175.123	95.37.175.123	2017-09-28 20:41:05.894382	2017-09-28 20:41:05.925369	HmHgVqns25eRxGhyQwAz	\N	\N	\N	\N
174	guest_beruup6mzu@mint-store.ru		\N	\N	2017-09-28 12:35:15.808189	1	2017-09-28 12:35:15.81479	2017-09-28 12:35:15.81479	79.175.51.230	79.175.51.230	2017-09-28 12:35:15.781443	2017-09-28 12:35:15.815735	ycT_uTRy6JN2kFdrxr9R	\N	\N	\N	\N
147	guest_uwfb2eez2y@mint-store.ru		\N	\N	2017-09-27 04:17:05.99404	10	2017-10-23 20:57:11.930458	2017-10-22 07:48:41.820682	5.166.220.13	5.166.220.13	2017-09-27 04:17:05.964198	2017-10-23 20:57:11.931558	EqospxqJSA6jszmUCU1T	\N	\N	\N	\N
143	guest_jzak9nbrgx@mint-store.ru		\N	\N	2017-09-26 20:34:33.104238	12	2017-10-24 13:03:18.113751	2017-10-21 09:54:36.717675	83.69.198.222	5.3.201.188	2017-09-26 20:34:33.086779	2017-10-24 13:03:18.114649	eGwyVatnHhHpDZh4M5Q6	\N	\N	\N	\N
180	guest_i8x6zllhxv@mint-store.ru		\N	\N	2017-09-29 09:11:30.049642	4	2017-10-05 18:59:38.758736	2017-10-02 08:17:12.77053	37.147.206.195	37.147.206.195	2017-09-29 09:11:30.025766	2017-10-05 18:59:38.75968	eXdUq4bgm96AAwZENF8A	\N	\N	\N	\N
177	guest_dtcagbrxc7@mint-store.ru		\N	\N	2017-09-28 21:30:54.84635	1	2017-09-28 21:30:54.859321	2017-09-28 21:30:54.859321	212.67.26.217	212.67.26.217	2017-09-28 21:30:54.816549	2017-09-28 21:30:54.860331	X1h4tN3sjr_hsYFYsyGs	\N	\N	\N	\N
166	guest_3vrxtfk7hq@mint-store.ru		\N	\N	2017-09-27 20:48:21.092966	8	2017-10-24 19:22:17.890742	2017-10-21 07:23:57.63818	5.164.204.10	5.166.220.45	2017-09-27 20:48:21.076684	2017-10-24 19:22:17.892071	CeGxEY6KjWG3Ad6G534E	79040676245	Инна	\N	\N
179	guest_mpkvzpyns-@mint-store.ru		\N	\N	2017-09-29 01:18:44.279404	1	2017-09-29 01:18:44.292483	2017-09-29 01:18:44.292483	87.250.224.50	87.250.224.50	2017-09-29 01:18:44.253822	2017-09-29 01:18:44.293381	txHkMLzfR9G-oXP79tkz	\N	\N	\N	\N
148	guest_zruspxy-cp@mint-store.ru		\N	\N	2017-09-27 04:51:29.214095	17	2017-10-21 19:44:14.174777	2017-10-21 07:13:12.906285	82.208.100.229	82.208.100.229	2017-09-27 04:51:29.186029	2017-10-21 19:44:14.175691	bJifGziVfMK2yfyWb-sU	79200290212	Наталья	\N	\N
73	maslova_natalya_@mail.ru		\N	\N	2017-09-21 08:34:30.013528	11	2017-10-16 12:30:46.088604	2017-10-13 10:47:12.972314	91.230.65.201	91.230.65.201	2017-09-21 08:34:29.991082	2017-10-16 12:30:46.089446	xNFKKLHkKJ2MPmdsJ3yZ	79092958000	Наталья	\N	\N
152	stektris@rambler.ru		\N	\N	2017-09-27 08:21:56.051315	3	2017-09-30 12:57:28.312364	2017-09-27 15:26:29.81434	82.208.100.151	93.120.220.33	2017-09-27 08:21:56.021009	2017-09-30 12:57:28.313427	PcnBq2jDQsFhmg9_594b	79302760652	Elena	\N	\N
154	ismakova.a@gmail.com		\N	\N	2017-09-27 08:33:44.428974	1	2017-09-27 08:33:44.435178	2017-09-27 08:33:44.435178	195.151.33.26	195.151.33.26	2017-09-27 08:33:44.415296	2017-09-29 11:17:48.65853	VFwjMhJZGsfSQwxfxgiQ	79161296617	Анастасия	\N	\N
145	plyusnina00d@icloud.com		\N	\N	2017-09-26 21:27:24.417318	35	2017-10-23 20:02:40.399692	2017-10-22 08:45:35.172448	176.59.106.90	176.59.119.87	2017-09-26 21:27:24.402235	2017-10-23 20:02:40.400854	inExx4eS4fcpqsmf6SyC	79513560409	Дарья	\N	\N
173	guest_mawtwj3msw@mint-store.ru		\N	\N	2017-09-28 12:18:47.933756	2	2017-10-02 11:13:34.843639	2017-09-28 12:18:47.954721	176.59.119.126	176.59.106.36	2017-09-28 12:18:47.896686	2017-10-02 11:13:34.844882	syXiWxxGAsuZD2zwhXpy	\N	\N	\N	\N
182	guest_yqyvtv6_3g@mint-store.ru		\N	\N	2017-09-29 18:04:20.289348	1	2017-09-29 18:04:20.295769	2017-09-29 18:04:20.295769	85.26.164.204	85.26.164.204	2017-09-29 18:04:20.277944	2017-09-29 18:04:20.29662	C4C6gx_yLtTLN842Jifn	\N	\N	\N	\N
183	guest_tmqu8sjebc@mint-store.ru		\N	\N	2017-09-29 18:05:36.057198	1	2017-09-29 18:05:36.06384	2017-09-29 18:05:36.06384	85.26.164.204	85.26.164.204	2017-09-29 18:05:36.027748	2017-09-29 18:05:36.064728	p_G6bxs93sDKsKuiTVBL	\N	\N	\N	\N
184	guest_c58fmfz_zx@mint-store.ru		\N	\N	2017-09-29 19:01:42.792272	1	2017-09-29 19:01:42.805347	2017-09-29 19:01:42.805347	82.208.100.148	82.208.100.148	2017-09-29 19:01:42.777569	2017-09-29 19:01:42.8063	xTEe_VUUMxjXFPz1TwCj	\N	\N	\N	\N
185	guest_gu7ebngqzx@mint-store.ru		\N	\N	2017-09-29 19:20:47.113654	1	2017-09-29 19:20:47.126731	2017-09-29 19:20:47.126731	66.249.66.27	66.249.66.27	2017-09-29 19:20:47.083405	2017-09-29 19:20:47.127703	xoaYVyNnVA66SiseSPzF	\N	\N	\N	\N
155	guest_xl6knzvpb5@mint-store.ru		\N	\N	2017-09-27 08:36:01.058307	2	2017-09-30 09:12:38.852274	2017-09-27 08:36:01.064807	81.200.8.79	81.200.8.85	2017-09-27 08:36:01.029572	2017-09-30 09:12:38.853362	AJYxLFoyaNwgwUqMq2Fs	\N	\N	\N	\N
186	guest_anxiianggj@mint-store.ru		\N	\N	2017-09-30 06:21:59.625947	1	2017-09-30 06:21:59.632418	2017-09-30 06:21:59.632418	66.249.76.53	66.249.76.53	2017-09-30 06:21:59.608474	2017-09-30 06:21:59.633282	5EaGKyTe3BsCsssjDbs4	\N	\N	\N	\N
194	guest_vrhkdr-ed9@mint-store.ru		\N	\N	2017-10-01 10:52:23.479159	2	2017-10-03 08:38:41.752783	2017-10-01 10:52:23.485674	188.170.80.98	213.87.145.113	2017-10-01 10:52:23.447149	2017-10-03 08:38:41.753834	L73AAqpz7b9y1j-vHr7z	\N	\N	\N	\N
215	guest_nhbtzvj5tc@mint-store.ru		\N	\N	2017-10-06 08:36:20.21281	1	2017-10-06 08:36:20.227402	2017-10-06 08:36:20.227402	195.2.214.77	195.2.214.77	2017-10-06 08:36:20.193506	2017-10-06 08:36:20.228268	Vjdoip9mvgYWRVTdzy8h	\N	\N	\N	\N
188	guest_kqxw_qbrj-@mint-store.ru		\N	\N	2017-09-30 11:37:48.010431	1	2017-09-30 11:37:48.017033	2017-09-30 11:37:48.017033	82.208.100.122	82.208.100.122	2017-09-30 11:37:47.981126	2017-09-30 11:37:48.017959	7xE-giE7Je4VXEjauRbF	\N	\N	\N	\N
189	guest_qbjgjsgjyp@mint-store.ru		\N	\N	2017-09-30 13:48:04.648956	1	2017-09-30 13:48:04.655402	2017-09-30 13:48:04.655402	176.99.162.1	176.99.162.1	2017-09-30 13:48:04.633902	2017-09-30 13:48:04.656325	NqZxfkN6pLAzYXcLx59s	\N	\N	\N	\N
227	guest_xkmoy2m999@mint-store.ru		\N	\N	2017-10-07 16:22:18.589221	6	2017-10-20 12:42:57.415552	2017-10-17 12:21:41.19641	213.177.124.42	213.177.124.42	2017-10-07 16:22:18.561808	2017-10-20 12:42:57.416234	ojNjx4WcrodTAKmJJaxN	\N	\N	\N	\N
191	guest_pnmnyr8t9t@mint-store.ru		\N	\N	2017-09-30 18:43:02.702558	1	2017-09-30 18:43:02.708981	2017-09-30 18:43:02.708981	185.14.4.78	185.14.4.78	2017-09-30 18:43:02.67371	2017-09-30 18:43:02.709993	7yMdYovArVrGN2VGo4Y9	\N	\N	\N	\N
192	guest_48axsaznhv@mint-store.ru		\N	\N	2017-10-01 09:40:33.302762	1	2017-10-01 09:40:33.315886	2017-10-01 09:40:33.315886	89.222.164.90	89.222.164.90	2017-10-01 09:40:33.270099	2017-10-01 09:40:33.316906	VALzmfR3dy4KK5F6yi9x	\N	\N	\N	\N
204	guest_hfvza4w2hy@mint-store.ru		\N	\N	2017-10-04 09:18:57.465681	1	2017-10-04 09:18:57.520508	2017-10-04 09:18:57.520508	109.73.36.254	109.73.36.254	2017-10-04 09:18:57.434264	2017-10-04 09:18:57.521494	ZAJzigwuPjC_FDniQ41H	\N	\N	\N	\N
193	guest_1kvs4uxhvk@mint-store.ru		\N	\N	2017-10-01 10:03:48.802993	1	2017-10-01 10:03:48.809335	2017-10-01 10:03:48.809335	87.250.224.50	87.250.224.50	2017-10-01 10:03:48.774111	2017-10-01 10:03:48.810271	Uxi7_iDmVEpUFk_WTzF8	\N	\N	\N	\N
216	guest_f7wl-vuuxd@mint-store.ru		\N	\N	2017-10-06 08:53:47.46774	1	2017-10-06 08:53:47.474359	2017-10-06 08:53:47.474359	81.18.158.20	81.18.158.20	2017-10-06 08:53:47.38414	2017-10-06 08:53:47.475284	KxUZGJbxx_yH5KzExN9J	\N	\N	\N	\N
195	malaia_2004@mail.ru		\N	\N	2017-10-01 11:14:47.223385	1	2017-10-01 11:14:47.238185	2017-10-01 11:14:47.238185	178.71.179.127	178.71.179.127	2017-10-01 11:14:47.19382	2017-10-01 11:18:24.628174	8umDXcSJj_Sk1UXnFr-e	79112897769	Татьяна	\N	\N
225	guest_lmdjlj5fxm@mint-store.ru		\N	\N	2017-10-07 02:13:11.645782	1	2017-10-07 02:13:11.660357	2017-10-07 02:13:11.660357	87.250.224.126	87.250.224.126	2017-10-07 02:13:11.629982	2017-10-07 02:13:11.66124	tNsrxv_8CPHdzfRyFqFy	\N	\N	\N	\N
205	guest_uprgydwo5u@mint-store.ru		\N	\N	2017-10-04 20:04:59.273558	1	2017-10-04 20:04:59.279307	2017-10-04 20:04:59.279307	87.250.224.126	87.250.224.126	2017-10-04 20:04:59.244151	2017-10-04 20:04:59.279992	RQtqozFURvzhFmSctgmg	\N	\N	\N	\N
197	guest_ecrxecggr_@mint-store.ru		\N	\N	2017-10-02 04:37:29.077798	1	2017-10-02 04:37:29.085841	2017-10-02 04:37:29.085841	185.190.104.68	185.190.104.68	2017-10-02 04:37:29.042831	2017-10-02 04:37:29.086824	1b_yC-rEJZyw_EjdZ9rG	\N	\N	\N	\N
206	guest_3qczgisuqi@mint-store.ru		\N	\N	2017-10-04 21:26:37.459057	1	2017-10-04 21:26:37.472014	2017-10-04 21:26:37.472014	95.24.3.66	95.24.3.66	2017-10-04 21:26:37.443522	2017-10-04 21:26:37.472831	kHF6wJ-vhUsRgS1BWgXM	\N	\N	\N	\N
198	guest_vquq_nvjvx@mint-store.ru		\N	\N	2017-10-02 08:27:14.518109	1	2017-10-02 08:27:14.540429	2017-10-02 08:27:14.540429	217.69.133.10	217.69.133.10	2017-10-02 08:27:14.475559	2017-10-02 08:27:14.541363	FNqVoyEoQFmeKav1c9Q3	\N	\N	\N	\N
187	guest_isdpt9vdig@mint-store.ru		\N	\N	2017-09-30 08:51:28.747235	2	2017-10-05 21:23:18.729842	2017-09-30 08:51:28.753641	95.79.221.245	95.79.221.245	2017-09-30 08:51:28.70866	2017-10-05 21:23:18.730913	z5TszEg8PZuJfZ-QzoWA	\N	\N	\N	\N
199	guest_yu4qk9f5p7@mint-store.ru		\N	\N	2017-10-02 18:40:02.421643	1	2017-10-02 18:40:02.434047	2017-10-02 18:40:02.434047	82.208.127.36	82.208.127.36	2017-10-02 18:40:02.341203	2017-10-02 18:40:02.435069	64zcznxodt9oahTwJjYf	\N	\N	\N	\N
207	guest_nnxwthff2y@mint-store.ru		\N	\N	2017-10-04 21:35:36.175275	1	2017-10-04 21:35:36.19005	2017-10-04 21:35:36.19005	66.249.76.102	66.249.76.102	2017-10-04 21:35:36.162238	2017-10-04 21:35:36.190944	JjQQnAiBeu4D9cYcuRK9	\N	\N	\N	\N
201	guest_yyuemnzglj@mint-store.ru		\N	\N	2017-10-03 01:18:30.826185	1	2017-10-03 01:18:30.83873	2017-10-03 01:18:30.83873	87.250.224.50	87.250.224.50	2017-10-03 01:18:30.806766	2017-10-03 01:18:30.839692	Z2Mt6ekLk5-ZF_TDbKfy	\N	\N	\N	\N
230	guest_loxsahxgig@mint-store.ru		\N	\N	2017-10-08 16:44:16.981296	2	2017-10-09 12:28:43.411818	2017-10-08 16:44:16.9877	82.208.124.121	82.208.124.143	2017-10-08 16:44:16.957642	2017-10-09 12:28:43.412934	LcdsbaUzZGY_yLKn6Kgu	\N	\N	\N	\N
208	guest_x92r6tpt4s@mint-store.ru		\N	\N	2017-10-05 08:27:08.095134	1	2017-10-05 08:27:08.101397	2017-10-05 08:27:08.101397	109.74.139.147	109.74.139.147	2017-10-05 08:27:08.063053	2017-10-05 08:27:08.102324	EW8-5ZGsCPzaCpcXcdZ5	\N	\N	\N	\N
202	guest_dyjssdknum@mint-store.ru		\N	\N	2017-10-03 08:27:15.828832	1	2017-10-03 08:27:15.835279	2017-10-03 08:27:15.835279	46.242.72.250	46.242.72.250	2017-10-03 08:27:15.797141	2017-10-03 08:27:15.836236	-3DuBj9MKxiHs9LFqUPr	\N	\N	\N	\N
214	guest_cr9gieq-qs@mint-store.ru		\N	\N	2017-10-06 02:30:36.459064	1	2017-10-06 02:30:36.472281	2017-10-06 02:30:36.472281	83.149.46.169	83.149.46.169	2017-10-06 02:30:36.444316	2017-10-06 02:30:36.473157	6N-iqohQmqDvEhdSMyxy	\N	\N	\N	\N
219	guest_m3dwsv8k6n@mint-store.ru		\N	\N	2017-10-06 10:38:59.326074	7	2017-10-23 10:56:31.369218	2017-10-21 09:26:09.533369	128.68.100.104	128.68.100.104	2017-10-06 10:38:59.312464	2017-10-23 10:56:31.370098	AE9mxy9SBjJZZet-c3fW	\N	\N	\N	\N
218	guest_yh-npy_1l3@mint-store.ru		\N	\N	2017-10-06 10:16:09.325329	1	2017-10-06 10:16:09.340715	2017-10-06 10:16:09.340715	85.140.2.254	85.140.2.254	2017-10-06 10:16:09.276927	2017-10-06 10:16:09.341634	wi6NhADb4ox6V5s1HnEz	\N	\N	\N	\N
210	guest_hctpmv_q5r@mint-store.ru		\N	\N	2017-10-05 13:35:06.974306	1	2017-10-05 13:35:06.986498	2017-10-05 13:35:06.986498	176.59.41.212	176.59.41.212	2017-10-05 13:35:06.951861	2017-10-05 13:35:06.987407	sySsuwNDn7a79v5zTRqv	\N	\N	\N	\N
203	a.pelykh@bk.ru		\N	\N	2017-10-04 07:52:45.362463	2	2017-10-06 04:46:22.11768	2017-10-04 07:52:45.369011	109.252.198.147	91.79.201.178	2017-10-04 07:52:45.345474	2017-10-06 04:48:52.63551	xp9nszjR3z5djBrBxuxy	79646424036	Анастасия	\N	\N
223	guest_6pa6xmonsl@mint-store.ru		\N	\N	2017-10-06 21:28:45.951363	1	2017-10-06 21:28:45.957806	2017-10-06 21:28:45.957806	213.87.137.255	213.87.137.255	2017-10-06 21:28:45.936597	2017-10-06 21:28:45.958732	2o7QWCyxWLz_oYaBiPxP	\N	\N	\N	\N
217	guest_kdsecw55cn@mint-store.ru		\N	\N	2017-10-06 09:33:07.263805	7	2017-10-21 04:55:16.03777	2017-10-16 05:31:27.772435	82.208.124.164	176.59.116.43	2017-10-06 09:33:07.222825	2017-10-21 04:55:16.038699	DkRPueZ-VU3SdjH6ULek	\N	\N	\N	\N
231	guest_686vtqyr8w@mint-store.ru		\N	\N	2017-10-08 16:48:38.557468	10	2017-10-21 05:49:41.697397	2017-10-20 09:26:57.962308	188.162.192.2	185.150.15.79	2017-10-08 16:48:38.525704	2017-10-21 05:49:41.698271	qT5rjxniXjjkKPLdvD4y	\N	\N	\N	\N
196	guest_zv68nskslb@mint-store.ru		\N	\N	2017-10-01 18:12:58.087698	10	2017-10-13 14:57:48.79101	2017-10-12 13:59:00.035836	85.140.2.112	85.140.2.112	2017-10-01 18:12:58.06958	2017-10-13 14:57:48.792786	td9fzkoqfLqHziUbfdDX	\N	\N	\N	\N
213	guest_d3wbfsht3e@mint-store.ru		\N	\N	2017-10-05 21:14:13.60255	14	2017-10-22 15:32:12.053395	2017-10-20 13:02:29.121874	5.164.234.66	217.118.93.165	2017-10-05 21:14:13.593249	2017-10-22 15:32:12.054882	pL8penxPL-4-HhUcWhA1	79056617375	Инна	\N	\N
221	guest_6zw_yrgryd@mint-store.ru		\N	\N	2017-10-06 19:27:05.927387	1	2017-10-06 19:27:05.93375	2017-10-06 19:27:05.93375	46.242.29.178	46.242.29.178	2017-10-06 19:27:05.902709	2017-10-06 19:27:05.934552	kz4bx_rRqu7zvpxyos8k	\N	\N	\N	\N
222	guest_2rfdg_tgxx@mint-store.ru		\N	\N	2017-10-06 20:29:56.515273	1	2017-10-06 20:29:56.521899	2017-10-06 20:29:56.521899	178.206.94.35	178.206.94.35	2017-10-06 20:29:56.484557	2017-10-06 20:29:56.522751	2QKqyzAQuNkav8x4mB2K	\N	\N	\N	\N
224	guest_rysaxknawe@mint-store.ru		\N	\N	2017-10-07 00:50:29.516786	1	2017-10-07 00:50:29.523248	2017-10-07 00:50:29.523248	89.178.21.172	89.178.21.172	2017-10-07 00:50:29.487492	2017-10-07 00:50:29.524221	b4wXBKzikRQ-p2jSoKHT	\N	\N	\N	\N
226	guest_9sfn7vlhf1@mint-store.ru		\N	\N	2017-10-07 04:43:40.051578	1	2017-10-07 04:43:40.057885	2017-10-07 04:43:40.057885	176.59.107.170	176.59.107.170	2017-10-07 04:43:40.026892	2017-10-07 04:43:40.058665	x4e9T1bfx_27dqXTAfmc	\N	\N	\N	\N
212	guest_heizhyju5y@mint-store.ru		\N	\N	2017-10-05 19:05:04.829117	2	2017-10-16 13:17:35.947122	2017-10-05 19:05:04.843815	89.109.5.147	95.79.31.156	2017-10-05 19:05:04.81468	2017-10-16 13:17:35.948035	fsMhbUjgxEosDzzX-7kP	\N	\N	\N	\N
200	guest_h1zuo938v5@mint-store.ru		\N	\N	2017-10-02 19:25:55.693396	8	2017-10-20 07:45:00.404247	2017-10-16 07:31:19.911907	149.62.24.245	88.81.41.247	2017-10-02 19:25:55.678766	2017-10-20 07:45:00.405227	dqLa-hEgKMZNbPEAJfSh	\N	\N	\N	\N
228	guest_g711qsq9uv@mint-store.ru		\N	\N	2017-10-08 09:07:15.468364	1	2017-10-08 09:07:15.474313	2017-10-08 09:07:15.474313	213.87.155.119	213.87.155.119	2017-10-08 09:07:15.449687	2017-10-08 09:07:15.475265	xxE57m6ZssJmeCorWWnv	\N	\N	\N	\N
190	guest_lt81gtqv1g@mint-store.ru		\N	\N	2017-09-30 15:57:17.164525	15	2017-10-23 11:31:44.104022	2017-10-16 09:37:58.729067	91.234.96.150	217.118.79.38	2017-09-30 15:57:17.133827	2017-10-23 11:31:44.104922	3DmFteh-NTpeo2eV1B8z	\N	\N	\N	\N
229	guest_avmxtks4ta@mint-store.ru		\N	\N	2017-10-08 10:19:51.352271	1	2017-10-08 10:19:51.3587	2017-10-08 10:19:51.3587	176.15.43.101	176.15.43.101	2017-10-08 10:19:51.320305	2017-10-08 10:19:51.359696	ge6s5AxxepcCbdVYjNRi	\N	\N	\N	\N
220	lovy87@mail.ru		\N	\N	2017-10-06 11:43:24.174016	10	2017-10-23 09:55:25.100046	2017-10-18 19:12:28.516498	178.252.127.229	178.252.127.229	2017-10-06 11:43:24.156922	2017-10-23 09:55:25.100905	jPq_6wMH5abdMsSAYHD4	79101073718	Юля 	\N	\N
209	guest_yeonsc8_4r@mint-store.ru		\N	\N	2017-10-05 11:12:36.237566	3	2017-10-13 16:14:25.779609	2017-10-13 06:26:23.384336	85.140.3.3	85.140.3.134	2017-10-05 11:12:36.222509	2017-10-13 16:14:25.780654	bvzGXsSWQgz4a4PPW8rJ	\N	\N	\N	\N
232	guest_vkrynxs9fq@mint-store.ru		\N	\N	2017-10-08 16:52:17.646027	1	2017-10-08 16:52:17.652558	2017-10-08 16:52:17.652558	88.198.25.244	88.198.25.244	2017-10-08 16:52:17.62258	2017-10-08 16:52:17.653429	2jHgBjJi-zSx9UxzAMku	\N	\N	\N	\N
211	guest_ztymyxmfwg@mint-store.ru		\N	\N	2017-10-05 18:50:15.076265	8	2017-10-24 02:09:09.898973	2017-10-19 23:34:21.892113	217.27.35.220	5.166.204.37	2017-10-05 18:50:15.061223	2017-10-24 02:09:09.900034	1km9uSo9LjtuwjGm7kRe	\N	\N	\N	\N
244	guest_tj3pbdzpem@mint-store.ru		\N	\N	2017-10-10 12:27:42.060019	11	2017-10-20 10:36:06.141654	2017-10-20 07:59:45.059685	83.149.44.8	83.149.44.32	2017-10-10 12:27:42.050602	2017-10-20 10:36:06.142443	fKES8rLe5S4XRizaohGs	\N	\N	\N	\N
234	guest_mzasyxblsz@mint-store.ru		\N	\N	2017-10-08 20:46:13.002827	1	2017-10-08 20:46:13.009266	2017-10-08 20:46:13.009266	37.147.101.119	37.147.101.119	2017-10-08 20:46:12.984431	2017-10-08 20:46:13.01024	7usJZKhzY94E9KAzm9Lr	\N	\N	\N	\N
250	guest_z3ertzfjf5@mint-store.ru		\N	\N	2017-10-11 18:51:45.051184	1	2017-10-11 18:51:45.066031	2017-10-11 18:51:45.066031	93.120.229.186	93.120.229.186	2017-10-11 18:51:45.020505	2017-10-11 18:51:45.066828	hpp1xUb9sKks3FfaLZkY	\N	\N	\N	\N
235	guest_zsk_fuflze@mint-store.ru		\N	\N	2017-10-08 21:16:30.497249	1	2017-10-08 21:16:30.509723	2017-10-08 21:16:30.509723	95.220.118.37	95.220.118.37	2017-10-08 21:16:30.46631	2017-10-08 21:16:30.510717	2jK4B7MRAbDbYxb3BdxN	\N	\N	\N	\N
270	guest_izre4kfmvb@mint-store.ru		\N	\N	2017-10-15 05:02:50.186272	1	2017-10-15 05:02:50.200553	2017-10-15 05:02:50.200553	95.213.183.162	95.213.183.162	2017-10-15 05:02:50.156146	2017-10-15 05:02:50.201351	7q3iGSXaQ9Beax7G3kvh	\N	\N	\N	\N
251	guest_xmosxfxzgs@mint-store.ru		\N	\N	2017-10-11 18:51:45.875961	1	2017-10-11 18:51:45.882566	2017-10-11 18:51:45.882566	93.120.229.186	93.120.229.186	2017-10-11 18:51:45.84784	2017-10-11 18:51:45.883384	BQMeoeswi891KNpLVwtp	\N	\N	\N	\N
238	guest_vlgdnccqem@mint-store.ru		\N	\N	2017-10-09 14:22:38.027822	1	2017-10-09 14:22:38.03434	2017-10-09 14:22:38.03434	87.250.224.126	87.250.224.126	2017-10-09 14:22:37.998698	2017-10-09 14:22:38.035211	nMUSCoRuKzhVpfr89T5m	\N	\N	\N	\N
252	guest_sa1rzbpzya@mint-store.ru		\N	\N	2017-10-11 18:51:51.217609	1	2017-10-11 18:51:51.223857	2017-10-11 18:51:51.223857	93.120.229.186	93.120.229.186	2017-10-11 18:51:51.198901	2017-10-11 18:51:51.224645	iaBPXWyswz-tgTvx2rQi	\N	\N	\N	\N
265	guest_3gmyongdcz@mint-store.ru		\N	\N	2017-10-13 20:00:31.180728	1	2017-10-13 20:00:31.195349	2017-10-13 20:00:31.195349	66.249.75.197	66.249.75.197	2017-10-13 20:00:31.149134	2017-10-13 20:00:31.196277	MHx-5usgqsFsxc3ZYigd	\N	\N	\N	\N
240	guest_kyb8fryycy@mint-store.ru		\N	\N	2017-10-09 19:47:40.139105	1	2017-10-09 19:47:40.145756	2017-10-09 19:47:40.145756	185.6.8.3	185.6.8.3	2017-10-09 19:47:40.103934	2017-10-09 19:47:40.146518	6CzUpu5wea3BxEHCmapU	\N	\N	\N	\N
253	guest_u-dhuhtrdu@mint-store.ru		\N	\N	2017-10-11 18:51:51.417204	1	2017-10-11 18:51:51.423778	2017-10-11 18:51:51.423778	93.120.229.186	93.120.229.186	2017-10-11 18:51:51.40483	2017-10-11 18:51:51.424598	6jW1czniFQYQQUoWJ6f8	\N	\N	\N	\N
241	petrichkovich@yandex.ru		\N	\N	2017-10-09 22:46:59.263257	1	2017-10-09 22:46:59.276453	2017-10-09 22:46:59.276453	193.243.174.39	193.243.174.39	2017-10-09 22:46:59.248068	2017-10-09 22:53:47.357787	7ynyAo-E2R7KYs-WMsss	79629772120	Екатерина	\N	\N
242	guest_ejkjx_p6pv@mint-store.ru		\N	\N	2017-10-10 01:26:51.61938	1	2017-10-10 01:26:51.632564	2017-10-10 01:26:51.632564	109.63.144.14	109.63.144.14	2017-10-10 01:26:51.590051	2017-10-10 01:26:51.633518	fWxvgEXRUhiqqVyX7AnL	\N	\N	\N	\N
254	guest_1vyvxmugpn@mint-store.ru		\N	\N	2017-10-11 18:51:53.175413	1	2017-10-11 18:51:53.181997	2017-10-11 18:51:53.181997	93.120.229.186	93.120.229.186	2017-10-11 18:51:53.167032	2017-10-11 18:51:53.182879	F9rfnYzT9wqHChhYx8xV	\N	\N	\N	\N
243	guest_kjqy4h-qym@mint-store.ru		\N	\N	2017-10-10 07:36:56.9272	1	2017-10-10 07:36:56.941255	2017-10-10 07:36:56.941255	109.172.31.28	109.172.31.28	2017-10-10 07:36:56.900452	2017-10-10 07:39:27.610375	etSw8-LsBS7dxxL8HcNY	79036571128	Елена	\N	\N
259	guest_qqdpzxwscc@mint-store.ru		\N	\N	2017-10-12 06:56:55.36721	2	2017-10-25 14:12:28.537953	2017-10-12 06:56:55.380556	89.109.5.147	89.109.5.147	2017-10-12 06:56:55.334236	2017-10-25 14:12:28.539099	omx-eV5wyxssjkkxf9s3	\N	\N	\N	\N
236	guest_vmw6kudcxq@mint-store.ru		\N	\N	2017-10-09 12:01:25.145015	5	2017-10-24 20:14:59.827194	2017-10-22 09:03:18.766453	31.173.84.219	31.173.86.29	2017-10-09 12:01:25.127812	2017-10-24 20:14:59.828639	TqQUs8PjH85jrUPZSp97	\N	\N	\N	\N
245	guest_zsuvjntpvt@mint-store.ru		\N	\N	2017-10-10 14:07:30.748079	1	2017-10-10 14:07:30.754478	2017-10-10 14:07:30.754478	176.112.106.59	176.112.106.59	2017-10-10 14:07:30.729519	2017-10-10 14:07:30.755394	PiJmavh1MkTYKZanVxhc	\N	\N	\N	\N
261	guest_eaxtchj4qi@mint-store.ru		\N	\N	2017-10-13 18:30:34.155866	1	2017-10-13 18:30:34.162342	2017-10-13 18:30:34.162342	62.182.78.94	62.182.78.94	2017-10-13 18:30:34.126517	2017-10-13 18:30:34.163355	Yd3Xr8J3uEgEj79EmpAd	\N	\N	\N	\N
246	guest_xfnydqkf29@mint-store.ru		\N	\N	2017-10-10 15:01:11.320186	1	2017-10-10 15:01:11.33178	2017-10-10 15:01:11.33178	5.42.94.208	5.42.94.208	2017-10-10 15:01:11.298065	2017-10-10 15:01:11.332743	sseotGnQaFziPNwqVsZx	\N	\N	\N	\N
247	guest_xeobtxtqnu@mint-store.ru		\N	\N	2017-10-10 16:08:49.277479	1	2017-10-10 16:08:49.283843	2017-10-10 16:08:49.283843	5.42.94.208	5.42.94.208	2017-10-10 16:08:49.246463	2017-10-10 16:08:49.284832	ewGiCaaV12bs-GVw1Cfq	\N	\N	\N	\N
248	guest_qsyymqow4p@mint-store.ru		\N	\N	2017-10-11 06:44:34.297037	1	2017-10-11 06:44:34.311655	2017-10-11 06:44:34.311655	31.148.122.123	31.148.122.123	2017-10-11 06:44:34.269191	2017-10-11 06:44:34.312726	ZTXCmh17HyjZrFS5-UBr	\N	\N	\N	\N
249	guest_qxtg6jqx8a@mint-store.ru		\N	\N	2017-10-11 18:51:40.002113	1	2017-10-11 18:51:40.01677	2017-10-11 18:51:40.01677	93.120.229.186	93.120.229.186	2017-10-11 18:51:39.984044	2017-10-11 18:51:40.017742	rDU5xbkoUxf2sEJwHpaK	\N	\N	\N	\N
256	guest_6ai3yarmtz@mint-store.ru		\N	\N	2017-10-12 03:15:02.3813	1	2017-10-12 03:15:02.38672	2017-10-12 03:15:02.38672	148.251.223.21	148.251.223.21	2017-10-12 03:15:02.350232	2017-10-12 03:15:02.387498	e6Dpi9h7NzJb49z-8cX1	\N	\N	\N	\N
262	guest_efthjr7-wn@mint-store.ru		\N	\N	2017-10-13 18:34:06.245251	1	2017-10-13 18:34:06.251453	2017-10-13 18:34:06.251453	85.140.7.168	85.140.7.168	2017-10-13 18:34:06.223819	2017-10-13 18:34:06.252447	V9n_p2Dg8n71QD3PhLfy	\N	\N	\N	\N
257	guest_clcpndj5w8@mint-store.ru		\N	\N	2017-10-12 03:33:47.525468	1	2017-10-12 03:33:47.532505	2017-10-12 03:33:47.532505	87.250.224.126	87.250.224.126	2017-10-12 03:33:47.496949	2017-10-12 03:33:47.53316	6ybQmUbwFXA_kmAsSu3x	\N	\N	\N	\N
258	guest_grczcsbs4w@mint-store.ru		\N	\N	2017-10-12 03:34:59.136456	1	2017-10-12 03:34:59.142833	2017-10-12 03:34:59.142833	212.193.117.245	212.193.117.245	2017-10-12 03:34:59.122593	2017-10-12 03:34:59.143801	7SFn8GdvdbPbRuyGT2Yj	\N	\N	\N	\N
266	arina.shheglova@mail.ru		\N	\N	2017-10-14 02:18:06.003225	1	2017-10-14 02:18:06.016504	2017-10-14 02:18:06.016504	213.110.225.100	213.110.225.100	2017-10-14 02:18:05.97269	2017-10-14 15:58:06.872238	556osYrsbzU_uKs7jty-	79130431806	Арина	\N	\N
278	guest_zyecfnrh_k@mint-store.ru		\N	\N	2017-10-17 08:37:33.644742	4	2017-10-23 08:38:14.830447	2017-10-20 10:32:13.093557	195.46.23.67	217.66.152.123	2017-10-17 08:37:33.619319	2017-10-23 08:38:14.83136	KtmcyQcyX2JgouiYm7nC	79114429997	Ирина	\N	\N
263	guest_eapmqstnva@mint-store.ru		\N	\N	2017-10-13 18:38:25.362885	1	2017-10-13 18:38:25.369574	2017-10-13 18:38:25.369574	95.79.20.172	95.79.20.172	2017-10-13 18:38:25.335399	2017-10-13 18:38:25.370325	s_YXLeaJPRXYxF-pj2E2	\N	\N	\N	\N
272	guest_ekgegqzgzu@mint-store.ru		\N	\N	2017-10-15 19:11:01.04839	1	2017-10-15 19:11:01.055557	2017-10-15 19:11:01.055557	5.101.14.134	5.101.14.134	2017-10-15 19:11:01.029515	2017-10-15 19:11:01.05608	5bbVRNHVarmzVsyYwpWX	\N	\N	\N	\N
264	guest_kzcts6yx43@mint-store.ru		\N	\N	2017-10-13 19:09:14.721329	1	2017-10-13 19:09:14.734273	2017-10-13 19:09:14.734273	87.250.224.126	87.250.224.126	2017-10-13 19:09:14.705437	2017-10-13 19:09:14.73526	CBP5u_uU1yd9wLa6HNeM	\N	\N	\N	\N
255	elena.v.nazarenko@gmail.com		\N	\N	2017-10-11 20:44:25.099251	2	2017-10-13 19:45:12.192129	2017-10-11 20:44:25.105819	87.255.2.21	87.255.2.21	2017-10-11 20:44:25.079754	2017-10-13 19:45:12.193559	pwZfNbmMaExnFmxC_2TV	79636831188	Елена Назаренко	\N	\N
239	guest_g5rvubxykq@mint-store.ru		\N	\N	2017-10-09 18:58:36.541119	5	2017-10-20 12:05:45.992667	2017-10-17 04:19:51.856611	94.25.167.77	5.164.193.18	2017-10-09 18:58:36.508983	2017-10-20 12:05:45.993536	26kUdxyCYPQcxGzm1yL4	\N	\N	\N	\N
267	guest_6f6wcymktm@mint-store.ru		\N	\N	2017-10-14 08:03:42.96695	1	2017-10-14 08:03:42.973301	2017-10-14 08:03:42.973301	207.46.13.187	207.46.13.187	2017-10-14 08:03:42.946774	2017-10-14 08:03:42.974199	fimRvfXXTbz7QMkxnbhp	\N	\N	\N	\N
233	guest_pfyhi4javc@mint-store.ru		\N	\N	2017-10-08 20:16:08.683105	5	2017-10-23 14:20:14.936293	2017-10-18 10:03:17.333988	91.231.233.136	91.231.233.136	2017-10-08 20:16:08.667394	2017-10-23 14:20:14.937313	gEfnEZD9ErHs6dHGd7qR	\N	\N	\N	\N
268	guest_spyky9xu-v@mint-store.ru		\N	\N	2017-10-14 08:50:13.080342	1	2017-10-14 08:50:13.093374	2017-10-14 08:50:13.093374	66.249.79.66	66.249.79.66	2017-10-14 08:50:13.064793	2017-10-14 08:50:13.094202	yWx5iRWwrZXoqizkUjdk	\N	\N	\N	\N
274	guest_jb7j_-7oym@mint-store.ru		\N	\N	2017-10-15 21:45:43.36842	1	2017-10-15 21:45:43.416686	2017-10-15 21:45:43.416686	157.55.39.99	157.55.39.99	2017-10-15 21:45:43.347899	2017-10-15 21:45:43.417401	nxzQmnyJhz5bLM1y1FWG	\N	\N	\N	\N
275	guest_tylzdqfqqa@mint-store.ru		\N	\N	2017-10-16 12:24:00.531589	2	2017-10-20 12:50:11.445773	2017-10-16 12:24:00.538623	217.118.93.165	217.118.93.128	2017-10-16 12:24:00.520017	2017-10-20 12:50:11.446668	Xd8_fwcaNFCfVS49CE5M	\N	\N	\N	\N
271	guest_nzghl4zy-t@mint-store.ru		\N	\N	2017-10-15 17:25:17.894963	8	2017-10-25 03:17:18.391183	2017-10-20 05:08:12.295125	95.37.68.48	95.37.68.48	2017-10-15 17:25:17.87176	2017-10-25 03:17:18.392208	72gJz1R1uRkaxYv7jbbH	\N	\N	\N	\N
269	guest_tezuryhgrm@mint-store.ru		\N	\N	2017-10-14 13:56:51.96397	2	2017-10-19 14:59:59.100274	2017-10-14 13:56:51.97684	5.164.244.29	217.118.93.189	2017-10-14 13:56:51.935568	2017-10-19 14:59:59.101272	N5sP8rDoqc3FoseiGkkB	\N	\N	\N	\N
276	guest_bf5mlgdedc@mint-store.ru		\N	\N	2017-10-16 12:35:57.27108	1	2017-10-16 12:35:57.286532	2017-10-16 12:35:57.286532	109.184.103.104	109.184.103.104	2017-10-16 12:35:57.241379	2017-10-16 12:35:57.287069	VHy7ZPHMK8-D_fKB7QYQ	\N	\N	\N	\N
260	guest_n6ar55v8gq@mint-store.ru		\N	\N	2017-10-13 16:38:23.218965	4	2017-10-19 13:00:16.200974	2017-10-16 14:04:39.54852	89.109.5.147	89.109.5.147	2017-10-13 16:38:23.189344	2017-10-19 13:00:16.20187	sjQqy53YQPa8LSBsfyvW	\N	\N	\N	\N
277	guest_pqcryok-fw@mint-store.ru		\N	\N	2017-10-16 17:35:18.162919	1	2017-10-16 17:35:18.176169	2017-10-16 17:35:18.176169	87.250.224.126	87.250.224.126	2017-10-16 17:35:18.143167	2017-10-16 17:35:18.177253	HYV7x-sD6EqSpMMRbdzG	\N	\N	\N	\N
237	guest_r3qkfpfgvv@mint-store.ru		\N	\N	2017-10-09 13:37:25.325251	7	2017-10-23 20:38:28.8212	2017-10-20 07:57:35.725624	37.147.207.192	37.147.195.128	2017-10-09 13:37:25.304213	2017-10-23 20:38:28.821805	Urc8i6-m4BXvs4S_wjh-	\N	\N	\N	\N
273	guest_kzuaenv8kr@mint-store.ru		\N	\N	2017-10-15 19:44:50.372741	3	2017-10-17 19:11:26.507234	2017-10-16 16:54:00.076293	46.242.14.0	46.242.14.0	2017-10-15 19:44:50.357652	2017-10-17 19:11:26.507814	uKYGLyy7Baz6BPxDzw_7	79663167700	Ксения 	\N	\N
296	guest_zkzsrkxct6@mint-store.ru		\N	\N	2017-10-20 20:40:35.090172	1	2017-10-20 20:40:35.10364	2017-10-20 20:40:35.10364	82.208.101.87	82.208.101.87	2017-10-20 20:40:35.051249	2017-10-20 20:40:35.10465	GV1Hc_u9kEfhQbUCs3D-	\N	\N	\N	\N
280	guest_a36eyzy-1a@mint-store.ru		\N	\N	2017-10-17 16:34:06.733734	1	2017-10-17 16:34:06.747866	2017-10-17 16:34:06.747866	176.59.106.137	176.59.106.137	2017-10-17 16:34:06.720671	2017-10-17 16:34:06.748525	uDre942EhL6tWgvgw2HL	\N	\N	\N	\N
281	guest_ydvsjs-dyy@mint-store.ru		\N	\N	2017-10-17 20:34:39.510263	1	2017-10-17 20:34:39.516493	2017-10-17 20:34:39.516493	95.37.34.47	95.37.34.47	2017-10-17 20:34:39.493055	2017-10-17 20:34:39.518076	pEgRiiMJ99L51Z1AMAXe	\N	\N	\N	\N
297	guest_spqxs-fo4l@mint-store.ru		\N	\N	2017-10-21 07:21:44.195254	1	2017-10-21 07:21:44.202212	2017-10-21 07:21:44.202212	37.146.66.236	37.146.66.236	2017-10-21 07:21:44.149483	2017-10-21 07:21:44.202761	YPPiVDbz3NkhRDbZeHgc	\N	\N	\N	\N
283	guest_zzsh8ed_sj@mint-store.ru		\N	\N	2017-10-18 20:05:46.5332	1	2017-10-18 20:05:46.539916	2017-10-18 20:05:46.539916	188.32.246.230	188.32.246.230	2017-10-18 20:05:46.506427	2017-10-18 20:05:46.540585	Bgcc2ys3-jsFYT2E3eVw	\N	\N	\N	\N
313	guest_bgay5zj5na@mint-store.ru		\N	\N	2017-10-23 19:52:47.110529	1	2017-10-23 19:52:47.116779	2017-10-23 19:52:47.116779	95.79.156.156	95.79.156.156	2017-10-23 19:52:47.080863	2017-10-23 19:52:47.117798	s5yMNVVw2chNqUyADjyx	\N	\N	\N	\N
284	guest_6kyf5w842a@mint-store.ru		\N	\N	2017-10-19 08:17:31.859058	1	2017-10-19 08:17:31.873896	2017-10-19 08:17:31.873896	194.99.216.135	194.99.216.135	2017-10-19 08:17:31.843307	2017-10-19 08:17:31.874753	sdfLLkn2aRQLCUMspUsZ	\N	\N	\N	\N
298	guest_qznecxxozq@mint-store.ru		\N	\N	2017-10-21 07:57:46.516523	1	2017-10-21 07:57:46.523289	2017-10-21 07:57:46.523289	207.46.13.39	207.46.13.39	2017-10-21 07:57:46.500025	2017-10-21 07:57:46.523977	GtGSTGMvTWZasEzee-3e	\N	\N	\N	\N
285	guest_jjmcgyeeht@mint-store.ru		\N	\N	2017-10-19 09:31:58.279845	1	2017-10-19 09:31:58.286314	2017-10-19 09:31:58.286314	5.101.14.219	5.101.14.219	2017-10-19 09:31:58.253163	2017-10-19 09:31:58.287141	pjXmug-_doKY2_Exbr3h	\N	\N	\N	\N
286	guest_8cfzzexfmq@mint-store.ru		\N	\N	2017-10-19 09:34:19.759398	1	2017-10-19 09:34:19.766091	2017-10-19 09:34:19.766091	83.149.45.103	83.149.45.103	2017-10-19 09:34:19.742394	2017-10-19 09:34:19.766746	MV9sgbzcdpSKjQQsrAyi	\N	\N	\N	\N
287	guest_zetmzywula@mint-store.ru		\N	\N	2017-10-19 11:58:42.786652	1	2017-10-19 11:58:42.800284	2017-10-19 11:58:42.800284	95.79.191.118	95.79.191.118	2017-10-19 11:58:42.767565	2017-10-19 11:58:42.80095	5UbUssuiSggZNzTayyJf	\N	\N	\N	\N
279	guest_apjmc6yfp5@mint-store.ru		\N	\N	2017-10-17 13:35:23.386289	3	2017-10-19 12:05:07.194361	2017-10-18 11:14:16.041922	176.59.105.126	176.59.106.69	2017-10-17 13:35:23.367909	2017-10-19 12:05:07.195548	6n2xxBtAzMNspk2utR_B	\N	\N	\N	\N
305	guest_wxxans_akj@mint-store.ru		\N	\N	2017-10-22 11:09:55.478578	2	2017-10-23 20:17:53.498037	2017-10-22 11:09:55.484992	188.168.94.115	188.168.93.231	2017-10-22 11:09:55.4526	2017-10-23 20:17:53.499101	q9JuyHfCRzoxJaYshcN7	\N	\N	\N	\N
288	guest_m6rkkzjgvv@mint-store.ru		\N	\N	2017-10-19 16:19:07.287959	1	2017-10-19 16:19:07.301429	2017-10-19 16:19:07.301429	80.83.237.24	80.83.237.24	2017-10-19 16:19:07.271729	2017-10-19 16:19:07.302471	tSGYtPK5_PnskNuWoLzv	\N	\N	\N	\N
308	guest_qszaz5ekm3@mint-store.ru		\N	\N	2017-10-22 18:36:08.197303	1	2017-10-22 18:36:08.210444	2017-10-22 18:36:08.210444	80.251.238.231	80.251.238.231	2017-10-22 18:36:08.169734	2017-10-22 18:36:08.211431	rzqYmNxXbxgkzpzKEB9h	\N	\N	\N	\N
300	guest_axfqxutsqu@mint-store.ru		\N	\N	2017-10-21 12:51:59.205099	1	2017-10-21 12:51:59.21155	2017-10-21 12:51:59.21155	37.17.172.122	37.17.172.122	2017-10-21 12:51:59.185887	2017-10-21 12:51:59.212466	vTmbYnNbM6aSKZBvkMky	\N	\N	\N	\N
290	guest_9rvouipaob@mint-store.ru		\N	\N	2017-10-20 10:28:52.78711	1	2017-10-20 10:28:52.793812	2017-10-20 10:28:52.793812	95.79.111.8	95.79.111.8	2017-10-20 10:28:52.767123	2017-10-20 10:28:52.794555	SdNWxjEFd2VrBQG3RYgX	\N	\N	\N	\N
291	guest_-tyjanczyr@mint-store.ru		\N	\N	2017-10-20 10:36:43.15901	1	2017-10-20 10:36:43.165734	2017-10-20 10:36:43.165734	213.87.129.134	213.87.129.134	2017-10-20 10:36:43.128795	2017-10-20 10:36:43.166427	_6ztxmq9zGS1hTVsiFQC	\N	\N	\N	\N
316	selezneva_im@yahoo.com		\N	\N	2017-10-24 09:26:36.84881	1	2017-10-24 09:26:36.861748	2017-10-24 09:26:36.861748	185.44.11.66	185.44.11.66	2017-10-24 09:26:36.816894	2017-10-24 09:29:27.466153	ctA_t7s9U2oxb3VBQfMV	79875382595	Ирина	\N	\N
292	guest_khazznfuss@mint-store.ru		\N	\N	2017-10-20 12:11:42.29411	1	2017-10-20 12:11:42.300719	2017-10-20 12:11:42.300719	87.250.224.126	87.250.224.126	2017-10-20 12:11:42.265535	2017-10-20 12:11:42.301383	jjzSckjnkxRzWKPcctFb	\N	\N	\N	\N
301	guest_vnvufshrbg@mint-store.ru		\N	\N	2017-10-21 12:54:28.583616	1	2017-10-21 12:54:28.590272	2017-10-21 12:54:28.590272	37.17.172.122	37.17.172.122	2017-10-21 12:54:28.559585	2017-10-21 12:54:28.591289	D4piinsSogrtqMfvX2uq	\N	\N	\N	\N
293	guest_yo-fzkmvhq@mint-store.ru		\N	\N	2017-10-20 16:40:32.726688	1	2017-10-20 16:40:32.733735	2017-10-20 16:40:32.733735	176.214.27.153	176.214.27.153	2017-10-20 16:40:32.699102	2017-10-20 16:40:32.734279	JMrskGvC9_ychmkyMVsc	\N	\N	\N	\N
289	guest_5x6a_ud-pn@mint-store.ru		\N	\N	2017-10-19 17:17:52.870505	3	2017-10-23 21:40:35.572304	2017-10-20 11:55:07.245899	217.118.93.168	5.166.212.34	2017-10-19 17:17:52.852803	2017-10-23 21:40:35.573358	VLd-NLAM8i3xoAYszYu1	\N	\N	\N	\N
294	lamurka@yandex.ru		\N	\N	2017-10-20 16:56:11.399162	1	2017-10-20 16:56:11.412279	2017-10-20 16:56:11.412279	213.87.147.47	213.87.147.47	2017-10-20 16:56:11.362491	2017-10-20 16:57:18.208703	KqzeGoanFdLRFj_n4HGN	79037755976	Анна	\N	\N
302	guest_kvssfrp-hw@mint-store.ru		\N	\N	2017-10-21 18:40:56.320498	1	2017-10-21 18:40:56.325964	2017-10-21 18:40:56.325964	85.140.2.32	85.140.2.32	2017-10-21 18:40:56.276566	2017-10-21 18:40:56.326678	oNAfpWenurwyt7ZZDr1s	\N	\N	\N	\N
295	guest_qwgwx-h1eb@mint-store.ru		\N	\N	2017-10-20 20:24:39.148722	1	2017-10-20 20:24:39.153779	2017-10-20 20:24:39.153779	51.255.65.87	51.255.65.87	2017-10-20 20:24:39.133622	2017-10-20 20:24:39.154557	zxePSdmHVR4MVALnL7CH	\N	\N	\N	\N
309	guest_rbcmafzszy@mint-store.ru		\N	\N	2017-10-22 19:58:35.689305	1	2017-10-22 19:58:35.695554	2017-10-22 19:58:35.695554	5.227.14.39	5.227.14.39	2017-10-22 19:58:35.669172	2017-10-22 19:58:35.696471	6FzxnM6VJ3sRESxzRFnn	\N	\N	\N	\N
307	guest_tsxgmmlsye@mint-store.ru		\N	\N	2017-10-22 16:19:01.945022	2	2017-10-23 06:14:58.928067	2017-10-22 16:19:01.957764	5.101.14.215	213.87.158.157	2017-10-22 16:19:01.911398	2017-10-23 06:14:58.929318	bzz4PnTdAZHfJxm_mw1J	\N	\N	\N	\N
303	guest_cfn5cwjswv@mint-store.ru		\N	\N	2017-10-21 18:40:56.518903	1	2017-10-21 18:40:56.526042	2017-10-21 18:40:56.526042	85.140.2.32	85.140.2.32	2017-10-21 18:40:56.513241	2017-10-21 18:40:56.526644	aDg4NYR5qpVZDrzmw5pH	\N	\N	\N	\N
304	guest_i6y8bs5guf@mint-store.ru		\N	\N	2017-10-22 05:56:45.429867	1	2017-10-22 05:56:45.483493	2017-10-22 05:56:45.483493	95.78.0.22	95.78.0.22	2017-10-22 05:56:45.346948	2017-10-22 05:56:45.484245	DyeJqKb1eEsAzoshnDdm	\N	\N	\N	\N
299	guest_mrbss_kx8b@mint-store.ru		\N	\N	2017-10-21 12:44:56.653018	2	2017-10-22 10:47:49.966729	2017-10-21 12:44:56.666001	79.126.61.235	79.126.61.235	2017-10-21 12:44:56.633189	2017-10-22 10:47:49.967953	tW2Bx67UwYTKFaexTKde	\N	\N	\N	\N
310	guest_eosngtjtj_@mint-store.ru		\N	\N	2017-10-23 09:21:13.901764	1	2017-10-23 09:21:13.916217	2017-10-23 09:21:13.916217	91.228.161.38	91.228.161.38	2017-10-23 09:21:13.869742	2017-10-23 09:21:13.917063	sAPRqEuxgTS8anbDGTzT	\N	\N	\N	\N
306	guest_8vskd3xlav@mint-store.ru		\N	\N	2017-10-22 12:42:43.250296	1	2017-10-22 12:42:43.256553	2017-10-22 12:42:43.256553	5.227.14.46	5.227.14.46	2017-10-22 12:42:43.235141	2017-10-22 12:42:43.257478	srH9T42jeQDsjEJVcfSY	\N	\N	\N	\N
311	guest_zbypaeetge@mint-store.ru		\N	\N	2017-10-23 11:57:51.994727	1	2017-10-23 11:57:52.001403	2017-10-23 11:57:52.001403	87.250.224.126	87.250.224.126	2017-10-23 11:57:51.963223	2017-10-23 11:57:52.002195	HbymhnDqZhRgK_JG8Y38	\N	\N	\N	\N
314	guest_vpre1zsfyy@mint-store.ru		\N	\N	2017-10-24 06:34:32.627016	1	2017-10-24 06:34:32.633953	2017-10-24 06:34:32.633953	77.222.105.43	77.222.105.43	2017-10-24 06:34:32.579501	2017-10-24 06:34:32.634408	GtDK6mRB1CcZzy7a92t-	\N	\N	\N	\N
312	guest_2hyswm8-qk@mint-store.ru		\N	\N	2017-10-23 16:41:40.775547	1	2017-10-23 16:41:40.790696	2017-10-23 16:41:40.790696	109.252.86.197	109.252.86.197	2017-10-23 16:41:40.749893	2017-10-23 16:41:40.791429	X5rEHrCCzXXDdcX623ZG	\N	\N	\N	\N
282	guest_appaz7s9g-@mint-store.ru		\N	\N	2017-10-18 17:47:37.193059	2	2017-10-23 19:37:36.180734	2017-10-18 17:47:37.198314	95.37.95.155	95.37.95.155	2017-10-18 17:47:37.161136	2017-10-23 19:37:36.181764	jvtss3UWp2BQ4BB2zi4X	\N	\N	\N	\N
317	guest_pakbqlzfnv@mint-store.ru		\N	\N	2017-10-24 10:18:26.994562	1	2017-10-24 10:18:27.00792	2017-10-24 10:18:27.00792	91.228.161.38	91.228.161.38	2017-10-24 10:18:26.969323	2017-10-24 10:18:27.009246	3XyvqfyxRMX8WdCdNZyB	\N	\N	\N	\N
315	guest_tirnsxnrr8@mint-store.ru		\N	\N	2017-10-24 08:18:37.920743	1	2017-10-24 08:18:37.927228	2017-10-24 08:18:37.927228	5.3.196.253	5.3.196.253	2017-10-24 08:18:37.889344	2017-10-24 08:18:37.928231	ZWFPs_gju3LQqtA5URY3	\N	\N	\N	\N
319	guest_vganrt558y@mint-store.ru		\N	\N	2017-10-25 10:22:01.945315	1	2017-10-25 10:22:01.960617	2017-10-25 10:22:01.960617	91.228.161.38	91.228.161.38	2017-10-25 10:22:01.835873	2017-10-25 10:22:01.961714	W88Lsvzy34wJAUMHHcWe	\N	\N	\N	\N
318	guest_-2nalirxe4@mint-store.ru		\N	\N	2017-10-25 02:41:20.577445	1	2017-10-25 02:41:20.589913	2017-10-25 02:41:20.589913	66.249.75.197	66.249.75.197	2017-10-25 02:41:20.550499	2017-10-25 02:41:20.590966	hqMx1iL4CQjAsW9XyHpy	\N	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('users_id_seq', 319, true);


--
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY variants (id, product_id, color_id, sizes, created_at, updated_at, themes, category_id, out_of_stock, state) FROM stdin;
72	55	46	["", "0"]	2017-09-06 09:47:59.770349	2017-09-15 13:43:14.669185	[17]	29	f	1
112	88	2	["", "42"]	2017-09-08 14:42:11.81666	2017-10-06 12:13:30.641567	[11]	14	f	1
82	62	17	[""]	2017-09-06 12:46:25.99796	2017-09-29 10:44:25.900865	[11]	24	f	1
105	81	3	["", "40"]	2017-09-08 13:21:28.454322	2017-09-29 20:07:31.701034	[]	14	f	1
165	126	50	["", "40", "42"]	2017-09-19 14:18:12.650344	2017-09-24 13:20:07.730173	[]	30	f	1
233	164	50	["", "0"]	2017-10-11 15:07:35.893471	2017-10-11 15:11:12.915739	[]	45	f	1
88	67	1	["", "0"]	2017-09-07 09:42:15.916852	2017-09-13 12:21:32.427764	[]	31	f	1
67	52	27	["", "42"]	2017-09-04 22:04:27.279452	2017-10-16 09:30:36.690746	[11]	24	f	2
195	133	65	["", "0"]	2017-09-26 07:30:47.473769	2017-09-26 07:30:49.852576	[]	19	f	1
95	73	2	["", "40", "44", "46"]	2017-09-08 08:29:43.552203	2017-09-23 10:59:31.764155	[12]	33	f	1
109	85	4	[""]	2017-09-08 14:00:55.303921	2017-10-09 11:49:48.868029	[]	36	f	2
110	86	1	["", "40", "42"]	2017-09-08 14:21:42.828894	2017-10-10 11:48:06.497013	[11]	16	f	1
235	165	2	["", "0"]	2017-10-11 15:12:33.370375	2017-10-11 15:12:33.370375	[]	45	f	1
168	128	6	["", "0"]	2017-09-19 15:13:45.14387	2017-09-25 08:40:15.065789	[]	29	f	1
120	95	19	["", "44"]	2017-09-08 18:10:05.082208	2017-10-09 09:19:54.032762	[]	26	f	1
96	74	6	["", "44"]	2017-09-08 08:36:17.824011	2017-09-25 09:42:03.502174	[12]	38	f	1
83	63	43	["", "44", "46"]	2017-09-06 12:51:46.243064	2017-09-28 11:17:50.452543	[]	26	f	1
115	91	40	[""]	2017-09-08 15:48:56.476948	2017-09-28 13:31:12.686003	[]	26	f	1
104	80	15	["", "44", "46"]	2017-09-08 13:13:56.744258	2017-09-26 11:42:27.615858	[]	14	f	1
108	84	2	["", "40"]	2017-09-08 13:55:54.863802	2017-09-28 15:00:00.310425	[]	30	f	1
66	52	14	["", "40", "44"]	2017-09-04 21:52:20.019779	2017-09-28 13:35:41.543359	[11]	24	f	1
167	128	14	["", "0"]	2017-09-19 15:12:13.706675	2017-10-11 07:01:21.354982	[]	29	f	2
205	148	37	["", "0"]	2017-09-27 09:52:53.445187	2017-09-27 19:52:49.581574	[]	41	f	1
98	76	19	["", "44"]	2017-09-08 09:37:13.807028	2017-09-28 09:54:10.150742	[12]	33	f	1
107	83	12	["", "44"]	2017-09-08 13:51:52.171672	2017-09-28 19:23:56.646357	[]	19	f	1
97	75	2	["", "42", "44"]	2017-09-08 08:57:17.051015	2017-09-28 19:24:11.428903	[]	25	f	1
170	128	53	["", "0"]	2017-09-19 15:27:07.27053	2017-10-11 07:01:29.102309	[]	29	f	2
155	117	2	["", "0"]	2017-09-14 10:42:11.976157	2017-09-25 08:38:49.430322	[]	26	f	1
94	72	2	["", "44"]	2017-09-07 15:22:44.403647	2017-10-11 14:26:20.235598	[]	19	f	1
125	92	14	["", "0"]	2017-09-11 10:12:16.915666	2017-09-25 08:39:19.768885	[]	26	f	1
142	106	69	["", "40", "44"]	2017-09-13 13:43:16.971051	2017-09-26 20:30:08.118511	[]	36	f	1
147	110	17	["", "42", "44"]	2017-09-13 15:32:26.998707	2017-09-28 11:01:57.024812	[11]	24	f	1
150	112	46	["", "0"]	2017-09-14 08:59:37.858214	2017-09-25 08:43:36.70409	[]	29	f	1
59	49	7	[""]	2017-09-04 16:16:46.764705	2017-10-02 10:21:44.162132	[]	30	t	3
121	94	29	[""]	2017-09-08 18:20:26.218175	2017-10-02 16:58:09.085307	[]	26	f	1
152	114	49	["", "42"]	2017-09-14 09:24:41.746625	2017-10-03 13:43:57.438436	[]	15	f	1
236	166	56	["", "0"]	2017-10-11 15:17:48.715102	2017-10-11 15:17:48.715102	[]	45	f	1
179	136	2	[""]	2017-09-25 13:18:01.525229	2017-10-04 11:28:21.537245	[]	17	f	2
114	90	33	["", "42"]	2017-09-08 15:04:07.905771	2017-10-06 09:35:20.685972	[11]	14	f	1
237	166	2	["", "0"]	2017-10-11 15:19:06.403353	2017-10-11 15:19:12.18737	[]	45	f	1
169	128	52	["", "0"]	2017-09-19 15:15:16.057472	2017-10-12 10:15:46.560639	[]	29	f	2
240	169	4	["", "42"]	2017-10-12 16:36:13.584011	2017-10-12 16:36:13.584011	[]	14	f	1
137	101	44	[""]	2017-09-13 11:10:27.860174	2017-10-20 12:33:32.078727	[11]	14	f	2
106	82	37	[""]	2017-09-08 13:32:47.59158	2017-10-13 14:47:22.097926	[]	25	f	2
241	170	1	["", "42"]	2017-10-12 16:41:52.442484	2017-10-12 16:59:58.541565	[]	14	f	1
65	51	19	[""]	2017-09-04 21:45:54.056967	2017-10-13 11:30:26.636945	[]	28	f	2
242	171	68	[""]	2017-10-12 16:45:41.734925	2017-10-16 17:16:38.266046	[]	14	f	2
244	173	58	["", "42", "44"]	2017-10-14 10:27:36.385606	2017-10-14 10:27:36.385606	[]	14	f	1
81	61	17	[""]	2017-09-06 12:36:42.396245	2017-10-14 13:51:01.677338	[11]	24	f	1
93	71	3	["", "40"]	2017-09-07 15:16:39.629766	2017-10-24 10:16:59.372721	[12]	17	f	2
247	176	46	["", "42", "46"]	2017-10-15 10:39:38.121402	2017-10-15 10:39:38.121402	[]	39	f	1
249	178	58	["", "0"]	2017-10-15 10:45:56.479318	2017-10-15 10:45:56.479318	[]	25	f	1
248	177	46	["", "40", "42", "46"]	2017-10-15 10:41:44.891458	2017-10-15 11:09:24.993631	[]	39	f	1
146	109	35	[""]	2017-09-13 15:22:05.135528	2017-10-15 11:00:40.406499	[11]	14	f	2
250	179	36	["", "40", "42", "44", "46"]	2017-10-15 11:16:28.256506	2017-10-15 11:16:28.256506	[]	24	f	1
251	180	46	["", "40", "42", "44", "46"]	2017-10-15 11:21:58.490181	2017-10-15 11:21:58.490181	[]	33	f	1
111	87	3	[""]	2017-09-08 14:34:09.595601	2017-10-15 12:53:34.951126	[]	24	f	1
202	146	57	["", "0"]	2017-09-26 10:08:46.76586	2017-10-16 09:41:54.432565	[]	41	f	2
172	130	55	["", "0"]	2017-09-25 11:32:44.128631	2017-10-16 09:44:35.306666	[]	28	f	2
187	133	50	[""]	2017-09-25 17:44:09.396194	2017-10-17 10:43:08.53238	[]	19	f	2
180	136	18	[""]	2017-09-25 13:21:37.445204	2017-10-16 15:45:34.937792	[]	17	f	2
113	89	2	["", "42"]	2017-09-08 14:48:01.831663	2017-10-20 15:22:02.99538	[16]	14	f	2
193	143	2	[""]	2017-09-26 06:37:09.403419	2017-10-19 14:10:19.198772	[]	20	f	2
245	174	32	[""]	2017-10-14 10:57:40.970925	2017-10-23 13:24:45.853875	[]	21	f	1
157	119	17	[""]	2017-09-15 14:24:12.606793	2017-10-21 13:20:21.569853	[]	15	f	1
61	50	30	["", "42"]	2017-09-04 20:51:34.373947	2017-10-22 09:02:59.581247	[]	27	f	1
62	50	48	[""]	2017-09-04 20:55:21.741733	2017-10-22 09:03:02.722326	[]	27	f	2
64	51	45	[""]	2017-09-04 21:38:04.133366	2017-10-22 09:03:23.9009	[]	28	f	2
182	138	61	["", "0"]	2017-09-25 13:34:18.437733	2017-09-25 13:34:18.437733	[]	19	f	1
164	125	50	["", "40", "42"]	2017-09-19 13:40:10.525133	2017-09-24 13:25:13.862866	[]	32	f	1
100	78	42	["", "40", "42", "46"]	2017-09-08 09:58:54.243975	2017-09-25 08:38:04.383176	[12]	26	f	1
175	133	58	["", "0"]	2017-09-25 12:38:52.069592	2017-09-25 12:38:52.069592	[]	19	f	1
204	147	70	["", "0"]	2017-09-26 20:35:01.733561	2017-09-26 20:37:20.990028	[]	41	f	1
186	131	40	["", "0"]	2017-09-25 13:54:30.637089	2017-09-25 13:57:12.115563	[]	17	f	1
156	118	2	["", "40", "42"]	2017-09-14 18:33:31.759081	2017-09-29 15:29:17.222547	[16]	40	f	1
159	121	51	[""]	2017-09-19 12:47:35.508203	2017-09-28 13:37:26.119783	[]	32	f	1
183	139	12	["", "42"]	2017-09-25 13:38:04.412128	2017-09-26 21:14:30.99225	[]	20	f	1
70	54	14	[""]	2017-09-06 09:24:21.280467	2017-10-02 10:21:44.172666	[]	19	t	3
71	54	7	[""]	2017-09-06 09:42:04.593908	2017-10-02 10:21:44.182324	[]	19	t	3
86	66	10	[""]	2017-09-06 13:08:19.293907	2017-10-02 10:21:44.226323	[]	17	t	3
89	68	7	[""]	2017-09-07 09:48:29.082375	2017-10-02 10:21:44.234278	[]	29	t	3
91	69	18	[""]	2017-09-07 11:11:53.766007	2017-10-02 10:21:44.242163	[]	14	t	3
126	92	36	[""]	2017-09-11 10:29:12.531747	2017-10-02 10:21:44.250203	[]	26	t	3
128	94	26	["", "0"]	2017-09-11 10:43:52.574209	2017-10-02 10:21:44.258079	[]	26	t	3
132	97	36	["", "40"]	2017-09-13 09:05:18.156399	2017-10-02 10:21:44.265928	[]	39	t	3
133	98	2	[""]	2017-09-13 09:15:05.001783	2017-10-02 10:21:44.273936	[]	33	t	3
135	92	25	[""]	2017-09-13 10:36:54.538712	2017-10-02 10:21:44.282338	[]	26	t	3
140	104	3	[""]	2017-09-13 13:22:21.038552	2017-10-02 10:21:44.290816	[11]	24	t	3
141	105	15	[""]	2017-09-13 13:28:51.187954	2017-10-02 10:21:44.298954	[11]	14	t	3
144	107	15	[""]	2017-09-13 14:59:01.677506	2017-10-02 10:21:44.307304	[11]	24	t	3
188	140	63	[""]	2017-09-25 17:56:47.72568	2017-10-13 14:49:49.003855	[]	27	t	2
158	120	47	[""]	2017-09-15 14:34:27.550484	2017-10-02 10:21:44.323815	[]	26	t	3
161	123	14	[""]	2017-09-19 13:01:20.245689	2017-10-02 10:21:44.332062	[]	28	t	3
149	111	2	[""]	2017-09-13 17:44:05.523916	2017-10-13 14:40:24.485547	[]	28	t	2
171	129	54	[""]	2017-09-20 16:08:08.625861	2017-10-02 10:21:44.348633	[]	14	t	3
177	135	60	[""]	2017-09-25 12:59:54.014758	2017-10-02 10:21:44.356996	[]	29	t	3
208	150	29	["", "40", "44"]	2017-10-04 09:54:08.263073	2017-10-14 08:43:36.562518	[]	26	f	1
189	141	64	["", "0"]	2017-09-25 18:03:29.6659	2017-10-02 10:21:44.373251	[]	24	t	3
190	141	40	["", "0"]	2017-09-25 18:04:44.593253	2017-10-02 10:21:44.381346	[]	24	t	3
203	141	68	["", "0"]	2017-09-26 19:47:41.220378	2017-10-02 10:21:44.405825	[]	24	t	3
196	138	60	["", "0"]	2017-09-26 07:45:10.873837	2017-10-02 10:22:25.623136	[]	19	t	2
134	99	2	["", "44"]	2017-09-13 10:12:49.034755	2017-10-02 12:12:17.890495	[]	33	f	1
139	103	15	["", "40", "42"]	2017-09-13 12:57:32.596323	2017-10-03 13:43:49.795186	[]	27	f	1
176	134	59	["", "42", "44"]	2017-09-25 12:45:01.840816	2017-10-25 11:01:26.040537	[]	30	f	1
162	124	50	["", "42"]	2017-09-19 13:19:04.065107	2017-10-04 05:19:40.666396	[]	26	f	1
210	151	43	[""]	2017-10-04 10:30:24.058231	2017-10-11 12:28:24.489493	[]	42	f	2
215	153	71	["", "40"]	2017-10-04 11:27:34.727877	2017-10-10 14:33:09.483756	[]	14	f	1
197	142	2	["", "40", "44"]	2017-09-26 07:54:26.395692	2017-10-18 15:07:14.476718	[]	27	f	1
200	131	2	["", "0"]	2017-09-26 08:38:19.794109	2017-10-15 08:46:28.022171	[]	17	f	2
220	156	57	["", "44"]	2017-10-04 13:27:13.113469	2017-10-16 12:12:26.215219	[]	14	f	1
217	155	2	[""]	2017-10-04 13:08:49.477122	2017-10-17 10:14:37.068539	[]	14	f	2
211	151	58	["", "0"]	2017-10-04 10:33:24.571055	2017-10-05 20:56:48.236215	[]	42	f	1
206	149	49	[""]	2017-09-27 20:00:23.494255	2017-10-06 12:25:30.950291	[]	27	f	1
207	150	32	["", "40", "42", "44"]	2017-10-04 09:50:51.37888	2017-10-05 20:57:20.715883	[]	26	f	1
201	131	56	[""]	2017-09-26 08:39:38.168746	2017-10-04 11:25:29.954932	[]	17	f	2
76	58	16	["", "0"]	2017-09-06 10:31:55.636618	2017-10-06 12:27:57.064261	[17]	29	t	2
209	151	53	["", "0"]	2017-10-04 10:28:46.234577	2017-10-05 20:56:41.899957	[]	42	f	1
77	58	3	["", "0"]	2017-09-06 10:34:25.224751	2017-10-06 12:28:00.85754	[17]	29	t	2
213	152	53	["", "0"]	2017-10-04 11:06:16.599976	2017-10-05 20:58:13.922492	[]	43	f	1
74	56	15	[""]	2017-09-06 10:02:02.087554	2017-10-06 12:28:15.290598	[]	29	t	2
185	138	62	["", "0"]	2017-09-25 13:52:46.973851	2017-10-06 16:54:28.092519	[]	19	f	2
218	155	72	[""]	2017-10-04 13:19:08.318711	2017-10-24 16:05:51.254074	[]	14	f	2
153	115	10	["", "44"]	2017-09-14 09:37:17.744237	2017-10-07 09:46:56.375445	[]	31	f	1
219	156	47	["", "42"]	2017-10-04 13:26:13.106827	2017-10-09 14:02:10.630785	[]	14	f	1
198	144	37	[""]	2017-09-26 08:13:13.951049	2017-10-10 14:29:38.408973	[]	26	t	2
214	152	43	["", "0"]	2017-10-04 11:07:34.97219	2017-10-05 20:58:18.15318	[]	43	f	1
212	152	58	["", "0"]	2017-10-04 11:05:42.593753	2017-10-05 20:58:22.504302	[]	43	f	1
151	113	4	["", "42"]	2017-09-14 09:09:52.743651	2017-10-20 10:31:31.032072	[]	15	f	1
174	132	57	[""]	2017-09-25 12:31:57.991027	2017-10-06 09:34:27.868875	[16]	14	f	2
181	137	59	["", "0"]	2017-09-25 13:27:19.14729	2017-10-13 09:48:21.832841	[]	21	f	1
199	145	66	[""]	2017-09-26 08:18:39.189885	2017-10-10 08:37:44.318874	[]	21	f	2
216	154	16	["", "44"]	2017-10-04 11:41:05.518678	2017-10-21 12:36:06.316035	[]	20	f	1
238	167	79	["", "44"]	2017-10-12 16:12:01.132917	2017-10-17 14:55:26.071876	[]	17	f	1
166	127	51	[""]	2017-09-19 14:50:47.89121	2017-10-13 09:44:42.60429	[]	17	t	2
148	109	34	["", "42"]	2017-09-13 15:42:15.281162	2017-10-21 13:21:13.161648	[11]	14	f	2
192	142	63	["", "40", "44"]	2017-09-25 18:16:40.589308	2017-10-18 15:07:06.211533	[]	27	f	1
191	138	50	[""]	2017-09-25 18:13:47.923471	2017-10-18 15:04:05.861818	[]	19	f	2
163	124	25	[""]	2017-09-19 13:33:47.442925	2017-10-22 11:06:17.036883	[]	26	f	2
231	163	40	[""]	2017-10-05 13:47:09.155723	2017-10-22 14:29:43.14693	[]	26	f	2
224	158	47	["", "42"]	2017-10-04 13:51:05.161992	2017-10-09 11:51:18.085462	[]	24	f	1
264	193	19	["", "40", "44", "46"]	2017-10-15 14:10:43.319435	2017-10-15 14:10:43.319435	[]	25	f	1
230	162	35	["", "40", "42", "44"]	2017-10-05 13:27:51.232911	2017-10-18 11:19:42.229194	[]	26	f	1
284	211	72	["", "42", "44"]	2017-10-18 16:11:17.694932	2017-10-20 08:57:03.815542	[]	29	f	1
222	157	46	[""]	2017-10-04 13:43:07.616408	2017-10-13 16:09:04.741193	[]	28	f	2
243	172	72	["", "44", "46"]	2017-10-13 16:22:11.929284	2017-10-13 16:22:11.929284	[]	14	f	1
266	195	64	["", "44"]	2017-10-16 12:51:19.079847	2017-10-16 12:51:19.079847	[]	14	f	1
262	191	3	["", "46"]	2017-10-15 14:04:43.097458	2017-10-20 11:32:48.952466	[]	14	f	1
227	160	60	[""]	2017-10-04 14:26:09.305232	2017-10-15 10:14:24.831821	[]	28	f	2
246	175	58	["", "42"]	2017-10-14 14:29:55.695507	2017-10-15 10:15:05.572181	[]	14	f	1
252	181	46	["", "40", "42", "44"]	2017-10-15 11:28:25.872351	2017-10-15 11:28:25.872351	[]	33	f	1
253	182	1	["", "40", "42", "44", "46"]	2017-10-15 11:33:56.843134	2017-10-15 11:33:56.843134	[]	16	f	1
265	194	76	["", "44"]	2017-10-16 12:47:26.805112	2017-10-16 12:57:59.028542	[]	14	f	1
229	161	2	["", "0"]	2017-10-04 14:33:15.909842	2017-10-05 20:52:53.936999	[]	22	f	1
267	196	24	["", "42"]	2017-10-16 13:01:14.011687	2017-10-16 13:04:35.063484	[]	14	f	1
268	197	32	["", "44"]	2017-10-16 13:08:04.765364	2017-10-16 13:08:04.765364	[]	14	f	1
225	159	36	["", "42", "44"]	2017-10-04 14:01:07.866373	2017-10-05 20:53:46.527039	[]	24	f	1
269	198	15	["", "42"]	2017-10-16 13:11:39.277279	2017-10-16 13:11:39.277279	[]	14	f	1
221	157	14	["", "42", "44"]	2017-10-04 13:42:11.589821	2017-10-05 20:54:26.639229	[]	28	f	1
256	185	14	["", "40", "42", "44", "46"]	2017-10-15 12:23:51.512527	2017-10-15 12:23:51.512527	[]	33	f	1
277	206	77	["", "42"]	2017-10-16 14:01:22.153187	2017-10-16 14:12:08.911753	[]	32	f	1
257	186	37	["", "42", "44"]	2017-10-15 12:26:44.839325	2017-10-15 12:26:44.839325	[]	33	f	1
283	167	81	["", "44"]	2017-10-17 14:53:22.132371	2017-10-17 14:57:00.671868	[]	17	f	1
259	188	63	["", "40", "42", "44"]	2017-10-15 13:15:57.169644	2017-10-15 13:15:57.169644	[]	27	f	1
279	208	15	["", "42", "44"]	2017-10-16 14:14:54.923177	2017-10-16 14:14:54.923177	[]	14	f	1
270	199	58	["", "42"]	2017-10-16 13:16:03.308427	2017-10-16 13:19:05.080167	[]	24	f	1
271	200	74	["", "42"]	2017-10-16 13:27:35.133475	2017-10-16 13:27:35.133475	[]	31	f	1
272	201	32	["", "40"]	2017-10-16 13:32:45.250398	2017-10-16 13:32:45.250398	[]	20	f	1
273	202	1	["", "44"]	2017-10-16 13:34:43.009192	2017-10-16 13:34:43.009192	[]	17	f	1
275	204	32	["", "46"]	2017-10-16 13:51:27.253589	2017-10-16 13:51:27.253589	[]	17	f	1
276	205	5	["", "44"]	2017-10-16 13:54:44.956912	2017-10-16 13:54:44.956912	[]	17	f	1
274	203	1	["", "42"]	2017-10-16 13:43:25.332029	2017-10-17 15:03:12.294642	[]	31	f	2
280	209	47	["", "46"]	2017-10-16 14:30:41.542639	2017-10-16 14:35:43.161544	[]	24	f	1
223	157	23	["", "42", "44"]	2017-10-04 13:44:37.325691	2017-10-16 14:36:26.225948	[]	28	f	1
228	160	2	[""]	2017-10-04 14:28:44.476687	2017-10-21 14:00:42.890091	[]	28	f	2
263	192	8	["", "40", "42", "46"]	2017-10-15 14:08:59.423305	2017-10-16 16:42:31.455217	[]	25	f	1
292	215	15	["", "42", "44"]	2017-10-18 16:49:47.983501	2017-10-20 08:57:21.543221	[]	24	f	1
261	190	27	["", "42"]	2017-10-15 13:23:14.842454	2017-10-18 09:12:36.489183	[]	17	f	1
255	184	74	["", "40", "42", "46"]	2017-10-15 12:15:56.147325	2017-10-17 10:42:40.047883	[]	16	f	1
226	160	49	["", "42"]	2017-10-04 14:24:49.038824	2017-10-18 09:44:26.036149	[]	28	f	1
298	220	2	["", "40"]	2017-10-20 10:21:43.991681	2017-10-20 10:21:43.991681	[]	14	f	1
232	162	40	[""]	2017-10-06 08:49:59.841426	2017-10-18 11:19:37.992329	[]	26	f	2
291	214	22	["", "42", "44"]	2017-10-18 16:46:05.797016	2017-10-20 08:57:34.199153	[]	24	f	1
290	213	47	["", "42", "44"]	2017-10-18 16:30:03.573765	2017-10-20 08:57:44.587242	[]	39	f	1
293	216	15	["", "42", "44"]	2017-10-18 16:52:41.247385	2017-10-18 16:52:41.247385	[]	27	f	1
294	217	27	["", "44"]	2017-10-19 14:31:34.797616	2017-10-19 14:31:34.797616	[]	24	f	1
258	187	43	["", "40", "42", "46"]	2017-10-15 12:38:15.549925	2017-10-19 09:11:45.657006	[]	39	f	1
260	189	2	["", "40"]	2017-10-15 13:18:43.900757	2017-10-19 13:31:48.441977	[]	30	f	1
281	210	80	["", "40", "42", "44"]	2017-10-17 14:45:45.654138	2017-10-20 08:58:04.427722	[]	28	f	1
295	218	46	["", "0"]	2017-10-19 14:35:11.686509	2017-10-19 14:35:11.686509	[]	29	f	1
296	219	15	["", "40"]	2017-10-19 14:40:32.961127	2017-10-19 14:40:32.961127	[]	32	f	1
239	168	32	["", "44"]	2017-10-12 16:19:55.673098	2017-10-23 11:24:37.069572	[]	20	f	1
285	211	27	["", "42", "44"]	2017-10-18 16:12:06.687419	2017-10-20 08:56:58.836694	[]	29	f	1
286	211	79	["", "42", "44"]	2017-10-18 16:12:28.10375	2017-10-20 08:57:01.370687	[]	29	f	1
289	213	58	["", "42", "44"]	2017-10-18 16:29:00.191572	2017-10-20 08:57:45.449564	[]	39	f	1
299	221	12	["", "44"]	2017-10-20 10:25:20.159721	2017-10-20 10:25:20.159721	[]	40	f	1
282	210	79	["", "40", "44"]	2017-10-17 14:49:58.516057	2017-10-21 12:58:06.038738	[]	28	f	1
278	207	30	[""]	2017-10-16 14:03:50.011074	2017-10-20 10:30:52.643295	[]	31	f	3
300	222	37	["", "0"]	2017-10-22 12:16:20.079502	2017-10-22 12:22:11.443802	[]	41	f	1
301	223	37	["", "0"]	2017-10-22 12:32:46.679917	2017-10-22 12:32:46.679917	[]	41	f	1
302	224	37	["", "0"]	2017-10-22 13:17:29.904248	2017-10-22 13:17:29.904248	[]	41	f	1
303	225	37	["", "0"]	2017-10-22 13:36:49.20827	2017-10-22 13:36:49.20827	[]	41	f	1
304	226	37	["", "0"]	2017-10-22 13:47:38.460134	2017-10-22 13:47:38.460134	[]	41	f	1
305	227	37	["", "0"]	2017-10-22 14:20:42.309038	2017-10-22 14:20:42.309038	[]	41	f	1
306	228	14	["", "0"]	2017-10-22 14:31:44.247687	2017-10-22 14:31:44.247687	[]	41	f	1
297	163	2	[""]	2017-10-20 09:56:36.407203	2017-10-24 10:15:41.106268	[]	26	f	2
254	183	73	["", "40", "44", "46"]	2017-10-15 12:00:47.019524	2017-10-24 12:16:39.48832	[]	19	f	1
307	229	2	["", "0"]	2017-10-22 14:38:11.211563	2017-10-22 14:38:11.211563	[]	41	f	1
308	230	12	["", "0"]	2017-10-23 08:57:03.825484	2017-10-23 08:57:03.825484	[]	41	f	1
309	231	37	["", "0"]	2017-10-23 09:10:57.539495	2017-10-23 09:10:57.539495	[]	41	f	1
311	233	27	["", "0"]	2017-10-23 10:05:30.403114	2017-10-23 10:05:30.403114	[]	41	f	1
312	234	37	["", "0"]	2017-10-23 10:10:46.643637	2017-10-23 10:10:46.643637	[]	41	f	1
310	232	70	["", "0"]	2017-10-23 09:14:32.3949	2017-10-23 10:11:33.154257	[]	41	f	1
313	235	27	["", "0"]	2017-10-23 10:17:26.956813	2017-10-23 10:17:26.956813	[]	41	f	1
314	236	46	["", "0"]	2017-10-23 10:24:23.384896	2017-10-23 10:24:23.384896	[]	41	f	1
315	237	14	["", "0"]	2017-10-23 10:35:52.426828	2017-10-23 10:35:52.426828	[]	41	f	1
316	238	37	["", "0"]	2017-10-23 10:39:09.44861	2017-10-23 10:39:09.44861	[]	41	f	1
\.


--
-- Name: variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('variants_id_seq', 316, true);


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: mint
--

COPY wishlists (id, user_id, created_at, updated_at, variant_id) FROM stdin;
5	4	2017-09-15 13:57:28.643522	2017-09-15 13:57:28.643522	120
7	10	2017-09-15 18:29:10.844291	2017-09-15 18:29:10.844291	88
10	19	2017-09-15 19:04:54.513542	2017-09-15 19:04:54.513542	144
11	22	2017-09-15 19:34:23.851347	2017-09-15 19:34:23.851347	113
12	26	2017-09-15 20:46:13.106571	2017-09-15 20:46:13.106571	133
13	33	2017-09-16 05:13:43.701266	2017-09-16 05:13:43.701266	133
14	23	2017-09-16 13:18:44.511912	2017-09-16 13:18:44.511912	153
15	60	2017-09-18 17:03:45.177008	2017-09-18 17:03:45.177008	152
16	60	2017-09-18 17:04:15.10246	2017-09-18 17:04:15.10246	147
17	60	2017-09-18 17:13:28.877587	2017-09-18 17:13:28.877587	65
18	63	2017-09-19 11:50:04.823175	2017-09-19 11:50:04.823175	139
20	61	2017-09-20 11:16:35.582267	2017-09-20 11:16:35.582267	144
21	72	2017-09-21 08:28:43.876461	2017-09-21 08:28:43.876461	162
22	74	2017-09-21 08:37:11.228153	2017-09-21 08:37:11.228153	82
23	80	2017-09-21 19:05:15.241366	2017-09-21 19:05:15.241366	163
25	83	2017-09-22 04:48:25.213328	2017-09-22 04:48:25.213328	133
27	100	2017-09-22 19:11:13.674411	2017-09-22 19:11:13.674411	155
28	101	2017-09-23 08:40:42.331471	2017-09-23 08:40:42.331471	147
29	107	2017-09-23 10:32:29.410222	2017-09-23 10:32:29.410222	152
32	115	2017-09-24 00:16:24.31286	2017-09-24 00:16:24.31286	115
34	126	2017-09-25 18:13:05.598641	2017-09-25 18:13:05.598641	152
35	127	2017-09-25 19:13:58.699622	2017-09-25 19:13:58.699622	115
36	132	2017-09-26 04:38:08.482438	2017-09-26 04:38:08.482438	181
37	132	2017-09-26 04:40:37.113266	2017-09-26 04:40:37.113266	144
38	132	2017-09-26 04:45:45.764651	2017-09-26 04:45:45.764651	171
39	23	2017-09-26 11:52:14.895933	2017-09-26 11:52:14.895933	176
40	96	2017-09-26 18:08:01.321839	2017-09-26 18:08:01.321839	201
42	142	2017-09-26 19:31:35.506784	2017-09-26 19:31:35.506784	133
43	148	2017-09-27 04:51:29.246179	2017-09-27 04:51:29.246179	198
44	149	2017-09-27 05:56:04.197983	2017-09-27 05:56:04.197983	193
45	151	2017-09-27 08:14:57.425687	2017-09-27 08:14:57.425687	176
46	155	2017-09-27 08:36:01.080208	2017-09-27 08:36:01.080208	198
47	159	2017-09-27 10:37:01.510853	2017-09-27 10:37:01.510853	172
48	160	2017-09-27 11:24:53.963464	2017-09-27 11:24:53.963464	190
49	162	2017-09-27 12:02:45.649276	2017-09-27 12:02:45.649276	172
50	163	2017-09-27 12:17:17.586528	2017-09-27 12:17:17.586528	189
51	164	2017-09-27 12:17:36.293214	2017-09-27 12:17:36.293214	88
52	170	2017-09-28 10:55:36.367446	2017-09-28 10:55:36.367446	91
54	177	2017-09-28 21:30:54.884074	2017-09-28 21:30:54.884074	152
55	26	2017-09-29 14:56:01.125979	2017-09-29 14:56:01.125979	177
56	132	2017-09-30 09:07:55.10308	2017-09-30 09:07:55.10308	141
57	191	2017-09-30 18:43:02.73486	2017-09-30 18:43:02.73486	177
58	30	2017-10-01 07:10:46.713228	2017-10-01 07:10:46.713228	177
59	23	2017-10-01 11:34:17.59943	2017-10-01 11:34:17.59943	188
60	69	2017-10-05 15:02:54.079619	2017-10-05 15:02:54.079619	120
61	214	2017-10-06 02:30:36.495353	2017-10-06 02:30:36.495353	182
62	218	2017-10-06 10:16:09.365301	2017-10-06 10:16:09.365301	182
63	222	2017-10-06 20:29:56.546186	2017-10-06 20:29:56.546186	175
64	220	2017-10-08 16:37:56.948296	2017-10-08 16:37:56.948296	231
66	239	2017-10-09 18:58:36.572575	2017-10-09 18:58:36.572575	200
67	243	2017-10-10 07:36:56.972563	2017-10-10 07:36:56.972563	181
68	248	2017-10-11 06:44:34.337147	2017-10-11 06:44:34.337147	191
\.


--
-- Name: wishlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mint
--

SELECT pg_catalog.setval('wishlists_id_seq', 69, true);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: carts_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: colors_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: kitables_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY kitables
    ADD CONSTRAINT kitables_pkey PRIMARY KEY (id);


--
-- Name: kits_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY kits
    ADD CONSTRAINT kits_pkey PRIMARY KEY (id);


--
-- Name: order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: similarables_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY similarables
    ADD CONSTRAINT similarables_pkey PRIMARY KEY (id);


--
-- Name: themables_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY themables
    ADD CONSTRAINT themables_pkey PRIMARY KEY (id);


--
-- Name: themes_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: variants_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (id);


--
-- Name: wishlists_pkey; Type: CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY wishlists
    ADD CONSTRAINT wishlists_pkey PRIMARY KEY (id);


--
-- Name: index_carts_on_user_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_carts_on_user_id ON carts USING btree (user_id);


--
-- Name: index_carts_on_variant_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_carts_on_variant_id ON carts USING btree (variant_id);


--
-- Name: index_categories_on_parent_category_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_categories_on_parent_category_id ON categories USING btree (parent_category_id);


--
-- Name: index_colors_on_parent_color_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_colors_on_parent_color_id ON colors USING btree (parent_color_id);


--
-- Name: index_colors_on_slug; Type: INDEX; Schema: public; Owner: mint
--

CREATE UNIQUE INDEX index_colors_on_slug ON colors USING btree (slug);


--
-- Name: index_images_on_imagable_type_and_imagable_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_images_on_imagable_type_and_imagable_id ON images USING btree (imagable_type, imagable_id);


--
-- Name: index_kitables_on_kit_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_kitables_on_kit_id ON kitables USING btree (kit_id);


--
-- Name: index_kitables_on_product_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_kitables_on_product_id ON kitables USING btree (product_id);


--
-- Name: index_kitables_on_variant_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_kitables_on_variant_id ON kitables USING btree (variant_id);


--
-- Name: index_kits_on_theme_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_kits_on_theme_id ON kits USING btree (theme_id);


--
-- Name: index_order_items_on_order_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_order_items_on_order_id ON order_items USING btree (order_id);


--
-- Name: index_order_items_on_variant_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_order_items_on_variant_id ON order_items USING btree (variant_id);


--
-- Name: index_orders_on_user_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_orders_on_user_id ON orders USING btree (user_id);


--
-- Name: index_products_on_category_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_products_on_category_id ON products USING btree (category_id);


--
-- Name: index_products_on_colors; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_products_on_colors ON products USING gin (colors);


--
-- Name: index_products_on_kind_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_products_on_kind_id ON products USING btree (kind_id);


--
-- Name: index_similarables_on_product_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_similarables_on_product_id ON similarables USING btree (product_id);


--
-- Name: index_similarables_on_similar_product_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_similarables_on_similar_product_id ON similarables USING btree (similar_product_id);


--
-- Name: index_themables_on_product_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_themables_on_product_id ON themables USING btree (product_id);


--
-- Name: index_themables_on_theme_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_themables_on_theme_id ON themables USING btree (theme_id);


--
-- Name: index_themes_on_slug; Type: INDEX; Schema: public; Owner: mint
--

CREATE UNIQUE INDEX index_themes_on_slug ON themes USING btree (slug);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: mint
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: mint
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_variants_on_category_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_variants_on_category_id ON variants USING btree (category_id);


--
-- Name: index_variants_on_color_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_variants_on_color_id ON variants USING btree (color_id);


--
-- Name: index_variants_on_product_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_variants_on_product_id ON variants USING btree (product_id);


--
-- Name: index_variants_on_product_id_and_color_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE UNIQUE INDEX index_variants_on_product_id_and_color_id ON variants USING btree (product_id, color_id);


--
-- Name: index_wishlists_on_user_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_wishlists_on_user_id ON wishlists USING btree (user_id);


--
-- Name: index_wishlists_on_variant_id; Type: INDEX; Schema: public; Owner: mint
--

CREATE INDEX index_wishlists_on_variant_id ON wishlists USING btree (variant_id);


--
-- Name: fk_rails_19f8efee69; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY variants
    ADD CONSTRAINT fk_rails_19f8efee69 FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: fk_rails_476172d337; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY order_items
    ADD CONSTRAINT fk_rails_476172d337 FOREIGN KEY (variant_id) REFERENCES variants(id);


--
-- Name: fk_rails_89db678531; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY kits
    ADD CONSTRAINT fk_rails_89db678531 FOREIGN KEY (theme_id) REFERENCES themes(id);


--
-- Name: fk_rails_8f0fc13947; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY similarables
    ADD CONSTRAINT fk_rails_8f0fc13947 FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: fk_rails_91776d71e2; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY wishlists
    ADD CONSTRAINT fk_rails_91776d71e2 FOREIGN KEY (variant_id) REFERENCES variants(id);


--
-- Name: fk_rails_97800e0e36; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY themables
    ADD CONSTRAINT fk_rails_97800e0e36 FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: fk_rails_98c5c00776; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT fk_rails_98c5c00776 FOREIGN KEY (variant_id) REFERENCES variants(id);


--
-- Name: fk_rails_b7484ad079; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY variants
    ADD CONSTRAINT fk_rails_b7484ad079 FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- Name: fk_rails_c000fc3663; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY themables
    ADD CONSTRAINT fk_rails_c000fc3663 FOREIGN KEY (theme_id) REFERENCES themes(id);


--
-- Name: fk_rails_c1e5a116ec; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY kitables
    ADD CONSTRAINT fk_rails_c1e5a116ec FOREIGN KEY (variant_id) REFERENCES variants(id);


--
-- Name: fk_rails_e3cb28f071; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY order_items
    ADD CONSTRAINT fk_rails_e3cb28f071 FOREIGN KEY (order_id) REFERENCES orders(id);


--
-- Name: fk_rails_ea59a35211; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT fk_rails_ea59a35211 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_eb66139660; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY wishlists
    ADD CONSTRAINT fk_rails_eb66139660 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_f868b47f6a; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_rails_f868b47f6a FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_f9d23b08d3; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY variants
    ADD CONSTRAINT fk_rails_f9d23b08d3 FOREIGN KEY (color_id) REFERENCES colors(id);


--
-- Name: fk_rails_fb915499a4; Type: FK CONSTRAINT; Schema: public; Owner: mint
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_rails_fb915499a4 FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

