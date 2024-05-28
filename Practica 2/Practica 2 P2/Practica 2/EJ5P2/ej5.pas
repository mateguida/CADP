program ej5p2;
function esDoble (numA : integer; numB : integer): boolean;
var
	BdobleA : boolean;
begin
	if(numB = (numA*2))then
		BdobleA := true
	else
		BdobleA := false;
	esDoble := BdobleA;
end;
var
	contadorpares, contadordobles, numeroA, numeroB : integer;
begin
	contadorpares := 0;
	contadordobles := 0;
	write('Ingrese N°A = ');
	readln(numeroA);
	write('Ingrese N°B = ');
	readln(numeroB);
	while((numeroA <> 0)and(numeroB<>0))do
		begin
		if(esDoble(numeroA, numeroB))then
			contadordobles := contadordobles + 1;
		write('Ingrese Nro A = ');
		readln(numeroA);
		write('Ingrese Nro B = ');
		readln(numeroB);
		contadorpares := contadorpares + 1;
		end;
	writeln('Pares leidos = ',contadorpares);
	writeln('Pares donde B es el doble de A = ',contadordobles);
end.
