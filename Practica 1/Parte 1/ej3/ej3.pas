program ej3;
var
	num1,num2,num3: integer;
begin
	write('Ingrese el primer numero = ');
	readln(num1);
	write('Ingrese el segundo numero = ');
	readln(num2);
	write('Ingrese el tercer numero = ');
	readln(num3);
	if(num1>num2)then
		begin
			if(num3>num1)then
				writeln(num3,' ',num1,' ', num2,' ')
			else
				if(num3>num2)then
					writeln(num1,' ',num3,' ', num2,' ')
				else
					writeln(num1,' ',num2,' ', num3,' ');
		end;
	if(num2>num1)then
		begin
			if(num3>num2)then
				writeln(num3,' ',num2,' ', num1,' ')
			else
				if(num3>num1)then
					writeln(num2,' ',num3,' ', num1,' ')
				else
					writeln(num2,' ',num1,' ', num3,' ');
		end;
end.
