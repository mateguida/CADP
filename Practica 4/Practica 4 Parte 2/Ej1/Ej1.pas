program Practica4Parte2Ej1;
const
	tam = 500;
type
	vecEnteros = array[1..tam] of integer;
function BuscarValor(enteros : vecEnteros; num : integer): boolean;
var
	presente : boolean;
	i : integer;
begin
	presente := false;
	for i := 1 to tam do
		begin 
		if(enteros[i] = num)then
			presente := true;
		end;
		BuscarValor := presente;
end;
var
	i :integer;
	numingresado : integer;
	vector : vecEnteros;
begin
	for i := 1 to tam do
		begin
		vector[i] := random(500);
		end;
	write('Ingrese el numero que desea buscar en el vector = ');
	readln(numingresado);
	if(BuscarValor(vector, numingresado))then
		writeln('El numero se encuentra en el vector')
	else
		writeln('El numero no se encuentra en el vector');
end.

