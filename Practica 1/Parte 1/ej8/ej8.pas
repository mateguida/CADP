program ej8;
var
	check1, check2, check3: boolean;
	letras : array[1..3]of char;
	vocales : array[1..5] of char;
begin
	vocales[1]:='a';
	vocales[2]:='e';
	vocales[3]:='i';
	vocales[4]:='o';
	vocales[5]:='u';
	write('Ingrese la primera letra : ');
	readln(letras[1]);
	write('Ingrese la segunda letra : ');
	readln(letras[2]);
	write('Ingrese la tercera letra : ');
	readln(letras[3]);
	if((letras[1] = vocales[1]) or (letras[1] = vocales[2]) or (letras[1] = vocales[3]) or (letras[1] = vocales[4]) or (letras[1] = vocales[5]))then
		check1 := true
	else 
		check1 := false;
	if((letras[2] = vocales[1]) or (letras[2] = vocales[2]) or (letras[2] = vocales[3]) or (letras[2] = vocales[4]) or (letras[2] = vocales[5]))then
		check2 := true
	else 
		check2 := false;
	if((letras[3] = vocales[1]) or (letras[3] = vocales[2]) or (letras[3] = vocales[3]) or (letras[3] = vocales[4]) or (letras[3] = vocales[5]))then
		check3 := true
	else 
		check3 := false;
	if(check1 and check2 and check3)then
		writeln('Todas las letras son vocales')
	else
		writeln('Al menos una letra no es vocal')
end.
