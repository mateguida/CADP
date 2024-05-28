program ej23;
var
	nombrealumno : string;
	aprobados, nota7, nota: integer;
begin
	aprobados := 0;
	nota7 := 0;
	repeat
		begin
		write('Ingrese nombre del alumno = ');
		readln(nombrealumno);
		write('Ingrese la nota que obtuvo ', nombrealumno,' en el modulo EPA = ');
		readln(nota);
		if(nota>8)then
			aprobados := aprobados + 1
		else
			if(nota = 7)then
				nota7 := nota7 + 1;
		end
	until(nombrealumno = 'Zidane Zinedine');
	writeln('Alumnos aprobados = ', aprobados);
	writeln('Alumnos con 7 = ', nota7);
end.
