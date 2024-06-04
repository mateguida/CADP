program P4Part2Ej2;
const
	tam = 500;
type
	vecAlumnos = array[1..tam] of string;
procedure imprimirVector(vector : vecAlumnos; dimL :integer);
var
	i : integer;
begin
	write('[');
	for i := 1 to dimL do
		begin
		write(vector[i],' ,');
		end;
	write(']');
end;
procedure guardarNombre(var vector: vecAlumnos; var dimLogica : integer; nombreingresado: string);
begin
	if(((dimLogica +1)<= tam)and (nombreingresado <> 'ZZZ'))then
		begin
		dimLogica := dimLogica + 1;
		vector[dimLogica] := nombreingresado;
		end;
end;
procedure eliminarNombre(var vector : vecAlumnos; var dimLogica : integer; nombreEliminar: string);
var
	i : integer;
begin
	i := 1;
	while(vector[i]<>nombreEliminar)do
		begin
		i := i + 1;
		end;
	for i:= i to dimLogica do 
		vector[i] := vector[i+1];
	dimLogica := dimLogica - 1;
end;
procedure posicion4(var vector: vecAlumnos; var dimLogica : integer; nombreingresado : string);
var
	i: integer;
begin
	for i := dimLogica to 4 do
		begin
			vector[i+1]:= vector[i];
		end;
	dimLogica := dimLogica + 1;
	vector[4]:= nombreingresado;
end;
var
	nombres : vecAlumnos;
	dimLogica : integer;
	nombreingresado : string;
begin
	nombreingresado := ' ';
	dimLogica := 0;
	while(nombreingresado <> 'ZZZ')do
		begin
		write('Ingrese un nombre a cargar : ');
		readln(nombreingresado);
		guardarNombre(nombres, dimLogica,nombreingresado);
		writeln;
		imprimirVector(nombres, dimLogica);
		writeln;
		writeln;
		end;
	write('Ingrese un nombre el cual se eliminara la primera aparicion en el vector : ');
	readln(nombreingresado);
	eliminarNombre(nombres, dimLogica, nombreingresado);
	imprimirVector(nombres, dimLogica);
	writeln;
	write('Ingrese un nombre el cual se ingresara en la posicion 4 del vector : ');
	readln(nombreingresado);
	posicion4(nombres,dimLogica, nombreingresado);
	imprimirVector(nombres, dimLogica);
end.
