program ej7;
var
	numproducto, precio, precionuevo:real;
begin
	repeat
		begin
		write('Ingrese numero de producto = ');
		readln(numproducto);
		write('Ingrese precio = ');
		readln(precio);
		write('Ingrese el nuevo precio = ');
		readln(precionuevo);
		if((precionuevo-precio)>(precio/10))then
			writeln('El aumento de precio del producto ', numproducto:5:0, ' supera el 10%')
		else
			writeln('El aumento de precio del producto ', numproducto:5:0, ' no supera el 10%');
		end;
	until(numproducto = 32767);
end.
