-- CREACION DE LA BASE DE DATOS TIENDA 1

-- CREA LA BASE DE DATOS TIENDA 1
create database tienda1;

--UTILIZAR UNA BASE DE DATOS 
use tienda1;
--SQL-LDD
-- CREAR LA TABLA CATEGORIA
create table categoria(
categoriaid int not null,
nombre varchar(20)  not null, 
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre
unique(nombre)
);

-- SQL-LMD
--AGREGAR REGISTROS A LA TABLA CATEGORIA
insert into categoria 
values(1,'carnes frias');

insert into categoria(categoriaid,nombre)
values(2, 'linea blanca');

insert into categoria(nombre,categoriaid)
values('vinos y licores',3);


insert into categoria
values (4,'ropa'),
       (5,'dulces'),
	   (6,'lacteos');

	   insert into categoria(nombre,categoriaid)
	   values('panaderia',7),
	         ('zapateria',8),
			 ('jugueteria',9);

			 insert into categoria
			 values(10,'panaderia')

	   select * from categoria
	   order by categoriaid asc;