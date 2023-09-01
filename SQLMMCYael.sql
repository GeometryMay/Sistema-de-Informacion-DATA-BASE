create database MMCYael
go

use MMCYael
go

create table c_cliente
(
codigo varchar(5),
nombre varchar(50),
edad int,
telefono int
);
go

create proc listar_cliente
as
select * from c_cliente order by codigo
go

create proc buscar_cliente
@nombre varchar(50)
as
select codigo,nombre,edad,telefono from c_cliente where nombre like @nombre + '%'
go

create proc matenimiento_cliente
@codigo varchar(5),
@nombre varchar(50),
@edad int,
@telefono int,
@accion varchar(50) output
as
if (@accion='1')
begin
	declare @codnuevo varchar(5), @codmax varchar(5)
	set @codmax = (select max(codigo) from c_cliente)
	set @codmax = isnull(@codmax,'A0000')
	set @codnuevo = 'A'+RIGHT(RIGHT(@codmax,4)+10001,4)
	insert into c_cliente(codigo,nombre,edad,telefono)
	values (@codnuevo,@nombre,@edad,@telefono)
	set @accion='Se genero el codigo: ' +@codnuevo
	end
	else if (@accion='2')
	begin
	update c_cliente set nombre=@nombre, edad=@edad, telefono=@telefono where codigo=@codigo
	set @accion='Se modifico el código: ' +@codigo
	end
	else if (@accion='3')
	begin
	delete from c_cliente where codigo=@codigo
	set @accion='Se borro el código: ' +@codigo
	end
	go