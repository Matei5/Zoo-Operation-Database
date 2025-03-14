CREATE SEQUENCE incrementare_cod_angajat START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_job START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_gradina_zoologica START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_locatie START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_sponsor START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_habitat START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_acvariu START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_animal_suprateran START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_animal_acvatic START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_vizitator START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999 NOCYCLE;
CREATE SEQUENCE incrementare_cod_tranzactie START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999999999 NOCYCLE;

CREATE TABLE LOCATII(
    cod_locatie NUMBER(5) CONSTRAINT pk_locatii PRIMARY KEY,
    oras VARCHAR2(50) CONSTRAINT oras_null NOT NULL,
    strada VARCHAR2(50) CONSTRAINT strada_null NOT NULL,
    numar NUMBER(3) CONSTRAINT numar_null NOT NULL
);

CREATE TABLE JOBURI(
    cod_job NUMBER(5) CONSTRAINT pk_joburi PRIMARY KEY,
    nume_job VARCHAR2(50) CONSTRAINT nume_job_null NOT NULL,
    experienta_minima NUMBER(2) CONSTRAINT experienta_minima_null NOT NULL
);

CREATE TABLE SPONSORI(
    cod_sponsor NUMBER(5) CONSTRAINT pk_sponsori PRIMARY KEY,
    nume_sponsor VARCHAR2(50) CONSTRAINT nume_sponsor_null NOT NULL,
    email VARCHAR2(50) CONSTRAINT email_sponsor_null NOT NULL,
    numar_de_telefon VARCHAR2(10) CONSTRAINT numar_de_telefon_null NOT NULL
);

CREATE TABLE VIZITATORI(
    cod_vizitator NUMBER(10) CONSTRAINT pk_vizitatori PRIMARY KEY,
    nume VARCHAR2(50) CONSTRAINT nume_vizitator_null NOT NULL,
    prenume VARCHAR2(50) CONSTRAINT prenume_vizitator_null NOT NULL
);

CREATE TABLE GRADINI_ZOOLOGICE(
    cod_zoo NUMBER(5) CONSTRAINT pk_gradini_zoologice PRIMARY KEY,
    nume_zoo VARCHAR2(50),
    email VARCHAR2(50) CONSTRAINT email_null NOT NULL,
    cod_locatie NUMBER(5) NOT NULL,
	CONSTRAINT fk_cod_locatie FOREIGN KEY(cod_locatie) REFERENCES LOCATII(cod_locatie)
);

CREATE TABLE HABITATE(
    cod_habitat NUMBER(5) CONSTRAINT pk_habitate PRIMARY KEY,
    nume_habitat VARCHAR2(50) CONSTRAINT nume_habitat_null NOT NULL,
    cod_zoo NUMBER(5) NOT NULL,
    CONSTRAINT fk_cod_zoo FOREIGN KEY(cod_zoo) REFERENCES GRADINI_ZOOLOGICE(cod_zoo)
);

CREATE TABLE ACVARII(
    cod_acvariu NUMBER(5) CONSTRAINT pk_acvarii PRIMARY KEY,
    nume_acvariu VARCHAR2(50) CONSTRAINT nume_acvariu_null NOT NULL,
    cod_zoo NUMBER(5) NOT NULL,
    CONSTRAINT fk_cod_zoo_acvariu FOREIGN KEY(cod_zoo) REFERENCES GRADINI_ZOOLOGICE(cod_zoo)
);

CREATE TABLE ANGAJATI(
    cod_angajat NUMBER(5) CONSTRAINT pk_angajati PRIMARY KEY,
    data_angajare DATE CONSTRAINT data_angajare_null NOT NULL,
    nume VARCHAR2(50) CONSTRAINT nume_angajat_null NOT NULL,
    prenume VARCHAR2(50) CONSTRAINT prenume_angajat_null NOT NULL,
    cod_job NUMBER(5) NOT NULL,
    salariu NUMBER(5) CONSTRAINT salariu_null NOT NULL,
    CONSTRAINT fk_cod_job FOREIGN KEY(cod_job) REFERENCES JOBURI(cod_job)
);

CREATE TABLE ANIMALE_SUPRATERANE(
    cod_animal_st NUMBER(5) CONSTRAINT pk_animale_supraterane PRIMARY KEY,
    nume_animal VARCHAR2(50) CONSTRAINT nume_animal_null NOT NULL,
    specie VARCHAR2(50),
    cod_habitat NUMBER(5) NOT NULL,
    CONSTRAINT fk_cod_habitat FOREIGN KEY(cod_habitat) REFERENCES HABITATE(cod_habitat)
);

CREATE TABLE ANIMALE_ACVATICE(
    cod_animal_acv NUMBER(5) CONSTRAINT pk_animale_acvatice PRIMARY KEY,
    nume_animal_acv VARCHAR2(50) CONSTRAINT nume_animal_acv_null NOT NULL,
    specie_acv VARCHAR2(50),
    cod_acvariu NUMBER(5) NOT NULL,
    CONSTRAINT fk_cod_acvariu FOREIGN KEY(cod_acvariu) REFERENCES ACVARII(cod_acvariu)
);
CREATE TABLE GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(
    cod_sponsor NUMBER(5) NOT NULL,
    data_contract DATE CONSTRAINT data_contract_null NOT NULL,
    cod_zoo NUMBER(5) NOT NULL,
    suma NUMBER CONSTRAINT suma_null NOT NULL,
    CONSTRAINT fk_cod_zoo_sponsorizare FOREIGN KEY(cod_zoo) REFERENCES GRADINI_ZOOLOGICE(cod_zoo),
    CONSTRAINT fk_cod_sponsor FOREIGN KEY(cod_sponsor) REFERENCES SPONSORI(cod_sponsor),
    CONSTRAINT pk_gradini_zoologice_sunt_sponsorizate PRIMARY KEY(cod_sponsor, data_contract, cod_zoo)
);

CREATE TABLE GRADINI_ZOOLOGICE_AU_JOBURI(
    cod_job NUMBER(5) NOT NULL,
    cod_zoo NUMBER(5) NOT NULL,
    CONSTRAINT fk_cod_job_gradini FOREIGN KEY(cod_job) REFERENCES JOBURI(cod_job),
    CONSTRAINT fk_cod_zoo_job FOREIGN KEY(cod_zoo) REFERENCES GRADINI_ZOOLOGICE(cod_zoo),
    CONSTRAINT pk_gradini_zoologice_au_joburi PRIMARY KEY(cod_job, cod_zoo)
);

CREATE TABLE CUMPARA_ACCES_LA(
    cod_habitat NUMBER(5) NOT NULL,
    cod_acvariu NUMBER(5) NOT NULL,
    cod_vizitator NUMBER(10) NOT NULL,
    cod_tranzactie NUMBER(10) NOT NULL,
    data DATE CONSTRAINT data_null NOT NULL,
    pret NUMBER CONSTRAINT pret_null NOT NULL,
    CONSTRAINT fk_cod_habitat_acces FOREIGN KEY(cod_habitat) REFERENCES HABITATE(cod_habitat),
    CONSTRAINT fk_cod_acvariu_acces FOREIGN KEY(cod_acvariu) REFERENCES ACVARII(cod_acvariu),
    CONSTRAINT fk_cod_vizitator_acces FOREIGN KEY(cod_vizitator) REFERENCES VIZITATORI(cod_vizitator),
    CONSTRAINT pk_cumpara_acces_la PRIMARY KEY(cod_habitat, cod_acvariu, cod_vizitator, cod_tranzactie)
);

-- stiu ca e optionala acesta parte, mai ales daca nu omit nimic, dar mi-a fost mai usor sa scriu inserarile asa
--                 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Bucuresti', 'Aleea Florilor', 3);
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Cluj-Napoca', 'Strada Principala', 7);
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Timisoara', 'Strada Mare', 15);
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Iasi', 'Strada Verde', 5);
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Constanta', 'Strada Alba', 44);
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Brasov', 'Strada Rosie', 12);
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Sibiu', 'Strada Galbena', 32);
INSERT INTO LOCATII(cod_locatie, oras, strada, numar) VALUES(incrementare_cod_locatie.nextval, 'Oradea', 'Strada Albastra', 11);

INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Ingrijitor animale', 2);
INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Veterinar', 5);
INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Ghid', 1);
INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Administrator', 3);
INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Curator', 4);
INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Bucatar', 2);
INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Mecanic', 3);
INSERT INTO JOBURI(cod_job, nume_job, experienta_minima) VALUES(incrementare_cod_job.nextval, 'Contabil', 5);

INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, 'Zoo Bucuresti', 'zoo.bucuresti@gmail.com', 1);
INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, 'Zoo Cluj', 'zoo.cluj@gmail.com', 2);
INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, 'Zoo Timisoara', 'zoo.timisoara@gmail.com', 3);
INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, 'Zoo Iasi', 'zoo.iasi@yahoo.com', 4);
INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, null , 'zoo.constanta@gmail.com', 5);
INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, 'Zoo Brasov', 'zoo.brasov@gmail.com', 6);
INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, 'Zoo Sibiu', 'zoo.sibiu@gmail.com', 7);
INSERT INTO GRADINI_ZOOLOGICE(cod_zoo, nume_zoo, email, cod_locatie) VALUES(incrementare_cod_gradina_zoologica.nextval, 'Zoo Oradea' , 'zoo.oradea@yahoo.com', 8);

INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul African', 1);
INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul Arctic', 2);
INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul Tropical', 3);
INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul Desertic', 4);
INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul Montan', 5);
INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul Oceanic', 6);
INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul Padurii', 7);
INSERT INTO HABITATE(cod_habitat, nume_habitat, cod_zoo) VALUES(incrementare_cod_habitat.nextval, 'Habitatul Savanei', 8);

INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul Tropical', 1);
INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul de Apa Dulce', 2);
INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul Coralilor', 3);
INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul de Apa Sarata', 4);
INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul Oceanic', 5);
INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul Mediteranean', 6);
INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul de Mangrove', 7);
INSERT INTO ACVARII(cod_acvariu, nume_acvariu, cod_zoo) VALUES(incrementare_cod_acvariu.nextval, 'Acvariul de Recif', 8);

INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 1', 'sponsor1@gmail.com', '0712345678');
INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 2', 'sponsor2@gmail.com', '0723456789');
INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 3', 'sponsor3@gmail.com', '0734567890');
INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 4', 'sponsor4@gmail.com', '0745678901');
INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 5', 'sponsor5@gmail.com', '0756789012');
INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 6', 'sponsor6@gmail.com', '0767890123');
INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 7', 'sponsor7@gmail.com', '0778901234');
INSERT INTO SPONSORI(cod_sponsor, nume_sponsor, email, numar_de_telefon) VALUES(incrementare_cod_sponsor.nextval, 'Sponsor 8', 'sponsor8@gmail.com', '0789012345');

INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'Ionescu', 'Maria', 1, 3000);
INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2019-05-20', 'YYYY-MM-DD'), 'Popescu', 'Ion', 2, 4500);
INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2018-11-30', 'YYYY-MM-DD'), 'Georgescu', 'Ana', 3, 2800);
INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2017-03-25', 'YYYY-MM-DD'), 'Dumitrescu', 'Mihai', 5, 5200);
INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2021-07-15', 'YYYY-MM-DD'), 'Stan', 'Elena', 5, 3100);
INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2022-02-10', 'YYYY-MM-DD'), 'Marinescu', 'Alex', 6, 3400);
INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'Popa', 'Cristina', 6, 3800);
INSERT INTO ANGAJATI(cod_angajat, data_angajare, nume, prenume, cod_job, salariu) VALUES(incrementare_cod_angajat.nextval, TO_DATE('2021-12-05', 'YYYY-MM-DD'), 'Radu', 'Vasile', 8, 5000);

INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Leu', 'Panthera leo', 1);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Tigru', 'Panthera tigris', 2);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Elefant', 'Loxodonta africana', 3);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Girafa', 'Giraffa camelopardalis', 4);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Zimbru', 'Bison bonasus' , 4);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Crocodil', 'Crocodylus niloticus', 4);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Rinocer', 'Rhinocerotidae', 5);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Elefant', 'Loxodonta africana', 5);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Hipopotam', 'Hippopotamidae', 5);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Zebra', 'Equus quagga', 6);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Antilopa', 'Antilopinae', 7);
INSERT INTO ANIMALE_SUPRATERANE(cod_animal_st, nume_animal, specie, cod_habitat) VALUES(incrementare_cod_animal_suprateran.nextval, 'Cangur', 'Macropus', 8);

INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'peste Clovn', 'Amphiprioninae', 1);
INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'Rechin', 'Selachimorpha', 2);
INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'Calut de mare', 'Hippocampus', 3);
INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'Manta', 'Mobulidae', 4);
INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'Piranha', 'Pygocentrus nattereri', 5);
INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'Meduza', 'Scyphozoa', 6);
INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'Caracatita', 'Octopus', 7);
INSERT INTO ANIMALE_ACVATICE(cod_animal_acv, nume_animal_acv, specie_acv, cod_acvariu) VALUES(incrementare_cod_animal_acvatic.nextval, 'Stea de mare', 'Asteroidea', 8);

INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Andrei', 'Popescu');
INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Cristina', 'Ionescu');
INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Marius', 'Georgescu');
INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Alina', 'Dumitrescu');
INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Bogdan', 'Marinescu');
INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Ioana', 'Stan');
INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Vlad', 'Popa');
INSERT INTO VIZITATORI(cod_vizitator, nume, prenume) VALUES(incrementare_cod_vizitator.nextval, 'Diana', 'Radu');

INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(1, TO_DATE('2022-01-01', 'YYYY-MM-DD'), 1, 10000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(4, TO_DATE('2022-02-01', 'YYYY-MM-DD'), 2, 15000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(3, TO_DATE('2022-03-01', 'YYYY-MM-DD'), 2, 20000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(8, TO_DATE('2022-04-01', 'YYYY-MM-DD'), 4, 25000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(5, TO_DATE('2022-05-01', 'YYYY-MM-DD'), 5, 30000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(6, TO_DATE('2022-06-01', 'YYYY-MM-DD'), 3, 35000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(1, TO_DATE('2022-07-01', 'YYYY-MM-DD'), 7, 40000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(5, TO_DATE('2022-08-01', 'YYYY-MM-DD'), 7, 45000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 3, 10000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 2, 15000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(7, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 3, 20000);
INSERT INTO GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI(cod_sponsor, data_contract, cod_zoo, suma) VALUES(4, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 6, 25000);

INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(1, 1);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(2, 2);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(3, 3);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(4, 4);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(5, 5);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(6, 6);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(7, 7);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(8, 8);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(1, 2);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(2, 3);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(3, 4);
INSERT INTO GRADINI_ZOOLOGICE_AU_JOBURI(cod_job, cod_zoo) VALUES(4, 5);

INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 1, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);

--INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 2, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);
--INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 3, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);
--INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 4, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);
--INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 5, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);
--INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 6, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);
--INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 7, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);
--INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 8, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 50);

INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 3, 2, 2, TO_DATE('2023-02-20', 'YYYY-MM-DD'), 60);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 2, 3, 8, TO_DATE('2023-03-15', 'YYYY-MM-DD'), 70);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 4, 4, 4, TO_DATE('2023-04-25', 'YYYY-MM-DD'), 80);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 5, 5, 5, TO_DATE('2023-05-30', 'YYYY-MM-DD'), 90);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 8, 6, 6, TO_DATE('2023-05-30', 'YYYY-MM-DD'), 100);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 6, 6, 7, TO_DATE('2023-06-10', 'YYYY-MM-DD'), 100);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 7, 7, 3, TO_DATE('2023-07-20', 'YYYY-MM-DD'), 110);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 8, 8, 2, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 120);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 2, 1, 8, TO_DATE('2023-09-10', 'YYYY-MM-DD'), 55);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 3, 2, 1, TO_DATE('2023-10-20', 'YYYY-MM-DD'), 65);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 5, 3, 3, TO_DATE('2023-11-15', 'YYYY-MM-DD'), 75);
INSERT INTO CUMPARA_ACCES_LA(cod_tranzactie, cod_habitat, cod_acvariu, cod_vizitator, data, pret) VALUES(incrementare_cod_tranzactie.nextval, 5, 4, 5, TO_DATE('2023-12-25', 'YYYY-MM-DD'), 85);

