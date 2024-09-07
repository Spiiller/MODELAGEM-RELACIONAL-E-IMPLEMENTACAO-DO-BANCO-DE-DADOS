-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-03-19 17:05:10 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE mc_class_video CASCADE CONSTRAINTS;

DROP TABLE mc_cliente CASCADE CONSTRAINTS;

DROP TABLE mc_cliente_pf CASCADE CONSTRAINTS;

DROP TABLE mc_cliente_pj CASCADE CONSTRAINTS;

DROP TABLE mc_ctg_produto CASCADE CONSTRAINTS;

DROP TABLE mc_funcionario CASCADE CONSTRAINTS;

DROP TABLE mc_item_pedido CASCADE CONSTRAINTS;

DROP TABLE mc_pedido CASCADE CONSTRAINTS;

DROP TABLE mc_produto CASCADE CONSTRAINTS;

DROP TABLE mc_sac_chamado CASCADE CONSTRAINTS;

DROP TABLE mc_sac_chamado_ajuda CASCADE CONSTRAINTS;

DROP TABLE mc_sac_chamado_reclamacao CASCADE CONSTRAINTS;

DROP TABLE mc_sac_chamado_sugestao CASCADE CONSTRAINTS;

DROP TABLE mc_video_produto CASCADE CONSTRAINTS;

DROP TABLE mc_visualizacao_video CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE mc_class_video (
    cd_class   NUMBER(2) NOT NULL,
    tipo_video VARCHAR2(40) NOT NULL
);

COMMENT ON COLUMN mc_class_video.cd_class IS
    'Código da classificação do vídeo';

COMMENT ON COLUMN mc_class_video.tipo_video IS
    'Descrição do tipo do vídeo ';

ALTER TABLE mc_class_video ADD CONSTRAINT pk_class_video PRIMARY KEY ( cd_class );

CREATE TABLE mc_cliente (
    cd_cliente         NUMBER(7) NOT NULL,
    nm_cliente         VARCHAR2(50) NOT NULL,
    login_cliente      VARCHAR2(20) NOT NULL,
    senha_cliente      VARCHAR2(20) NOT NULL,
    email_cliente      VARCHAR2(20) NOT NULL,
    telefone_cliente   NUMBER(13) NOT NULL,
    status_cliente     CHAR(1) NOT NULL,
    uf_cliente         VARCHAR2(2) NOT NULL,
    cidade_cliente     VARCHAR2(30) NOT NULL,
    logradouro_cliente VARCHAR2(50) NOT NULL,
    cep_cliente        NUMBER(8) NOT NULL
);

ALTER TABLE mc_cliente
    ADD CONSTRAINT arc_1_lov CHECK ( cd_cliente IN ( cliente_pj, cliente_pf ) );

COMMENT ON COLUMN mc_cliente.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN mc_cliente.nm_cliente IS
    'Nome completo do cliente';

COMMENT ON COLUMN mc_cliente.login_cliente IS
    'E-mail pessoal do cliente que permite o acesso à plataforma';

COMMENT ON COLUMN mc_cliente.senha_cliente IS
    'Senha pessoal do cliente que permite o acesso à plataforma';

COMMENT ON COLUMN mc_cliente.email_cliente IS
    'E-mail pessoal do cliente';

COMMENT ON COLUMN mc_cliente.telefone_cliente IS
    'Telefone pessoal do cliente';

COMMENT ON COLUMN mc_cliente.status_cliente IS
    'Status do cliente, podendo ser ATIVO ou INATIVO';

COMMENT ON COLUMN mc_cliente.uf_cliente IS
    'Sigla do UF do Cliente ';

COMMENT ON COLUMN mc_cliente.cidade_cliente IS
    'Nome da cidade do Cliente';

COMMENT ON COLUMN mc_cliente.logradouro_cliente IS
    'Logradouro do Cliente';

COMMENT ON COLUMN mc_cliente.cep_cliente IS
    'Número de CEP do cliente';

ALTER TABLE mc_cliente ADD CONSTRAINT pk_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE mc_cliente ADD CONSTRAINT un_mc_cliente_cd UNIQUE ( cd_cliente );

CREATE TABLE mc_cliente_pf (
    cd_cliente       NUMBER(7) NOT NULL,
    nr_cpf           NUMBER(11) NOT NULL,
    dt_nascimento    DATE NOT NULL,
    sexo_bio_cliente VARCHAR2(10) NOT NULL,
    gn_nascimento    VARCHAR2(10)
);

COMMENT ON COLUMN mc_cliente_pf.nr_cpf IS
    'Número do CPF do cliente pessoa física';

COMMENT ON COLUMN mc_cliente_pf.dt_nascimento IS
    'Data de nascimento do cliente';

COMMENT ON COLUMN mc_cliente_pf.sexo_bio_cliente IS
    'Sexo biológico do cliente';

COMMENT ON COLUMN mc_cliente_pf.gn_nascimento IS
    'Gênero de nascimento do cliente';

ALTER TABLE mc_cliente_pf ADD CONSTRAINT pk_cliente_pf PRIMARY KEY ( cd_cliente );

CREATE TABLE mc_cliente_pj (
    cd_cliente            NUMBER(7) NOT NULL,
    nr_cnpj               NUMBER(14) NOT NULL,
    dt_fundacao           DATE,
    nr_inscricao_estadual NUMBER(20)
);

COMMENT ON COLUMN mc_cliente_pj.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN mc_cliente_pj.nr_cnpj IS
    'Número do CNPJ do cliente pessoa jurídica';

COMMENT ON COLUMN mc_cliente_pj.dt_fundacao IS
    'Data de fundação da empresa do cliente pessoa jurídica';

COMMENT ON COLUMN mc_cliente_pj.nr_inscricao_estadual IS
    'Número de inscrição estadual da empresa do cliente pessoa jurídica';

ALTER TABLE mc_cliente_pj ADD CONSTRAINT pk_cliente_pj PRIMARY KEY ( cd_cliente );

CREATE TABLE mc_ctg_produto (
    cd_categoria     NUMBER(2) NOT NULL,
    desc_categoria   VARCHAR2(30) NOT NULL,
    status_categoria CHAR(1) NOT NULL,
    dt_inicial       DATE NOT NULL,
    dt_termino       DATE
);

COMMENT ON COLUMN mc_ctg_produto.cd_categoria IS
    'Código da categoria';

COMMENT ON COLUMN mc_ctg_produto.desc_categoria IS
    'Descrição da categoria';

COMMENT ON COLUMN mc_ctg_produto.status_categoria IS
    'Status da categoria';

COMMENT ON COLUMN mc_ctg_produto.dt_inicial IS
    'Data do início';

COMMENT ON COLUMN mc_ctg_produto.dt_termino IS
    'Data do término';

ALTER TABLE mc_ctg_produto
    ADD CONSTRAINT ck_mc_ctg_produto_status CHECK ( status_categoria = 'A'
                                                    OR dt_termino IS NOT NULL );

ALTER TABLE mc_ctg_produto ADD CONSTRAINT pk_ctg_produto PRIMARY KEY ( cd_categoria );

ALTER TABLE mc_ctg_produto ADD CONSTRAINT un_mc_ctg_produto_desc UNIQUE ( desc_categoria );

CREATE TABLE mc_funcionario (
    cd_func       NUMBER(4) NOT NULL,
    nm_func       VARCHAR2(20) NOT NULL,
    cpf_func      NUMBER(11) NOT NULL,
    dt_nasc_func  DATE NOT NULL,
    telefone_func NUMBER(13) NOT NULL,
    email_func    VARCHAR2(20) NOT NULL,
    cargo_func    VARCHAR2(24) NOT NULL,
    depto_func    VARCHAR2(40) NOT NULL
);

COMMENT ON COLUMN mc_funcionario.cd_func IS
    'Código do funcionário';

COMMENT ON COLUMN mc_funcionario.nm_func IS
    'Nome completo do funcionário									';

COMMENT ON COLUMN mc_funcionario.cpf_func IS
    'Número de CPF do funcionário';

COMMENT ON COLUMN mc_funcionario.dt_nasc_func IS
    'Data de nascimento do funcionário';

COMMENT ON COLUMN mc_funcionario.telefone_func IS
    'Telefone com DDD do funcionário';

COMMENT ON COLUMN mc_funcionario.email_func IS
    'Endereço de e-mail do funcionário';

COMMENT ON COLUMN mc_funcionario.cargo_func IS
    'Cargo do funcionário';

COMMENT ON COLUMN mc_funcionario.depto_func IS
    'Departamento em que o funcionário trabalha';

ALTER TABLE mc_funcionario ADD CONSTRAINT pk_func PRIMARY KEY ( cd_func );

ALTER TABLE mc_funcionario ADD CONSTRAINT un_mc_func_cpf UNIQUE ( cpf_func );

CREATE TABLE mc_item_pedido (
    cd_pedido     NUMBER(5) NOT NULL,
    cd_produto    NUMBER(7) NOT NULL,
    qt_pedido     NUMBER(12),
    vl_unitário   NUMBER(6, 2),
    vl_total_item NUMBER(6, 2)
);

COMMENT ON COLUMN mc_item_pedido.cd_pedido IS
    'Código do pedido';

COMMENT ON COLUMN mc_item_pedido.cd_produto IS
    'Código do produto';

COMMENT ON COLUMN mc_item_pedido.qt_pedido IS
    'quantidade de pedidos';

COMMENT ON COLUMN mc_item_pedido.vl_unitário IS
    'valor unitário';

COMMENT ON COLUMN mc_item_pedido.vl_total_item IS
    'valor total do item';

ALTER TABLE mc_item_pedido ADD CONSTRAINT pk_item_pedido PRIMARY KEY ( cd_pedido,
                                                                       cd_produto );

CREATE TABLE mc_pedido (
    cd_pedido       NUMBER(5) NOT NULL,
    cd_cliente      NUMBER(7) NOT NULL,
    dt_pedido       DATE NOT NULL,
    vl_total_pedido NUMBER(6, 2)
);

COMMENT ON COLUMN mc_pedido.cd_pedido IS
    'Código do pedido';

COMMENT ON COLUMN mc_pedido.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN mc_pedido.dt_pedido IS
    'Data em que o pedido foi realizado';

COMMENT ON COLUMN mc_pedido.vl_total_pedido IS
    'Valor total do pedido';

ALTER TABLE mc_pedido ADD CONSTRAINT pk_pedido PRIMARY KEY ( cd_pedido );

CREATE TABLE mc_produto (
    cd_produto        NUMBER(7) NOT NULL,
    cd_categoria      NUMBER(2) NOT NULL,
    desc_produto      VARCHAR2(20) NOT NULL,
    desc_completa     VARCHAR2(50) NOT NULL,
    sg_status_produto CHAR(1) NOT NULL,
    preco_produto     FLOAT(5) NOT NULL,
    cd_barras         NUMBER(12)
);

COMMENT ON COLUMN mc_produto.cd_produto IS
    'Código do produto';

COMMENT ON COLUMN mc_produto.desc_produto IS
    'Nome comum utilizado durante a comercialização do produto';

COMMENT ON COLUMN mc_produto.desc_completa IS
    'Descrição com detalhamento do produto comercializado';

COMMENT ON COLUMN mc_produto.sg_status_produto IS
    'Produto pode estar ativo (A), inativo (I) ou em prospecção (P)';

COMMENT ON COLUMN mc_produto.preco_produto IS
    'Preço unitário atual do produto';

COMMENT ON COLUMN mc_produto.cd_barras IS
    'Código de barras do produto padrão EAN13';

ALTER TABLE mc_produto
    ADD CONSTRAINT mc_produto_ck CHECK ( status = "A"
                                         OR status = "I" );

ALTER TABLE mc_produto ADD CONSTRAINT pk_produto PRIMARY KEY ( cd_produto );

ALTER TABLE mc_produto ADD CONSTRAINT un_mc_produto_desc UNIQUE ( desc_produto );

CREATE TABLE mc_sac_chamado (
    cd_chamado           NUMBER(10) NOT NULL,
    cd_cliente           NUMBER(7) NOT NULL,
    cd_func              NUMBER(4) NOT NULL,
    dt_hora_chamado      DATE NOT NULL,
    desc_chamado         VARCHAR2(4000) NOT NULL,
    desc_retorno_chamado VARCHAR2(4000) NOT NULL,
    cd_tipo_chamado      VARCHAR2(1) NOT NULL,
    sg_status_chamado    VARCHAR2(1) NOT NULL,
    duracao_min_atend    NUMBER(4),
    indice_satisfacao    NUMBER(3),
    dt_hr_atend          DATE
);

COMMENT ON COLUMN mc_sac_chamado.cd_chamado IS
    'Número de identificador único do SAC';

COMMENT ON COLUMN mc_sac_chamado.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN mc_sac_chamado.cd_func IS
    'Código do funcionário';

COMMENT ON COLUMN mc_sac_chamado.dt_hora_chamado IS
    'Data e hora de abertura do chamado';

COMMENT ON COLUMN mc_sac_chamado.desc_chamado IS
    'Descrição detalhada do chamado';

COMMENT ON COLUMN mc_sac_chamado.desc_retorno_chamado IS
    'Descrição detalhada do retorno do chamado pelo funcionário';

COMMENT ON COLUMN mc_sac_chamado.cd_tipo_chamado IS
    'Código do tipo de chamado, indicando sua natureza: Ajuda (A), Reclamação (R) ou Sugestão (S)';

COMMENT ON COLUMN mc_sac_chamado.sg_status_chamado IS
    'Status do chamado: ativo (A), inativo (I) ou pendente (P)';

COMMENT ON COLUMN mc_sac_chamado.duracao_min_atend IS
    'Duração total do atendimento em minutos';

COMMENT ON COLUMN mc_sac_chamado.indice_satisfacao IS
    'Índice de satisfação atribuído pelo cliente';

COMMENT ON COLUMN mc_sac_chamado.dt_hr_atend IS
    'Data e hora do atendimento do chamado';

ALTER TABLE mc_sac_chamado
    ADD CONSTRAINT ck_mc_sac_chamado_dt_hr_atend CHECK ( dt_hr_atend IS NULL
                                                         OR status = 'Atendido' );

ALTER TABLE mc_sac_chamado
    ADD CONSTRAINT ck_mc_sac_chamado_status CHECK ( sg_status_chamado = 'A'
                                                    OR sg_status_chamado = 'E'
                                                    OR sg_status_chamado = 'C'
                                                    OR sg_status_chamado = 'F'
                                                    OR sg_status_chamado = 'X' );

ALTER TABLE mc_sac_chamado
    ADD CONSTRAINT ck_mc_sac_chamado_dur_hr_atend CHECK ( dt_hr_atend = duracao_min_atend / 60 );

ALTER TABLE mc_sac_chamado
    ADD CONSTRAINT ck_mc_sac_chamado_idc_stf CHECK ( indice_satisfacao IS NULL
                                                     OR indice_satisfacao BETWEEN 1 AND 10 );

ALTER TABLE mc_sac_chamado
    ADD CONSTRAINT ck_mc_sac_chamado_class_tipo CHECK ( cd_tipo_chamado = 'A'
                                                        OR cd_tipo_chamado = 'R'
                                                        OR cd_tipo_chamado = 'S' );

ALTER TABLE mc_sac_chamado ADD CONSTRAINT pk_sac PRIMARY KEY ( cd_chamado );

CREATE TABLE mc_sac_chamado_ajuda (
    cd_chamado NUMBER(10) NOT NULL,
    tipo_ajuda VARCHAR2(2) NOT NULL
);

COMMENT ON COLUMN mc_sac_chamado_ajuda.cd_chamado IS
    'Código do chamado';

COMMENT ON COLUMN mc_sac_chamado_ajuda.tipo_ajuda IS
    'Classificação do chamado Ajuda, podendo ser: Alteração de dados de compras (AD), Atualização cadastral (AC) ou Financeiro (FN)';

CREATE UNIQUE INDEX mc_sac_chamado_ajuda__idx ON
    mc_sac_chamado_ajuda (
        cd_chamado
    ASC );

ALTER TABLE mc_sac_chamado_ajuda ADD CONSTRAINT pk_class_ajuda PRIMARY KEY ( cd_chamado,
                                                                             tipo_ajuda );

CREATE TABLE mc_sac_chamado_reclamacao (
    cd_chamado            NUMBER(10) NOT NULL,
    tipo_reclamacao       VARCHAR2(2) NOT NULL,
    prioridade_reclamacao VARCHAR2(8) NOT NULL
);

COMMENT ON COLUMN mc_sac_chamado_reclamacao.cd_chamado IS
    'Código do chamado';

COMMENT ON COLUMN mc_sac_chamado_reclamacao.tipo_reclamacao IS
    'Categoria dos chamados definidos como Reclamação: Suporte técnico (N1) ou Suporte especializado (N2)';

COMMENT ON COLUMN mc_sac_chamado_reclamacao.prioridade_reclamacao IS
    'Podendo ser considerado: Baixa (B), Média (M), Alta (A) ou Urgente (U)';

CREATE UNIQUE INDEX mc_sac_chamado_reclamacao__idx ON
    mc_sac_chamado_reclamacao (
        cd_chamado
    ASC );

ALTER TABLE mc_sac_chamado_reclamacao ADD CONSTRAINT pk_class_reclamacao PRIMARY KEY ( cd_chamado,
                                                                                       tipo_reclamacao );

CREATE TABLE mc_sac_chamado_sugestao (
    cd_chamado      NUMBER(10) NOT NULL,
    tipo_sugestao   VARCHAR2(2) NOT NULL,
    status_sugestao VARCHAR2(1) NOT NULL
);

COMMENT ON COLUMN mc_sac_chamado_sugestao.cd_chamado IS
    'Código do chamado';

COMMENT ON COLUMN mc_sac_chamado_sugestao.tipo_sugestao IS
    'Categoria dos chamados definidos como Sugestão, podendo ser: Plataforma (PL), Conteúdos (CT) ou Atendimento (AT)';

COMMENT ON COLUMN mc_sac_chamado_sugestao.status_sugestao IS
    'Categoria dos chamados definidos como Sugestão, podendo ser:pendente (P), análise (A) ou implementada (I)';

CREATE UNIQUE INDEX mc_sac_chamado_sugestao__idx ON
    mc_sac_chamado_sugestao (
        cd_chamado
    ASC );

ALTER TABLE mc_sac_chamado_sugestao ADD CONSTRAINT pk_class_sugestao PRIMARY KEY ( cd_chamado,
                                                                                   tipo_sugestao );

CREATE TABLE mc_video_produto (
    cd_video          NUMBER(3) NOT NULL,
    cd_class          NUMBER(2) NOT NULL,
    cd_produto        NUMBER(7) NOT NULL,
    dt_cadastro_video DATE NOT NULL,
    status_video      CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_video_produto.cd_video IS
    'Código do vídeo';

COMMENT ON COLUMN mc_video_produto.cd_class IS
    'Código da classificação';

COMMENT ON COLUMN mc_video_produto.cd_produto IS
    'Código do produto';

COMMENT ON COLUMN mc_video_produto.dt_cadastro_video IS
    'Data do cadastro do vídeo';

COMMENT ON COLUMN mc_video_produto.status_video IS
    'Status do vídeo';

ALTER TABLE mc_video_produto
    ADD CONSTRAINT ck_mc_vdo_pdt_sts_vdo CHECK ( status_video = 'A'
                                                 OR status_video = 'I' );

ALTER TABLE mc_video_produto ADD CONSTRAINT pk_video_produto PRIMARY KEY ( cd_video );

CREATE TABLE mc_visualizacao_video (
    cd_visualizacao NUMBER(7) NOT NULL,
    cd_video        NUMBER(3) NOT NULL,
    dt_visualizacao DATE NOT NULL
);

COMMENT ON COLUMN mc_visualizacao_video.cd_visualizacao IS
    'Código da visualização';

COMMENT ON COLUMN mc_visualizacao_video.cd_video IS
    'Código do vídeo';

COMMENT ON COLUMN mc_visualizacao_video.dt_visualizacao IS
    'Data de visualização';

ALTER TABLE mc_visualizacao_video ADD CONSTRAINT pk_vsz_video PRIMARY KEY ( cd_visualizacao );

ALTER TABLE mc_sac_chamado
    ADD CONSTRAINT abrir FOREIGN KEY ( cd_cliente )
        REFERENCES mc_cliente ( cd_cliente );

ALTER TABLE mc_sac_chamado
    ADD CONSTRAINT atender FOREIGN KEY ( cd_func )
        REFERENCES mc_funcionario ( cd_func );

ALTER TABLE mc_produto
    ADD CONSTRAINT categorizar FOREIGN KEY ( cd_categoria )
        REFERENCES mc_ctg_produto ( cd_categoria );

ALTER TABLE mc_sac_chamado_ajuda
    ADD CONSTRAINT classificar FOREIGN KEY ( cd_chamado )
        REFERENCES mc_sac_chamado ( cd_chamado );

ALTER TABLE mc_sac_chamado_sugestao
    ADD CONSTRAINT classificar1 FOREIGN KEY ( cd_chamado )
        REFERENCES mc_sac_chamado ( cd_chamado );

ALTER TABLE mc_sac_chamado_reclamacao
    ADD CONSTRAINT classificar2 FOREIGN KEY ( cd_chamado )
        REFERENCES mc_sac_chamado ( cd_chamado );

ALTER TABLE mc_video_produto
    ADD CONSTRAINT classificarv1 FOREIGN KEY ( cd_class )
        REFERENCES mc_class_video ( cd_class );

ALTER TABLE mc_item_pedido
    ADD CONSTRAINT pertencer FOREIGN KEY ( cd_pedido )
        REFERENCES mc_pedido ( cd_pedido );

ALTER TABLE mc_cliente_pf
    ADD CONSTRAINT pode_ser FOREIGN KEY ( cd_cliente )
        REFERENCES mc_cliente ( cd_cliente );

ALTER TABLE mc_cliente_pj
    ADD CONSTRAINT pode_ser1 FOREIGN KEY ( cd_cliente )
        REFERENCES mc_cliente ( cd_cliente );

ALTER TABLE mc_item_pedido
    ADD CONSTRAINT "pode ter" FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE mc_video_produto
    ADD CONSTRAINT possuir FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE mc_pedido
    ADD CONSTRAINT realizar FOREIGN KEY ( cd_cliente )
        REFERENCES mc_cliente ( cd_cliente );

ALTER TABLE mc_visualizacao_video
    ADD CONSTRAINT visualizar FOREIGN KEY ( cd_video )
        REFERENCES mc_video_produto ( cd_video );

CREATE OR REPLACE TRIGGER arc_arc_1_mc_cliente_pj BEFORE
    INSERT OR UPDATE OF cd_cliente ON mc_cliente_pj
    FOR EACH ROW
DECLARE
    d NUMBER(7);
BEGIN
    SELECT
        a.cd_cliente
    INTO d
    FROM
        mc_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> cliente_pj ) THEN
        raise_application_error(-20223, 'FK pode_ser1 in Table MC_CLIENTE_PJ violates Arc constraint on Table MC_CLIENTE - discriminator column cd_cliente doesn''t have value cliente_pj'
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_1_mc_cliente_pf BEFORE
    INSERT OR UPDATE OF cd_cliente ON mc_cliente_pf
    FOR EACH ROW
DECLARE
    d NUMBER(7);
BEGIN
    SELECT
        a.cd_cliente
    INTO d
    FROM
        mc_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> cliente_pf ) THEN
        raise_application_error(-20223, 'FK pode_ser in Table MC_CLIENTE_PF violates Arc constraint on Table MC_CLIENTE - discriminator column cd_cliente doesn''t have value cliente_pf'
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_2_mc_sac_chamado_ajuda BEFORE
    INSERT OR UPDATE OF cd_chamado ON mc_sac_chamado_ajuda
    FOR EACH ROW
DECLARE
    d VARCHAR2(1);
BEGIN
    SELECT
        a.cd_tipo_chamado
    INTO d
    FROM
        mc_sac_chamado a
    WHERE
        a.cd_chamado = :new.cd_chamado;

    IF ( d IS NULL OR d <> 'tipo_ajuda' ) THEN
        raise_application_error(-20223, 'FK classificar in Table MC_SAC_CHAMADO_AJUDA violates Arc constraint on Table MC_SAC_CHAMADO - discriminator column cd_tipo_chamado doesn''t have value ''tipo_ajuda'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc__mc_sac_chamado_reclamacao BEFORE
    INSERT OR UPDATE OF cd_chamado ON mc_sac_chamado_reclamacao
    FOR EACH ROW
DECLARE
    d VARCHAR2(1);
BEGIN
    SELECT
        a.cd_tipo_chamado
    INTO d
    FROM
        mc_sac_chamado a
    WHERE
        a.cd_chamado = :new.cd_chamado;

    IF ( d IS NULL OR d <> 'tipo_reclamacao' ) THEN
        raise_application_error(-20223, 'FK classificar2 in Table MC_SAC_CHAMADO_RECLAMACAO violates Arc constraint on Table MC_SAC_CHAMADO - discriminator column cd_tipo_chamado doesn''t have value ''tipo_reclamacao'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_ar_mc_sac_chamado_sugestao BEFORE
    INSERT OR UPDATE OF cd_chamado ON mc_sac_chamado_sugestao
    FOR EACH ROW
DECLARE
    d VARCHAR2(1);
BEGIN
    SELECT
        a.cd_tipo_chamado
    INTO d
    FROM
        mc_sac_chamado a
    WHERE
        a.cd_chamado = :new.cd_chamado;

    IF ( d IS NULL OR d <> 'tipo_sugestao' ) THEN
        raise_application_error(-20223, 'FK classificar1 in Table MC_SAC_CHAMADO_SUGESTAO violates Arc constraint on Table MC_SAC_CHAMADO - discriminator column cd_tipo_chamado doesn''t have value ''tipo_sugestao'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE SEQUENCE sqc_ctg_produto START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER mc_ctg_produto_cd_categoria BEFORE
    INSERT ON mc_ctg_produto
    FOR EACH ROW
    WHEN ( new.cd_categoria IS NULL )
BEGIN
    :new.cd_categoria := sqc_ctg_produto.nextval;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             3
-- ALTER TABLE                             42
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           6
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
-- CREATE SEQUENCE                          1
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
