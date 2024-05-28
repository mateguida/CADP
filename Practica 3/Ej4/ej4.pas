program ej4p3;
type
	linea = record
		numero : string;
		minconsumidos : real;
		mbconsumidos : real;
		end;
	cliente = record
		codigo : integer;
		cantlineas : integer;
		end;
procedure cargarDatosLinea(var lin : linea);
begin
	writeln;
	writeln('Ingrese datos de la linea telefonica');
	write('Nro = ');
	readln(lin.numero);
	write('Minutos consumidos = ');
	readln(lin.minconsumidos);
	write('MB consumidos = ');
	readln(lin.mbconsumidos);
end;
procedure borrarDatosLinea(var lin : linea);
begin
	lin.numero := '';
	lin.minconsumidos := 0;
	lin.mbconsumidos := 0;
end;
procedure facturarCliente(codcliente : integer; cantidadlineas : integer; var minutostotales, mbtotales : real);
var
	lineaaux : linea;
	i:integer;
begin
	writeln('Facturando cliente ',codcliente);
	for i := 1 to cantidadlineas do
		begin
			cargarDatosLinea(lineaaux);
			minutostotales := minutostotales + lineaaux.minconsumidos;
			mbtotales := mbtotales + lineaaux.mbconsumidos;
			borrarDatosLinea(lineaaux);
		end;
end;
var
	codingresado, cantlineasingresadas : integer;
	montofinal, montomins,montombs, mins, mbs : real;
begin
	write('Ingrese codigo de cliente = ');
	readln(codingresado);
	write('Ingrese la cantidad de lineas del cliente ', codingresado, ' = ');
	readln(cantlineasingresadas);
	facturarCliente(codingresado, cantlineasingresadas, mins, mbs);
	montomins := mins * 3.40;
	montombs := mbs * 1.35;
	montofinal := montomins + montombs;
	writeln;
	writeln('TOTAL CLIENTE');
	writeln('Cantidad de minutos consumidos = ', mins:2:2, ' x $3.40 = ', montomins:2:2,'$');
	writeln('Cantidad de MB consumidos = ', mbs:2:2, ' x $1.35 = ', montombs:2:2,'$');
	writeln('Importe Total = ', montofinal:2:2,'$');
end.
