program Ej1;
var
	num:integer;
begin
	write('Ingrese un numero: ');
	readln(num);
	if(num<0)then
		num := num * (-1) ;
	writeln('El valor absoluto es : ', num);
end.
