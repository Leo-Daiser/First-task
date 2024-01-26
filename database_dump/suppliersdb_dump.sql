--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)

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
-- Name: update_supplier_materials(); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.update_supplier_materials() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  UPDATE suppliers
  SET materials = (
    SELECT jsonb_agg(jsonb_build_object('id', materials.id, 'name', materials.name, 'unit_of_measurement', materials.unit_of_measurement))
    FROM supplier_materials
    JOIN materials ON supplier_materials.material_id = materials.id
    WHERE suppliers.id = supplier_materials.supplier_id
    GROUP BY suppliers.id
  )
  WHERE suppliers.id = NEW.supplier_id;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_supplier_materials() OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: materials; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.materials (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    unit_of_measurement character varying(20) NOT NULL
);


ALTER TABLE public.materials OWNER TO admin;

--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.materials_id_seq OWNER TO admin;

--
-- Name: materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.materials_id_seq OWNED BY public.materials.id;


--
-- Name: supplier_materials; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.supplier_materials (
    id integer NOT NULL,
    supplier_id integer,
    material_id integer,
    quantity integer
);


ALTER TABLE public.supplier_materials OWNER TO admin;

--
-- Name: supplier_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.supplier_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supplier_materials_id_seq OWNER TO admin;

--
-- Name: supplier_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.supplier_materials_id_seq OWNED BY public.supplier_materials.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(20) NOT NULL,
    phone character varying(15) NOT NULL,
    address character varying(255) NOT NULL,
    materials jsonb
);


ALTER TABLE public.suppliers OWNER TO admin;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO admin;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: materials id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.materials ALTER COLUMN id SET DEFAULT nextval('public.materials_id_seq'::regclass);


--
-- Name: supplier_materials id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.supplier_materials ALTER COLUMN id SET DEFAULT nextval('public.supplier_materials_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.materials (id, name, unit_of_measurement) FROM stdin;
1	Material 1	шт.
2	Material 2	кг
5	Material 3	литр
6	Material 4	метр
7	Material 5	грамм
\.


--
-- Data for Name: supplier_materials; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.supplier_materials (id, supplier_id, material_id, quantity) FROM stdin;
202	1	7	1
203	2	7	1
204	6	7	2
205	7	7	1
206	8	7	1
207	9	7	2
208	10	7	1
209	11	7	1
210	12	7	1
211	13	7	3
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.suppliers (id, name, type, phone, address, materials) FROM stdin;
8	Supplier 5	ИП	333-333-3333	Address 5	[{"id": 1, "name": "Material 1", "quantity": 2, "unit_of_measurement": "грамм"}, {"id": 2, "name": "Material 2", "quantity": 3, "unit_of_measurement": "грамм"}, {"id": 4, "name": "Material 4", "quantity": 2, "unit_of_measurement": "грамм"}]
9	Supplier 6	ООО	444-444-4444	Address 6	[{"id": 1, "name": "Material 1", "quantity": 1, "unit_of_measurement": "грамм"}, {"id": 2, "name": "Material 2", "quantity": 2, "unit_of_measurement": "грамм"}, {"id": 4, "name": "Material 4", "quantity": 2, "unit_of_measurement": "грамм"}]
10	Supplier 7	ИП	555-555-5555	Address 7	[{"id": 1, "name": "Material 1", "quantity": 3, "unit_of_measurement": "грамм"}, {"id": 2, "name": "Material 2", "quantity": 2, "unit_of_measurement": "грамм"}, {"id": 5, "name": "Material 5", "quantity": 3, "unit_of_measurement": "грамм"}]
1	Supplier 1	ИП	123-456-7890	Address 1	[{"id": 1, "name": "Material 1", "quantity": 1, "unit_of_measurement": "грамм"}, {"id": 2, "name": "Material 2", "quantity": 2, "unit_of_measurement": "грамм"}, {"id": 4, "name": "Material 4", "quantity": 3, "unit_of_measurement": "грамм"}]
2	Supplier 2	ООО	987-654-3210	Address 2	[{"id": 1, "name": "Material 1", "quantity": 1, "unit_of_measurement": "грамм"}, {"id": 2, "name": "Material 2", "quantity": 2, "unit_of_measurement": "грамм"}, {"id": 4, "name": "Material 4", "quantity": 3, "unit_of_measurement": "грамм"}]
6	Supplier 3	ИП	111-111-1111	Address 3	[{"id": 2, "name": "Material 2", "quantity": 1, "unit_of_measurement": "грамм"}]
7	Supplier 4	ООО	222-222-2222	Address 4	[{"id": 1, "name": "Material 1", "quantity": 1, "unit_of_measurement": "грамм"}, {"id": 2, "name": "Material 2", "quantity": 2, "unit_of_measurement": "грамм"}]
11	Supplier 8	ООО	666-666-6666	Address 8	\N
12	Supplier 9	ИП	777-777-7777	Address 9	\N
13	Supplier 10	ООО	888-888-8888	Address 10	\N
\.


--
-- Name: materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.materials_id_seq', 7, true);


--
-- Name: supplier_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.supplier_materials_id_seq', 211, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 14, true);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: supplier_materials supplier_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.supplier_materials
    ADD CONSTRAINT supplier_materials_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: suppliers unique_supplier_name; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT unique_supplier_name UNIQUE (name);


--
-- Name: supplier_materials after_insert_supplier_materials; Type: TRIGGER; Schema: public; Owner: admin
--

CREATE TRIGGER after_insert_supplier_materials AFTER INSERT ON public.supplier_materials FOR EACH ROW EXECUTE FUNCTION public.update_supplier_materials();


--
-- Name: supplier_materials supplier_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.supplier_materials
    ADD CONSTRAINT supplier_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: supplier_materials supplier_materials_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.supplier_materials
    ADD CONSTRAINT supplier_materials_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- PostgreSQL database dump complete
--

