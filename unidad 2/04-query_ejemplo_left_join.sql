-- Ejemplo de left join aplicado

use northwind

select * from products_new

drop table products_new

-- Crear un tabla a partir de una consulta 
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

-- crea la tabla con solo la estructura
select top 0 p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

-- Con alias
select top 0 0 as [productbk] ,p.ProductID, p.ProductName as [producto]
,[cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID
-- Carga Full

insert into products_new
select 0 as [bkproduct], p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE()
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID

alter table products_new
add constraint pk_products_new
primary key (productbk) 

-- Crear la tabla mediante consulta y se agrega el campo identidad
-- y calve primaria despues

drop table products_new

select top 0 p.ProductID, p.ProductName as [producto]
,[cu].CompanyName as [Customer], 
c.CategoryName as [Category], od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
into products_new
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID



alter table products_new
add productbk int not null identity(1,1)

alter table products_new
add constraint pk_products_new
primary key (productbk)
Go


-- Carga Full
insert into products_new (ProductID,producto,Customer,
Category,UnitPrice,Discontinued, inserted_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date' 
from Products as p 
inner join 
Categories as c 
on p.CategoryID = c.CategoryID
inner join [Order Details] as od
on od.ProductID = p.ProductID
inner join Orders as o
on o.OrderID = od.OrderID
inner join Customers as [cu]
on [cu].CustomerID = o.CustomerID


select * from products_new


select * from Products

--CARGA DELTA

insert into products_new (ProductID,producto,Customer,
Category,UnitPrice,Discontinued, inserted_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date', pn.ProductID 
from Products as p 
LEFT join 
Categories as c 
on p.CategoryID = c.CategoryID
LEFT join [Order Details] as od
on od.ProductID = p.ProductID
LEFT join Orders as o
on o.OrderID = od.OrderID
LEFT join Customers as [cu]
on [cu].CustomerID = o.CustomerID
LEFT join products_new as pn
on pn.ProductID = p.ProductID
where pn.ProductID is null

select pn.ProductID, pn.producto, pn.Customer,
pn.Category, pn.UnitPrice, pn.Discontinued, pn.inserted_date,
p.ProductID, p.ProductName from Products as p
left join products_new as pn
on p.ProductID = pn.ProductID
where pn.ProductID is null

select * from products_new as pn
where pn.producto in (' guaracha sabrosona', 'elote feliz')

select * from products_new
drop table products_new











select pn.ProductID, pn.producto, pn.Customer,
pn.Category, pn.UnitPrice, pn.Discontinued, pn.inserted_date,
p.ProductID, p.ProductName from Products as p
left join products_new as pn
on p.ProductID = pn.ProductID
where pn.ProductID is null








use Northwind
select top 10 *
into porudcts2
from Products

select * from Products as p1
inner join porudcts2 as p2
on p1.ProductID = p2.ProductID


select * from Products as p1
left join porudcts2 as p2
on p1.ProductID = p2.ProductID

select * from Products as p1
right join porudcts2 as p2
on p1.ProductID = p2.ProductID

select c.CategoryName, p.ProductName, p.ProductID from Categories as c
inner join porudcts2 as p
on c.CategoryID = p.CategoryID


select c.CategoryName, p.ProductName, p.ProductID from Categories as c
left join porudcts2 as p
on c.CategoryID = p.CategoryID

select c.CategoryName, p.ProductName, p.ProductID from Categories as c
right join porudcts2 as p
on c.CategoryID = p.CategoryID