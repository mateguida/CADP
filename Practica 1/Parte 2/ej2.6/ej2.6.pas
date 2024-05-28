program ej26;
var
	p16par, prodbarato1,preciobarato1 , prodbarato2,preciobarato2 , i, codigoproducto, precio:integer;
begin
	prodbarato1 := 0;
	prodbarato2 := 0;
	p16par := 0;
	for i:= 1 to 10 do
		begin
			write('Ingrese el codigo del producto = ');
			readln(codigoproducto);
			writeln('Ingrese el precio del producto ',codigoproducto, ' = ');
			readln(precio);
			
			if((prodbarato1 = 0)or(prodbarato2 = 0))then
				begin
				if(prodbarato1 = 0)then
					begin
					prodbarato1 := codigoproducto;
					preciobarato1 := precio;
					end
				else
					begin
					prodbarato2 := codigoproducto;
					preciobarato2 := precio;
					end
				end;
				
			if((precio<preciobarato1)or(precio<preciobarato2))then
				begin
				if(precio<preciobarato1)then
					begin
					prodbarato1 := codigoproducto;
					preciobarato1 := precio;
					end
				else
					begin
					prodbarato2 := codigoproducto;
					preciobarato2 := precio;
					end
				end;
			
			if((precio>16)and((codigoproducto mod 2) = 0))then
				p16par := p16par + 1;
		end;
	writeln('Los codigos de los 2 productos mas baratos son : El producto : ',prodbarato1, ' y el producto : ', prodbarato2);
	writeln('La cantidad de productos que valen mas de 16 pesos con codigo par es = ', p16par);
end.
