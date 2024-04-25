SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;


CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;



CREATE TABLE viacep (
    codigo integer NOT NULL,
    cep character varying(8) NOT NULL,
    endereco character varying(50) NOT NULL,
    complemento character varying(50),
    bairro character varying(50) NOT NULL,
    cidade character varying(50) NOT NULL,
    uf character varying(2) NOT NULL
);


ALTER TABLE public.viacep OWNER TO postgres;

CREATE SEQUENCE viacep_codigo_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.viacep_codigo_seq OWNER TO postgres;

ALTER SEQUENCE viacep_codigo_seq OWNED BY viacep.codigo;

SELECT pg_catalog.setval('viacep_codigo_seq', 1, false);

ALTER TABLE ONLY viacep ALTER COLUMN codigo SET DEFAULT nextval('viacep_codigo_seq'::regclass);


COPY viacep (codigo, cep, endereco, complemento, bairro, cidade, uf) FROM stdin;
\.


ALTER TABLE ONLY viacep
    ADD CONSTRAINT viacep_pkey PRIMARY KEY (codigo);


REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;

