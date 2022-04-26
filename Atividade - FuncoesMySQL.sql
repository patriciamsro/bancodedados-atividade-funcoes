use venda;

/* BD Venda 
Cliente(codCliente, nome, Endereco, Telefone, CNPJ)
Categoria(codCat,nomeCategoria)
Produto(codProduto,nome,valorUnit,quantidade,#codCat)
Pedido(codPedido,#codCliente, dataCompra,valorTotal,status)
ItemPedido(codItem,#codProduto,#codPedido,quantidade, valorItem)
Entrada(cod_Entrada, dataEntrada, codProduto, qtde_produto)
  */

/*1) Crie uma função to_br_date que receba como entrada um tipo date e retorne uma data no padrão brasileiro(dd/mm/yyyy)*/
delimiter |
create function to_br_date(var_data date)
returns varchar(10)
begin
	declare var_data_formatada varchar(10);
	set var_data_formatada = concat(day(var_data), "/", month(var_data), "/", year(var_data));
	return var_data_formatada;
end |
Delimiter ;

select to_br_date('2022-09-01');


/*2) Crie uma função que dada uma data, retorne o nome do dia da semana (segunda-feira, terça-feira, etc) no qual aquela data ocorreu.*/
delimiter |
create function mostrar_dia_semana(var_data date)
returns varchar(20)
begin
	declare var_dia_semana varchar(30);
	declare var_dia int;
	set var_dia = weekday(var_data);
    if(var_dia = 0) then
		set var_dia_semana = 'segunda-feira';
	else if(var_dia = 1) then
		set var_dia_semana = 'terça-feira';
	else if(var_dia = 2) then
		set var_dia_semana = 'quarta-feira';
	else if(var_dia = 3) then
		set var_dia_semana = 'quinta-feira';
	else if(var_dia = 4) then
		set var_dia_semana = 'sexta-feira';
	else if(var_dia = 5) then
		set var_dia_semana = 'sábado';
	if(var_dia = 6) then
		set var_dia_semana = 'domingo';
    end if;
	end if;
	end if;
	end if;
	end if;
	end if;
	end if;
	return var_dia_semana;
end |
Delimiter ;

drop function mostrar_dia_semana;
select mostrar_dia_semana('2022-04-19');


/* 3) Crie uma função para formatar um CNPJ no padrão xx.xxx.xxx/xxxx-xx */
delimiter |
create function formatar_cnpj(var_cnpj varchar(16))
returns varchar(20)
begin
	declare cnpj_formatado varchar(20);
    set cnpj_formatado = (concat(substring(var_cnpj, 1,2),'.',substring(var_cnpj, 3,3),'.',substring(var_cnpj, 6,3), '/', substring(var_cnpj, 9,4),'-',substring(var_cnpj, 13,2)));
	return cnpj_formatado;
end |
Delimiter ;

select formatar_cnpj(10512767000153);


/*4) Crie um procedimento que liste o valor médio das vendas realizadas por dia da semana, recebendo como parâmetro o ano e o mês.
Se o valor do mês estiver null, listar para todos os meses do ano. Mostrar o nome do dia da semana e a média. */
delimiter |
create procedure media_vendas_semana(var_ano int, var_mes int)
begin
	if(var_mes is null) then
		select mostrar_dia_semana(dataCompra) semana, avg(valorTotal) total 
		from Pedido
        where year(dataCompra) = var_ano
		group by semana;
	else
		select mostrar_dia_semana(dataCompra) semana, avg(valorTotal) total 
		from Pedido
        where year(dataCompra) = var_ano and month(dataCompra) = var_mes
		group by semana;
	end if;
end |
Delimiter ;
