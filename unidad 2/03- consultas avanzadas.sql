use Northwind
-- seleccionar todos las categorias y productos 
select * from 
 Categories
 inner join
 Products 
 on Categories.CategoryID =Products.CategoryID;

select Categories.CategoryID, CategoryName, ProductName, UnitsInStock, 
UnitPrice from
Categories 
inner join 
Products 
on Categories.CategoryID = Products.CategoryID; 

select c.CategoryID as [numero de categoria], CategoryName as 'nombre categoria', ProductName as 'nombre de producto', UnitsInStock as 'existencia', 
UnitPrice as precio from
Categories as c
inner join 
Products as p
on c.CategoryID = p.CategoryID; 

-- seleccionar los productos de la categoria beverges y condiments 
-- donde la existencia este entre los 18 y 30
select * from Products as p 
join Categories as ca
on p.CategoryID = ca.CategoryID 
where (Ca.CategoryName = 'beverges' or ca.CategoryName = 'condiments')
and (p.UnitsInStock>=18 and p.UnitsInStock<=30)

select * from Products as p 
join Categories as ca
on p.CategoryID = ca.CategoryID 
where Ca.CategoryName in ('beverges','condiments')
and p.UnitsInStock between 18 and 30 ;

--seleccionar los productos y sus importes realizados de marzo a junio
-- de 1996, mostrando la fecha de la orden, el id del producto y el importe

select o.OrderID, o.OrderDate, od.ProductID, 
(od.UnitPrice * od.Quantity) as importe
from Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-30'

select getdate()

--mostrar el importe total de ventas de la consulta anterior
select concat('$',' ',sum(od.Quantity * od.UnitPrice)) from 
Orders as o
inner join [Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-30'


use Northwind
select * from Orders
-- CONSULTAS BASICAS CON INNER JOIN
--1- OBTENER LOS NOMBRES DE LOS CLIENTES Y LOS PAISES A LOS QUE SE ENVIARON SUS PEDIDOS
select o.CustomerID as 'nombre del cliente', o.ShipCountry as 'pais de envio' from Orders as o
inner join Customers as c
on c.CustomerID = o.CustomerID
order by o.ShipCountry desc
--2- OBTENER LOS PRODUCTOS  Y SUS RESPECTIVOS PROVEDORES
select p.ProductName as 'nombre del  producto', s.CompanyName as [nombre del provedor]
from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID
--3- OBETENER LOS PEDIDOS Y LOS EMPLEADOS QUE LOS GESTIONARON
select o.OrderID, concat (e.Title ,'-', e.FirstName, '-', e.LastName) as 'nombre' from 
Orders as o
inner join 
Employees as e
on o.EmployeeID = e.EmployeeID

-- 4- listar los productos junto con sus precios y la categoria a la que pertenecen
select p.ProductName, p.UnitPrice, c.CategoryID from Products as p
inner join 
Categories as c
on p.ProductID = c.CategoryID
--5- obtener el nombre del cliente, el numero de orden y la fecha de orden 

select c.CompanyName as'nombre ', o.OrderID as 'numero de orde', o.OrderDate as 'fecha de order' from 
 Customers as c
inner join
orders   as o
on c.CustomerID = o.CustomerID

--6- listar las ordenes mostrando el numero de orden, el nombre del producto
--y la cantidad que se vendio
select od.OrderID as 'numero de orden',p.ProductName as 'nombre de producto', od.Quantity as 'cantidad'  from 
 Products as P
inner join
[Order Details]  as od
on  P.ProductID= od.ProductID

select top 5 od.OrderID as 'numero de orden',p.ProductName as 'nombre de producto', od.Quantity as 'cantidad'  from 
 Products as P
inner join
[Order Details]  as od
on  P.ProductID= od.ProductID

select  od.OrderID as 'numero de orden',p.ProductName as 'nombre de producto', od.Quantity as 'cantidad'  from 
 Products as P
inner join
[Order Details]  as od
on  P.ProductID= od.ProductID
where od.OrderID ='11031'
order by od.Quantity desc
--7- obtener los empleados y sus respectivos jefes
select  CONCAT(e1.FirstName,'',e1.LastName) as [empleado],
concat (j1.FirstName,'',j1.LastName) as [jefe] from  Employees as e1
inner join Employees as j1
on e1.ReportsTo = j1.EmployeeID

select  FirstName, ReportsTo from Employees

--8- listar los pedidos y el nombre de la empresa utilizada
select o.OrderID, s.CompanyName from Orders as o
inner join
Shippers as s
on o.ShipVia = s.ShipperID

-- consultas inner join intermedias
--9 obtener la cantidad total de productos vendidas por categoria
select c.CategoryName as 'nombre categoria', sum(Quantity) as 'productos vendidos' 
from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName

--10 obtener el total de ventas por empleado

select *
from Orders as o
inner join 
Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID

select e.FirstName, sum((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount)
as total
from Orders as o
inner join 
Employees as e
on o.EmployeeID = e.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by e.FirstName, e.LastName

--11 LISTAR LOS CLIENTES Y LA CANTIDAD DE PEDIDOS QUE HAN REALIZADO
select c.CompanyName as [cliente], count(*) as [numero de ordenes] from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
group by c.CompanyName 
order by [numero de ordenes] desc

select c.CompanyName as [cliente], count(*) as [numero de ordenes] from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
group by c.CompanyName 
order by 2 desc

select c.CompanyName as [cliente], count(*) as [numero de ordenes] from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
group by c.CompanyName 
order by count(*) desc

--12 OBTENER LOS EMPLEADOS QUE AN GESTIONADO PEDIDOS ENVIADOS A ALEMANIA 
select distinct concat (e.FirstName, '', e.LastName) as [nombre] from Employees as e
inner join Orders as o
on  e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'
--13 LISTAR LOS PRODUCTOS JUNTO CON EL NOMBRE DEL PROVEDOR Y EL PAIS DE ORIGEN
select p.ProductName as [nombre producto], s.CompanyName as [provedor],
s.Country as [pais de origen] from Products as p
inner join Suppliers as s
on p.SupplierID = s.SupplierID
order by 1 asc

--14 obtener los pedidos agrupados por pais de envio
select e1.OrderID as [pedido],
j1.ShipCountry as [país] from  Orders as e1
inner join Orders as j1
on e1.OrderID = j1.ShipCountry

select o.ShipCountry as [país de envio], count (o.OrderID) 
as [numero de ordenes] from Orders as o
group by o.ShipCountry
order by 2 desc



--15 obtener los empleados y la cantidad de territorios en los que trabajan
select e.FirstName as [empleado], t.TerritoryID  from Employees as e
inner join EmployeeTerritories as t
on e.EmployeeID = t.EmployeeID

select concat(e.FirstName, '', e.LastName ) as [nombre],
count(et.TerritoryID) as [cantidad de territorios] from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by concat(e.FirstName, '', e.LastName )

select concat(e.FirstName, '', e.LastName ) as [nombre],
t.TerritoryDescription,
count(et.TerritoryID) as [cantidad de territorios] from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t 
on et.EmployeeID = t.TerritoryID
group by concat(e.FirstName, '', e.LastName )
order by [nombre], t.TerritoryDescription desc

--16 listar las categorias y la cantidad de productos que contienen
select c.CategoryID as [categoria], p.UnitsInStock as [productos] from Categories as c
inner join Products as p
on c.CategoryID = p.ProductID

select c.CategoryName as [categoria], count(p.ProductID) as [cantidad de producto]  from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
group by c.CategoryName 
order by 2 desc

--17 obtener la cantidad total de productos  vendidos por proveedor
select s.ContactTitle ,  count (p.ProductName)  from Products as p
inner join Suppliers as s
on p.ProductID = s.SupplierID

select s.CompanyName as [provedor], sum(od.Quantity) as [total de productos vendidos] from Suppliers as s
inner join Products as p
on s.SupplierID = p.SupplierID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName
order by 2 desc
--18 obtener la cantidad de pedidos enviados por cada empresa de transporte
select * from Products as p
inner join 
--CONSULTAS AVANZADAS


