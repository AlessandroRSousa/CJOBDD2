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
    rest_descricao  VARCHAR(100)
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
    cod_cargo            VARCHAR(20) PRIMARY KEY,
    nivel_de_acesso      VARCHAR(25) NOT NULL,
    id_setores VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES DEPARTAMENTOS(id_setores)
);
GO

--TABELA FUNCIONARIOS
CREATE TABLE FUNCIONARIOS (
    cod_funcionario     VARCHAR(25) PRIMARY KEY,
    login_funcionario   VARCHAR(50) NOT NULL,
    senha_funcionario   VARCHAR(6)  NOT NULL,
    cod_cargo    VARCHAR(25) NOT NULL FOREIGN KEY REFERENCES CARGOS(cod_cargo)
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
    valor_total         MONEY NOT NULL,
    forma_pagamento     VARCHAR(8) NOT NULL,
    status_fat          VARCHAR(10) NOT NULL,
    cod_pedidos         VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES PEDIDOS(cod_pedido)
);
GO

--TABELA ITENS/PRODUTOS
CREATE TABLE ITENSPRODUTOS (
    cod_item            VARCHAR(25) PRIMARY KEY,
    id_item             VARCHAR(50) NOT NULL,
    qt_item_produto     VARCHAR(10) NOT NULL,
    preco_venda         MONEY NOT NULL,
    desc_item           VARCHAR(5),
    motivo_desc         TEXT,
    cod_pedidos         VARCHAR(15) NOT NULL FOREIGN KEY REFERENCES PEDIDOS(cod_pedido)
    --  ?? COD_PEDIDO OBRIGATORIO?? CONFLITO COM MOV ESTOQUE DE ITENS/PRODUTOS E INSUMOS. -- 
);
GO

--TABELA CLIENTES
CREATE TABLE CLIENTES (
    id_cliente      VARCHAR(25) PRIMARY KEY,
    id_venda        VARCHAR(50) NOT NULL,
    nome_cliente    VARCHAR(50) NOT NULL,
    tel_cliente     VARCHAR(20) NOT NULL
    --?? FK COM FATURAS ?? --
);
GO

--TABELA PRODUTOS
CREATE TABLE PRODUTOS (
    cod_produto     VARCHAR(50) PRIMARY KEY,
    nome_produto    VARCHAR(50) NOT NULL,
    preco_produto   MONEY NOT NULL,
    qt_estoque      VARCHAR(10) NOT NULL,
    desc_prod       VARCHAR(50),
    cod_item        VARCHAR(25) NOT NULL FOREIGN KEY REFERENCES ITENSPRODUTOS(id_item)
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
    id_item          VARCHAR(25) NOT NULL FOREIGN KEY REFERENCES ITENSPRODUTOS(cod_item)
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
--INSERÇÃO DE DADOS RESTAURANTE
INSERT INTO RESTAURANTE(cnpj, rest_nome, rest_end, rest_email, rest_descricao) 
VALUES (
    '01012012000101', 
    'Culinária Assembly',
    'Rua baixo nivel, n. 0',
    'malassombro@gmail.com',
     'Tecnologia em cada sabor'
);
GO

--INSERÇÃO DE DADOS DEPARTAMENTOS
INSERT INTO DEPARTAMENTOS(id_setores, descricao_setores, cnpj)
VALUES 
    ('A&B', 'Alimentos e Bebidas', '01012012000101'),
    ('Governança', 'Governança/Limpeza', '01012012000101'),
    ('Recepção', 'Hostess e Recepcionistas', '01012012000101'),
    ('Manutenção', 'Manutenção', '01012012000101'),
    ('Almoxarifado', 'Estoque/Controladoria', '01012012000101');
GO

--INSERÇÃO DE DADOS CARGOS
INSERT INTO CARGOS(cod_cargo, nivel_de_acesso, id_setores)
VALUES
    ('Maitrê', 'Gerencia01', 'A&B'),
    ('Chefe de Fila', 'Gerencia02', 'A&B'),
    ('Operador de Caixa', 'User01', 'Recepção'),
    ('Garçom', 'User02', 'A&B'),
    ('Cumin', 'User06', 'A&B'),
    ('Hostess', 'Hostess', 'Recepção'),
    ('Chef', 'Gerencia02', 'A&B'),
    ('Cozinheiro', 'User05', 'A&B'),
    ('Auxiliar de Cozinha', 'User06', 'A&B'),
    ('Áreas Sociais', 'Governança', 'Governança'),
    ('Manutencionista', 'Manutenção', 'Manutenção'),
    ('Almoxarife', 'User03', 'Almoxarifado'),
    ('Estoquista', 'User04', 'Almoxarifado');
GO

--INSERÇÃO DADOS TABELA FUNCIONARIOS
INSERT INTO FUNCIONARIOS(cod_funcionario, login_funcionario, senha_funcionario, cod_cargo)
VALUES
    ('Sr Senior', 'GerenciaRest01', 'MAB001', 'Maitrê'),
    ('Sr Pleno', 'GerenciaRest02', 'CFAB02', 'Chefe de Fila'),
    ('Op Caxias', 'OpCaixa01', 'Op.Ca1', 'Operador de Caixa'),
    ('Alfredo', 'GarcomMaquina', 'Gar001', 'Garçom'),
    ('Juninho', 'CuminBala', 'Cab4ço', 'Cumin'),
    ('Filezinho', 'Hostess01', 'Sugest','Hostess'),
    ('Rattatouille', 'MiniChef', 'Lingni', 'Chef'),
    ('Gosteau', 'QueimaArroz', '123456', 'Cozinheiro'),
    ('Garmange', 'PicaTudo', 'FazCaf', 'Auxiliar de Cozinha'),
    ('Tia', 'Limpeza', 'TdLimp', 'Áreas Sociais'),
    ('Tiozinho', 'PicaFio', 'VdRosc', 'Manutencionista'),
    ('Pelé', 'Almox', 'Notnha', 'Almoxarife'),
    ('JHopkins', 'GuardaTudo', 'GtaEs', 'Estoquista');
GO

--INSERÇÃO DADOS TABELA PEDIDOS
INSERT INTO PEDIDOS(cod_pedido, data_hora_pedido, cod_funcionario)
VALUES 
    ('00001', '2026-11-03 19:45:00', 'Sr Senior'),
    ('00002', '2026-11-03 20:30:50', 'Alfredo'),
    ('00003', '2026-11-02 18:05:00', 'Alfredo');
GO

--INSERÇÃO DADOS TABELA FATURA
INSERT INTO FATURAS(id_fatura, valor_total, forma_pagamento, status_fat, cod_pedidos)
VALUES
    (1, '$300.00', 'Débito', 'Pago', '00003'),
    (2, '$250.00', 'Crédito', 'Pago', '00001'),
    (3, '$1150.00', 'Dinheiro', 'Pago', '00002');
GO

---INSERÇÃON DADOS TABELA
INSERT INTO ITENSPRODUTOS(cod_item, id_item, qt_item_produto, preco_venda, desc_item, motivo_desc, cod_pedidos)
VALUES
    ('2000', 'BEBIDA', '1', '$5.00', NULL, NULL, '00001'),
    ('9470', 'ALIMENTO', '1', '$22.00', NULL, NULL, '00002'),
    ('2001', 'BEBIDA', '2', '$10.00', NULL, NULL, '00003');
GO

--INSERÇÃO DADOS PRODUTOS
INSERT INTO PRODUTOS(cod_produto, nome_produto, preco_produto, qt_estoque, desc_prod, id_item)
VALUES
    ('CocaKs', 'Coca-cola', '$2.50', '10', NULL, 'BEBIDA'),
    ('CocaKsZero', 'Coca-cola Zero', '$2.70', '10', NULL, 'BEBIDA'),
    ('FantaLa', 'Fanta Laranja', '$2.20', '10', NULL, 'BEBIDA'),
    ('Corte Picanha', 'Picanha', '$35.00', '5', NULL, 'ALILMENTO'),
    ('Arroz Branco', 'Arroz', '$5.50', '5', NULL, 'ALIMENTO'),
    ('Feijão Carioca', 'Feijão', '$3.30', '3', NULL, 'ALIMENTO');
GO


--INSERÇÃO DADOS TABELA CLIENTES
INSERT INTO CLIENTES(id_cliente, id_venda, nome_cliente, tel_cliente)
VALUES
    ('CLI001', 'VENDA001', 'Carmen Velasco', '(12) 99999-1111'),
    ('CLI002', 'VENDA002', 'Joãozinho Pereira', '(12) 98888-2222'),
    ('CLI003', 'VENDA003', 'Ana Braga', '(12) 97777-3333');
GO

--INSERÇÃO DADOS TABELA CATEGORIAS 
INSERT INTO CATEGORIAS(cod_categoria, desc_categoria, cod_produto)
VALUES
    (1, 'Bebidas', 'CocaKs'),
    (2, 'Bebidas Zero', 'CocaKsZero'),
    (3, 'Bebidas Sabor', 'FantaLa');
GO

--INSERÇÃO DADOS TABELA INSUMOS
INSERT INTO INSUMOS(id_insumo, nome_insumo, lote_insumo, validade_insumo, id_item)
VALUES
    ('INS001', 'Arroz 5kg', 1001, '2027-05-30', 'ALIMENTO'),
    ('INS002', 'Feijão 1kg', 1002, '2027-03-15', 'ALIMENTO'),
    ('INS003', 'Óleo de soja', 1003, '2027-01-20', 'ALIMENTO'),
    ('INS004', 'Coca-Cola', 2001, '2027-05-03', 'BEBIDA');
GO

--INSERÇÃO DADOS TABELA MOVIMENTACAOESTOQUE 
--tipo mov 1 = entrada
--tipo mov 2 = saida
INSERT INTO MOVIMENTACAOESTOQUE(id_movimentacao, tipo_mo_est, data_mo_est, id_insumos)
VALUES
    (1, 1, '2026-11-01 08:00:00', 'INS001'),
    (2, 1, '2026-11-01 08:15:00', 'INS002'),
    (3, 2, '2026-11-03 14:30:00', 'INS001');
GO








