program ej7p2;
procedure sumatoria(input : integer; var cantdigitos: integer; var sumadigitos : integer);
var
	digito, aux : integer;
begin
	aux := input;
	digito := -1;
	while(aux <> 0)do
		begin
		digito := aux mod 10;
		cantdigitos := cantdigitos + 1;
		sumadigitos := sumadigitos + digito;
		aux := aux div 10
		end;
end;
var
	numeroingresado, cantidaddigitos, sumatoriafinal : integer;
begin
	cantidaddigitos := 0;
	repeat
		begin
		sumatoriafinal := 0;
		write('Ingrese un numero entero = ');
		readln(numeroingresado);
		sumatoria(numeroingresado, cantidaddigitos, sumatoriafinal);
		end
	until(sumatoriafinal = 10);
	writeln('Digitos leidos = ', cantidaddigitos);
end.
