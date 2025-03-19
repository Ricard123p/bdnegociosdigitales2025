-- funciones de cadena, fechas, instrucciones de control, variables 
-- las funciones de cadena permiten manipular tipo de datos como varchar, nvarchar, char, nchar

-- funcion len -> devuelve la longitud de una cadena 

-- declaracion de una variable 
declare @numero int;
set @numero = 10;
print @numero
--declare @texto varchar (50) = 'Hola, mundo!';


--obtener el tamaño de la cadena alamacenada en la variable texto

select len(@texto) as [longitud]



-- funcion left-> extrae un numero especifico de caracteres desde el inicio de la cadena 
select LEFT(@texto, 4) as inicio

-- right -> estrae un determinado numero de caracteres del final de la cadena
select right(@texto, 6) as final


-- substring-> extrae una parte de la cadena, donde el segundo parametro es la posicion inicial
-- y el tercer parametro el recorrido
--select SUBSTRING(@texto2, 7,4) 

-- replace-> reemplaza una subcadena por otra
-- REPLACE(STRING_EXPERECION, STRING_PATTERN, STRING_REPLACEMENT)


select REPLACE(@texto2, 'mundo', 'amigo')


--charindex

select CHARINDEX('mundo', @texto2)
declare @texto2 varchar (50) = 'Hola, mundo!';
--uper ->convierte una cadena en mayusculas 
--declare @Texto varchar (50) = 'Hola, Mundo!';
Select CONCAT(
			LEFT(@Texto,6),
			UPPER(SUBSTRING(@Texto,7,5)),
			RIGHT(@Texto,1)
			) as TextoNuevo

update Customers set CompanyName = upper(CompanyName)
where country in ('Mexico', 'Germany')

select * from Customers
--TRIM-> quita espacios de una cadena
declare @Texto varchar (50) = 'Hola, Mundo!';
SELECT TRIM(@Texto ) AS Result;
SELECT LTRIM('     Five spaces are at the beginning of this string.');

select CompanyName,len(CompanyName) as 'numero de caracteres', left(CompanyName, 4) as inicio,
right (CompanyName, 6) as final,
SUBSTRING(@texto2, 7,4) as 'subcadena' from Customers 
go


