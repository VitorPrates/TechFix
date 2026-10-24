--ativa as chaves estrangeiras
PRAGMA foreign_keys = ON;
--TESTAR SE TA FUNCIONANDO (tem que ser 1)
PRAGMA foreign_keys;

CREATE TABLE IF NOT EXISTS cargo(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_cargo TEXT NOT NULL COLLATE NOCASE,
	status INTEGER NOT NULL DEFAULT 1
)STRICT; 

CREATE TABLE IF NOT EXISTS funcionario(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_funcionario TEXT NOT NULL COLLATE NOCASE,
	status INTEGER NOT NULL DEFAULT 1,
	data_registro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	id_cargo INTEGER NOT NULL,
	FOREIGN KEY (id_cargo) REFERENCES cargo(id) ON UPDATE CASCADE ON DELETE CASCADE,
	unique(id,id_cargo)
)STRICT;

INSERT INTO cargo (nome_cargo) VALUES ("Gerente"),("Atendente"),("Técnico");

INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES
    ('Carlos Almeida', 3),   -- Técnico
    ('Marcos Oliveira', 3),  -- Técnico
    ('Rafael Santos', 3),    -- Técnico
    ('Ana Paula Silva', 2),  -- Atendente
    ('Juliana Costa', 2),    -- Atendente
    ('Roberto Martins', 1);  -- Gerente
   
INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES ('Silas Camus', 1);  -- Gerente
    
CREATE TABLE IF NOT EXISTS cliente(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_cliente TEXT NOT NULL COLLATE NOCASE,
	cpf TEXT NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	status INTEGER NOT NULL DEFAULT 1,
	data_registro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1 OR id_funcionario_cargo = 2),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id,id_cargo)
)STRICT;

INSERT INTO cliente (nome_cliente, email,cpf, id_funcionario, id_funcionario_cargo) VALUES ("joão", "joao@gmail.com","782-643-597-54", 3,(SELECT id_cargo FROM funcionario f WHERE id = 3));     

-- 2.3. Clientes (RF02: Cadastrados por Atendentes [Cargo 2] ou Gerente [Cargo 1])
INSERT
	INTO
	cliente (
		cpf,
		nome_cliente,
		email,
		id_funcionario,
		id_funcionario_cargo
	)
VALUES
	(
		'000-000-000-01',
		'Marcos Vinicius Souza',
		'marcos.souza@email.com',
		6,
		1
	),
(
		'000-000-000-02',
		'Fernanda Maria Oliveira',
		'fernanda.oliveira@email.com',
		6,
		1
	),
(
		'000-000-000-03',
		'Roberto Carlos Andrade',
		'roberto.andrade@email.com',
		6,
		1
	),
(
		'000-000-000-04',
		'Camila de Cassia Martins',
		'camila.martins@email.com',
		6,
		1
	),
(
		'000-000-000-05',
		'Patricia Ferreira Lima',
		'patricia.lima@email.com',
		6,
		1
	),
(
		'000-000-000-06',
		'Lucas Gabriel Barbosa',
		'lucas.barbosa@email.com',
		6,
		1
	);



--CATEGORIA
CREATE TABLE IF NOT EXISTS categoria(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
	status INTEGER NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id,id_cargo)
)STRICT;


INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Computadores", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Celulares", 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Smart TVs", 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Redes", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Videogames", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Áudio", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Recuperação de Dados", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Eletrônica Avançada", 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Informática", 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Insumos", 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Acessórios", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Telas", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Baterias", 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Componentes", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("Carcaças", 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

INSERT INTO categoria (nome, id_funcionario, id_funcionario_cargo) 
VALUES ("TVs", 6, (SELECT id_cargo FROM funcionario WHERE id = 6));

--SERVICOS
CREATE TABLE IF NOT EXISTS servicos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_categoria INTEGER NOT NULL,
	preco INTEGER NOT NULL,
	horas_trabalho REAL NOT NULL,
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
	status INTEGER NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id,id_cargo),
	FOREIGN KEY (id_categoria) REFERENCES categoria(id)
)STRICT;

INSERT INTO servicos (nome, id_categoria, preco, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES
('Formatação e Instalação de Sistema Operacional', 1, 12000, 2.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Limpeza Interna e Troca de Pasta Térmica', 1, 15000, 1.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Upgrade de Hardware (RAM/SSD)', 1, 8000, 1.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Remoção de Vírus e Malwares', 1, 10000, 1.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Troca de Tela de Notebook', 1, 18000, 1.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Troca de Display/Frontal de Celular', 2, 15000, 1.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Troca de Bateria de Smartphone', 2, 9000, 0.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Desoxidação após Contato com Líquido', 2, 20000, 3.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Reparo em Conector de Carga (Micro USB / Type-C)', 2, 11000, 1.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Troca de Barra de LED de Smart TV', 3, 35000, 3.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Reparo na Placa Principal de Smart TV', 3, 28000, 2.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Conserto de Fonte de Alimentação Interna (TV)', 3, 22000, 2.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Configuração de Rede e Roteador Wi-Fi', 4, 9000, 1.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Higienização e Troca de Metal Líquido / Pasta Térmica (Console)', 5, 22000, 2.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Reparo de Drift em Analógico de Controle (Joy-Con / DualSense / Xbox)', 5, 8000, 1.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Substituição de HDMI / Conector de Vídeo (Console)', 5, 25000, 2.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Troca de Bateria de Caixa de Som Portátil (Bluetooth)', 6, 12000, 1.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Troca de Almofadas / Reparo de Cabo de Headset Gamer', 6, 7000, 1.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Recuperação de Dados de HD / SSD / Pendrive Danificado', 7, 30000, 4.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Rebaling / Reparo de BGA em Placa Mãe ou Placa de Vídeo', 8, 45000, 5.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Gravação e Reprogramação de BIOS Eprom (Notebook / Desktop)', 8, 16000, 2.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Troca de Vidro Traseiro de Smartphone a Laser / Manual', 2, 18000, 2.5, 6, (SELECT id_cargo FROM funcionario WHERE id = 6)),
('Reparo e Solda de Conector Jack P2/P10 de Mesa de Som ou Amplificador', 6, 9500, 1.0, 6, (SELECT id_cargo FROM funcionario WHERE id = 6));


CREATE TABLE marca (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_marca TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (
		id_funcionario_cargo = 1
	OR id_funcionario_cargo = 2
	),
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	status INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE modelo (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_modelo TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (
		id_funcionario_cargo = 1
	OR id_funcionario_cargo = 2
	),
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	status INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE tipo (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_tipo TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (
		id_funcionario_cargo = 1
	OR id_funcionario_cargo = 2
	),
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	status INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;

CREATE TABLE equipamento(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	id_marca INTEGER NOT NULL,
	id_modelo INTEGER NOT NULL,
	id_tipo INTEGER NOT NULL,
	id_cliente INTEGER NOT NULL,
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (
		id_funcionario_cargo = 1
		OR id_funcionario_cargo = 2
	),
	numero_serie TEXT DEFAULT(NULL) COLLATE NOCASE,
	imei TEXT DEFAULT(NULL) COLLATE NOCASE UNIQUE,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	status INTEGER NOT NULL DEFAULT 1,
	FOREIGN KEY (id_marca) REFERENCES marca(id),
	FOREIGN KEY (id_modelo) REFERENCES modelo(id),
	FOREIGN KEY (id_tipo) REFERENCES tipo(id),
	FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;
--INSERTS DE EQUIPAMENTO, TIPO, MODELO,MARCA
-- 2.4. Marcas (Cadastradas por Atendentes ou Gerente)
INSERT
	INTO
	marca (nome_marca,
	id_funcionario,
	id_funcionario_cargo)
VALUES
	('Apple',
6,
1),
('Samsung',
7,
1),
('Motorola',
7,
1),
('Xiaomi',
6,
1),
('Dell',
6,
1),
('Lenovo',
7,
1),
('LG',
7,
1),
('Sony',
6,
1);
-- 2.5. Modelos (Cadastrados por Atendentes ou Gerente)
INSERT
	INTO
	modelo (
		nome_modelo,
		id_funcionario,
		id_funcionario_cargo
	)
VALUES
	('iPhone 11',
6,
1),
('iPhone 12',
6,
1),
('Galaxy A54',
6,
1),
('Galaxy A32',
7,
1),
('Moto G84',
7,
1),
('Moto G30',
4,
2),
('Redmi Note 11',
4,
2),
('Inspiron 15 3000',
6,
1),
('IdeaPad 3',
6,
1),
('Smart TV 50 UN50TU8000',
7,
1),
('Smart TV 43 43UP7500',
4,
2),
('PlayStation 5',
7,
1);
-- 2.6. Tipos de Equipamento (Cadastrados por Atendentes ou Gerente)
INSERT
	INTO
	tipo (nome_tipo,
	id_funcionario,
	id_funcionario_cargo)
VALUES
	('Smartphone',
6,
1),
('Notebook',
4,
2),
('Desktop',
5,
2),
('Smart TV',
5,
2),
('Console de Videogame',
5,
2),
('Caixa de Som Bluetooth',
5,
2);
-- 2.7. Equipamentos (RF03: Cadastrados por Atendentes ou Gerentes)
INSERT
	INTO
	equipamento (
		id_marca,
		id_modelo,
		id_tipo,
		id_cliente,
		id_funcionario,
		id_funcionario_cargo,
		numero_serie,
		imei
	)
VALUES
	(1,
1,
1,
1,
6,
1,
NULL,
'356789012345671'),
(2,
3,
1,
2,
6,
1,
NULL,
'356789012345672'),
(5,
8,
2,
3,
6,
1,
'DELL-INSP-2023-998',
NULL),
(7,
10,
4,
4,
6,
1,
'LG-TV43-77612',
NULL),
(8,
12,
5,
5,
6,
1,
'PS5-SONY-009182',
NULL),
(3,
5,
1,
6,
6,
1,
NULL,
'356789012345673');

--Peças
CREATE TABLE IF NOT EXISTS peca(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_categoria INTEGER NOT NULL,
	preco_compra INTEGER NOT NULL,
	preco_venda INTEGER NOT NULL,
	estoque_atual INTEGER NOT NULL,
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
	status INTEGER NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id,id_cargo),
	FOREIGN KEY (id_categoria) REFERENCES categoria(id)
)STRICT;

INSERT INTO peca (nome, id_categoria, preco_compra, preco_venda, estoque_atual, id_funcionario, id_funcionario_cargo)
VALUES
('SSD NVMe 512GB M.2', 9, 14000, 26000, 15, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('SSD SATA III 480GB 2.5"', 9, 11000, 21000, 20, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Memória RAM DDR4 8GB 2666MHz (Notebook)', 9, 9000, 17000, 12, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Memória RAM DDR4 16GB 3200MHz (Desktop)', 9, 18000, 32000, 8, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Pasta Térmica de Alta Performance (Bisnaga 4g)', 10, 2500, 6000, 25, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Fonte ATX 500W 80 Plus Bronze', 9, 19000, 34000, 6, 7, 1),
('Bateria Célula Moeda CR2032 (Cartela c/ 5)', 10, 800, 2500, 30, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Cooler para Processador Socket Universal', 9, 4500, 9500, 10, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Cabo SATA III 6Gbps 50cm', 11, 300, 1500, 50, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Tela LED 15.6" Slim 30 Pinos Full HD', 12, 28000, 48000, 5, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Display Frontal Completo iPhone 11', 12, 18000, 35000, 4, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Display Frontal Completo Samsung Galaxy A54', 12, 16000, 31000, 6, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Display Frontal Completo Motorola Moto G84', 12, 14000, 28000, 5, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Bateria Compatível iPhone 11 (3110mAh)', 13, 7500, 16000, 8, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Bateria Compatível Samsung Galaxy A32', 13, 6000, 13000, 7, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Bateria Compatível Moto G30', 13, 5500, 12000, 6, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Conector de Carga Type-C Universal (Unidade)', 14, 250, 2000, 100, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Conector de Carga Micro USB V8', 14, 150, 1500, 100, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Flex de Carga e Microfone Moto G9 Play', 14, 1800, 5500, 10, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Tampa Traseira de Vidro iPhone 12', 15, 4000, 11000, 4, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Câmera Traseira Principal Redmi Note 11', 14, 6500, 14000, 3, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Alto-Falante Auricular Universal', 14, 500, 2500, 40, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Barra de LED TV Samsung 50" (Kit com 3 barras)', 16, 11000, 23000, 4, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Barra de LED TV LG 43" (Kit com 3 barras)', 16, 9500, 19500, 5, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Placa Fonte TV Samsung UN50TU8000', 16, 16000, 31000, 2, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Placa Principal TV LG 43UP7500', 16, 21000, 42000, 2, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Cabo Flat T-Con para Display TV 55"', 16, 2200, 6500, 8, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Receptor Infravermelho para Controle Remoto TV', 14, 400, 2000, 15, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)', 10, 8500, 15000, 3, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Álcool Isopropílico 99.8% 1 Litro', 10, 2200, 4500, 12, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Fita Kapton Térmica 10mm x 33m', 10, 1200, 3000, 15, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Fita Dupla Face Fixação de Telas (3mm x 50m)', 10, 1500, 3500, 10, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Fusível de Louça 5A 250V (Pacote c/ 10)', 14, 500, 1800, 20, 7, (SELECT id_cargo FROM funcionario WHERE id = 7)),
('Capacitor Eletrolítico 1000uF x 25V', 14, 80, 500, 150, 7, (SELECT id_cargo FROM funcionario WHERE id = 7));

CREATE TABLE IF NOT EXISTS situacao(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL COLLATE NOCASE UNIQUE,
	status INTEGER NOT NULL DEFAULT 1
)
-- aberto, em diag, orçamento aprovado, em reparo, pronto, entregue, cancelado, descarte por defeito/avaria, Uso em Reparo (os)
--teste
INSERT INTO situacao (nome, status) VALUES ("Aberto",1),("Em Diagnóstico",1);
--todos
INSERT INTO situacao (nome, status) VALUES ("Orçamento Apovado",1),("Em reparo",1),("Pronto",1),("Entregue",1),("Cancelado",1),("Descarte por Defeito/Avaria",1),("Uso em Reparo (OS)",1);


CREATE TABLE IF NOT EXISTS forma_pagamento(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome TEXT NOT NULL COLLATE NOCASE UNIQUE,
	status INTEGER NOT NULL DEFAULT 1,
	data_criacao TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
	id_funcionario INTEGER NOT NULL,
	id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id,id_cargo)
);
--INSERT DE PAGAMENTOS 
-- 2.2. Formas de Pagamento (Cadastradas por Gerente - Cargo ID 1)
INSERT INTO forma_pagamento (
		nome,
		id_funcionario,
		id_funcionario_cargo
	)
VALUES
	('Dinheiro',6,1),
('PIX',6,1),
('Cartão de Débito',6,1),
('Cartão de Crédito - À Vista',6,1),
('Cartão de Crédito - Parcelado',6,1),
('Boleto Bancário',6,1);



CREATE TABLE IF NOT EXISTS ordem(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	id_equipamento INTEGER NOT NULL,
	defeito_relatado TEXT NOT NULL COLLATE NOCASE,
	defeito_constatado TEXT DEFAULT('') COLLATE NOCASE,
	data_abertura TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	data_fechamento TEXT,
	valor_total INTEGER,
	id_forma_pagamento INTEGER NOT NULL,
	id_funcionario_abertura INTEGER NOT NULL,
	id_funcionario_cargo_abertura INTEGER NOT NULL CHECK (
		id_funcionario_cargo_abertura = 1
		OR id_funcionario_cargo_abertura = 2
	),
	id_tecnico INTEGER NOT NULL,
	id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
	FOREIGN KEY (id_equipamento) REFERENCES equipamento(id),
	FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id),
	FOREIGN KEY (
		id_funcionario_abertura,
		id_funcionario_cargo_abertura
	) REFERENCES funcionario(id, id_cargo),
	FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;


CREATE TABLE IF NOT EXISTS ordem_situacao(
	id integer PRIMARY KEY AUTOINCREMENT,
	id_ordem integer NOT NULL,
	id_nova_situacao INTEGER NOT NULL,
	id_funcionario INTEGER NOT NULL,
	data_situacao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	FOREIGN KEY (id_ordem) REFERENCES ordem(id),
	FOREIGN KEY (id_nova_situacao) REFERENCES situacao(id),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario(id)
)STRICT;

CREATE TABLE IF NOT EXISTS ordem_peca(
	id integer PRIMARY KEY AUTOINCREMENT,
	id_ordem integer NOT NULL,
	id_peca INTEGER NOT NULL,
	preco INTEGER NOT NULL,
	quantidade INTEGER NOT NULL,
	data_saida TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
	FOREIGN KEY (id_ordem) REFERENCES ordem(id),
	FOREIGN KEY (id_peca) REFERENCES peca(id)
)STRICT;

CREATE TABLE IF NOT EXISTS ordem_servico(
	id integer PRIMARY KEY AUTOINCREMENT,
	id_ordem integer NOT NULL,
	id_servico INTEGER NOT NULL,
	preco_praticado INTEGER NOT NULL,
	quantidade_servicos INTEGER NOT NULL,
	data_execucao text NOT NULL DEFAULT (datetime('now','localtime')),
	FOREIGN KEY (id_ordem) REFERENCES ordem(id),
	FOREIGN KEY (id_servico) REFERENCES servicos(id)
)STRICT;

-- ==========================================
-- TESTES
-- ==========================================

SELECT * FROM peca p WHERE p.preco_venda > 10000;

CREATE VIEW vw_preco_venda_maior_100 AS SELECT id,nome,preco_venda, estoque_atual FROM peca p WHERE p.preco_venda > 10000;

SELECT * FROM vw_preco_venda_maior_100 vpvm ;

-- ==========================================
-- 2. POPULAÇÃO DE DADOS (DML)
-- ==========================================
INSERT
	INTO
	ordem (
		id_equipamento,
		defeito_relatado,
		defeito_constatado,
		data_abertura,
		data_fechamento,
		valor_total,
		id_forma_pagamento,
		id_funcionario_abertura,
		id_funcionario_cargo_abertura,
		id_tecnico,
		id_tecnico_cargo
	)
VALUES
-- OS 1: Troca de tela do iPhone 11 (Entregue)
	(
		1,
		'Tela quebrada após queda.',
		'Display frontal danificado, toque não responde.',
		'2026-09-01 09:30:00',
		'2026-09-02 16:00:00',
		50000,
		2,
		6,
		1,
		3,
		3
	),
-- OS 2: Upgrade de SSD em Notebook Dell (Pronto)
	(
		3,
		'Notebook muito lento para ligar.',
		'Lentidão provocada por HD mecânico antigo.',
		'2026-09-10 10:15:00',
		'2026-09-11 14:30:00',
		38000,
		1,
		6,
		1,
		3,
		3
	),
-- OS 3: Smart TV em diagnóstico
	(
		4,
		'TV com som, mas imagem não aparece.',
		'Barra de LED queimada.',
		'2026-09-15 11:00:00',
		NULL,
		NULL,
		1,
		6,
		1,
		3,
		3
	),
-- OS 4: Console PS5 (Em Reparo)
	(
		5,
		'Desligando por aquecimento.',
		'Acúmulo severo de poeira e necessidade de troca de pasta térmica.',
		'2026-09-20 14:20:00',
		NULL,
		NULL,
		4,
		6,
		1,
		3,
		3
	);
