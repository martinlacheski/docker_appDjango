-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.paises
(
    id_pais serial,
    pais text NOT NULL,
    PRIMARY KEY(id_pais)
);

CREATE TABLE public.provincias
(
    id_provincia serial,
    provincia text NOT NULL,
    id_pais integer NOT NULL,
    PRIMARY KEY(id_provincia)
);

CREATE TABLE public.localidades
(
    id_localidad serial,
    localidad text NOT NULL,
    id_provincia integer NOT NULL,
    PRIMARY KEY(id_localidad)
);

CREATE TABLE public.feriados
(
    id_feriado serial,
    feriado text NOT NULL,
    inamovible date,
    inasistencia boolean NOT NULL,
    computa_extra boolean NOT NULL,
    porcentaje double precision NOT NULL,
    PRIMARY KEY(id_feriado)
);

CREATE TABLE public.calendarios
(
    id_calendario serial,
    anio integer NOT NULL,
    leyenda_anual text,
    PRIMARY KEY(id_calendario)
);

CREATE TABLE public.calendario_feriados
(
    id bigserial,
    id_calendario integer NOT NULL,
    id_feriado integer NOT NULL,
    fecha date,
    PRIMARY KEY(id)
);

CREATE TABLE public.empresas
(
    id_empresa serial,
    id_localidad integer NOT NULL,
    razon_social text NOT NULL,
    cuit character varying(15),
    telefonos text,
    web text,
    PRIMARY KEY(id_empresa)
);

CREATE TABLE public.sucursales
(
    id_sucursal serial,
    id_empresa integer NOT NULL,
    id_localidad integer NOT NULL,
    sucursal text NOT NULL,
    direccion text,
    telefonos text,
    PRIMARY KEY(id_sucursal)
);

CREATE TABLE public.sectores
(
    id_sector serial,
    sector text NOT NULL,
    id_empleado_jefe integer NOT NULL,
    horario_notif time without time zone,
    PRIMARY KEY(id_sector)
);

CREATE TABLE public.sectores_sucursales
(
    id serial,
    id_sucursal integer NOT NULL,
    id_sector integer NOT NULL,
    id_empleado_jefe integer NOT NULL,
    horario_notif time without time zone,
    PRIMARY KEY(id)
);

CREATE TABLE public.sexos
(
    id_sexo serial,
    sexo character varying(20) NOT NULL,
    PRIMARY KEY(id_sexo)
);

CREATE TABLE public.personas
(
    id_persona serial,
    apellido text NOT NULL,
    nombres text NOT NULL,
    id_tipo_doc integer NOT NULL,
    nrodoc character varying(20) NOT NULL,
    id_sexo integer NOT NULL,
    fecha_nac date,
    id_localidad integer NOT NULL,
    direccion text NOT NULL,
    email text,
    telefono text,
    PRIMARY KEY(id_persona)
);

CREATE TABLE public.tipos_doc
(
    id_tipo_doc serial,
    tipo_doc text NOT NULL,
    PRIMARY KEY(id_tipo_doc)
);

CREATE TABLE public.estados
(
    id_estado serial,
    estado text NOT NULL,
    PRIMARY KEY(id_estado)
);

CREATE TABLE public.tarjetas
(
    id_tarjeta serial NOT NULL,
    tarjeta text NOT NULL,
    codigo_tarjeta text,
	PRIMARY KEY(id_tarjeta)
);

CREATE TABLE public.visitas
(
    id_visita serial,
    apellido text NOT NULL,
    nombres text NOT NULL,
    id_tipo_doc integer NOT NULL,
    nro_doc character varying(20),
    id_sexo integer NOT NULL,
    empresa text,
    puesto text,
    fecha_ingreso date NOT NULL,
    id_sucursal integer NOT NULL,
    id_sector integer NOT NULL,
    motivo text,
    pertenencias text,
    id_tarjeta integer NOT NULL,
    PRIMARY KEY(id_visita)
);

CREATE TABLE public.tipos_empleados
(
    id_tipo_empleado serial,
    tipo_empleado character varying(30) NOT NULL,
    PRIMARY KEY(id_tipo_empleado)
);

CREATE TABLE public.turnos
(
    id_turno serial,
    id_presentismo integer NOT NULL,
    turno character varying(30) NOT NULL,
    cant_hs time without time zone NOT NULL,
    porcentaje double precision,
    estricto boolean NOT NULL,
    PRIMARY KEY(id_turno)
);

CREATE TABLE public.presentismos
(
    id_presentismo serial,
    presentismo character varying(30) NOT NULL,
    cant_tardanza integer NOT NULL,
    PRIMARY KEY(id_presentismo)
);

CREATE TABLE public.turnos_dias
(
    id_turno_dia serial,
    id_turno integer NOT NULL,
    dia_semana integer NOT NULL,
    entrada time without time zone NOT NULL,
    salida time without time zone NOT NULL,
    PRIMARY KEY(id_turno_dia)
);

CREATE TABLE public.empleados
(
    id_empleado serial,
    id_tipo_empleado integer NOT NULL,
    id_estado integer NOT NULL,
    id_persona integer NOT NULL,
    id_sucursal integer NOT NULL,
    id_sector integer NOT NULL,
    id_puesto integer NOT NULL,
    fecha_ingreso date NOT NULL,
    computar_hs_extras boolean NOT NULL,
    email_tardanza boolean NOT NULL,
    whatapps_tardanza boolean NOT NULL,
    incluir_reportes boolean NOT NULL,
    id_turno integer NOT NULL,
    cant_hs time without time zone,
    id_tarjeta integer NOT NULL,
    PRIMARY KEY(id_empleado)
);

CREATE TABLE public.puestos
(
    id_puesto serial,
    puesto text NOT NULL,
    PRIMARY KEY(id_puesto)
);

CREATE TABLE public.control_proceso
(
    id bigserial,
    fecha date NOT NULL,
    proceso_ok boolean NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE public.motivos
(
    id_motivo serial,
    motivo character varying(30) NOT NULL,
    detalle text,
    dia_trabajado boolean NOT NULL,
    max_mes integer,
    max_anio integer,
    PRIMARY KEY(id_motivo)
);

CREATE TABLE public.comprobantes
(
    id_comprobante serial,
    comprobante text NOT NULL,
    PRIMARY KEY(id_comprobante)
);

CREATE TABLE public.licencias
(
    id_licencia serial,
    id_empleado integer NOT NULL,
    desde date NOT NULL,
    hasta date NOT NULL,
    id_motivo integer NOT NULL,
    id_comprobante integer NOT NULL,
    comprobante text,
    observaciones text,
    PRIMARY KEY(id_licencia)
);

CREATE TABLE public.marcas
(
    id_marca bigserial,
    id_empleado integer NOT NULL,
    entrada timestamp without time zone,
    salida timestamp without time zone,
    marcadas time without time zone,
    proyectadas time without time zone,
    reales_turno time without time zone,
    descanso time without time zone,
    inconsistencia boolean NOT NULL,
    origen_marca character varying(30),
    id_motivo integer NOT NULL,
    observaciones text,
    PRIMARY KEY(id_marca)
);

CREATE TABLE public.calculo_mensual
(
    id_calculo serial,
    fecha timestamp without time zone NOT NULL,
    mes_anio date NOT NULL,
    PRIMARY KEY(id_calculo)
);

CREATE TABLE public.det_calculo_mensual
(
    id bigserial,
    id_turno integer NOT NULL,
    id_empleado integer NOT NULL,
    id_marca integer NOT NULL,
    cant_tarde integer,
    id_calculo_mensual integer NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE public.relojes
(
    id_reloj serial,
    marca character varying(30) NOT NULL,
    modelo character varying(30) NOT NULL,
    id_sucursal integer NOT NULL,
    id_sector integer NOT NULL,
    ubicacion text NOT NULL,
    ip_reloj character varying(100) NOT NULL,
    "user" character varying(30),
    password character varying(30),
    PRIMARY KEY(id_reloj)
);

ALTER TABLE public.calendario_feriados
    ADD FOREIGN KEY (id_feriado)
    REFERENCES public.feriados(id_feriado);


ALTER TABLE public.calendario_feriados
    ADD FOREIGN KEY (id_calendario)
    REFERENCES public.calendarios(id_calendario);


ALTER TABLE public.provincias
    ADD FOREIGN KEY (id_pais)
    REFERENCES public.paises(id_pais);


ALTER TABLE public.localidades
    ADD FOREIGN KEY (id_provincia)
    REFERENCES public.provincias(id_provincia);


ALTER TABLE public.empresas
    ADD FOREIGN KEY (id_localidad)
    REFERENCES public.localidades(id_localidad);


ALTER TABLE public.sucursales
    ADD FOREIGN KEY (id_localidad)
    REFERENCES public.localidades(id_localidad);


ALTER TABLE public.sucursales
    ADD FOREIGN KEY (id_empresa)
    REFERENCES public.empresas(id_empresa);


ALTER TABLE public.sectores_sucursales
    ADD FOREIGN KEY (id_sucursal)
    REFERENCES public.sucursales(id_sucursal);


ALTER TABLE public.sectores_sucursales
    ADD FOREIGN KEY (id_sector)
    REFERENCES public.sectores(id_sector);


ALTER TABLE public.personas
    ADD FOREIGN KEY (id_tipo_doc)
    REFERENCES public.tipos_doc(id_tipo_doc);


ALTER TABLE public.personas
    ADD FOREIGN KEY (id_sexo)
    REFERENCES public.sexos(id_sexo);


ALTER TABLE public.visitas
    ADD FOREIGN KEY (id_tipo_doc)
    REFERENCES public.tipos_doc(id_tipo_doc);


ALTER TABLE public.visitas
    ADD FOREIGN KEY (id_sexo)
    REFERENCES public.sexos(id_sexo);


ALTER TABLE public.visitas
    ADD FOREIGN KEY (id_sucursal)
    REFERENCES public.sucursales(id_sucursal);


ALTER TABLE public.visitas
    ADD FOREIGN KEY (id_sector)
    REFERENCES public.sectores(id_sector);


ALTER TABLE public.visitas
    ADD FOREIGN KEY (id_tarjeta)
    REFERENCES public.tarjetas(id_tarjeta);


ALTER TABLE public.turnos
    ADD FOREIGN KEY (id_presentismo)
    REFERENCES public.presentismos(id_presentismo);


ALTER TABLE public.turnos_dias
    ADD FOREIGN KEY (id_turno)
    REFERENCES public.turnos(id_turno);


ALTER TABLE public.empleados
    ADD FOREIGN KEY (id_tipo_empleado)
    REFERENCES public.tipos_empleados(id_tipo_empleado);


ALTER TABLE public.empleados
    ADD FOREIGN KEY (id_estado)
    REFERENCES public.estados(id_estado);


ALTER TABLE public.empleados
    ADD FOREIGN KEY (id_persona)
    REFERENCES public.personas(id_persona);


ALTER TABLE public.empleados
    ADD FOREIGN KEY (id_sucursal)
    REFERENCES public.sucursales(id_sucursal);


ALTER TABLE public.empleados
    ADD FOREIGN KEY (id_sector)
    REFERENCES public.sectores(id_sector);


ALTER TABLE public.empleados
    ADD FOREIGN KEY (id_puesto)
    REFERENCES public.puestos(id_puesto);


ALTER TABLE public.sectores
    ADD FOREIGN KEY (id_empleado_jefe)
    REFERENCES public.empleados(id_empleado);


ALTER TABLE public.sectores_sucursales
    ADD FOREIGN KEY (id_empleado_jefe)
    REFERENCES public.empleados(id_empleado);


ALTER TABLE public.licencias
    ADD FOREIGN KEY (id_empleado)
    REFERENCES public.empleados(id_empleado);


ALTER TABLE public.licencias
    ADD FOREIGN KEY (id_motivo)
    REFERENCES public.motivos(id_motivo);


ALTER TABLE public.licencias
    ADD FOREIGN KEY (id_comprobante)
    REFERENCES public.comprobantes(id_comprobante);


ALTER TABLE public.marcas
    ADD FOREIGN KEY (id_empleado)
    REFERENCES public.empleados(id_empleado);


ALTER TABLE public.marcas
    ADD FOREIGN KEY (id_motivo)
    REFERENCES public.motivos(id_motivo);


ALTER TABLE public.det_calculo_mensual
    ADD FOREIGN KEY (id_turno)
    REFERENCES public.turnos(id_turno);


ALTER TABLE public.det_calculo_mensual
    ADD FOREIGN KEY (id_empleado)
    REFERENCES public.empleados(id_empleado);


ALTER TABLE public.det_calculo_mensual
    ADD FOREIGN KEY (id_marca)
    REFERENCES public.marcas(id_marca);


ALTER TABLE public.det_calculo_mensual
    ADD FOREIGN KEY (id_calculo_mensual)
    REFERENCES public.calculo_mensual(id_calculo);


ALTER TABLE public.relojes
    ADD FOREIGN KEY (id_sucursal)
    REFERENCES public.sucursales(id_sucursal);


ALTER TABLE public.relojes
    ADD FOREIGN KEY (id_sector)
    REFERENCES public.sectores(id_sector);

END;