-- tablas --
CREATE DATABASE IF NOT EXISTS BDferreteria DEFAULT CHARACTER SET utf8mb4;
USE BDferreteria;


create table if not exists persona (
idPersona int not null auto_increment,
tipodocumento enum('Cedula','Nit')  null,
documento int null,
correo varchar(75) null,
nombre varchar(75) null,
apellido varchar(75) null,
telefono varchar(75) null,
contrasena  varchar(75) null,
rol enum('administrador','empleado','cliente','proveedorjuridico','proveedornatural')  null,
estado enum('activo','inactivo') null,
PRIMARY KEY (idPersona)
)ENGINE = InnoDB;

create table if not exists clasificacion(
idClasificacion int not null auto_increment,
nombre varchar(75) not null, 
PRIMARY KEY (idclasificacion)
)ENGINE = InnoDB;

create table if not exists medida(
idMedida int not null auto_increment,
nombre varchar(75) not null, 
tipoMedida ENUM('metrico', 'masa', 'volumen', 'longitud') NOT NULL,
unidadMedida varchar(75) not null, 
PRIMARY KEY (idmedida)
)ENGINE = InnoDB;

create table if not exists marca(
idMarca int not null auto_increment,
nombre varchar(75) not null, 
PRIMARY KEY (idMarca)
)ENGINE = InnoDB;

create table if not exists material(
idMaterial int not null auto_increment,
nombre varchar(75) not null, 
PRIMARY KEY (idmaterial)
)ENGINE = InnoDB;

-- llaves foraneas ---

create table if not exists producto(
idProducto bigint not null auto_increment,
nombre varchar(75) not null, 
stock smallint not null, 
precio double not null, 
clasificacion_idclasificacion int not null, 
PRIMARY KEY (idProducto),
 CONSTRAINT fk_producto_clasificacion FOREIGN KEY ( clasificacion_idclasificacion) REFERENCES clasificacion(idclasificacion) ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;



create table if not exists facturaVenta(
idFacturaVenta int not null auto_increment,
fecha date not null, 
monto varchar(75) not null,
persona_idPersona int not null,
PRIMARY KEY (idFacturaVenta),
 CONSTRAINT fk_facturaVenta_persona FOREIGN KEY ( persona_idPersona ) REFERENCES persona(idPersona)  ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;

create table if not exists compra(
idCompra int not null auto_increment,
fecha date not null, 
monto varchar(75) not null,
persona_idPersona int not null,
PRIMARY KEY (idCompra),
 CONSTRAINT fk_compra_persona FOREIGN KEY ( persona_idPersona ) REFERENCES persona(idPersona)  ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;

create table if not exists detalleVenta(
idDetalleVenta int not null auto_increment,
cantidad double not null, 
valor double not null, 
producto_idProducto bigint not null,
facturaVenta_idFacturaVenta int not null,
medida_idMedida int not null,
PRIMARY KEY (idDetalleVenta),
 CONSTRAINT fk_detalleVenta_producto FOREIGN KEY ( producto_idProducto ) REFERENCES producto(idProducto)  ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT fk_detalleVenta_facturaVenta FOREIGN KEY ( facturaVenta_idFacturaVenta ) REFERENCES facturaVenta(idFacturaVenta) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT fk_detalleVenta_medida FOREIGN KEY ( medida_idMedida  ) REFERENCES medida(idMedida) ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;

create table if not exists detalleCompra(
idDetalleCompra int not null auto_increment,
cantidad DOUBLE not null, 
valor double not null, 
producto_idProducto bigint not null,
compra_idCompra int not null,
PRIMARY KEY (idDetalleCompra),
 CONSTRAINT fk_detalleCompra_producto FOREIGN KEY ( producto_idProducto ) REFERENCES producto(idProducto)  ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT fk_detalleCompra_compra FOREIGN KEY ( compra_idCompra ) REFERENCES compra(idCompra) ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;

create table if not exists productoMedida(
idProductoMedida int not null auto_increment,
producto_idProducto bigint not null,
medida_idMedida  int not null,
PRIMARY KEY (idProductoMedida,producto_idProducto,medida_idMedida),
 CONSTRAINT fk_productoMedida_producto FOREIGN KEY ( producto_idProducto ) REFERENCES producto(idProducto)  ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_productoMedida_medida FOREIGN KEY ( medida_idMedida  ) REFERENCES medida(idMedida) ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;

create table if not exists productoMarca(
idProductoMarca int not null auto_increment,
producto_idProducto bigint not null,
marca_idMarca int not null,
PRIMARY KEY (idProductoMarca,producto_idProducto,marca_idMarca),
 CONSTRAINT fk_productoMarca_producto FOREIGN KEY ( producto_idProducto ) REFERENCES producto(idProducto)  ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_productoMarca_medida FOREIGN KEY ( marca_idMarca  ) REFERENCES marca(idMarca) ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;


create table if not exists productoMaterial(
idProductoMaterial int not null auto_increment,
producto_idProducto bigint not null,
material_idMaterial int not null,
PRIMARY KEY (idProductoMaterial,producto_idProducto,material_idMaterial),
 CONSTRAINT fk_productoMaterial_producto FOREIGN KEY ( producto_idProducto ) REFERENCES producto(idProducto)  ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT fk_productoMaterial_material FOREIGN KEY ( material_idMaterial  ) REFERENCES material(idMaterial)  ON DELETE NO ACTION ON UPDATE NO ACTION
)ENGINE = InnoDB;


-- insert into persona--

insert into  persona(tipodocumento,documento,correo,nombre ,apellido ,telefono ,contrasena,rol ,estado)
values ("Cedula",1234567891," ","juan","gonzales","3132653478"," ","Cliente","activo" );
insert into  persona(tipodocumento,documento,correo,nombre ,apellido ,telefono ,contrasena,rol ,estado)
values ("Cedula",1123456789,"juan@gmail.com ","juanito","perez","3132653345"," ","empleado","activo" );
insert into  persona(tipodocumento,documento,correo,nombre ,apellido ,telefono ,contrasena,rol ,estado)
values ("Cedula",1456567891,"maria@gmail.com ","Maria","","3139843478","2467 ","administrador","activo" );
insert into  persona(tipodocumento,documento,correo,nombre ,apellido ,telefono ,contrasena,rol ,estado)
values ("Cedula",1147839789,"mesa@gmail.com ","Carlos","mesa","3139873445"," ","empleado","activo" );
insert into  persona(tipodocumento,documento,correo,nombre ,apellido ,telefono ,contrasena,rol ,estado)
values ("Nit",11345439,"press@gmail.com ","pedro","corredor","3224563445"," ","proveedornatural","activo" );

-- insert into clasificacion --

insert into  clasificacion(nombre)
values ("general" );
insert into  clasificacion(nombre)
values ("sanitario" );
insert into  clasificacion(nombre)
values ("agricultura" );
insert into  clasificacion(nombre)
values ("mineria" );
insert into  clasificacion(nombre)
values ("construccion" );

-- insert into producto --
insert into  producto(nombre ,stock ,precio ,clasificacion_idclasificacion)
values ("alambre"," 50 ","800","1" );
insert into  producto(nombre ,stock ,precio ,clasificacion_idclasificacion)
values ("lavamanos"," 5 ","200000","2" );
insert into  producto(nombre ,stock ,precio ,clasificacion_idclasificacion)
values ("empate para guadaña"," 3 ","2500","3" );
insert into  producto(nombre ,stock ,precio ,clasificacion_idclasificacion)
values ("abrazadera metalica media luna "," 100 ","200","4" );
insert into  producto(nombre ,stock ,precio ,clasificacion_idclasificacion)
values ("cemento  "," 20 ","2700","5" );

-- insert into medida --
insert into  medida (nombre,unidadMedida,tipoMedida )
values ("2","lb","masa" );
insert into  medida (nombre,unidadMedida,tipoMedida )
values ("42X42","cm","metrico" );
insert into  medida (nombre,unidadMedida,tipoMedida )
values ("42","cm","metrico" );
insert into  medida (nombre,unidadMedida,tipoMedida )
values ("1/2","cm","metrico" );
insert into  medida (nombre,unidadMedida,tipoMedida )
values ("50","kg","masa" );



-- insert into marca --
insert into  marca(nombre )
values ("fiero" );
insert into  marca(nombre )
values ("corona" );
insert into  marca(nombre )
values ("stihl" );
insert into  marca(nombre )
values ("fiero" );
insert into  marca(nombre )
values ("tequendama" );

-- insert into material --
insert into  material(nombre )
values ("cobre" );
insert into  material(nombre )
values ("porcelana" );
insert into  material(nombre )
values ("madera" );
insert into  material(nombre )
values ("metal" );
insert into  material(nombre )
values (" " );

-- insert into venta--
insert into  facturaVenta(fecha ,monto ,persona_idPersona )
values ('2021-03-17',300600,1 );

-- inset into detventa--
insert into  detalleVenta(cantidad ,valor ,producto_idProducto,facturaVenta_idFacturaVenta,medida_idMedida )
values (1,1600 ,1,1,1 );
insert into  detalleVenta(cantidad ,valor ,producto_idProducto,facturaVenta_idFacturaVenta,medida_idMedida )
values (1,200000 ,2,1,2 );
insert into  detalleVenta(cantidad ,valor ,producto_idProducto,facturaVenta_idFacturaVenta,medida_idMedida )
values (2,5000 ,3,1,2 );
insert into  detalleVenta(cantidad ,valor ,producto_idProducto,facturaVenta_idFacturaVenta,medida_idMedida )
values (20,4000 ,4,1,2 );
insert into  detalleVenta(cantidad ,valor ,producto_idProducto,facturaVenta_idFacturaVenta,medida_idMedida )
values (2,54000,5,1,1);



-- inset into compra--
insert into  compra(fecha ,monto ,persona_idPersona )
values ('2021-04-01',986000,5 );



-- inset into detcompra--
insert into  detalleCompra(cantidad ,valor ,producto_idProducto,compra_idCompra)
values (5,160000 ,2,1);
insert into  detalleCompra(cantidad ,valor ,producto_idProducto,compra_idCompra)
values (5,15000 ,1,1 );
insert into  detalleCompra(cantidad ,valor ,producto_idProducto,compra_idCompra)
values (3,15000 ,5,1);
insert into  detalleCompra(cantidad ,valor ,producto_idProducto,compra_idCompra)
values (4,1500 ,3,1);
insert into  detalleCompra(cantidad ,valor ,producto_idProducto,compra_idCompra)
values (40,1500 ,4,1 );




-- inset into proMarca--

insert into  productoMarca (producto_idProducto ,marca_idMarca )
values (1,1 );
insert into  productoMarca (producto_idProducto ,marca_idMarca )
values (2,2 );
insert into  productoMarca (producto_idProducto ,marca_idMarca )
values (3,3 );
insert into  productoMarca (producto_idProducto ,marca_idMarca )
values (4,4 );
insert into  productoMarca (producto_idProducto ,marca_idMarca )
values (5,5 );

-- inset into proMedida--

insert into  productoMedida (producto_idProducto  ,medida_idMedida )
values (1,1);
insert into  productoMedida (producto_idProducto  ,medida_idMedida )
values (2,2 );
insert into  productoMedida (producto_idProducto  ,medida_idMedida )
values (3,3 );
insert into  productoMedida (producto_idProducto  ,medida_idMedida )
values (4,4 );
insert into  productoMedida (producto_idProducto  ,medida_idMedida )
values (5,5 );

-- inset into proMedida--

insert into  productoMaterial (producto_idProducto  ,material_idMaterial )
values (1,1 );
insert into  productoMaterial (producto_idProducto  ,material_idMaterial )
values (2,2 );
insert into  productoMaterial (producto_idProducto  ,material_idMaterial )
values (3,3 );
insert into  productoMaterial (producto_idProducto  ,material_idMaterial )
values (4,4 );
insert into  productoMaterial (producto_idProducto  ,material_idMaterial )
values (5,5 );


-- consultas --

select * from producto where idproducto=1 or idproducto=3 ;
select * from persona where rol="empleado";

update persona set estado="inactivo" where idpersona=4;
select * from persona;

select sum(precio) from producto;


select idProductoMarca,marca.nombre,producto.nombre from  ProductoMarca
join marca on marca_idMarca=marca.idMarca
join producto on producto_idProducto=producto.idProducto
order by marca.nombre ; 


 SELECT compra.monto,rol="proveedornatural" from compra join persona
 on  persona_idPersona=persona.idPersona 
 order by monto;


 SELECT producto.nombre,clasificacion.nombre from producto join clasificacion 
 on clasificacion_idClasificacion=clasificacion.idClasificacion
 order by producto.nombre;
 
 SELECT idProductomedida,producto.nombre,medida.tipoMedida="masa" from productomedida
  join producto on producto_idProducto=producto.idProducto
 join medida on medida_idMedida=medida.idMedida 
 order by tipoMedida;
 
 

select * from persona
order by nombre;

SELECT * FROM clasificacion LIMIT 2;

select sum(valor) from detalleventa;

select sum(valor * cantidad ) from detallecompra;

select * from producto order by precio desc;

SELECT * from persona where rol like ('cliente');  

SELECT * from marca where nombre like ('c%');  

select * from productomarca;