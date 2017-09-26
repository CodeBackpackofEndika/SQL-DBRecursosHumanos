
CREATE TABLE puestos(
  cod_puesto NUMBER(2) CONSTRAINT puestos_pk PRIMARY KEY,
  titulo_puesto VARCHAR(2) CONSTRAINT puestos_uk1 UNIQUE
                          CONSTRAINT puestos_nn1 NOT NULL,
  salario_min NUMBER(11,2),
  salrio_max NUMBER (11,2)
);

CREATE TABLE historial(
  cod_puesto NUMBER(2) CONSTRAINT historial_fk1 REFERENCES puestos,

  fecha_inicio DATE CONSTRAINT historial_nn1 NOT NULL,
  fecha_fin DATE,

  salario NUMBER(11,2),
  CONSTRAINT historial_pk PRIMARY KEY (cod_puesto)
);

CREATE TABLE empleados (
  cod_emp   NUMBER(4) CONSTRAINT empleados_pk PRIMARY KEY,
  nombre    VARCHAR2(50) CONSTRAINT empleados_nn1 NOT NULL,
  apellido1 VARCHAR2(50) CONSTRAINT empleados_nn2 NOT NULL,
  apellido2 VARCHAR2(50) CONSTRAINT empleados_nn3 NOT NULL,
  telefono  CHAR(9),
  direccion VARCHAR2(50),
  email     VARCHAR2(50) CONSTRAINT empleados_uk1 UNIQUE,
  cod_jefe  NUMBER(4) CONSTRAINT empleados_fk1 REFERENCES empleados (cod_emp)
);

CREATE TABLE departamentos(
  cod_dep  NUMBER(2) CONSTRAINT departamentos_pk PRIMARY KEY,
  nombre_dep VARCHAR2(25) CONSTRAINT departamentos_uk1 UNIQUE
                            CONSTRAINT departamentos_nn1 NOT NULL,
  cod_resp NUMBER(4) CONSTRAINT departamentos_fk1 REFERENCES empleados (cod_emp)
                            CONSTRAINT departamentos_nn2 NOT NULL

);

CREATE TABLE localizaciones(
  cod_localizacion NUMBER(3) CONSTRAINT localizaciones_pk PRIMARY KEY,
  localidad VARCHAR2(50) CONSTRAINT localidades_nn1 NOT NULL,
  direccion VARCHAR2(50) ,
  CIP CHAR(5),
  provincia VARCHAR2(25)
);

ALTER TABLE historial ADD cod_dep NUMBER(3) CONSTRAINT historial_fk3 REFERENCES departamentos;
ALTER TABLE historial ADD cod_emp NUMBER(4) CONSTRAINT historial_fk2 REFERENCES empleados;
ALTER TABLE historial DROP CONSTRAINT historial_pk;
ALTER TABLE historial ADD   CONSTRAINT historial_pk1 PRIMARY KEY (cod_emp,cod_puesto);
ALTER TABLE departamentos ADD CONSTRAINT empleados_fk2 FOREIGN KEY(cod_dep) REFERENCES departamentos (cod_dep);
ALTER TABLE departamentos ADD  (cod_loc  NUMBER(3) CONSTRAINT departamentos_fk2 REFERENCES localizaciones (cod_localizacion)
                            CONSTRAINT departamentos_nn3 NOT NULL);