--BDD RESTAURANTE - ALESSANDRO CJ3032094

--CRIAÇÃO DATABASE
CREATE DATABASE VendasPdvRestaurante;
GO

USE VendasPdvRestaurante;
GO
--TABELA RESTAURANTE
CREATE TABLE RESTAURANTE (
    cnpj            VARCHAR(14) PRIMARY KEY,
    rest_nome       VARCHAR(50) NOT NULL,
    rest_end        VARCHAR(100) NOT NULL,
    rest_email      VARCHAR(50) NOT NULL,
    rest_descricao  CHAR(100)
);
GO

--TABELA DEPARTAMENTOS
CREATE TABLE DEPARTAMENTOS (
    id_setores          VARCHAR(25) PRIMARY KEY,
    descricao_setores   VARCHAR(100)NOT NULL,
    cnpj                VARCHAR(14) NOT NULL FOREIGN KEY REFERENCES RESTAURANTE(cnpj)
    
);
GO

--TABELA CARGOS
CREATE TABLE CARGOS (
    cod_cargo            VARCHAR(10) PRIMARY KEY,
    nivel_de_acesso      VARCHAR(25) NOT NULL,
    id_setores VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES DEPARTAMENTOS(id_setores)
);
GO

--TABELA FUNCIONARIOS
CREATE TABLE FUNCIONARIOS (
    cod_funcionario     VARCHAR(25) PRIMARY KEY,
    login_funcionario   VARCHAR(50) NOT NULL,
    senha_funcionario   VARCHAR(6)  NOT NULL,
    cod_cargo    VARCHAR(25) NOT NULL FOREIGN KEY REFERENCES CARGOS(cod_cargos)
);
GO

--TABELA PEDIDOS
CREATE TABLE PEDIDOS (
    cod_pedido          VARCHAR(15) PRIMARY KEY,
    data_hora_pedido    DATETIME NOT NULL,
    cod_funcionario     VARCHAR(25) NOT NULL FOREIGN KEY REFERENCES FUNCIONARIOS(cod_funcionario)
);
GO

--TABELA FATURAS
CREATE TABLE FATURAS (
    id_fatura           INT PRIMARY KEY,
    valor_total         VARCHAR(10) NOT NULL,
    forma_pagamento     INT NOT NULL,
    status_fat          INT NOT NULL,
    cod_pedidos         VARCHAR(15) NOT NULL, FOREIGN KEY REFERENCES PEDIDOS(cod_pedido)
);
GO

--TABELA ITENS/PRODUTOS
CREATE TABLE ITENSPRODUTOS (
    cod_item            INT PRIMARY KEY,
    qt_item_produto     VARCHAR(10) NOT NULL,
    preco_venda         VARCHAR(10) NOT NULL,
    desc_item           VARCHAR(5),
    motivo_desc         INT,
    cod_pedidos         VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES PEDIDOS(cod_pedido)
    --  ?? COD_PEDIDO OBRIGATORIO?? CONFLITO COM MOV ESTOQUE DE ITENS/PRODUTOS E INSUMOS. -- 
);
GO

--TABELA CLIENTES
CREATE TABLE CLIENTES (
    id_cliente      VARCHAR(25) PRIMARY KEY,
    id_venda        VARCHAR(50) NOT NULL,
    nome_cliente    VARCHAR(50) NOT NULL,
    tel_cliente     VARCHAR(20) NOT NULL,
    --?? FK COM FATURAS ?? --
)

--TABELA PRODUTOS
CREATE TABLE PRODUTOS (
    cod_produto     VARCHAR(50) PRIMARY KEY,
    nome_produto    INT NOT NULL,
    preco_produto   VARCHAR(10) NOT NULL,
    qt_estoque      VARCHAR(10) NOT NULL,
    desc_prod       VARCHAR(50),
    cod_item        INT NOT NULL FOREIGN KEY REFERENCES ITENSPRODUTOS(cod_item)
);
GO

--TABELA CATEGORIAS
CREATE TABLE CATEGORIAS (
    cod_categoria   INT PRIMARY KEY,
    desc_categoria  VARCHAR(25) NOT NULL,
    cod_produto     VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES PRODUTOS(cod_produto)
);
GO

--TABELA INSUMOS
CREATE TABLE INSUMOS (
    id_insumo        VARCHAR(15) PRIMARY KEY,
    nome_insumo      VARCHAR(25) NOT NULL,
    lote_insumo      INT NOT NULL,
    validade_insumo  VARCHAR(10),
    cod_item         INT NOT NULL FOREIGN KEY REFERENCES ITENPRODUTOS(cod_produto)
);
GO

--TABELA MOVIMENTACAO ESTOQUE
CREATE TABLE MOVIMENTACAOESTOQUE(
    id_movimentacao  INT PRIMARY KEY,
    tipo_mo_est      INT NOT NULL,
    data_mo_est      DATETIME NOT NULL,
    id_insumos       VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES INSUMOS(id_insumo)
);
GO