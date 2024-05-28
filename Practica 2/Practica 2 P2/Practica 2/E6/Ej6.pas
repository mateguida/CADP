Program P2E6;
procedure lectura;
var
	max, num : integer;
begin
	max := -1;
	repeat
		begin
			write('Ingrese un numero = ');
			readln(num);
			if((num > max)and((num MOD 2) = 0))then
				max := num;
		end
	until(num<0);
	writeln('El numero par mas alto fue el = ', max);
end;
begin
	lectura;
end.
