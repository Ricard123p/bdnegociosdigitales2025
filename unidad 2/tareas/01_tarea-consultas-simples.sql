use Northwind
--tarea
--1.    Productos con categoría 1, 3 o 5
select ProductName as 'nombre de producto' , CategoryID as 'categoria',
UnitPrice as 'precio unidad' from Products
where CategoryID in (1,3,5)
--2.    Clientes de México, Brasil o Argentina
select * from Orders;
select shipCountry, ShipName from Orders
where ShipCountry in ('Brazil', 'Mexico', 'Argentina')



--3.    Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
select * from Shippers;
select * from Orders;

select EmployeeID, Freight from Orders where  EmployeeID in (1,2,3) and Freight>='50'

--4.    Empleados que trabajan en Londres, Seattle o Buenos Aires
select * from Orders
select ShipName, ShipCity, ShipCountry from Orders
where ShipCity in ('London','Seattle') or ShipCountry in ('Argentina')


--5.    Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
Select * from Orders
select ShipName as 'cliente', ShipCountry 'país', Freight as 'flete' from Orders
where ShipCountry in ('France', 'Germany') and Freight <=100

--6.    Productos con categoría 2, 4 o 6 y que NO estén descontinuados
select * from Products
select ProductName as 'productos',CategoryID as 'categoria',Discontinued from Products
where CategoryID in ('2','4','6') and Discontinued in ('1')
--7.    Clientes que NO son de Alemania, Reino Unido ni Canadá
select * from Orders
select ShipName as 'clientes', ShipCountry as 'país' from Orders
where not ShipCountry in ('Germany','canada','UK')
--8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canadá
select * from Shippers;
select * from Orders
select EmployeeID from Orders where ShipCountry in ('USA','Canada') and EmployeeID in (2,3) 
--9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados después de 1995
select * from Employees
select FirstName as 'empleado', City as 'ciudad', HireDate as 'fecha de contratacion' from Employees
where City in ('London','Seattle')  and   year (HireDate)  >=1995
--10.    Productos de categorías 1, 3 o 5 con stock mayor a 50 y que NO están descontinuados
select * from Products
select ProductName as 'producto', CategoryID as 'categoria', UnitsInStock as 'stok',
Discontinued as 'descontinuado'
from Products
where CategoryID in ('1', '3','5') and UnitsInStock <=50 and Discontinued >=1


