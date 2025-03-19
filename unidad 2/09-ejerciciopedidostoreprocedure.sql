-- REALIZAR UN PEDIDO 
--VALIDAR QUE EL PEDIDO NO EXISTA
-- VALIDAR QUE EL CLIENTE EXISTA, QUE EL EMPLEADO EXISTA Y PRODUCTO EXISTA
-- VALIDAR QUE LA CANTIDAD A VENDER TENGA SUFICIENTE STOCK
-- INSETAR EL PEDIDO Y CALCULAR EL IMPORTE(MULTIPLICANDO EL 
--PRECIO DEL PRODUCTO POR LA CANTIDAD VENDIDA)
-- ACTALIZAR EL STOCK DEL PRODUCTO(RESTANDO EL STOCK MENOS LA CANTIDAD
--VENDIDA)
create or alter proc spu_RealizarPedido
@numPedido int, @cliente int,
@repre int, @fab char(3), 
@proceducto char(5), @cantidad int
as 
begin
	if exists (select 1 from Pedidos where Num_Pedido = @numPedido) -- verificamos si el pedido existe
	begin
	print 'el pedido ya existe'
	return
	end 
	if	not exists (select 1 from Clientes where Num_Cli = @cliente) or -- verificamos si el cliente existe
		not exists (select 1 from Representantes where Num_Empl = @repre) or
		not exists (select 1 from Productos where Id_fab= @fab and Id_producto = @proceducto) 
	begin
	print 'el pedido ya existe'
	return
	end 

	if @cantidad <= 0
	begin 
		print 'la cantidad no puede ser 0 o negativo'
		return ;
	end
	declare @stockvalido int
	select @stockvalido= Stock from Productos
	where Id_fab = @fab and Id_producto = @proceducto

		if @cantidad > @stockvalido
	begin 
		print 'no hay suficiente stock'
		return;
	end
	declare @precio money
	declare @importe money 
	select @precio = Precio  from   Productos where Id_fab = @fab  and Id_producto = @proceducto
	
	set @importe= @cantidad * @precio

	begin try
	-- se inserto un pedido
	insert into Pedidos
	values(@numPedido, GETDATE(), @cliente, @repre, @fab, @proceducto, @cantidad,@importe)

	update Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fab and Id_producto = @proceducto;

	end try
	begin catch
	print 'Error al actualizar datos'
	return;
	end catch
end;
go
exec spu_realizar_pedido @numPedido = 113070, @cliente = 2000,
@repre = 106, @fab = 'REI',
@producto = '2A4L', @cantidad = 20
 select * from Pedidos

 exec spu_realizar_pedido @numPedido = 113070, @cliente = 2117,
@repre = 111, @fab = 'REI',
@producto = '2A4L', @cantidad = 20

 exec spu_realizar_pedido @numPedido = 113070, @cliente = 2117,
@repre = 101, @fab = 'ACI',
@producto = '4100X', @cantidad = 20

select * from Productos
where Id_fab = 'ACI' and Id_producto = '4100x'

