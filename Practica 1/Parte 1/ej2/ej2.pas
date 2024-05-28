program ej2;
var
	num1,num2: integer;
begin
	write('Ingrese el primer numero = ');
	readln(num1);
	write('Ingrese el segundo numero = ');
	readln(num2);
	if(num1=num2)then
		writeln('Los numeros leidos son iguales')
	else
		if(num1>num2)then
			writeln('El numero 1 es mayor')
		else
			writeln('El numero 2 es mayor');
end.
