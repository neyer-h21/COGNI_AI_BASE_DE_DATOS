
CREATE TABLE asignacion_proyecto
(
  codigo_asignacion    int      NOT NULL,
  fecha_asignacion     datetime NOT NULL,
  codigo_proyecto      int      NOT NULL,
  codigo_desarrollador int      NOT NULL,
  CONSTRAINT PK_asignacion_proyecto PRIMARY KEY (codigo_asignacion)
)
GO

CREATE TABLE asignacion_tarea
(
  codigo_asignacion_tarea int      NOT NULL,
  fecha_asignacion        datetime NOT NULL,
  codigo_tarea            int      NOT NULL,
  codigo_asignacion       int      NOT NULL,
  CONSTRAINT PK_asignacion_tarea PRIMARY KEY (codigo_asignacion_tarea)
)
GO

CREATE TABLE clave_api
(
  codigo_clave_api          int          NOT NULL,
  nombre_clave              varchar(50)  NOT NULL,
  hash_clave                varchar(255) NOT NULL,
  ultimos_cuatro_caracteres char(4)      NOT NULL,
  estado                    varchar(20)  NOT NULL,
  fecha_creacion            datetime     NOT NULL,
  fecha_ultimo_uso          datetime    ,
  fecha_revocacion          datetime    ,
  codigo_empresa            int          NOT NULL,
  codigo_admin_creador      int          NOT NULL,
  CONSTRAINT PK_clave_api PRIMARY KEY (codigo_clave_api)
)
GO

CREATE TABLE conexion_credencial
(
  codigo_credencial int         NOT NULL,
  nombre_proveedor  varchar(50) NOT NULL,
  fecha_conexion    datetime    NOT NULL,
  codigo_usuario    int         NOT NULL,
  CONSTRAINT PK_conexion_credencial PRIMARY KEY (codigo_credencial)
)
GO

CREATE TABLE empresa
(
  codigo_empresa            int           NOT NULL,
  nombre_empresa            nvarchar(100) NOT NULL,
  razon_social              nvarchar(150) NOT NULL,
  ruc                       varchar(20)   NOT NULL,
  estado                    varhcar(20)   NOT NULL,
  licencias_totales         int           NOT NULL,
  fecha_creacion            datetime      NOT NULL,
  acepto_terminos           bit           NOT NULL,
  fecha_aceptacion_terminos datetime      NOT NULL,
  CONSTRAINT PK_empresa PRIMARY KEY (codigo_empresa)
)
GO

ALTER TABLE empresa
  ADD CONSTRAINT UQ_empresa_ruc UNIQUE (ruc)
GO

CREATE TABLE integracion_proyecto_externo
(
  codigo_integracion   int          NOT NULL,
  plataforma_proveedor varchar(50)  NOT NULL,
  url_base             varchar(255) NOT NULL,
  hash_token_externo   varchar(255) NOT NULL,
  estado               varchar(20)  NOT NULL,
  fecha_configuracion  datetime     NOT NULL,
  codigo_empresa       int          NOT NULL,
  CONSTRAINT PK_integracion_proyecto_externo PRIMARY KEY (codigo_integracion)
)
GO

CREATE TABLE invitacion_equipo
(
  codigo_invitacion int          NOT NULL,
  token_invitacion  varchar(100) NOT NULL,
  estado            varchar(20)  NOT NULL,
  fecha_expiracion  datetime     NOT NULL,
  fecha_creacion    datetime     NOT NULL,
  correo_invitado   varchar(100) NOT NULL,
  codigo_proyecto   int          NOT NULL,
  CONSTRAINT PK_invitacion_equipo PRIMARY KEY (codigo_invitacion)
)
GO

ALTER TABLE invitacion_equipo
  ADD CONSTRAINT UQ_invitacion_equipo_token_invitacion UNIQUE (token_invitacion)
GO

CREATE TABLE metodo_pago_usuario
(
  codigo_metodo_pago     int          NOT NULL,
  token_pasarela         varchar(255) NOT NULL,
  ultimos_cuatro_digitos char(4)      NOT NULL,
  marca_tarjeta          varchar(20)  NOT NULL,
  es_predeterminado      bit          NOT NULL,
  fecha_agregado         datetime     NOT NULL,
  codigo_usuario         int          NOT NULL,
  CONSTRAINT PK_metodo_pago_usuario PRIMARY KEY (codigo_metodo_pago)
)
GO

ALTER TABLE metodo_pago_usuario
  ADD CONSTRAINT UQ_metodo_pago_usuario_token_pasarela UNIQUE (token_pasarela)
GO

CREATE TABLE plan_suscripcion
(
  codigo_plan                 int           NOT NULL,
  nombre_plan                 varchar(50)   NOT NULL,
  tipo_plan                   varchar(20)   NOT NULL,
  usuarios_minimos_requeridos int           NOT NULL,
  precio_mensual              decimal(10,2) NOT NULL,
  precio_anual                decimal(10,2) NOT NULL,
  esta_activo                 bit           NOT NULL,
  CONSTRAINT PK_plan_suscripcion PRIMARY KEY (codigo_plan)
)
GO

CREATE TABLE proyecto
(
  codigo_proyecto       int           NOT NULL,
  nombre_proyecto       nvarchar(100) NOT NULL,
  codigo_empresa        int           NOT NULL,
  codigo_lider_proyecto int           NOT NULL,
  CONSTRAINT PK_proyecto PRIMARY KEY (codigo_proyecto)
)
GO

CREATE TABLE suscripcion_empresa
(
  codigo_suscripcion_empresa int         NOT NULL,
  ciclo                      varchar(10) NOT NULL,
  fecha_creacion             datetime    NOT NULL,
  codigo_empresa             int         NOT NULL,
  codigo_plan                int         NOT NULL,
  CONSTRAINT PK_suscripcion_empresa PRIMARY KEY (codigo_suscripcion_empresa)
)
GO

CREATE TABLE suscripcion_usuario
(
  codigo_suscripcion int         NOT NULL,
  ciclo              varchar(10) NOT NULL,
  estado             varchar(20) NOT NULL,
  fin_periodo_actual datetime    NOT NULL,
  codigo_plan        int         NOT NULL,
  codigo_usuario     int         NOT NULL,
  CONSTRAINT PK_suscripcion_usuario PRIMARY KEY (codigo_suscripcion)
)
GO

CREATE TABLE tarea_sprint
(
  codigo_tarea    int           NOT NULL,
  titulo          nvarchar(150) NOT NULL,
  descripcion     nvarchar     ,
  tipo            varchar(20)   NOT NULL,
  codigo_proyecto int           NOT NULL,
  CONSTRAINT PK_tarea_sprint PRIMARY KEY (codigo_tarea)
)
GO

CREATE TABLE transaccion_pago
(
  codigo_transaccion  int           NOT NULL,
  monto               decimal(10,2) NOT NULL,
  moneda              char(3)       NOT NULL,
  estado              varchar(20)   NOT NULL,
  url_recibo_pasarela varchar(500) ,
  fecha_procesamiento datetime      NOT NULL,
  codigo_metodo_pago  int           NOT NULL,
  codigo_suscripcion  int           NOT NULL,
  CONSTRAINT PK_transaccion_pago PRIMARY KEY (codigo_transaccion)
)
GO

CREATE TABLE transaccion_pago_empresa
(
  codigo_transaccion_empresa int           NOT NULL,
  monto                      decimal(10,2) NOT NULL,
  moneda                     char(3)       NOT NULL,
  estado                     varchar(20)   NOT NULL,
  fecha_procesamiento        datetime      NOT NULL,
  url_descarga_pdf           varchar(500) ,
  codigo_empresa             int           NOT NULL,
  codigo_suscripcion_empresa int           NOT NULL,
  CONSTRAINT PK_transaccion_pago_empresa PRIMARY KEY (codigo_transaccion_empresa)
)
GO

CREATE TABLE usuario
(
  codigo_usuario      int          NOT NULL,
  primer_nombre       nvarchar(50) NOT NULL,
  apellido_materno    nvarchar(50),
  apellido_paterno    nvarchar(50) NOT NULL,
  correo_electronico  varchar(100) NOT NULL,
  hash_contrasena     varchar(255),
  tipo_usuario        varchar(20)  NOT NULL,
  estado_cuenta       varchar(20)  NOT NULL,
  fecha_creacion      datetime     NOT NULL,
  fecha_actualizacion datetime    ,
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
  codigo_usuario            int      NOT NULL,
  acepto_terminos_servicio  bit      NOT NULL,
  fecha_aceptacion_terminos datetime NOT NULL,
  CONSTRAINT PK_usuario_b2c PRIMARY KEY (codigo_usuario)
)
GO

ALTER TABLE conexion_credencial
  ADD CONSTRAINT FK_usuario_TO_conexion_credencial
    FOREIGN KEY (codigo_usuario)
    REFERENCES usuario (codigo_usuario)
GO

ALTER TABLE proyecto
  ADD CONSTRAINT FK_empresa_TO_proyecto
    FOREIGN KEY (codigo_empresa)
    REFERENCES empresa (codigo_empresa)
GO

ALTER TABLE invitacion_equipo
  ADD CONSTRAINT FK_proyecto_TO_invitacion_equipo
    FOREIGN KEY (codigo_proyecto)
    REFERENCES proyecto (codigo_proyecto)
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

ALTER TABLE integracion_proyecto_externo
  ADD CONSTRAINT FK_empresa_TO_integracion_proyecto_externo
    FOREIGN KEY (codigo_empresa)
    REFERENCES empresa (codigo_empresa)
GO

ALTER TABLE clave_api
  ADD CONSTRAINT FK_empresa_TO_clave_api
    FOREIGN KEY (codigo_empresa)
    REFERENCES empresa (codigo_empresa)
GO

ALTER TABLE clave_api
  ADD CONSTRAINT FK_usuario_b2b_TO_clave_api
    FOREIGN KEY (codigo_admin_creador)
    REFERENCES usuario_b2b (codigo_usuario)
GO

ALTER TABLE transaccion_pago_empresa
  ADD CONSTRAINT FK_empresa_TO_transaccion_pago_empresa
    FOREIGN KEY (codigo_empresa)
    REFERENCES empresa (codigo_empresa)
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
