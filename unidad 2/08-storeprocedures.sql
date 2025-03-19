--store procedure
-- crear un store procedure para seleccionar todos los clientes
create or alter procedure spu_mostrar_clientes
as 
begin
select * from Customers
end;
go

--ejecutar un store en transacc
exec spu_mostrar_clientes

--crear un sp que muestre los clientes por pais  
--parametros de entrada

create or alter proc spu_customersporpais
--parametros
@pais nvarchar(15), @pais2 nvarchar --´parametro de entrada
as 
begin
   select * from Customers
   where Country  in (@pais, @pais2);
end;

--ejecuta un store procedure
declare @p1 nvarchar(15) = 'spain'
declare @p2 nvarchar(15) = 'germany'
exec spu_customersporpais @p1, @p2;

exec spu_customersporpais 'spain', 'mexico'

--generar un reporte q permita visualizar los datos de compra de un determinado cliente en un rango de fechas
--mostrando el monto total de compras por producto, mediante un sp
use Northwind
go

create or alter proc spu_informe_Ventas_clientes
@nombre nvarchar(40) = 'Berglunds snabbköp', -- parametro de entrada con valor por default
@fechainicial datetime,
@fechafinal datetime 
as
begin
select [nombre de producto],[nombre de cliente],  sum (importe) as [monto total]
from vistasordenescompra
where [nombre de cliente] = @nombre
and [fecha de orden] between @fechainicial and @fechafinal
group by [nombre de producto], [nombre de cliente]
end
go


select * from Customers
select getdate()
--ejecucion de un store con parametros de entrada
exec spu_informe_Ventas_clientes 'Berglunds snabbköp',
                                 '1996-07-04','1997-01-01'    

--ejecucion de un store procedure con parametros en diferente posicion
exec spu_informe_Ventas_clientes @fechafinal = '1997-01-01',
                                  @nombre = 'Berglunds snabbköp',
								   @fechainicial = '1996-07-04'

--ejecucion de un store procedure con parametros de entrada
-- con un campo que tiene valor por default
exec spu_informe_Ventas_clientes @fechainicial =  '1996-07-04',
                                 @fechafinal = '1997-01-01'    

go
-- store procedure con parametros de salida
create or alter proc spu_obtener_numero_clientes
@customerid nchar(5), --parametro de entrada
@totalcustomers int output --parametro de salida
as
begin

select @totalcustomers=count(*) from Customers
where CustomerID = @customerid;
end;
go

declare @numero int;

exec spu_obtener_numero_clientes @customerid = 'ANATR',
                                  @totalcustomers = @numero output;
print @numero;
go


-- crear un store procedure que permita saber si un alumno aprobo o reprobo

create or alter proc spu_comparar_calificacion
@calif decimal(10,2) -- parametro de entrada
as 
begin
if @calif>=0 and @calif<=10
begin
if @calif>=8
print 'la calificacion es aprovatoria'
else 
print 'la calificacion es reprovatoria'
end
else
print 'calificacion no valida'
end;
go

exec spu_comparar_calificacion @calif = 8


-- crear un sp que permita verificar si un cliente existe
--antes de devolver su informacion

create or alter proc spu_obtener_cliente_siexiste
@numeroCliente nchar(5)
as 
begin
if exists (select 1 from Customers where CustomerID = @numeroCliente)
select * from Customers where CustomerID = @numeroCliente;
else print 'el producto no existe'
end;
go

select 1 from Customers where CustomerID = 'AROUT'

exec spu_obtener_cliente_siexiste @numeroCliente = 'uwu'

--crear un sp que permita insertar un cliente pero se debe verificar
--primero que no exista 
use Northwind

create or alter procedure spu_agregar_cliente
@id nchar(5),
@nombre nvarchar (40),
@city nvarchar(15) = 'San Miguel'
as
begin
if exists (select 1 from  Customers where CustomerID = @id)
begin
print ('el cliente ya existe')
return 1
end
insert into Customers (CustomerID, CompanyName)
values(@id, @nombre);
print('cliente insertado exitosamente');
return 0;

end;
go

exec spu_agregar_cliente 'ALFKI', 'Patito de Hule'

exec spu_agregar_cliente 'ALFKI', 'Patito de Hule'

go

go
create or alter procedure spu_agregar_cliente_try_catch
@id nchar(5),
@nombre nvarchar (40),
@city nvarchar(15) = 'San Miguel'
as
begin

begin try 
insert into Customers (CustomerID, CompanyName)
values(@id, @nombre);
print('cliente insertado exitosamente');
 end try

 begin catch
 print ('el cliente ya existe')

 end catch
end;

exec spu_agregar_cliente 'ALFKId', 'muñeca vieja'

-- MENEJO DE CICLOS EN STORES
-- IMPRIMIR EL NUMERO DE VECES QUE INDIQUE EL USUARIO

create or alter procedure spu_imprimir 
@numero int
as
begin
if @numero<=0
begin
print('el numero no puede ser 0 o negativo')
return
end

declare @i int
set @i = 1
while(@i<=@numero)
begin
print concat('Numero' , @i)
end

end;
go
exec spu_imprimir @numero = 10