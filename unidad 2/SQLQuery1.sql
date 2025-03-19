use Northwind
select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName from Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID 
where c.CategoryName = 'fast food'

select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName from Categories as c
left join Products as p
on c.CategoryID = p.CategoryID 
where c.CategoryName is null

select c.CategoryName, c.CategoryID, p.CategoryID, p.ProductName from Products as p
left join Categories as c
on c.CategoryID = p.CategoryID 
where c.CategoryName is null


insert into Products(ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock
,UnitsOnOrder,ReorderLevel,Discontinued)
VALUES('Burger Sabrosa',1,9,'xyz',68.7,45,12,2,0)


insert into Products(ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,UnitsInStock
,UnitsOnOrder,ReorderLevel,Discontinued)
VALUES('huaracha Sabrosona',1,null,'xyz',68.7,45,12,2,0)


delete Products
where CategoryID = 9

-- 1- listar la los empleados y los pedidos que han gestionado 