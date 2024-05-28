program ej21;
var
	i, mayoresa5, numeroingresado, total:integer;
	
begin
	total := 0;
	mayoresa5 := 0;
	for i := 1 to 10 do
		begin
		write('Ingrese un numero = ');
		readln(numeroingresado);
		if(numeroingresado>5)then
			mayoresa5 := mayoresa5 + 1;
		total := total + numeroingresado;
		end;
	writeln('La sumatoria de los numeros ingresados previamente es = ', total);
	writeln('La cantidad de numeros mayores a 5 es = ', mayoresa5);
end.

