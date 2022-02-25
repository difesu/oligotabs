CREATE SCHEMA generals;

CREATE SCHEMA particulars;

CREATE SCHEMA  relations;

CREATE TABLE generals.g_core (
	g_core_id BIGSERIAL UNIQUE PRIMARY KEY,
	name VARCHAR NOT NULL,
	active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE particulars.p_core (
	p_core_id BIGSERIAL UNIQUE PRIMARY KEY,
	name VARCHAR NOT NULL,
	active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE relations.g1_in_g2 (
    g1_core_id BIGSERIAL REFERENCES generals.g_core,
    g2_core_id BIGSERIAL REFERENCES generals.g_core,
    active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE relations.p_in_g (
    g_core_id BIGSERIAL REFERENCES generals.g_core,
    p_core_id BIGSERIAL REFERENCES particulars.p_core,
    active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE relations.p1_in_p2 (
    p1_core_id BIGSERIAL REFERENCES particulars.p_core,
    p2_core_id BIGSERIAL REFERENCES particulars.p_core,
    active BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE relations.p1_subsets_p2 (  
    p1_core_id BIGSERIAL REFERENCES particulars.p_core,
    p2_core_id BIGSERIAL REFERENCES particulars.p_core,
    active BOOLEAN NOT NULL DEFAULT true 
);

CREATE TABLE relations.g1_subsets_g2 (  
    g1_core_id BIGSERIAL REFERENCES generals.g_core,
    g2_core_id BIGSERIAL REFERENCES generals.g_core,
    active BOOLEAN NOT NULL DEFAULT true 
);

CREATE TABLE relations.p1_is_g_of_p2 (
    p1_core_id BIGSERIAL REFERENCES particulars.p_core,
    p2_core_id BIGSERIAL REFERENCES particulars.p_core,
    g_core_id BIGSERIAL REFERENCES generals.g_core,
    active BOOLEAN NOT NULL DEFAULT true 
);