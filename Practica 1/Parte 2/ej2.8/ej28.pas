{Un local de ropa desea analizar las ventas realizadas en el último mes. Para ello se lee por cada día del mes,
 los montos de las ventas realizadas. La lectura de montos para cada día finaliza cuando se lee el monto 0. Se
 asume unmesde31días. Informar la cantidad de ventas por cada día, y el monto total acumulado en ventas
 de todo el mes.
 a. Modifique el ejercicio anterior para que además informe el día en el que se realizó la mayor cantidad
 de ventas}
 Program ej28;
 const
	diasmes = 4;
 var
	i, ventasdiamasventas, montoingresado, contadorventas, montototal, diaconmasventas:integer;
begin
	diaconmasventas := 0;
	ventasdiamasventas := -1;
	montototal := 0;
	for i := 1 to diasmes do
		begin
		write('Ingrese un monto = ');
		readln(montoingresado);
		montototal := montototal + montoingresado;
		contadorventas := 0;
			while(montoingresado <> 0)do
				begin
					write('Ingrese un monto = ');
					readln(montoingresado);
					contadorventas := contadorventas + 1;
					montototal := montototal + montoingresado;
				end;
			writeln;
			writeln('Ventas del dia ',i, ' = ', contadorventas);
			writeln;
			if(contadorventas > ventasdiamasventas)then begin
				ventasdiamasventas := contadorventas;
				diaconmasventas := i;
				end;
		end	;
		writeln;
		writeln('Dia con mas ventas : Dia ',diaconmasventas);
		writeln('Monto del mes = ',montototal);
end.
