program ej6p2;
procedure leerProducto(var precioproducto : real; var codigoproducto : integer; var tipo : string);
begin
	writeln('CARGAR PRODUCTO');
	write('Precio = ');
	readln(precioproducto);
	write('Codigo = ');
	readln(codigoproducto);
	write('Tipo : ');
	readln(tipo);
	writeln;
end;
procedure actualizarBaratos(codingresado : integer; precioingresado : real; var codbarato1 : integer; var codbarato2:integer; var preciobarato1 : real; var preciobarato2 : real);
begin
	if((precioingresado<preciobarato1)and(precioingresado<preciobarato2))then
		begin
		preciobarato2 := precioingresado;
		codbarato2 := codingresado;
		end
	else
		if((precioingresado>preciobarato2)and(precioingresado<preciobarato1))then
			begin
			preciobarato1:= precioingresado;
			codbarato1:= codingresado;
			end;
end;
procedure actualizarPantMasCaro(codingresado: integer; precioingresado: real; var preciomascaro : real; var codigomascaro : integer);
begin
	if(precioingresado > preciomascaro)then
		begin
		preciomascaro := precioingresado;
		codigomascaro := codingresado;
		end
end;
var
	tipoingresado : string;
	codigoingresado, cpantmascaro, cmasbarato1, cmasbarato2 : integer;
	ppromedio,sumatotal, precioingresado, ppantmascaro, pmasbarato1, pmasbarato2 : real;
	i : integer;
begin
	sumatotal := 0;
	ppantmascaro := -1;
	cpantmascaro := 0;
	cmasbarato1 := 0;
	cmasbarato2 := 0;
	pmasbarato1 := 9999;
	pmasbarato2 := 9999;
	for i := 1 to 5 do
		begin
		leerProducto(precioingresado, codigoingresado, tipoingresado);
		actualizarBaratos(codigoingresado, precioingresado,cmasbarato1, cmasbarato2, pmasbarato1, pmasbarato2);
		if(tipoingresado = 'Pantalon')then
			actualizarPantMasCaro(codigoingresado, precioingresado, ppantmascaro, cpantmascaro);
		sumatotal := sumatotal + precioingresado;
		end;
	ppromedio := (sumatotal/i);
	writeln;
	writeln('Los codigos de los 2 productos mas baratos = ');
	writeln('El producto ', cmasbarato2, ' que vale ', pmasbarato2:2:2);
	writeln('El producto ', cmasbarato1, ' que vale ', pmasbarato1:2:2);
	writeln;
	writeln('El pantalon mas caro tiene el codigo ', cpantmascaro, ' y sale ', ppantmascaro:2:2);
	writeln;
	writeln('El precio promedio fue = ', ppromedio:2:2);
	
end.
