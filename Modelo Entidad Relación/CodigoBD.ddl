-- Generado por Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   en:        2019-09-13 09:45:55 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE caja CASCADE CONSTRAINTS;

DROP TABLE cajero CASCADE CONSTRAINTS;

DROP TABLE categoria CASCADE CONSTRAINTS;

DROP TABLE cliente CASCADE CONSTRAINTS;

DROP TABLE compraxsucursal CASCADE CONSTRAINTS;

DROP TABLE domiciliario CASCADE CONSTRAINTS;

DROP TABLE domicilio CASCADE CONSTRAINTS;

DROP TABLE empleado CASCADE CONSTRAINTS;

DROP TABLE jefe CASCADE CONSTRAINTS;

DROP TABLE marca CASCADE CONSTRAINTS;

DROP TABLE producto CASCADE CONSTRAINTS;

DROP TABLE prodxcompra CASCADE CONSTRAINTS;

DROP TABLE prodxsucursal CASCADE CONSTRAINTS;

DROP TABLE prodxventa CASCADE CONSTRAINTS;

DROP TABLE proveedor CASCADE CONSTRAINTS;

DROP TABLE sucursal CASCADE CONSTRAINTS;

DROP TABLE venta CASCADE CONSTRAINTS;

CREATE TABLE caja (
    numerocaja                NUMBER NOT NULL CHECK (numerocaja >= 0),
    codsucursal               NUMBER NOT NULL CHECK (codsucursal >= 0),
    cajero_idempleado	      NUMBER NOT NULL CHECK (cajero_idempleado >= 0)
);

ALTER TABLE caja ADD CONSTRAINT caja_pk PRIMARY KEY ( numerocaja,
						      codsucursal);

CREATE TABLE cajero (
    idempleado    NUMBER NOT NULL CHECK (idempleado >= 0), 
    jefe	      NUMBER NOT NULL CHECK (jefe >= 0),
    jefe_sucursal NUMBER NOT NULL CHECK (jefe_sucursal >= 0),
    codsucursal   NUMBER NOT NULL CHECK (codsucursal >= 0)
);

ALTER TABLE cajero ADD CONSTRAINT cajero_pk PRIMARY KEY ( codsucursal,
                                                          idempleado );


CREATE TABLE categoria (
    codcategoria           NUMBER NOT NULL CHECK (codcategoria >= 0),
    descripcioncategoria   VARCHAR2(20) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( codcategoria );

CREATE TABLE cliente (
    idcliente            NUMBER NOT NULL CHECK (idcliente >= 0),
    nombreusuario        VARCHAR2(20 CHAR) NOT NULL, 
    direccioncliente     VARCHAR2(20 CHAR) NOT NULL,
    contrasena           VARCHAR2(25) NOT NULL CHECK (LENGTH(contrasena)>5),
    distanciadomicilio   NUMBER NOT NULL CHECK (distanciadomicilio >= 0),
    edadcliente          NUMBER NOT NULL CHECK (edadcliente >= 0),
    nombrecompleto       VARCHAR2(30 CHAR) NOT NULL CHECK ( nombrecompleto LIKE ('[[:ALPHA:]]+')), --TEXTO
    telefonocliente      NUMBER NOT NULL CHECK (LENGTH(telefonocliente)>7 AND telefonocliente >= 0)
);


ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( idcliente );

CREATE TABLE compraxsucursal (
    idcompra                   NUMBER NOT NULL CHECK (idcompra >= 0),
    sucursal_codsucursal       NUMBER NOT NULL CHECK (sucursal_codsucursal >= 0),
    cantidadprodductoscompra   NUMBER NOT NULL CHECK (cantidadprodductoscompra >= 0),
    proveedor_codproveedor     NUMBER NOT NULL CHECK (proveedor_codproveedor >= 0),
    preciototal                NUMBER NOT NULL CHECK (preciototal >=0)
);

ALTER TABLE compraxsucursal ADD CONSTRAINT compraxsucursal_pk PRIMARY KEY ( idcompra, sucursal_codsucursal,
                                                                            proveedor_codproveedor );

CREATE TABLE domiciliario (
    idempleado    	NUMBER NOT NULL CHECK (idempleado >= 0),
    codsucursal   	NUMBER NOT NULL CHECK (codsucursal >= 0),
    jefe	    	NUMBER NOT NULL CHECK (jefe >= 0),
    jefe_sucursal	NUMBER NOT NULL CHECK (jefe_sucursal >= 0)
);

ALTER TABLE domiciliario ADD CONSTRAINT domiciliario_pk PRIMARY KEY ( codsucursal,
                                                                      idempleado );


CREATE TABLE domicilio (
    venta_codventa               NUMBER NOT NULL CHECK (venta_codventa >= 0),
    venta_cliente_idcliente      NUMBER NOT NULL CHECK (venta_cliente_idcliente >= 0),
    entregado                    CHAR(1) NOT NULL CHECK (entregado in ('T', 'F')),
    fecha_de_entrega             TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    fecha_de_entregado           TIMESTAMP WITH LOCAL TIME ZONE,
    venta_caja_numerocaja        NUMBER NOT NULL CHECK (venta_caja_numerocaja >= 0),
    domiciliario_idempleado      NUMBER NOT NULL CHECK (domiciliario_idempleado >= 0),
    venta_sucursal_codsucursal   NUMBER NOT NULL CHECK (venta_sucursal_codsucursal >= 0)
);

ALTER TABLE domicilio
    ADD CONSTRAINT domicilio_pk PRIMARY KEY ( venta_cliente_idcliente,
                                              venta_codventa,
                                              venta_caja_numerocaja,
                                              venta_sucursal_codsucursal );

CREATE TABLE empleado (
    idempleado             NUMBER NOT NULL CHECK (idempleado >= 0),
    sucursal_codsucursal   NUMBER NOT NULL CHECK (sucursal_codsucursal >= 0),
    nombreempleado         VARCHAR2(20 CHAR) NOT NULL CHECK ( nombreempleado LIKE ('[[:ALPHA:]]+')),--TEXTO
    direccionempleado      VARCHAR2(10 CHAR) NOT NULL,
    telefonoempleado       NUMBER NOT NULL CHECK (LENGTH(telefonoempleado)>7 AND telefonoempleado >= 0),
    cargo                  VARCHAR2(12 CHAR) NOT NULL  CHECK (cargo in ('cajero', 'jefe', 'domiciliario'))
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( sucursal_codsucursal,
                                                              idempleado );

CREATE TABLE jefe (
    idempleado    NUMBER NOT NULL CHECK (idempleado >= 0),
    codsucursal   NUMBER NOT NULL CHECK (codsucursal >= 0)
);

ALTER TABLE jefe ADD CONSTRAINT jefe_pk PRIMARY KEY ( codsucursal,
                                                      idempleado );


CREATE TABLE marca (
    codmarca           NUMBER NOT NULL CHECK (codmarca >= 0),
    descripcionmarca   VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE marca ADD CONSTRAINT marca_pk PRIMARY KEY ( codmarca );

CREATE TABLE producto (
    codproducto              NUMBER NOT NULL CHECK (codproducto >= 0),
    categoria_codcategoria   NUMBER NOT NULL CHECK (categoria_codcategoria >= 0),
    marca_codmarca           NUMBER NOT NULL CHECK (marca_codmarca >= 0),
    descripcionproducto      VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( codproducto );

CREATE TABLE prodxcompra (
    producto_codproducto                     NUMBER NOT NULL CHECK (producto_codproducto >= 0),
    codcategoria                             NUMBER NOT NULL CHECK (codcategoria >= 0),
    codmarca                                 NUMBER NOT NULL CHECK (codmarca >= 0),
    preciocompra                             NUMBER NOT NULL CHECK (preciocompra >= 0),
    compraxsucursal_codsucursal              NUMBER NOT NULL CHECK (compraxsucursal_codsucursal >= 0), 
    compraxsucursal_proveedor_codproveedor   NUMBER NOT NULL CHECK (compraxsucursal_proveedor_codproveedor >= 0),
    compraxsucursal_idcompra                 NUMBER NOT NULL CHECK (compraxsucursal_idcompra >= 0)
);

ALTER TABLE prodxcompra
    ADD CONSTRAINT prodxcompra_pk PRIMARY KEY ( codcategoria,
                                                codmarca,
                                                producto_codproducto );

CREATE TABLE prodxsucursal (
    producto_codproducto           NUMBER NOT NULL CHECK (producto_codproducto >= 0),
    sucursal_codsucursal           NUMBER NOT NULL CHECK (sucursal_codsucursal >= 0),
    cantidadprodductosinventario   NUMBER NOT NULL CHECK (cantidadprodductosinventario >= 0),
    precioventa                    NUMBER NOT NULL ,
    precioespecial                 NUMBER NOT NULL ,
    oferta                         CHAR(1) CHECK (oferta in ('T', 'F')),
    CONSTRAINT CHK_precioventa CHECK ((precioventa >= 0) AND (oferta = 'F')),
    CONSTRAINT CHK_precioespecial CHECK ((precioespecial >= 0) AND (oferta = 'T'))
);

ALTER TABLE prodxsucursal ADD CONSTRAINT prodxsucursal_pk PRIMARY KEY ( producto_codproducto );

CREATE TABLE prodxventa (
    prodxsucursal_codproducto   NUMBER NOT NULL CHECK (prodxsucursal_codproducto >= 0),
    venta_codventa              NUMBER NOT NULL CHECK (venta_codventa >= 0),
    venta_cliente_idcliente     NUMBER NOT NULL CHECK (venta_cliente_idcliente >= 0),
    cantidadprodductosventa     NUMBER NOT NULL CHECK (cantidadprodductosventa >= 0),
    subtotal                    NUMBER NOT NULL CHECK (subtotal >= 0),
    venta_numerocaja            NUMBER NOT NULL CHECK (venta_numerocaja >= 0),
    venta_codsucursal           NUMBER NOT NULL CHECK (venta_codsucursal >= 0)
);

ALTER TABLE prodxventa
    ADD CONSTRAINT prodxventa_pk PRIMARY KEY ( prodxsucursal_codproducto,
                                               venta_cliente_idcliente,
                                               venta_codventa,
                                               venta_numerocaja,
                                               venta_codsucursal );

CREATE TABLE proveedor (
    codproveedor        NUMBER NOT NULL CHECK (codproveedor >= 0),
    nombreproveedor     VARCHAR2(20 CHAR) NOT NULL,
    telefonoproveedor   NUMBER NOT NULL CHECK (LENGTH (telefonoproveedor)>7 AND telefonoproveedor >= 0)
);

ALTER TABLE proveedor ADD CONSTRAINT proveedor_pk PRIMARY KEY ( codproveedor );

CREATE TABLE sucursal (
    codsucursal   NUMBER NOT NULL CHECK (codsucursal >= 0),
    direccion     VARCHAR2(20 CHAR) NOT NULL,
    rango         NUMBER NOT NULL CHECK (rango >= 0)
);

ALTER TABLE sucursal ADD CONSTRAINT sucursal_pk PRIMARY KEY ( codsucursal );

CREATE TABLE venta (
    codventa               NUMBER NOT NULL  CHECK (codventa >= 0),
    cliente_idcliente      NUMBER NOT NULL  CHECK (cliente_idcliente >= 0),
    metodo_de_pago         VARCHAR2(10 CHAR) NOT NULL,
    fechaventa             TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    tipoventa              VARCHAR2(6 CHAR) NOT NULL CHECK (tipoventa in ('online', 'fisica')),
    caja_numerocaja        NUMBER NOT NULL  CHECK (caja_numerocaja >= 0),
    totalventa             NUMBER NOT NULL  CHECK (totalventa >= 0),
    caja_codsucursal	   NUMBER NOT NULL CHECK (caja_codsucursal >= 0),
    CONSTRAINT CHK_metodo_pago CHECK (((tipoventa = 'online') AND metodo_de_pago in ('tarjeta_credito', 'tarjeta_debito', 'pse')) 
                                OR((tipoventa = 'fisica') AND metodo_de_pago in ('tarjeta_credito', 'tarjeta_debito', 'pse', 'efectivo')))
);


ALTER TABLE venta
    ADD CONSTRAINT venta_pk PRIMARY KEY ( cliente_idcliente,
                                          codventa,
                                          caja_numerocaja,
                                          caja_codsucursal );


ALTER TABLE caja
    ADD CONSTRAINT caja_cajero_fk FOREIGN KEY ( codsucursal,
                                                    cajero_idempleado )
        REFERENCES cajero ( codsucursal,
                              idempleado );


ALTER TABLE cajero
    ADD CONSTRAINT cajero_empleado_fk FOREIGN KEY ( codsucursal,
                                                    idempleado )
        REFERENCES empleado ( sucursal_codsucursal,
                              idempleado );
                              
ALTER TABLE cajero
    ADD CONSTRAINT cajero_jefe_fk FOREIGN KEY ( jefe_sucursal,
                                                    jefe )
        REFERENCES jefe ( codsucursal,
                              idempleado);


ALTER TABLE compraxsucursal
    ADD CONSTRAINT compraxsucursal_proveedor_fk FOREIGN KEY ( proveedor_codproveedor )
        REFERENCES proveedor ( codproveedor );

ALTER TABLE compraxsucursal
    ADD CONSTRAINT compraxsucursal_sucursal_fk FOREIGN KEY ( sucursal_codsucursal )
        REFERENCES sucursal ( codsucursal );

ALTER TABLE domiciliario
    ADD CONSTRAINT domiciliario_empleado_fk FOREIGN KEY ( codsucursal,
                                                          idempleado )
        REFERENCES empleado ( sucursal_codsucursal,
                              idempleado );


ALTER TABLE domiciliario
    ADD CONSTRAINT domiciliario_jefe_fk FOREIGN KEY ( jefe_sucursal,
                                                    jefe )
        REFERENCES jefe ( codsucursal,
                              idempleado);

ALTER TABLE domicilio
    ADD CONSTRAINT domicilio_domiciliario_fk FOREIGN KEY ( domiciliario_idempleado,
                               venta_sucursal_codsucursal )
        REFERENCES domiciliario ( idempleado, codsucursal );


ALTER TABLE domicilio
    ADD CONSTRAINT domicilio_venta_fk FOREIGN KEY ( venta_cliente_idcliente,
                                                    venta_codventa,
                                                    venta_caja_numerocaja,
                                                    venta_sucursal_codsucursal )
        REFERENCES venta ( cliente_idcliente,
                           codventa,
                           caja_numerocaja,
                           caja_codsucursal );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_sucursal_fk FOREIGN KEY ( sucursal_codsucursal )
        REFERENCES sucursal ( codsucursal );

ALTER TABLE jefe
    ADD CONSTRAINT jefe_empleado_fk FOREIGN KEY ( codsucursal,
                                                  idempleado )
        REFERENCES empleado ( sucursal_codsucursal,
                              idempleado );

ALTER TABLE producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( categoria_codcategoria )
        REFERENCES categoria ( codcategoria );

ALTER TABLE producto
    ADD CONSTRAINT producto_marca_fk FOREIGN KEY ( marca_codmarca )
        REFERENCES marca ( codmarca );

ALTER TABLE prodxcompra
    ADD CONSTRAINT prodxcompra_compraxsucursal_fk FOREIGN KEY ( compraxsucursal_codsucursal,
                                                                compraxsucursal_proveedor_codproveedor, 
                                                                compraxsucursal_idcompra)
        REFERENCES compraxsucursal ( sucursal_codsucursal,
                                     proveedor_codproveedor,
                                     idcompra);

ALTER TABLE prodxcompra
    ADD CONSTRAINT prodxcompra_producto_fk FOREIGN KEY ( producto_codproducto )
        REFERENCES producto ( codproducto );

ALTER TABLE prodxsucursal
    ADD CONSTRAINT prodxsucursal_producto_fk FOREIGN KEY ( producto_codproducto )
        REFERENCES producto ( codproducto );

ALTER TABLE prodxsucursal
    ADD CONSTRAINT prodxsucursal_sucursal_fk FOREIGN KEY ( sucursal_codsucursal )
        REFERENCES sucursal ( codsucursal );

ALTER TABLE prodxventa
    ADD CONSTRAINT prodxventa_prodxsucursal_fk FOREIGN KEY ( prodxsucursal_codproducto )
        REFERENCES prodxsucursal ( producto_codproducto );

ALTER TABLE prodxventa
    ADD CONSTRAINT prodxventa_venta_fk FOREIGN KEY ( venta_cliente_idcliente,
                                                     venta_codventa,
                                                     venta_numerocaja,
                                                     venta_codsucursal )
        REFERENCES venta ( cliente_idcliente,
                           codventa,
                           caja_numerocaja,
                           caja_codsucursal );

ALTER TABLE venta
    ADD CONSTRAINT venta_caja_fk FOREIGN KEY ( caja_numerocaja,
                           caja_codsucursal)
        REFERENCES caja ( numerocaja,
              codsucursal );

ALTER TABLE venta
    ADD CONSTRAINT venta_cliente_fk FOREIGN KEY ( cliente_idcliente )
        REFERENCES cliente ( idcliente );

ALTER TABLE venta
    ADD CONSTRAINT venta_sucursal_fk FOREIGN KEY ( caja_codsucursal )
        REFERENCES sucursal ( codsucursal );




-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             35
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
