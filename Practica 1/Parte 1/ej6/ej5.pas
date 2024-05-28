program ej5;
var
	cantalumnosdestfinal, numlegajo, numpromedio:real;
	cantalumnos,cantalumnosaprobados,cantalumnosdest:integer;
begin
	cantalumnos := 0;
	cantalumnosaprobados:= 0;
	cantalumnosdest:= 0;
	repeat
		begin
		write('Ingrese numero de legajo = ');
		readln(numlegajo);
		if(numlegajo <> -1)then
			begin
				write('Ingrese promedio = ');
				readln(numpromedio);
				cantalumnos := cantalumnos+1;
				if((numpromedio > 8.5) and (numlegajo < 2500))then
					cantalumnosdest := cantalumnosdest + 1;
				if(numpromedio > 6.5)then
					cantalumnosaprobados := cantalumnosaprobados + 1;
				end;
			end
	until(numlegajo = -1);
	cantalumnosdestfinal := (cantalumnosdest/cantalumnos)*100;
	writeln('Cantidad de alumnos leidos = ', cantalumnos);
	writeln('Cantidad de alumnos aprobados = ', cantalumnosaprobados);
	writeln('Porcentaje de alumnos destacados con numero de legajo inferior a 2500 = ', cantalumnosdestfinal:3:2, '%');
end.
