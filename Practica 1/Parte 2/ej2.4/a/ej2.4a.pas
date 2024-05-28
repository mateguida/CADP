program ej24a;
var
	numerominimo1, numerominimo2, numeroingresado: integer;
begin
	numerominimo1 := 0;
	numerominimo2 := 0;
	repeat
		begin
			write('Ingrese un numero = ');
			readln(numeroingresado);
			if((numerominimo1 <> 0) and (numerominimo2 <> 0) and ((numeroingresado < numerominimo1) or (numeroingresado < numerominimo2)))then
				begin
					if((numeroingresado < numerominimo1)and(numeroingresado <> 0))then
						numerominimo1 := numeroingresado
					else
						numerominimo2 := numeroingresado;
				end
			else
				begin
					if(numerominimo1 = 0)then
						numerominimo1 := numeroingresado
					else
						begin
							if(numerominimo2 = 0)then
								numerominimo2 := numeroingresado;
						end
				end
		end
	until(numeroingresado = 0);
	write('Los numeros minimos ingresados son ', numerominimo1, ' y ', numerominimo2);
end.
