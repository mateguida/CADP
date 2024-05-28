program ej3p3;
const
	cantidadescuelas = 4;
type
	establecimiento = record
		cue : integer;
		nombre : string;
		cantdocentes : integer;
		cantalumnos : integer;
		localidad : string;
		end;
procedure leerEscuela(var escuela : establecimiento);
begin
	write('Ingrese CUE(Codigo unico de establecimiento) = ');
	readln(escuela.cue);
	write('Ingrese nombre del establecimiento : ');
	readln(escuela.nombre);
	write('Ingrese la cantidad de docentes en el establecimiento = ');
	readln(escuela.cantdocentes);
	write('Ingrese la cantidad de alumnos en el establecimiento = ');
	readln(escuela.cantalumnos);
	write('Ingrese la localidad del establecimiento = ');
	readln(escuela.localidad);
	writeln;
end;
function sacarRelacionDocenteAlumno(cantidadalumnos : integer; cantidaddocentes: integer):integer;
var
	resultado : integer;
begin
	resultado := (cantidadalumnos div cantidaddocentes);
	sacarRelacionDocenteAlumno := resultado;
end;
procedure actualizarMejoresEscuelas(ractual : integer; cueactual:integer; nombreactual: string;
var rmejorescuela : integer; var cuemejorescuela : integer; var nombremejorescuela : string;
var rsegundamejorescuela : integer; var cuesegundamejorescuela : integer; var nombresegundamejorescuela : string);
begin
	if((ractual > rmejorescuela)and( ractual > rsegundamejorescuela))then
		begin
			rsegundamejorescuela := rmejorescuela;
			cuesegundamejorescuela := cuemejorescuela;
			nombresegundamejorescuela := nombremejorescuela;
			rmejorescuela := ractual;
			cuemejorescuela := cueactual;
			nombremejorescuela := nombreactual;
		end;
	if((ractual < rmejorescuela) and (ractual > rsegundamejorescuela))then
		begin
		rsegundamejorescuela := ractual;
		cuesegundamejorescuela := cueactual;
		nombresegundamejorescuela := nombreactual;
		end;
end;
var
	escuela: establecimiento;
	nmejorescuela, nsegundamejorescuela : string;
	cuemejorescuela, cuesegundamejorescuela : integer;
	rmejorescuela, rsegundamejorescuela : integer;
	contadorescuelasporencima, relacionactual, i :integer;
begin
	cuemejorescuela := 0;
	cuesegundamejorescuela := 0;
	nmejorescuela := ' ';
	nsegundamejorescuela := ' ';
	rmejorescuela := -1;
	rsegundamejorescuela := -1;
	contadorescuelasporencima := 0;
	for i := 1 to cantidadescuelas do
		begin
			leerEscuela(escuela);
			relacionactual := sacarRelacionDocenteAlumno(escuela.cantalumnos, escuela.cantdocentes);
			if(relacionactual > 23435)then
				contadorescuelasporencima := contadorescuelasporencima +1;
			actualizarMejoresEscuelas(relacionactual, escuela.cue, escuela.nombre,
			rmejorescuela,cuemejorescuela,nmejorescuela,rsegundamejorescuela,cuesegundamejorescuela,nsegundamejorescuela)
		end;
	writeln('Cantidad de escuelas con Relacion docentes-alumnos mayor a 23435 = ', contadorescuelasporencima);
	writeln;
	writeln('Mejores 2 escuelas');
	writeln;
	writeln('1. ', nmejorescuela);
	writeln('CUE = ',cuemejorescuela);
	writeln('Relacion = ',rmejorescuela);
	writeln('2. ', nsegundamejorescuela);
	writeln('CUE = ',cuesegundamejorescuela);
	writeln('Relacion = ', rsegundamejorescuela);
end.
