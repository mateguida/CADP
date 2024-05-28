program ej22;
var
	i, posicionfinal, numeromayor, numeroingresado:integer;
begin
	numeromayor := 0;
	for i := 1 to 10 do
		begin
		write('Ingrese un numero = ');
		readln(numeroingresado);
		if(numeroingresado>numeromayor)then
			begin
			numeromayor := numeroingresado;
			posicionfinal := i;
			end
		end;
	writeln('El mayor numero leido fue el = ', numeromayor,',en la posicion ', posicionfinal);
end.
