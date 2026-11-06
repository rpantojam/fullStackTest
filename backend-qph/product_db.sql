--
-- PostgreSQL database dump
--

\restrict UZG1uRlx0SOpPH4NLWDs7Rq8EDbo9U3ngVy5cuIBYH5ecsdAQHB86o6hCuWhych

-- Dumped from database version 15.19 (Debian 15.19-1.pgdg13+2)
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-05 22:27:17

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 24579)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
                                 id integer NOT NULL,
                                 nombre character varying(255) NOT NULL,
                                 precio numeric(38,2) NOT NULL,
                                 stock integer NOT NULL,
                                 CONSTRAINT products_stock_check CHECK ((stock >= 0))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24578)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 214
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 218 (class 1259 OID 24604)
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
                              id integer NOT NULL,
                              product_id integer NOT NULL,
                              unitary_price numeric NOT NULL,
                              amount integer NOT NULL,
                              total numeric NOT NULL,
                              sale_dt timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
                              seller_user_id integer NOT NULL
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24611)
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.sales_id_seq OWNER TO postgres;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 219
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- TOC entry 216 (class 1259 OID 24586)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
                              id integer NOT NULL,
                              username character varying(15) NOT NULL,
                              password character varying(255) NOT NULL,
                              created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24602)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3273 (class 2604 OID 24582)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 24612)
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 24603)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3432 (class 0 OID 24579)
-- Dependencies: 215
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, nombre, precio, stock) FROM stdin;
2	Monitor Acer 27" Curvo	850000.00	48
1	Simulador racing Logitec G921	1200000.00	8
\.


--
-- TOC entry 3435 (class 0 OID 24604)
-- Dependencies: 218
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (id, product_id, unitary_price, amount, total, sale_dt, seller_user_id) FROM stdin;
2	2	850000.00	2	1700000.00	2026-11-05 22:49:41.639942+00	4
3	1	1200000	2	2400000.00	2026-11-06 03:24:05.730654+00	9
\.


--
-- TOC entry 3433 (class 0 OID 24586)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, password, created) FROM stdin;
4	admin	$2a$10$Si69PgmxAwAa27drHBwoJ.ZrUPX0pwHhzLJV/Rf6CMbPkEuqZ.Pza	2026-11-05 21:19:12.347773+00
5	richie	$2a$10$1EcI4zYDY//WXyNh1qdkVONQiGx2ZeUwRaxL/.zXsFbZ.RaWb2NrC	2026-11-06 01:09:28.617187+00
8	sebapl	$2a$10$jN9JJNIde3fPcpgnXejrWu9ViXIiTFKJjypaTRPL5yzbICGYR97gK	2026-11-06 01:45:59.642748+00
9	natapl	$2a$10$zp/SfNMomLyXOrXrjyTGkuEUDjNWcWLCBlkl9o/aDEWZ.9vG5i3e2	2026-11-06 01:58:02.337993+00
\.


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 214
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 4, true);


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 219
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_seq', 3, true);


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 217
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- TOC entry 3280 (class 2606 OID 24585)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 24610)
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 24601)
-- Name: users uniqe_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uniqe_user UNIQUE (username);


--
-- TOC entry 3284 (class 2606 OID 24592)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3287 (class 2606 OID 24614)
-- Name: sales fk_products; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;


--
-- TOC entry 3288 (class 2606 OID 24619)
-- Name: sales fk_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT fk_users FOREIGN KEY (seller_user_id) REFERENCES public.users(id) NOT VALID;


-- Completed on 2026-11-05 22:27:17

--
-- PostgreSQL database dump complete
--

\unrestrict UZG1uRlx0SOpPH4NLWDs7Rq8EDbo9U3ngVy5cuIBYH5ecsdAQHB86o6hCuWhych

