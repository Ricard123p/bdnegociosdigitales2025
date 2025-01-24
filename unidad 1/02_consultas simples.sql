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
