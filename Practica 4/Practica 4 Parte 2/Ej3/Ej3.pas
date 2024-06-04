program P4P2Ej3;
const
	tam = 200;
type
	viaje = record
		dia : integer;
		dineroTransportado : real;
		distanciaRecorrida : real;
		end;
		
	vecViajes = array[1..tam] of viaje;
	
	arraycontador = array[1..31] of integer;

procedure ingresarDatos(var V : viaje);
begin
	write('Ingrese el dia que se realizo el viaje = ');
	readln(V.dia);
	write('Ingrese el dinero que fue transportado en el viaje = ');
	readln(V.dineroTransportado);
	write('Ingrese la distancia recorrida en el viaje = ');
	readln(V.distanciaRecorrida);
	writeln;
end;

procedure cargarViaje(var vector : vecViajes; var dimLogica : integer; viajeingresado : viaje);
begin
	if(((dimLogica + 1)<= tam)and (viajeingresado.distanciaRecorrida <> 0))then
		begin
		dimLogica := dimLogica + 1;
		vector[dimLogica] := viajeingresado;
		end;
end;

procedure ProcesarVector(vector : vecViajes; dimLogica : integer);
var
	i,j, diaMenorViaje, diames: integer;
	arraycont : arraycontador;
	dineroMenorViaje, distanciaMenorViaje, promedioMonto, acumuladorMonto : real;
begin
	for j := 1 to 31 do begin
		arraycont[j] := 0;
	end;
	dineroMenorViaje := 999;
	acumuladorMonto := 0;
	for i := 1 to dimLogica do//Recorro arreglo
		begin
		if(vector[i].dineroTransportado < dineroMenorViaje)then begin//Comparacion Minimo
			dineroMenorViaje := vector[i].dineroTransportado;
			diaMenorViaje := vector[i].dia;
			distanciaMenorViaje := vector[i].distanciaRecorrida;
			end;
		acumuladorMonto := acumuladorMonto + vector[i].dineroTransportado;//Acumulador del monto para promedio
		diames := vector[i].dia;
		arraycont[diames] := arraycont[diames] + 1;
		end;
	promedioMonto := acumuladorMonto / dimLogica;
	writeln('El monto promedio de los viajes fue ', promedioMonto);//Informar
	writeln('El viaje que transporto menos dinero fue el dia ', diaMenorViaje,' y recorrio ', distanciaMenorViaje:2:2,'km');
	for i := 1 to 31 do begin
		writeln('Viajes del dia ', i, ' = ', arraycont[i]);
		end;
end;

procedure EliminarViajesCortos(var vector : vecViajes; var dimL : integer);
var
	i ,j :integer;
begin
	for i := 1 to dimL do begin
		if(vector[i].distanciaRecorrida  < 100)then begin
			for j:= i to dimL do begin
				vector[i] := vector[i+1];
			end;
		dimL := dimL - 1;
		end;
	end;
end;



var
	infoViaje : viaje;
	viajesMes : vecViajes;
	dimLogica : integer;
begin
	dimLogica := 0;
	ingresarDatos(infoViaje);
	while(infoViaje.distanciaRecorrida <> 0)do
		begin
		ingresarDatos(infoViaje);
		cargarViaje(viajesMes, dimLogica, infoViaje);
		end;
		ProcesarVector(viajesMes, dimLogica);
		EliminarViajesCortos(viajesMes, dimLogica);
end.
