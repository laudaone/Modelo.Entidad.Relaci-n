--Generando la base de datos nueva
CREATE DATABASE LAURAOBANDOESQUIVEL
GO
--Esta linea es para saber si la base de datos se me genero correctamente
use LAURAOBANDOESQUIVEL
--Ahora voy a crear las tablas que hice en el modelo grafico, primero territorio 
create table TERRITORIO(
idterritorio int IDENTITY(1,1) not null PRIMARY KEY, --asigno llave primaria al atributo, usando el tipo de dato "int" para que me acepte valores enteros 
provincia varchar(50) not null, --voy a trabajar con el tipo de dato "varchar" porque me permite ingresar caracteres en una longitud que yo asigné 
canton varchar(50) not null, --cuando yo pongo "not null" hago la restricción para que no se permitan la entrada de los valores nulos
distrito varchar(50) not null
);
--Tabla de proveedor
create table PROVEEDOR(
cedulaproveedor varchar(50) not null PRIMARY KEY, --asigno llave primaria al atributo 
tipodecedula varchar(50) not null,
nombre varchar(80) not null,
correo varchar(50) not null,
telefono varchar(50) not null,
idterritorio int --llave foranea
constraint for_idterritorio foreign key (idterritorio) references TERRITORIO(idterritorio) --constraint toma mi llave foranea y asigno una referencia de que tabla proviene esa tabla foranea
);
--Tabla de categoría
create table CATEGORIA(
idcategoria int IDENTITY(1,1) not null PRIMARY KEY, --asigno llave primaria al atributo  
nombre varchar(80) not null
);
--Tabla de subcategoria
create table SUBCATEGORIA(
idsubcategoria int IDENTITY(1,1) not null PRIMARY KEY, --asigno llave primaria al atributo 
nombre varchar(80) not null,
idcategoria int not null,  
constraint idcategoria foreign key (idcategoria) references CATEGORIA(idcategoria) 
);
--Tabla de producto 
create table PRODUCTO(
consecutivopro int IDENTITY(1,1) not null PRIMARY KEY, --asigno llave primaria al atributo 
iduniversal int not null,
nombre varchar(80) not null,
tamaño varchar(50) not null,
precio decimal(10,2) not null,
color varchar(50) not null,
cedulaproveedor varchar(50) not null, --llave foranea
idsubcategoria int not null,
constraint for_cedulaproveedor foreign key (cedulaproveedor) references PROVEEDOR(cedulaproveedor),
constraint for_subcategoria foreign key (idsubcategoria) references SUBCATEGORIA(idsubcategoria) 
);
--Tabla de cliente
create table CLIENTE(
cedulaC varchar(50) not null PRIMARY KEY, --asigno llave primaria al atributo 
tipodecedula varchar(50) not null,
nombre varchar(80) not null, 
correo varchar(50) not null,
direccion INT not null
);
-- Creación de la tabla FACTURA
CREATE TABLE FACTURA(
numerofactura int IDENTITY(1,1) not null PRIMARY KEY, --asigno llave primaria al atributo 
nombre varchar(80) not null,
correo varchar(50) not null, 
cantidadcompra int not null,
fecha date not null, -- nueva columna de fecha para responder a las preguntas del profe
descuento decimal(10,2) not null,
impuesto decimal(10,2) not null,
consecutivo int not null, --llave foranea
cedulaC varchar(50) not null,
constraint for_consecutivopro_factura foreign key (consecutivo) references PRODUCTO(consecutivopro),
constraint for_cedula foreign key (cedulaC) references CLIENTE(cedulaC) 
);
--DATOS MANUALES TERRITORIO
INSERT INTO TERRITORIO ( provincia, canton, distrito)
VALUES 
('San José', 'Goicoechea', 'Calle Blancos'),--San José
('San José', 'Montes de Oca', 'San Pedro'),
('Limón', 'Matina', 'Batán'), --Limón
('Limón', 'Siquirres', 'Florida'),
('Puntarenas', 'Garabito', 'Jacó'), --Puntarenas 
('Puntarenas', 'Osa', 'Palmar'),
('Heredia', 'Barva', 'Barva'), --Heredia
('Heredia', 'Santo Domingo', 'San Miguel'),
('Alajuela', 'Grecia', 'San Isidro'), --Alajuela
('Alajuela', 'Atenas', 'Jesús'),
('Cartago', 'Paraíso', 'Santiago'), --Cartago
('Cartago', 'Turrialba', 'La Suiza'),
('Guanacaste', 'Liberia', 'Liberia'), --Guanacaste
('Guanacaste', 'Carrillo', 'Filadelfia');
-- DATOS MANUALES PROVEEDOR
INSERT INTO PROVEEDOR(cedulaproveedor, tipodecedula, nombre, correo, telefono, idterritorio)
VALUES
('156834609', 'física', 'Carlos Olivares', 'carlosolivares@proveedor.com', '87456778', 1),
('234659044', 'física', 'Andrea Corrales', 'andreacorrales@proveedor.com', '60002243', 2),
('347860014', 'física', 'Enrique Contreras', 'enriquecontreras@proveedor.com', '74267879', 3),
('405067842', 'física', 'Ana Rosales', 'anarosales@proveedor.com', '88964524', 4),
('515467699', 'física', 'Yamileth Esquivel', 'yamilethesquivel@proveedor.com', '86456890', 5),
('634651376', 'física', 'Bryan Diaz', 'bryandiaz@proveedor.com', '65785477', 6),
('767444090', 'física', 'Karla Chan', 'karlachan@proveedor.com', '77890988', 7);
-- DATOS MANUALES CATEGORIA
SET IDENTITY_INSERT CATEGORIA ON;
INSERT INTO CATEGORIA(idcategoria, nombre)
VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'Neutro');
SET IDENTITY_INSERT CATEGORIA OFF;
--DATOS MANUALES DE SUBCATEGORIA
SET IDENTITY_INSERT SUBCATEGORIA ON;
INSERT INTO SUBCATEGORIA(idsubcategoria, nombre, idcategoria)
VALUES
(1, 'Empresarial', 1),
(2, 'Independiente', 2),
(3, 'Pymes', 3);
SET IDENTITY_INSERT SUBCATEGORIA OFF;
--DATOS MANUALES DE PRODUCTO
SET IDENTITY_INSERT PRODUCTO ON;
INSERT INTO PRODUCTO(consecutivopro, iduniversal, nombre, tamaño, precio, color, idsubcategoria, cedulaproveedor)
VALUES
(1, 123, 'Camisa', 'Pequeño', 5000, 'Blanco', 1, '156834609'),
(2, 124, 'Camisa', 'Mediano', 5000, 'Blanco', 2, '156834609'),
(3, 125, 'Camisa', 'Grande', 5000, 'Blanco', 3, '156834609'),
(4, 126, 'Camisa', 'Pequeño', 5000, 'Negro', 1, '156834609'),
(5, 127, 'Camisa', 'Mediano', 5000, 'Negro', 2, '156834609'),
(6, 128, 'Camisa', 'Grande', 5000, 'Negro', 3, '156834609'),
(7, 223, 'Pantalón', 'Pequeño', 12000,'Azul', 1 ,156834609),
(8 ,224,'Pantalón','Mediano' ,12000 ,'Azul' ,2 ,156834609),
(9 ,225,'Pantalón','Grande' ,12000 ,'Azul' ,3 ,156834609),
(10 ,323,'Enagua','Pequeño' ,10000 ,'Azul' ,1 ,'156834609'),
(11 ,224,'Enagua','Mediano' ,10000 ,'Azul' ,2 ,'156834609'),
(12 ,225,'Enagua','Grande' ,10000 ,'Azul' ,3 ,'156834609');
SET IDENTITY_INSERT PRODUCTO OFF;
-- DATOS MANUALES CLIENTE
INSERT INTO CLIENTE(cedulaC, tipodecedula, nombre, correo, direccion)
VALUES
(3014042113, 'jurídica', 'Municipalidad de Coto Brus', 'municipalidadcb@cliente.com', 23656778),
(4000042149, 'jurídica', 'Universidad de Costa Rica', 'universidaddecostarica@cliente.com', 25116578),
(104640422, 'física', 'Linda Alemán', 'lindaaleman@cliente.com', 27896778),
(709671234, 'física', 'Ricardo Sanchez', 'ricardosanchez@cliente.com', 28905465);
-- Insertar datos en la tabla FACTURA
SET IDENTITY_INSERT FACTURA ON;
INSERT INTO FACTURA(numerofactura, nombre, correo, cantidadcompra, descuento, impuesto, consecutivo, cedulaC, fecha)
VALUES
(47356, 'Venta Autorizada', 'ventaslo@uniformes.com', 8 , 10.0, 13.0, 1, '3014042113', '2023-09-12'),
(67249, 'Venta Autorizada', 'ventaslo@uniformes.com', 27, 0.0, 13.0, 2, '4000042149', '2023-09-12'),
(79089, 'Venta Autorizada', 'ventaslo@uniformes.com', 1, 2.0, 13.0, 3, '104640422', '2023-09-12'),
(16533, 'Venta Autorizada', 'ventaslo@uniformes.com', 8, 10.0, 13.0, 4, '709671234', '2023-09-12');
SET IDENTITY_INSERT FACTURA OFF;


-- Ahora agregamos la consulta para concatenar los nombres
SELECT CONCAT(CLIENTE.nombre, ' ', FACTURA.nombre) AS 'Nombre Completo'
FROM CLIENTE
JOIN FACTURA ON CLIENTE.cedulaC = FACTURA.cedulaC;


--PREGUNTA 1
--¿Cuánto dinero se ha vendido en total por mes?
SELECT MONTH(fecha) AS Mes, SUM(cantidadcompra * precio) AS TotalVendido --en esta linea añadí la variable fecha porque me la piden en el almacenamiento aunque no se encuentre en el esquema, es la única manera de resolver la pregunta del profesor
FROM FACTURA --agregue una variable
JOIN PRODUCTO ON FACTURA.consecutivo = PRODUCTO.consecutivopro
GROUP BY MONTH(fecha);

--PREGUNTA 2
--¿Cuántos productos diferentes tiene la empresa?
SELECT COUNT(*) AS TotalProductos
FROM PRODUCTO;

--PREGUNTA 3
--¿Cuáles son los proveedores a los que más unidades de productos se les compra?
SELECT PROVEEDOR.nombre, SUM(cantidadcompra) AS UnidadesCompradas
FROM FACTURA
JOIN PRODUCTO ON FACTURA.consecutivo = PRODUCTO.consecutivopro
JOIN PROVEEDOR ON PRODUCTO.cedulaproveedor = PROVEEDOR.cedulaproveedor
GROUP BY PROVEEDOR.nombre
ORDER BY UnidadesCompradas DESC;

--PREGUNTA 4
--¿Cuáles son los clientes a los que más unidades de productos se les vende?
SELECT CLIENTE.nombre, SUM(FACTURA.cantidadcompra) as TotalUnidadesVendidas
FROM FACTURA
JOIN CLIENTE ON FACTURA.cedulaC = CLIENTE.cedulaC
GROUP BY CLIENTE.nombre
ORDER BY TotalUnidadesVendidas DESC;

--PREGUNTA 5
--¿Qué categoría de producto vende menos?
SELECT CATEGORIA.nombre, SUM(FACTURA.cantidadcompra) as TotalUnidadesVendidas
FROM FACTURA
JOIN PRODUCTO ON FACTURA.consecutivo = PRODUCTO.consecutivopro
JOIN SUBCATEGORIA ON PRODUCTO.idsubcategoria = SUBCATEGORIA.idsubcategoria
JOIN CATEGORIA ON SUBCATEGORIA.idcategoria = CATEGORIA.idcategoria
GROUP BY CATEGORIA.nombre
ORDER BY TotalUnidadesVendidas ASC;