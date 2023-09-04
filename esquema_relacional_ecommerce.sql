-- Criação do banco de dados  - Desafio E-commerce

-- drop database ecommerce;

create database ecommerce;
use ecommerce;

-- ###### criar tabela cliente ######

create table Cliente (
	idCliente int auto_increment primary key,
    Pnome varchar(15) default null,
    Mnome varchar(3) default null,
    Snome varchar(15) default null,
    CPF char(11) default null,
	razaoSocial varchar(255) default null,
    CNPJ char(15) default null,
    enderecoCliente varchar (255),
    constraint cpf_unico_cliente unique (CPF),
    constraint cnpj_unico_cliente unique (CNPJ)
);

alter table Cliente auto_increment=1;

-- ###### criar tabela produto ######

create table Produto (
	idProduto int auto_increment primary key,
    NomeProd varchar(30) not null,
    classificacao_crianca bool default false,
    categoriaProd enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliacaoProd float default 0,
    valorProd float not null
);

alter table Produto auto_increment=1;

-- ###### criar tabela pagamento ######

create table Pagamento(
	idClientePag int,
    idPagamento int,
    formaDePagamento enum('Boleto', 'Cartão crédito', 'Cartão débito'),
    limiteCartao float,
    primary key(idPagamento, idClientePag)
);

-- ###### criar tabela pedido ######

create table Pedido (
	idPedido int auto_increment primary key,
    idPedidoCliente int, 
    idFormaPagamento int,
	statusPedido enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    descricaoPedido varchar(255),
    fretePedido float default 10,
    idDinheiro bool default false,
    constraint fk_pedido_cliente foreign key (idPedidoCliente) references Cliente(idCliente),
    constraint fk_forma_pagamento foreign key (idFormaPagamento) references Pagamento(idPagamento)
);

alter table Pedido auto_increment=1;

-- ###### criar tabela estoque ######

create table Estoques (
	idProdEstoques int auto_increment primary key,
    quantidade int default 0,
    localizacao varchar(255)
);

alter table Estoques auto_increment=1;

-- ###### criar tabela fornecedor ######

create table Fornecedor (
	idFornecedor int auto_increment primary key,
    razaoSocial varchar(255) not null,
    CNPJ char(15) not null,
    telefone char(11) default 0,
    constraint cnpj_unico_fornecedor unique (CNPJ)
);

alter table Fornecedor auto_increment=1;

-- ###### criar tabela vendedor ######

create table Vendedor (
	idVendedor int auto_increment primary key,
    razaoSocial varchar(255),
    CNPJ char(15),
    NomeVendedor varchar(45) default null,
    CPF char(11) default null,
    localizacao varchar(255),
    telefone char(11) default 0,
    constraint cnpj_unico_vendedor unique (CNPJ),
    constraint cpf_unico_vendedor unique (CPF)
);

alter table Vendedor auto_increment=1;

-- ###### criar tabela produtos/vendedor ######

create table ProdutosVendedor (
	idVendPlataforma int,
    idProdVendedor int,
    quantidadeProd int default 1,
    primary key (idProdVendedor, idVendPlataforma),
    constraint fk_vendedor_plataforma foreign key (idVendPlataforma) references Vendedor(idVendedor),
    constraint fk_produtos_vendedor foreign key (idProdVendedor) references Produto(idProduto)
);

-- ###### criar tabela PedidosProdutos ######

create table PedidosProdutos (
	idPedidos int,
    idProdutos int,
    quantidadeProdPed int default 1,
    statusProdutos enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPedidos, idProdutos),
    constraint fk_pedidos foreign key (idPedidos) references Pedido(idPedido),
    constraint fk_produtos foreign key (idProdutos) references Produto(idProduto)
);

-- ###### criar tabela LocalizaçãoEstoque ######

create table ProdutosEstoque (
	idEstoque int,
    idProdEstoque int,
    localizacao varchar(255),
    statusProdutos enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idEstoque, idProdEstoque),
    constraint fk_estoque foreign key (idEstoque) references Estoques(idProdEstoques),
    constraint fk_produtos_em_estoque foreign key (idProdEstoque) references Produto(idProduto)
);

-- ###### criar tabela produtos/fornecedor ######

create table ProdutosFornecedor (
	idForn int,
    idProdForn int,
    quantidade int not null,
    primary key (idForn, idProdForn),
    constraint fk_forn foreign key (idForn) references Fornecedor(idFornecedor),
    constraint fk_prod_forn foreign key (idProdForn) references Produto(idProduto)
);