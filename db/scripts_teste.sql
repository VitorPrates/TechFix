--ativa as chaves estrangeiras
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










