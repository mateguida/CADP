program ej25;
var
	numeroingresado, numeromayor, numeromenor, sumatotal:integer;
begin
	numeromayor := 0;
	numeromenor := 0;
	sumatotal := 0;
	repeat
		begin
			write('Ingrese un numero = ');
			readln(numeroingresado);
			sumatotal := sumatotal + numeroingresado;
			if((numeromayor = 0)and(numeromenor = 0))then
				begin
					numeromayor := numeroingresado;
					numeromenor := numeroingresado;
				end
			else
				begin
					if(numeroingresado<numeromenor)then
						numeromenor := numeroingresado;
					if(numeroingresado>numeromayor)then
						numeromayor := numeroingresado;
				end
		end
	until(numeroingresado = 100);
	writeln('El mayor numero ingresado es ',numeromayor,' y el menor numero ingresado es ', numeromenor);
	writeln('La sumatoria total de numeros es = ', sumatotal);
end.
