use Oficina;

insert into Cliente (NomeCliente, CPF, Endereco, Contato)
	values('Maria Martins Silva', 12345678910, 'Rua Silva de Prata 29, Carangola - Cidade das Flores', 11364587125),
		  ('João Diego Oliveira', 12845679135, 'Avenida Getulio Vargas 1506, Centro - Cidade das Flores', 21554268859),
          ('Kléber Toledo Neves', 15894445125, 'Rua Prof Fortes Silva 56, Centro - Cidade das Flores', 11241256634),
          ('Otávio Luiz Cruz', 55631124584, 'Rua Silva de Prata 685, Carangola - Cidade das Flores', 21352645512),
          ('Natalia Galdino Assis', 12564875915, 'Rua Dr Pablo Junior 115, Serrinha - Cidade das Flores', 32988885662);
          
insert into Responsavel (idResponsavel, NomeResp, Departamento)
	values(1, 'João Pedro Lima', 'motor'),
		  (2, 'Natalia Lima Silva', 'pintura'),
          (3, 'Luiz Castro e Paiva', 'motor'),
          (4, 'Marcelo Oliveira Pereira', 'rodas'),
          (5, 'Tiago Ricardo Neves', 'rodas');
          
						
insert into Pedido (Descricao, NivelUrgencia, Liberado, TipoServico, Cliente_idCliente)
	values('Barulho estranho no motor', 'alta', 'nao', 'Manutencao', 1),
		  ('Periodica', 'baixa', 'sim', default, 3),
          ('Batida na porta', 'media', 'nao', 'Manutencao', 2),
          ('Batida na porta', 'media', 'nao', 'Manutencao', 1),
          ('Troca de óleo', 'baixa', 'sim', default, 4),
          ('Eixo desalinhado', 'media', 'nao', 'Manutencao', 5);
          
          
insert into OrdemServico (StatusDaOs, Pedido_idPedido)
	values('Na fila', 1),
		  ('Em andamento', 2),
          ('Em andamento', 3),
          (default, 4),
          (default, 5),
          ('Liberada', 6);     
          

insert into ResponsaveisPedidos (Pedido_idPedido, Responsavel_idResponsavel)
	values(1, 3),
		  (2, 4),
          (3, 2),
          (4, 2),
          (5, 5),
          (6, 1); 

          
-- #################### Queries ####################        

-- Visualização dos dados
select * from Cliente;
select * from Responsavel;
select * from Pedido;
select * from OrdemServico;
select * from ResponsaveisPedidos;

-- Andamento dos pedidos do clientes
select NomeCliente, StatusDaOs
	from Pedido, OrdemServico, Cliente
    where Pedido_idPedido = idPedido and Cliente_idCliente = idCliente;

-- Descrição completa dos pedidos dos clientes ordenado por urgencia
select Descricao, Departamento, TipoServico, NivelUrgencia
	from Pedido, ResponsaveisPedidos, Responsavel, Cliente
    where idPedido = Pedido_idPedido and Cliente_idCliente = idCliente and Responsavel_idResponsavel = idResponsavel
    order by NivelUrgencia; 
    
-- Numero de pedidos realizados pelos clientes
select idCliente, NomeCliente, count(*) as NumeroDePedidos from cliente inner join pedido on idCliente = cliente_idcliente
	group by idCliente;
    
-- Clientes problemas recorrentes
select idCliente, NomeCliente, count(*) as NumeroDePedidos from cliente inner join pedido on idCliente = cliente_idcliente
	group by idCliente
    having count(*)>1;
	

    
    