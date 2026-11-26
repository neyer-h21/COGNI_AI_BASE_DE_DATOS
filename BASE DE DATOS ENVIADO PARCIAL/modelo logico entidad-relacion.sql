
CREATE TABLE asignacion_proyecto
(
  codigo_asignacion     NOT NULL,
  fecha_asignacion     ,
  codigo_proyecto       NOT NULL,
  codigo_desarrollador  NOT NULL,
  CONSTRAINT PK_asignacion_proyecto PRIMARY KEY (codigo_asignacion)
)
GO

CREATE TABLE asignacion_tarea
(
  codigo_asignacion_tarea  NOT NULL,
  fecha_asignacion        ,
  codigo_tarea             NOT NULL,
  codigo_asignacion        NOT NULL,
  CONSTRAINT PK_asignacion_tarea PRIMARY KEY (codigo_asignacion_tarea)
)
GO

CREATE TABLE clave_api
(
  codigo_clave_api           NOT NULL,
  nombre_clave              ,
  hash_clave                ,
  ultimos_cuatro_caracteres ,
  estado                    ,
  fecha_creacion            ,
  fecha_ultimo_uso          ,
  fecha_revocacion          ,
  codigo_empresa             NOT NULL,
  codigo_admin_creador       NOT NULL,
  CONSTRAINT PK_clave_api PRIMARY KEY (codigo_clave_api)
)
GO

CREATE TABLE conexion_credencial
(
  codigo_credencial  NOT NULL,
  nombre_proveedor  ,
  fecha_conexion    ,
  codigo_usuario     NOT NULL,
  CONSTRAINT PK_conexion_credencial PRIMARY KEY (codigo_credencial)
)
GO

CREATE TABLE empresa
(
  codigo_empresa             NOT NULL,
  nombre_empresa            ,
  razon_social              ,
  ruc                       ,
  estado                    ,
  licencias_totales         ,
  fecha_creacion            ,
  acepto_terminos           ,
  fecha_aceptacion_terminos ,
  CONSTRAINT PK_empresa PRIMARY KEY (codigo_empresa)
)
GO

CREATE TABLE integracion_proyecto_externo
(
  codigo_integracion    NOT NULL,
  plataforma_proveedor ,
  url_base             ,
  hash_token_externo   ,
  estado               ,
  fecha_configuracion  ,
  codigo_empresa        NOT NULL,
  CONSTRAINT PK_integracion_proyecto_externo PRIMARY KEY (codigo_integracion)
)
GO

CREATE TABLE invitacion_equipo
(
  codigo_invitacion  NOT NULL,
  token_invitacion  ,
  estado            ,
  fecha_expiracion  ,
  fecha_creacion    ,
  correo_invitado   ,
  codigo_proyecto    NOT NULL,
  CONSTRAINT PK_invitacion_equipo PRIMARY KEY (codigo_invitacion)
)
GO

CREATE TABLE metodo_pago_usuario
(
  codigo_metodo_pago      NOT NULL,
  token_pasarela         ,
  ultimos_cuatro_digitos ,
  marca_tarjeta          ,
  es_predeterminado      ,
  fecha_agregado         ,
  codigo_usuario          NOT NULL,
  CONSTRAINT PK_metodo_pago_usuario PRIMARY KEY (codigo_metodo_pago)
)
GO

CREATE TABLE plan_suscripcion
(
  codigo_plan                  NOT NULL,
  nombre_plan                 ,
  tipo_plan                   ,
  usuarios_minimos_requeridos ,
  precio_mensual              ,
  precio_anual                ,
  esta_activo                 ,
  CONSTRAINT PK_plan_suscripcion PRIMARY KEY (codigo_plan)
)
GO

CREATE TABLE proyecto
(
  codigo_proyecto        NOT NULL,
  nombre_proyecto       ,
  codigo_empresa         NOT NULL,
  codigo_lider_proyecto  NOT NULL,
  CONSTRAINT PK_proyecto PRIMARY KEY (codigo_proyecto)
)
GO

CREATE TABLE suscripcion_empresa
(
  codigo_suscripcion_empresa  NOT NULL,
  ciclo                      ,
  fecha_creacion             ,
  codigo_empresa              NOT NULL,
  codigo_plan                 NOT NULL,
  CONSTRAINT PK_suscripcion_empresa PRIMARY KEY (codigo_suscripcion_empresa)
)
GO

CREATE TABLE suscripcion_usuario
(
  codigo_suscripcion  NOT NULL,
  ciclo              ,
  estado             ,
  fin_periodo_actual ,
  codigo_plan         NOT NULL,
  codigo_usuario      NOT NULL,
  CONSTRAINT PK_suscripcion_usuario PRIMARY KEY (codigo_suscripcion)
)
GO

CREATE TABLE tarea_sprint
(
  codigo_tarea     NOT NULL,
  titulo          ,
  descripcion     ,
  tipo            ,
  codigo_proyecto  NOT NULL,
  CONSTRAINT PK_tarea_sprint PRIMARY KEY (codigo_tarea)
)
GO

CREATE TABLE transaccion_pago
(
  codigo_transaccion   NOT NULL,
  monto               ,
  moneda              ,
  estado              ,
  url_recibo_pasarela ,
  fecha_procesamiento ,
  codigo_metodo_pago   NOT NULL,
  codigo_suscripcion   NOT NULL,
  CONSTRAINT PK_transaccion_pago PRIMARY KEY (codigo_transaccion)
)
GO

CREATE TABLE transaccion_pago_empresa
(
  codigo_transaccion_empresa  NOT NULL,
  monto                      ,
  moneda                     ,
  estado                     ,
  fecha_procesamiento        ,
  url_descarga_pdf           ,
  codigo_empresa              NOT NULL,
  codigo_suscripcion_empresa  NOT NULL,
  CONSTRAINT PK_transaccion_pago_empresa PRIMARY KEY (codigo_transaccion_empresa)
)
GO

CREATE TABLE usuario
(
  codigo_usuario       NOT NULL,
  primer_nombre       ,
  apellido_materno    ,
  apellido_paterno    ,
  correo_electronico  ,
  hash_contrasena     ,
  tipo_usuario        ,
  estado_cuenta       ,
  fecha_creacion      ,
  fecha_actualizacion ,
  CONSTRAINT PK_usuario PRIMARY KEY (codigo_usuario)
)
GO

CREATE TABLE usuario_b2b
(
  codigo_usuario   NOT NULL,
  rol_corporativo ,
  codigo_empresa   NOT NULL,
  CONSTRAINT PK_usuario_b2b PRIMARY KEY (codigo_usuario)
)
GO

CREATE TABLE usuario_b2c
(
  codigo_usuario             NOT NULL,
  acepto_terminos_servicio  ,
  fecha_aceptacion_terminos ,
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
