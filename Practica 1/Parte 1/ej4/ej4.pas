program ej4;
var
	numbase, numingresado:real;
begin
	write('Ingrese el numero base = ');
	readln(numbase);
	repeat
		begin
		write('Ingrese un numero = ');
		readln(numingresado);
		end
	until(numingresado = (numbase*2));
	writeln('Se ha finalizado el codigo porque el ultimo numero ingresado equivale al valor de 2 veces el numero base')
end.
