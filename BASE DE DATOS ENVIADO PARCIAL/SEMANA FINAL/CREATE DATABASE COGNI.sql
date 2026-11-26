CREATE DATABASE COGNI

GO

CREATE TABLE asignacion_proyecto
(
  codigo_asignacion    int       NOT NULL IDENTITY(1,1),
  fecha_asignacion     datetime2 NOT NULL,
  codigo_proyecto      int       NOT NULL,
  codigo_desarrollador int       NOT NULL,
  CONSTRAINT PK_asignacion_proyecto PRIMARY KEY (codigo_asignacion)
)
GO

CREATE TABLE asignacion_tarea
(
  codigo_asignacion_tarea int       NOT NULL IDENTITY(1,1),
  fecha_asignacion        datetime2 NOT NULL,
  codigo_tarea            int       NOT NULL,
  codigo_asignacion       int       NOT NULL,
  CONSTRAINT PK_asignacion_tarea PRIMARY KEY (codigo_asignacion_tarea)
)
GO

CREATE TABLE auditoria_asignacion_forzada
(
  codigo_asignacion_tarea  int           NOT NULL,
  puntaje_fatiga_momento   int           NOT NULL,
  justificacion_riesgo     nvarchar(300) NOT NULL,
  fecha_registro           datetime2     NOT NULL,
  codigo_lider_autorizador int           NOT NULL,
  CONSTRAINT PK_auditoria_asignacion_forzada PRIMARY KEY (codigo_asignacion_tarea)
)
GO

CREATE TABLE empresa
(
  codigo_empresa            int           NOT NULL IDENTITY(1,1),
  nombre_empresa            nvarchar(100) NOT NULL,
  razon_social              nvarchar(150) NOT NULL,
  ruc                       varchar(20)   NOT NULL,
  estado                    varchar(20)   NOT NULL,
  licencias_totales         int           NOT NULL,
  fecha_creacion            datetime2     NOT NULL,
  acepto_terminos           bit           NOT NULL,
  fecha_aceptacion_terminos datetime2     NOT NULL,
  costo_hora_promedio       decimal(10,2) NOT NULL,
  CONSTRAINT PK_empresa PRIMARY KEY (codigo_empresa)
)
GO

ALTER TABLE empresa
  ADD CONSTRAINT UQ_empresa_ruc UNIQUE (ruc)
GO

CREATE TABLE metodo_pago_usuario
(
  codigo_metodo_pago     int          NOT NULL IDENTITY(1,1),
  token_pasarela         varchar(255) NOT NULL,
  ultimos_cuatro_digitos char(4)      NOT NULL,
  marca_tarjeta          varchar(20)  NOT NULL,
  es_predeterminado      bit          NOT NULL,
  fecha_agregado         datetime2    NOT NULL,
  codigo_usuario         int          NOT NULL,
  CONSTRAINT PK_metodo_pago_usuario PRIMARY KEY (codigo_metodo_pago)
)
GO

ALTER TABLE metodo_pago_usuario
  ADD CONSTRAINT UQ_metodo_pago_usuario_token_pasarela UNIQUE (token_pasarela)
GO

CREATE TABLE plan_suscripcion
(
  codigo_plan                 int           NOT NULL IDENTITY(1,1),
  nombre_plan                 varchar(50)   NOT NULL,
  tipo_plan                   varchar(20)   NOT NULL,
  usuarios_minimos_requeridos int           NOT NULL,
  precio_mensual              decimal(10,2) NOT NULL,
  precio_anual                decimal(10,2) NOT NULL,
  esta_activo                 bit           NOT NULL,
  CONSTRAINT PK_plan_suscripcion PRIMARY KEY (codigo_plan)
)
GO

ALTER TABLE plan_suscripcion
  ADD CONSTRAINT UQ_plan_suscripcion_nombre_plan UNIQUE (nombre_plan)
GO

CREATE TABLE proyecto
(
  codigo_proyecto       int           NOT NULL IDENTITY(1,1),
  nombre_proyecto       nvarchar(100) NOT NULL,
  codigo_empresa        int           NOT NULL,
  codigo_lider_proyecto int           NOT NULL,
  CONSTRAINT PK_proyecto PRIMARY KEY (codigo_proyecto)
)
GO

CREATE TABLE suscripcion_empresa
(
  codigo_suscripcion_empresa int         NOT NULL IDENTITY(1,1),
  ciclo                      varchar(10) NOT NULL,
  fecha_creacion             datetime2   NOT NULL,
  estado                     varchar(20) NOT NULL,
  fin_periodo_actual         datetime2   NOT NULL,
  codigo_empresa             int         NOT NULL,
  codigo_plan                int         NOT NULL,
  CONSTRAINT PK_suscripcion_empresa PRIMARY KEY (codigo_suscripcion_empresa)
)
GO

CREATE TABLE suscripcion_usuario
(
  codigo_suscripcion int         NOT NULL IDENTITY(1,1),
  ciclo              varchar(10) NOT NULL,
  estado             varchar(20) NOT NULL,
  fin_periodo_actual datetime2   NOT NULL,
  fecha_creacion     datetime2   NOT NULL,
  codigo_plan        int         NOT NULL,
  codigo_usuario     int         NOT NULL,
  CONSTRAINT PK_suscripcion_usuario PRIMARY KEY (codigo_suscripcion)
)
GO

CREATE TABLE tarea_sprint
(
  codigo_tarea    int           NOT NULL IDENTITY(1,1),
  titulo          nvarchar(150) NOT NULL,
  descripcion     nvarchar(255),
  tipo            varchar(20)   NOT NULL,
  codigo_proyecto int           NOT NULL,
  criticidad      varchar(20)   NOT NULL,
  horas_estimadas decimal(5,2)  NOT NULL,
  CONSTRAINT PK_tarea_sprint PRIMARY KEY (codigo_tarea)
)
GO

CREATE TABLE transaccion_pago
(
  codigo_transaccion  int           NOT NULL IDENTITY(1,1),
  monto               decimal(10,2) NOT NULL,
  moneda              char(3)       NOT NULL,
  estado              varchar(20)   NOT NULL,
  url_recibo_pasarela varchar(500) ,
  fecha_procesamiento datetime2     NOT NULL,
  codigo_metodo_pago  int           NOT NULL,
  codigo_suscripcion  int           NOT NULL,
  CONSTRAINT PK_transaccion_pago PRIMARY KEY (codigo_transaccion)
)
GO

CREATE TABLE transaccion_pago_empresa
(
  codigo_transaccion_empresa int           NOT NULL IDENTITY(1,1),
  monto                      decimal(10,2) NOT NULL,
  moneda                     char(3)       NOT NULL,
  estado                     varchar(20)   NOT NULL,
  fecha_procesamiento        datetime2     NOT NULL,
  url_descarga_pdf           varchar(500) ,
  codigo_suscripcion_empresa int           NOT NULL,
  CONSTRAINT PK_transaccion_pago_empresa PRIMARY KEY (codigo_transaccion_empresa)
)
GO

CREATE TABLE usuario
(
  codigo_usuario      int          NOT NULL IDENTITY(1,1),
  primer_nombre       nvarchar(50) NOT NULL,
  apellido_materno    nvarchar(50),
  apellido_paterno    nvarchar(50) NOT NULL,
  correo_electronico  varchar(100) NOT NULL,
  hash_contrasena     varchar(255) NOT NULL,
  tipo_usuario        varchar(20)  NOT NULL,
  estado_cuenta       varchar(20)  NOT NULL,
  fecha_creacion      datetime2    NOT NULL,
  fecha_actualizacion datetime2   ,
  CONSTRAINT PK_usuario PRIMARY KEY (codigo_usuario)
)
GO

ALTER TABLE usuario
  ADD CONSTRAINT UQ_usuario_correo_electronico UNIQUE (correo_electronico)
GO

CREATE TABLE usuario_b2b
(
  codigo_usuario  int         NOT NULL,
  rol_corporativo varchar(50) NOT NULL,
  codigo_empresa  int         NOT NULL,
  CONSTRAINT PK_usuario_b2b PRIMARY KEY (codigo_usuario)
)
GO

CREATE TABLE usuario_b2c
(
  codigo_usuario            int       NOT NULL,
  acepto_terminos_servicio  bit       NOT NULL,
  fecha_aceptacion_terminos datetime2 NOT NULL,
  CONSTRAINT PK_usuario_b2c PRIMARY KEY (codigo_usuario)
)
GO

ALTER TABLE proyecto
  ADD CONSTRAINT FK_empresa_TO_proyecto
    FOREIGN KEY (codigo_empresa)
    REFERENCES empresa (codigo_empresa)
GO

ALTER TABLE suscripcion_empresa
  ADD CONSTRAINT FK_empresa_TO_suscripcion_empresa
    FOREIGN KEY (codigo_empresa)
    REFERENCES empresa (codigo_empresa)
GO

ALTER TABLE tarea_sprint
  ADD CONSTRAINT FK_proyecto_TO_tarea_sprint
    FOREIGN KEY (codigo_proyecto)
    REFERENCES proyecto (codigo_proyecto)
GO

ALTER TABLE usuario_b2b
  ADD CONSTRAINT FK_usuario_TO_usuario_b2b
    FOREIGN KEY (codigo_usuario)
    REFERENCES usuario (codigo_usuario)
GO

ALTER TABLE asignacion_tarea
  ADD CONSTRAINT FK_tarea_sprint_TO_asignacion_tarea
    FOREIGN KEY (codigo_tarea)
    REFERENCES tarea_sprint (codigo_tarea)
GO

ALTER TABLE usuario_b2b
  ADD CONSTRAINT FK_empresa_TO_usuario_b2b
    FOREIGN KEY (codigo_empresa)
    REFERENCES empresa (codigo_empresa)
GO

ALTER TABLE suscripcion_usuario
  ADD CONSTRAINT FK_plan_suscripcion_TO_suscripcion_usuario
    FOREIGN KEY (codigo_plan)
    REFERENCES plan_suscripcion (codigo_plan)
GO

ALTER TABLE transaccion_pago
  ADD CONSTRAINT FK_suscripcion_usuario_TO_transaccion_pago
    FOREIGN KEY (codigo_suscripcion)
    REFERENCES suscripcion_usuario (codigo_suscripcion)
GO

ALTER TABLE transaccion_pago
  ADD CONSTRAINT FK_metodo_pago_usuario_TO_transaccion_pago
    FOREIGN KEY (codigo_metodo_pago)
    REFERENCES metodo_pago_usuario (codigo_metodo_pago)
GO

ALTER TABLE asignacion_tarea
  ADD CONSTRAINT FK_asignacion_proyecto_TO_asignacion_tarea
    FOREIGN KEY (codigo_asignacion)
    REFERENCES asignacion_proyecto (codigo_asignacion)
GO

ALTER TABLE usuario_b2c
  ADD CONSTRAINT FK_usuario_TO_usuario_b2c
    FOREIGN KEY (codigo_usuario)
    REFERENCES usuario (codigo_usuario)
GO

ALTER TABLE suscripcion_usuario
  ADD CONSTRAINT FK_usuario_b2c_TO_suscripcion_usuario
    FOREIGN KEY (codigo_usuario)
    REFERENCES usuario_b2c (codigo_usuario)
GO

ALTER TABLE metodo_pago_usuario
  ADD CONSTRAINT FK_usuario_b2c_TO_metodo_pago_usuario
    FOREIGN KEY (codigo_usuario)
    REFERENCES usuario_b2c (codigo_usuario)
GO

ALTER TABLE asignacion_proyecto
  ADD CONSTRAINT FK_proyecto_TO_asignacion_proyecto
    FOREIGN KEY (codigo_proyecto)
    REFERENCES proyecto (codigo_proyecto)
GO

ALTER TABLE asignacion_proyecto
  ADD CONSTRAINT FK_usuario_b2b_TO_asignacion_proyecto
    FOREIGN KEY (codigo_desarrollador)
    REFERENCES usuario_b2b (codigo_usuario)
GO

ALTER TABLE proyecto
  ADD CONSTRAINT FK_usuario_b2b_TO_proyecto
    FOREIGN KEY (codigo_lider_proyecto)
    REFERENCES usuario_b2b (codigo_usuario)
GO

ALTER TABLE suscripcion_empresa
  ADD CONSTRAINT FK_plan_suscripcion_TO_suscripcion_empresa
    FOREIGN KEY (codigo_plan)
    REFERENCES plan_suscripcion (codigo_plan)
GO

ALTER TABLE transaccion_pago_empresa
  ADD CONSTRAINT FK_suscripcion_empresa_TO_transaccion_pago_empresa
    FOREIGN KEY (codigo_suscripcion_empresa)
    REFERENCES suscripcion_empresa (codigo_suscripcion_empresa)
GO

ALTER TABLE auditoria_asignacion_forzada
  ADD CONSTRAINT FK_asignacion_tarea_TO_auditoria_asignacion_forzada
    FOREIGN KEY (codigo_asignacion_tarea)
    REFERENCES asignacion_tarea (codigo_asignacion_tarea)
GO

ALTER TABLE auditoria_asignacion_forzada
  ADD CONSTRAINT FK_usuario_b2b_TO_auditoria_asignacion_forzada
    FOREIGN KEY (codigo_lider_autorizador)
    REFERENCES usuario_b2b (codigo_usuario)
GO

CREATE UNIQUE INDEX IDX_asignacion_proyecto
  ON asignacion_proyecto (codigo_proyecto ASC, codigo_desarrollador ASC)
GO

CREATE UNIQUE INDEX IDX_asignacion_tarea
  ON asignacion_tarea (codigo_tarea ASC, codigo_asignacion ASC)
GO
