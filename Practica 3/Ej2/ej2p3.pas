program ej2p3;
type
	fecha = record
		dia: integer;
		mes: string;
		ano: integer;
		end;
procedure actualizarFecha(var f: fecha);
begin
	write('Ingrese dia del casamiento = ');
	readln(f.dia);
	write('Ingrese mes del casamiento en palabras : ');
	readln(f.mes);
	write('Ingrese ano del casamiento = ');
	readln(f.ano);
end;
var
	cantidadverano, cantidadprimeros10 : integer;
	fech : fecha;
begin
	cantidadverano := 0;
	cantidadprimeros10 := 0;
	actualizarFecha(fech);
	if((fech.mes = 'enero') or (fech.mes = 'febrero') or (fech.mes = 'marzo'))then
		cantidadverano := cantidadverano + 1;
	if(fech.dia <= 10)then
		cantidadprimeros10 := cantidadprimeros10 + 1;
	while(fech.ano = 2019)do
		begin
		actualizarFecha(fech);
		if((fech.mes = 'enero') or (fech.mes = 'febrero') or (fech.mes = 'marzo'))then
			cantidadverano := cantidadverano + 1;
		if(fech.dia <= 10)then
			cantidadprimeros10 := cantidadprimeros10 + 1;
		end;
	writeln('Cantidad de casamientos en los meses de verano = ', cantidadverano);
	writeln('Cantidad de casamientos en los primeros 10 dias del mes = ', cantidadprimeros10);
end.
