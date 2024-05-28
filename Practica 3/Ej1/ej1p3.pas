program Registros;
type
	str20 = string[20];
	alumno = record
		codigo : integer;
		nombre : str20;
		promedio : real;
		end;
procedure leer(var alu : alumno);
	begin
		write('Ingrese el codigo del alumno = ');
		readln(alu.codigo);
		if (alu.codigo <> 0) then begin
			write('Ingrese el nombre del alumno : '); readln(alu.nombre);
			write('Ingrese el promedio del alumno = '); readln(alu.promedio);
		end;
end;
procedure actualizarMejorPromedio(promedioingresado : real; nombreingresado : string; var mejorpromedio : real; var nombremejorpromedio :string);
begin
	if(promedioingresado>mejorpromedio)then
		begin
		mejorpromedio := promedioingresado;
		nombremejorpromedio := nombreingresado;
		end;
end;
 { declaración de variables del programa principal }
var
	contadoralumnos :integer;
	mejorpromedio : real;
	nmejorpromedio : string;
	a : alumno;
begin
	mejorpromedio := -1;
	nmejorpromedio := ' ';
	contadoralumnos := 0;
	leer(a);
	actualizarMejorPromedio(a.promedio, a.nombre, mejorpromedio, nmejorpromedio);
	while(a.codigo<>0)do
		begin
			leer(a);
			contadoralumnos := contadoralumnos + 1;
			actualizarMejorPromedio(a.promedio, a.nombre, mejorpromedio, nmejorpromedio);
		end;
	writeln('Cantidad de alumnos registrados = ', contadoralumnos);
	writeln('El alumno con mejor promedio fue ', nmejorpromedio, ' con un promedio de ', mejorpromedio:2:2)
end.

