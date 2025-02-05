-- lenguaje sql-lmd (insert,update, delete, select - CRUD)
-- consultas simples

use Northwind;

-- mostrar todos los clientes, provedores, categorias, productos, ordenes, detalles de orden, empleados
--con todas las columnas de datos de la empresa

select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details];


-- Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock from Products;
-- selecionar el numero de empleado, su primer nombre, su cargo, ciudad y país
select * from Employees;
select EmployeeID, FirstName, Title,City, Country from Employees;

-- Alia de columna
-- En base a la consulta anterior, visualisar el employeeid como numero empleado
-- el firstname como primer nombre,  title como cargo, city como ciudad, country como país
-- funciona con ´´ 
select EmployeeID as 'numero empleado', FirstName as 'primer nombre', Title as 'cargo', 
City as 'ciudad', Country as 'país' from Employees;
--funciona igual con []
select EmployeeID as [numero empleado], FirstName as [primer nombre], Title as [cargo], 
City as [ciudad], Country as [país] from Employees;

--campos calculados
--seleccionar el importe de cada uno de los productos vendidos en una orden
select *, (UnitPrice * Quantity) from [Order Details];
select (UnitPrice * Quantity) as importe from [Order Details];
 -- seleccionar las fechas de orden, año, mes y dia, el cliente que las ordeno
 --y el empleado que la realizo

 select OrderDate as 'fecha de orden', year (OrderDate) as 'año',
 month (OrderDate) as 'mes', day (OrderDate) as 'dia',
 CustomerID, EmployeeID from Orders;

 -- clausula wehre
 -- operadores relacionales (<,>,=,<=,>=,!=0 <>)
 select * from Customers;
  -- seleccionar del cliente bolid
  select CustomerID as 'cliente', CompanyName as 'nombre de la compania', 
  City as 'ciudad', country as 'país' 
  from Customers
  where CustomerID = 'BOLID';

  --seleccionar los clientes, mostrando su identificador
  --nombre de la empresa, contacto, ciudad y país
  --de alemania

  select CustomerID as 'cliente', CompanyName as 'nombre de la compania', 
  City as 'ciudad', country as 'país' 
  from Customers
  where country = 'germany' 

  -- selecionar todos los clientes que no sean de alemania 
   select CustomerID as 'cliente', CompanyName as 'nombre de la compania', 
  City as 'ciudad', country as 'país' 
  from Customers
  where country != 'germany' 
  --2da opcion
   select CustomerID as 'cliente', CompanyName as 'nombre de la compania', 
  City as 'ciudad', country as 'país' 
  from Customers
  where country <> 'germany' 

  -- selecionar todos los productos, mostrando su nombre de producto
  --categoria que pertenece, existencia,, precio, pero solamete
  -- donde se precio sea mayor a 100
  select *from Products;
  select ProductName as 'nombre del producto',
  CategoryID as 'categoria',
 UnitsInStock 'existencia',
 UnitPrice as 'precio por unidad', (UnitPrice * UnitsInStock) as [costro inventario]
  from Products
  where UnitPrice > 100

  --seleccionar las ordenes de compra
  --mostrando la fecha de orden, la fecha de entraga,
  -- la fecha de envio, el cliente a quien se vendio,
  -- de 1996

  select * from Orders;

  Select RequiredDate as 'fecha de entrega',
  OrderDate as 'fecha de orden',
  ShippedDate as 'fecha de envio',
CustomerID as 'nombre de cliente'

  from Orders
  where ShippedDate <> 1996

 

 --filas duplicadas (distintc)
 select * from Customers;
  --mostrar los paises donde tengo cluentes
  select Country as 'país' from Customers;
  select distinct Country from Customers 
 order by Country 

 -- Mostrar todas las ordenes de compra donde la cantidad ordenada 
 -- de productos comprados sea mayor a 5

 select * from [Order Details];
 select Quantity as 'cantidad' from [Order Details] where Quantity > 5 ;

 -- Mostrar el nombre completo de empleado, su numero de empleado
 -- fecha de nacimiento, la ciudad, fecha de contratacion
 -- esta debe de ser de aquellos que fueron contratados despues de 1993,
 --los resultados en sus encabezados deben ser mostrados en español

 select * from Employees;
 select FirstName as 'primer nombre', LastName 'segundo nombre', EmployeeID as  'numero de empleado',
 BirthDate as 'fecha de nacimiento', City as 'ciudad', HireDate as 'fecha de contratacion'
 from Employees
 where year (HireDate) >1993 ;

 --02
  select * from Employees;
 select (FirstName + '' + LastName) as 'nombre completo',
 BirthDate as 'fecha de nacimiento', City as 'ciudad', HireDate as 'fecha de contratacion'
 from Employees
 where year (HireDate) >1993 ;


 --03
  select concat  (FirstName,' ',LastName, '-',Title) as 'nombre completo',
city as ciudad,
BirthDate as 'fecha de nacimiento',
HireDate as'fecha de contrato'  
from Employees where year(HireDate)='1993'

-- Mostrar los empleados que no son dirigidos por el gefe 02
 select FirstName as primernombre, 
EmployeeID as 'numero empleado',
LastName as 'apellido',
city as ciudad,
BirthDate as 'fecha de nacimiento',
HireDate as'fecha de contrato' , 
 ReportsTo as jefe  from Employees  where ReportsTo !=2;


--seleccionar los empleados que no tengan gefe
select * from Employees
where ReportsTo is null

use Northwind;
-- operadores logicos (or, and, not)
--seleccionar los productos que tengan un precio de entre 10 y 50


select ProductName as 'nombre', UnitPrice as 'precio',
UnitsInStock as 'existencia'
from Products
where UnitPrice>=10
and UnitPrice<=50;


-- mostrar todos los pedidos realizados por los clientes que no son enviados de 
-- alemania 
select * from Orders;
where NOT ShipCountry = 'Germany'

--selecionar clientes de mexico o estados unidos

select *from Orders where ShipCountry >='Mexico OR USA';


-- seleccionar empleados que nacieron entre 1955 y 1958 
-- y que viven en londres

select * from Employees;
select FirstName as 'nombre de empleado'
from Employees
where (year (BirthDate)>=1955 and year (BirthDate)<=1958)
and City = 'London' 

-- seleccionar los pedidos con flete (freight) mayor a 100 
-- y enviados a francia o españa
Select * from Orders where Freight >= 100 and ShipCountry 'france' OR 'Spain';

select OrderID, OrderDate, ShipCountry, Freight
from Orders 
where Freight>100 and (ShipCountry='france' or ShipCountry ='Spain')

--selecccionar las primeras top 5 ordenes de compra
select top 5* from Orders

-- seleccionar los productos con precio entre $10 y $50
-- que NO esten descontiniados y tengan mas de 20 unidades en stock

select UnitPrice as 'precio', Discontinued as 'descontinuado',
UnitsInStock as 'unidades'
from Products
where ( (UnitPrice)>=10 and (UnitPrice)<=50) and Discontinued =0
and UnitsInStock >20

-- pedidos enviados a francia o alemania
-- con un flete menor a 50
select OrderID, ShipCountry,Freight from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight < 50

--  clientes que no sean de mexico y usa
-- y que tengan fax registrado
select country, City, fax from Customers
where NOT (Country='Mexico' or Country='USA') and fax is not null
 

-- seleccionar pedidos con un flete mayor a 100
--enviados a Brasil o Argentina
-- pero no enviados por el transportista 1

--seleccionar empleados que no viven en londres
select concat(firstName , ' ' , LastName) as [Nombre Completo],
hiredate, city, country
from Employees
where not (city = 'London' or city = 'Seatle')
and year (HireDate) >= 1995

--CLAUSULA IN (OR)
-- seleccionar los productos con categoria 1,3 o 5
select ProductName as 'nombre de producto' , CategoryID as 'categoria',
UnitPrice as 'precio unidad' from Products
where CategoryID in (1,3,5)

--seleccionar todas las ordenes de la region RJ, Tachira
-- y que no tengan region asignada
use Northwind
select * from Orders
select OrderID, OrderDate,ShipRegion as 'region' from Orders
where ShipRegion in ('RJ''Táchira')
or ShipRegion is null

--seleccionar las ordenes que tengan cantidades de 12,9 o 40 
-- y descuento de 0.15 y 0.05
Select * from [Order Details]
Select OrderID as 'ordden', Quantity as 'cantidad',
Discount as 'descuento' from [Order Details]
where Quantity in (12,9,40)
and Discount in (0.15, 0.05)

use Northwind
--CLAUSUSA  between
--between valorInicial and valorfinal
--Mostrar los productos con precio entre 10 y 50 
select * from Products
where UnitPrice >= 10 and UnitPrice <= 50;

select * from Products 
where UnitPrice between 10 and 50

--seleccionar todos los pedidos realizados entre el primero de enero
--y el 30 de junio de 1997

select OrderID as ordeniID, concat (day(OrderDate),  '-',year(OrderDate), '-',month(OrderDate))  as fecha  from Orders
where OrderDate between '1997-01-01' and  '1997-06-30' ;

--seleccionar a todos los empleados contratados contratados entre 1992
-- y 1994 que trabajan en londres 
select * from Employees
where year (HireDate) >= 1992 and
      year (HireDate) <=1994 and
	  City = 'London'

select * from Employees
where (year(HireDate) between 1992 and 1994 and City = 'London')

-- pedidos con flete (freigh) entre 50 y 200 
--enviados a alemania y a francia 
select OrderID, OrderDate as [numero de orden],
RequiredDate as [fecha de entrega], 
Freight as [peso],
ShipCountry as [pais de entrega] from Orders
where Freight >=50 and Freight <=200
and (ShipCountry='France' or ShipCountry='germany')

select OrderID, OrderDate as [numero de orden],
RequiredDate as [fecha de entrega], 
Freight as [peso],
ShipCountry as [pais de entrega] from Orders
where Freight between 50 and 200
and ShipCountry in ('France' ,'germany')

-- seleccionar todos los productos que tengan un precio 
-- entre 50 y  20 dolares o que sean de la categoria 1,2 o 3
Select ProductID as [produccto] ,UnitPrice as [precio],
CategoryID as [categoria] from Products
where UnitPrice between 5 and 20 and CategoryID in (1,2,3)





-- empleados con numero de trabajador entre 3 y 7 que no trabajan
--en londres ni seattle
select EmployeeID as [numero de empleado], concat (FirstName, '', LastName)
as [nombre completo], 
City as [ciudad] from Employees
where EmployeeID between 3 and 7 or  NOT City in ('London','seattle')

select EmployeeID as [numero de empleado], concat (FirstName, '', LastName)
as [nombre completo], 
City as [ciudad] from Employees
where EmployeeID >=3 and EmployeeID<=7
and not City in ('London','seattle')

--	CLAUSULA LIKE
--patrones:
-- 1.- % ( porcentaje)este representa 0 o mas caracteres en el patron de busqueda 

-- 2.- _ (guion bajo) -> representa exactamente un caracter en el patron de busqueda 

-- 3.- [] (corchetes) se utliza para definir un conjunto de caracteres buscando cualquiera 
--de ellos en la posicion especifica
--4-. [ ^] se utiliza para buscar caraccteres que no estan dentro del conjunto especifico


--buscar los productos que comienzan con cha
select * from Products
where ProductName like 'Ch%'
and UnitPrice=18

-- buscar todos los productos que terminen con "e"

select * from Products
where ProductName like '%e'

-- seleccionar todos los clientes cuyo nombre de empresa contiene "co" en cualquier parte
select * from Customers
where CompanyName like '%co%'

-- seleccionar los empleados cuyo nombre comience con "a" y tenga exactamente 5 caracteres
select FirstName, LastName from Employees
where FirstName like 'A_____'


use Northwind

-- seleccionar los producctos que comiencen con A o B
select * from Products 
where ProductName like '[A-M]%'

--seleccionar todos los productos que no comiencen con A o B
Select * from Products
where ProductName like '[^AB]%'

--seleccionar todos los productos donde el nombre
-- que comience con A pero que no contenga la E
Select * from Products
where ProductName like 'A[^E]%'

-- clausula order BY
select ProductID, ProductName, UnitPrice, UnitsInStock
from Products
order by UnitPrice desc

select ProductID, ProductName, UnitPrice as 'capitan precio', UnitsInStock
from Products
order by 'capitan precio' desc 


-- seleccionar los clientes ordenados por el pais y dentro por ciudad
select CustomerID, Country, City, Region from Customers
where Country in ('Brazil', 'Germany')
order by Country asc, City asc

select CustomerID, Country, City, Region from Customers
where (Country = 'Brazil' or Country= 'Germany')
and region is not null 
order by Country asc, City asc

select CustomerID, Country, City from Customers
order by Country desc, City desc