CREATE TABLE produto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_produto TEXT NOT NULL COLLATE NOCASE UNIQUE,
    estoque_atual INTEGER NOT NULL CHECK (estoque_atual >= 0)
) STRICT;

CREATE TABLE venda_item (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_produto INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    data_venda TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_produto) REFERENCES produto(id)
) STRICT;

INSERT INTO produto (nome_produto, estoque_atual) VALUES
('Arroz Branco Tipo 1 (5kg)', 30),
('Feijão Carioca (1kg)', 25),
('Óleo de Soja (900ml)', 40),
('Açúcar Cristal (1kg)', 35),
('Café Torrado e Moído (500g)', 20),
('Macarrão Espaguete (500g)', 30),
('Molho de Tomate (340g)', 50),
('Sal Refinado (1kg)', 15),
('Leite Integral Longa Vida (1L)', 60),
('Manteiga com Sal (200g)', 12),
('Pão de Forma Tradicional (500g)', 10),
('Queijo Mussarela Fatiado (150g)', 18),
('Refrigerante Cola (2L)', 25),
('Água Mineral sem Gás (500ml)', 100),
('Sabão em Pó (1kg)', 20),
('Detergente Líquido (500ml)', 45),
('Papel Higiênico Folha Dupla (Pacote com 4 rolos)', 30),
('Pasta de Dente (90g)', 25),
('Sabonete em Barra (85g)', 50),
('Maçã Gala (Quilograma)', 15);

INSERT INTO venda_item (id_produto,quantidade) values (2,25);

CREATE TRIGGER trg_bf_valida_estoque_venda_item
	BEFORE INSERT ON venda_item
	FOR EACH ROW
	BEGIN
		SELECT RAISE(ABORT, 'Operação negada: Quantidade solicitada é superior ao estoque disponível.')
		WHERE NEW.quantidade > (
		SELECT estoque_atual
		FROM produto
		WHERE id = NEW.id_produto
	);
END;
 

