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
