-- VIEWS

-- sintaxis
/*create view nombreVista
as 
select columnas
where condicion*/

use Northwind
go
create view VistacategoriasTodas
as 
select CategoryID, CategoryName, [Description], Picture from Categories
go

alter view VistacategoriasTodas
as 
select CategoryID, CategoryName, [Description], Picture from Categories
where CategoryName = 'Beverages'
go

create or alter view VistacategoriasTodas
as 
select CategoryID, CategoryName, [Description], Picture from Categories
where CategoryName = 'Beverage'
go

select * from VistacategoriasTodas
where CategoryName = 'Beverages'

-- crear una vista que permita visualizar los clientes de mexico y brazil
select * from Customers 
go
drop view VistaClientesLatinos
create or alter view VistaClientesLatinos
as 
select ContactName, Country from Customers
where Country = 'Mexico' or Country= 'Brazil'
go
select CompanyName as [cliente], City as [ciudad], Country from VistaClientesLatinos
where city = 'Sao Paulo'
order by 2 desc


select distinct vcl.Country from Orders
as o 
inner join VistaClientesLatinos as vcl
on vcl.CustomerID = o.CustomerID


-- crear una vista que contenga los datos de todas las ordenes 
-- los productos,empleados , clientes,  categorias de productos, orden, calcular el importe

create or alter view [dbo].[vistasordenescompra]
as
select o.OrderID as [numero de orden], o.OrderDate,
o.OrderDate as [fecha de orden] , o.RequiredDate as [fecha de requisiscion],
concat (e.FirstName, '', e.LastName) as [nombre de empleado], cu.CompanyName as [nombre de cliente],
p.ProductName as [nombre de producto], c.CategoryName as [nombre de categoria],
od.UnitPrice as [precio de venta], od.Quantity [cantidad vendida],
(od.Quantity *od.UnitPrice ) as [importe]
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as cu
on cu.CustomerID = o.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID
go

select sum (importe) as [importe total]
from vistasordenescompra
where year ([fecha de orden]) between '1995' and '1996'
go


create or alter view vista_ordenes_1995_1996
as
select [nombre de cliente] as 'nombre cliente'  ,sum (importe) as [importe total]
from vistasordenescompra
where year ([fecha de orden]) between '1995' and '1996'
group by [nombre de cliente]
having count (*)>2
go

create schema rh

create table rh.tablarh (
id int primary key,
nombre varchar(50)
)


-- vista horizontal
create or alter view rh.viewcategoriasproductos
as
select c.CategoryID,  CategoryName, p.ProductID, p.ProductName from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID;
go

select * from rh.viewcategoriasproductos


-- vista vertical 