program ej9;
var
	operacion : char;
	numerooperado, numeroingresado:integer;
begin
	write('Ingrese la operacion a realizar : ');
	readln(operacion);
	if((operacion = '+') or (operacion = '-'))then
		begin
		write('Ingrese un numero = ');
		readln(numerooperado);
		repeat
			begin
			write('Ingrese un numero = ');
			readln(numeroingresado);
			if(operacion = '+')then
				numerooperado := numerooperado + numeroingresado
			else
				numerooperado := numerooperado - numeroingresado
			end
		until(numeroingresado = 0);
		writeln('El resultado es = ', numerooperado)
		end
	else
		writeln('Error : La operacion ingresada no es valida');
end.
