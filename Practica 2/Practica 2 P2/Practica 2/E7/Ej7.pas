program alcanceYFunciones;
var
	suma, cant : integer;
function calcularPromedio : real;
var
	prom : real;
begin
	if (cant = 0) then
		prom :=-1
	else
		prom := suma / cant;
	calcularPromedio := prom;
end;
var
	promediofinal : real;
begin { programa principal }
	readln(suma);
	readln(cant);
	promediofinal := calcularPromedio;
	if (promediofinal <> -1) then begin
		writeln('El promedio es: ' , promediofinal:2:2);
	end
	else
		writeln('Dividir por cero no parece ser una buena idea');
end.
