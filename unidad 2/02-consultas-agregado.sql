--CONSULTAS DE AGREGADO 
--NOTA: solo devuelven un solo registro
-- sum, avg, count, count(*), max y min

-- cuantos clientes tengo
use Northwind

Select count(*) as 'numero de clientes' from Customers

-- cuantas regiones hay 

Select count(*) from Customers
where Region is null 

select count (distinct Region) from Customers
where Region is not null





select * from Orders;

select COUNT (*) from Orders;

select COUNT (ShipRegion) as 'regiones envio' from Orders;

select * from Products;

--seleccciona el precio mas bajo de los productos

select min(UnitPrice) as 'precio minimo' from Products;

select avg(UnitsInStock) as 'unidades en stock' from Products;

select min(UnitsInStock) as 'unidades en stock' from Products;

select UnitsInStock as 'unidades en stock' from Products;

-- seleccionar cuantos pedidos ecisten 

select * from Orders;

select count(*) as 'numeros pedidos' from Orders;

-- calcula el total de dinero vendido

select *  from [Order Details]

select sum(UnitPrice * Quantity) as 'total dinero' from [Order Details]

select sum(UnitPrice * Quantity - (unitprice * Quantity * Discount)) 
 as 'total dinero' from [Order Details]

-- calcula el total de unidades en stock de todos los productos

select sum(UnitsInStock) as 'en stock' from Products;

-- seleccionar el total de dinero
-- que se gano en el ultimo trimestre de 1996


--group by sirve para agrupar cosas
-- seleecionar el numero de productos por categoria
select CategoryID, count (*) as 'numero de productos' from Products
group by CategoryID

select Categories.CategoryName,
count(*) as [numero de productos]
from Categories
inner join Products as p on Categories.CategoryID = p.CategoryID
group by Categories.CategoryName

-- calcular el precio promedio de los productos por cada categoria
select CategoryID, avg (UnitPrice) as 'precio promedio' from Products
group by CategoryID 

-- seleccionar el numero de pedidos realizados por  cada empleado
-- ultimo trimestre de 1996
select EmployeeID,count(*) as 'numero de pedidos'  from Orders
group by EmployeeID

select  EmployeeID,count(*) as 'numero de pedidos' from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
group by  EmployeeID 

-- seleccionar la suma total de unidades vendidas por cada producto 
select top 5 ProductID ,sum(Quantity)as 'numero de productos venididos' from [Order Details]
group by ProductID 
order by 1 desc 

select OrderID ,ProductID ,sum(Quantity)as 'numero de productos venididos' from [Order Details] 
group by OrderID,ProductID 
order by 2 desc 

--seleccionar el numero de productos por categoria, solo
-- aquellos que tengan mas de 10 productos
select CategoryID ,avg(UnitPrice)from Products
where CategoryID in (1,3,4)
group by CategoryID

select CategoryID ,avg(UnitPrice)from Products
where  CategoryID in (1,3,4)
group by CategoryID
having COUNT(*)>10

-- paso 1
select distinct CategoryID from Products

--paso 2
select CategoryID from Products
where CategoryID in (2,4,8)


select CategoryID,UnitsInStock from Products
where CategoryID in (2,4,8)
order by CategoryID 

--paso 3
select CategoryID,UnitsInStock from Products
where CategoryID in (2,4,8)
group by CategoryID
having count (*)>10
order by CategoryID 


-- listar las ordenes agrupadas por empleados, pero que solo 
--muestre aquellos que allan gestionado mas de 10 pedidos 
