program ej27;
var
	tiempoingresado, tprimerpuesto, tsegundopuesto, tultimopuesto, tanteultimopuesto : real;
	nprimerpuesto, nsegundopuesto,  nombreingresado, nultimopuesto, nanteultimopuesto : string;
	i: integer;
begin
	nprimerpuesto := ' ';
	nsegundopuesto := ' ';
	nanteultimopuesto := ' ';
	nultimopuesto := ' ';
	tprimerpuesto := 999;
	tsegundopuesto := 999;
	tanteultimopuesto := -1;
	tultimopuesto := -1;
	for i := 1 to 5 do
		begin
			write('Ingrese nombre del piloto : ');
			readln(nombreingresado);
			write('Ingrese tiempo del piloto ',nombreingresado,' = ');
			readln(tiempoingresado);
			if(tiempoingresado < tprimerpuesto)then
				begin
					tsegundopuesto := tprimerpuesto;
					nsegundopuesto := nprimerpuesto;
					tprimerpuesto := tiempoingresado;
					nprimerpuesto := nombreingresado;
				end;
			if((tiempoingresado < tsegundopuesto)and(tiempoingresado > tprimerpuesto))then
				begin
					tsegundopuesto := tiempoingresado;
					nsegundopuesto := nombreingresado;
				end;
			if(tiempoingresado>tultimopuesto)then
				begin
					tanteultimopuesto:= tultimopuesto;
					nanteultimopuesto:= nultimopuesto;
					tultimopuesto := tiempoingresado;
					nultimopuesto := nombreingresado;
				end;
			if((tiempoingresado<tultimopuesto)and(tiempoingresado>tanteultimopuesto))then
				begin
					tanteultimopuesto := tiempoingresado;
					nanteultimopuesto := nombreingresado;
				end;
			end;
	writeln;
	writeln('TABLA DE POSICIONES');
	writeln('1. ', nprimerpuesto, ' -- Tiempo = ', tprimerpuesto:2:2,'s');
	writeln('2. ', nsegundopuesto, ' -- Tiempo = ', tsegundopuesto:2:2,'s');
	writeln('. ');
	writeln('. ');
	writeln('. ');
	writeln('99. ', nanteultimopuesto, ' -- Tiempo = ', tanteultimopuesto:2:2,'s');
	writeln('100. ', nultimopuesto, ' -- Tiempo = ', tultimopuesto:2:2,'s');
	
end.
