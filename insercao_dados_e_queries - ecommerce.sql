use ecommerce;

insert into Cliente (Pnome, Mnome, Snome, CPF, razaoSocial, CNPJ, enderecoCliente)
	values('Maria', 'M', 'Silva', 12345678910, default, default, 'Rua Silva de Prata 29, Carangola - Cidade das Flores'),
		  ('João', 'D', 'Oliveira', 12845679135, default, default, 'Avenida Getulio Vargas 1506, Centro - Cidade das Flores'),
          (null, null, null, null, 'Cursinho do Paulo', 215963213000177, 'Avenida do Contorno 1220, Boa Vista - Cidade das Flores'),
          (null, null, null, null, 'Papelaria Alpha', 233447713000177, 'Avenida do Contorno 350, Boa Vista - Cidade das Flores'),
          ('Kléber', 'T', 'Neves', 15894445125, default, default, 'Rua Prof Fortes Silva 56, Centro - Cidade das Flores'),
          ('Otávio', 'L', 'Cruz', 55631124584, default, default, 'Rua Silva de Prata 685, Carangola - Cidade das Flores'),
          ('Natalia', 'J', 'Assis', 12564875915, default, default, 'Rua Dr Pablo Junior 115, Serrinha - Cidade das Flores');
          
insert into Produto (NomeProd, classificacao_crianca, categoriaProd, avaliacaoProd, valorProd)
	values('Fone de ouvido', false, 'Eletronico', '4', 50.0),
		  ('Barbie Elsa', true, 'Brinquedos', '3', 120.0),
          ('Casaco de couro', false, 'Vestimenta', '5', 330.0),
          ('Microfone RGB Youtuber', false, 'Eletronico', '4', 210.0),
          ('Sofá retrátil', false, 'Móveis', '4', 600.0),
          ('Max Steel - Selva', true, 'Brinquedos', '2', 180.0),
          ('KitKat - caixa', false, 'Alimentos', '5', 35.0);
          
insert into Pagamento (idClientePag, idPagamento, formaDePagamento, limiteCartao)
	values(2, 1, 'Boleto', default),
          (3, 2, 'Cartão crédito', 4000.0);          
          
insert into Pedido (idPedidoCliente, idFormaPagamento, statusPedido, descricaoPedido, fretePedido, idDinheiro)
	values(1, default, default, 'compra via aplicativo', default, 1),
		  (2, 1, default, 'compra via aplicativo', 50, 0),
          (3, 1, 'Confirmado', default, default, 0),
          (4, default, default, 'compra via web site', 150, 1),
          (5, 1, default, 'Confirmado', default, 1),
          (6, default, 'Cancelado', 'compra via web site', default, 1),
          (7, 1, default, 'compra via aplicativo', 90, 0);
	
insert into PedidosProdutos (idPedidos, idProdutos, quantidadeProdPed, statusProdutos)
	values(1, 1, 5, default),
          (2, 2, 10, default),
          (3, 3, 3, default),
          (4, 4, 12, default),
          (5, 2, 5, default),
          (6, 6, 12, default),
          (7, 7, 3, default);
          
insert into Estoques (localizacao, quantidade)
	values('Rio de Janeiro', 1000),
		  ('Rio de Janeiro', 500),     
          ('São Paulo', 10),
          ('São Paulo', 100),
          ('São Paulo', 50),
          ('Brasília', 60);

insert into ProdutosEstoque (idEstoque, idProdEstoque, localizacao, statusProdutos)
	values(1, 2, 'RJ', default),
		  (2, 5, 'SP', default);
          
insert into Fornecedor (razaoSocial, CNPJ, telefone)
	values('Almeida e Filhos', 567852145000156, 11458622369),
		  ('Eletrônicos Silva', 344759158000142, 11123445267),
          ('Magazine Tem de Tudo', 336147123000111, 11112876954);
          
insert into ProdutosFornecedor (idForn, idProdForn, quantidade)
	values(1, 1, 500),
          (1, 2, 400),
          (2, 4, 633),    
          (3, 3, 5), 
          (2, 5, 10); 
          
insert into Vendedor (razaoSocial, CNPJ, NomeVendedor, CPF, localizacao, telefone)
	values('Tech Eletronics', 556489123000120, default, default, 'Rio de Janeiro', 21488822369),
		  ('Botique Durgas', 536948123000120, default, default, 'São Paulo', 11123441758),
          (Null, Null, 'João Gomes Pereira', 12566512348, 'Rio de Janeiro', 21447123523);
          
insert into ProdutosVendedor (idVendPlataforma, idProdVendedor, quantidadeProd)
	values(1, 6, 80),
          (2, 3, 10);
          
-- #################### Queries ####################        

-- Andamento dos pedidos do clientes
select concat(Pnome,' ',Mnome,' ',Snome) as Clientes_PF, razaoSocial as Clientes_PJ, idPedido as Número_do_Pedido, statusPedido as Andamento_do_pedido
	from cliente c, pedido p
    where c.idCliente = p.idPedidoCliente;

-- Descrição completa dos pedidos dos clientes
select * from cliente c
	inner join pedido p
    on c.idCliente = p.idPedidoCliente
    inner join pedidosprodutos pp on pp.idPedidos = p.idPedido;

-- Numero de pedidos realizados pelos clientes
select idCliente, Pnome, razaoSocial, count(*) as Número_de_pedidos from cliente inner join pedido on idCliente = idPedidoCliente
	inner join produto on idProduto = idPedido
	group by idCliente;

-- Relação entre produtos, fornecedores e estoque
select nomeProd, razaoSocial, quantidade from ProdutosFornecedor inner join fornecedor inner join produto
	on idFornecedor = idForn and idProduto = idProdForn;
    
-- Informações completas sobre os vendedores
select NomeVendedor, razaoSocial, nomeProd, quantidadeProd from ProdutosVendedor inner join Vendedor inner join produto
	on idVendedor = idVendPlataforma and idProduto = idProdVendedor
    order by quantidadeProd;
    
	

