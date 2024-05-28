program ej12p4;
Const
	cantgalaxias = 5;
	
type
//Creamos tipo galaxia
	galaxia = record
	nombre : string;
	tipo : string;
	masa : real;
	distancia : real;
	end;

//Creacion del arreglo de galaxias
	arraygalaxias = array [1..cantgalaxias] of galaxia;
	
//Procedimiento para cargar datos
procedure cargarGalaxias(var galaxias : arraygalaxias);
var
	i : integer;
begin
	//Recorro el arreglo y cargo datos ingresados por el usuario
	for i := 1 to cantgalaxias do
		begin
		writeln('---CARGANDO GALAXIA---');
		writeln;
		write('Ingrese el nombre de la galaxia : ');
		readln(galaxias[i].nombre);
		write('Ingrese que tipo de galaxia es : ');
		readln(galaxias[i].tipo);
		write('Ingrese la masa de la galaxia = ');
		readln(galaxias[i].masa);
		write('Ingrese la distancia de la galaxia = ');
		readln(galaxias[i].distancia);
		end;
end;

//Procedimiento para contas las galaxias
procedure contarGalaxias(galaxias : arraygalaxias; var elipticas, espirales, lenticulares, irregulares : integer);
var
	i : integer;
begin
	//Recorro el array y comparo el tipo de galaxia, cuando coincide aumento el contador
	for i := 1 to cantgalaxias do
		begin
			case(galaxias[i].tipo)of
			'Eliptica' : elipticas := elipticas + 1;
			'Espiral' : espirales := espirales + 1;
			'Lenticular' : lenticulares := lenticulares + 1;
			'Irregular' : irregulares := irregulares + 1;
			end;
		end;
end;


//Funcion que recorre el arreglo hasta encontrar los nombres requeridos
function lasTresPrincipales(galaxias : arraygalaxias) : real;
var
	masavia, masaandromeda, masatriangulo : real;
	i : integer;
begin
	i := 1;
	while(galaxias[i].nombre <> 'Via Lactea')do
		i := i + 1;
	masavia := galaxias[i].masa;
	
	i:= 1;
	while(galaxias[i].nombre <> 'Andromeda')do
		i := i + 1;
	masaandromeda := galaxias[i].masa;
	
	i := 1;
	while(galaxias[i].nombre <> 'Triangulo')do
		i := i + 1;
	masatriangulo := galaxias[i].masa;
	//Acumulo el total de las masas de las 3 galaxias
	lasTresPrincipales := (masavia + masaandromeda + masatriangulo);
end;

//Funcion que retorna que porcentaje representa una masa que se le envie
function Porcentaje(galaxias : arraygalaxias; masaingresada : real) : real;
var
	acumuladormasas : real;
	i : integer;
begin
	acumuladormasas := 0;
	for i := 1 to cantgalaxias do 
		begin//Recorro el arreglo y acumulo la masa total
		acumuladormasas := acumuladormasas + galaxias[i].masa
		end;
	Porcentaje := (masaingresada/acumuladormasas)*100//Formula para dejarlo en porcentaje
end;

//Funcion que cuenta las galaxias a menos de 1000 parsecs de distancia, que no son irregulares
function noirregularesCercanas(galaxias : arraygalaxias) : integer;
var
	contadorgalaxiascercanas : integer;
	i : integer;
begin
	//recorro el arreglo
	contadorgalaxiascercanas := 0;
	for i := 1 to cantgalaxias do
		begin
			//Chequeo que la galaxia no sea irregular y que ademas la distancia sea menor a 1000
			if((galaxias[i].tipo <> 'Irregular')and(galaxias[i].distancia < 1000))then
				begin
					contadorgalaxiascercanas := contadorgalaxiascercanas + 1; //Incremento el contador
				end;
		end;
	noirregularesCercanas := contadorgalaxiascercanas; //retorno el contador
end;

//Procedimiento que compara las masas maximas y minimas y luego me devuelve los nombres de las galaxias
procedure maximosyminimos(galaxias : arraygalaxias; var nombremax1, nombremax2, nombremin1, nombremin2 : string);
var
	i : integer;
	max1, max2, min1, min2 : real;
begin
	max1:= -1;
	max2:= -1;
	min1 := 9999;
	min2 := 9999;
	
	for i := 1 to cantgalaxias do
		begin
		if(galaxias[i].masa > max1)then begin
			max1 := galaxias[i].masa;
			nombremax1 := galaxias[i].nombre;
			end;
			
		if((galaxias[i].masa < max1)and(galaxias[i].masa > max2))then begin
			max2 := galaxias[i].masa;
			nombremax2 := galaxias[i].nombre;
			end;
			
		if(galaxias[i].masa < min1)then begin
			min1 := galaxias[i].masa;
			nombremin1 := galaxias[i].nombre;
			end;
			
		if((galaxias[i].masa > min1)and(galaxias[i].masa < min2))then begin
			min2 := galaxias[i].masa;
			nombremin2 := galaxias[i].nombre;
			end;
			
		end;
end;

//main code
var
	elipticas, espirales, lenticulares, irregulares : integer;
	galaxias : arraygalaxias;
	masagalaxiasprincipales : real;
	nombremax1, nombremax2, nombremin1, nombremin2 : string;
begin
	nombremax1 := '';
	nombremax2 := '';
	nombremin1 := '';
	nombremin2 := '';
	cargarGalaxias(galaxias);
	masagalaxiasprincipales := lasTresPrincipales(galaxias);
	contarGalaxias(galaxias, elipticas, espirales, lenticulares, irregulares);
	maximosyminimos(galaxias, nombremax1,nombremax2,nombremin1,nombremin2);
	writeln;
	writeln('Contador de galaxias');
	writeln('Elipticas = ', elipticas);
	writeln('Espirales = ', espirales);
	writeln('Lenticulares = ', lenticulares);
	writeln('Irregulares = ', irregulares);
	writeln;
	writeln('La masa total de las galaxias Via Lactea, Andromeda y Triangulo es = ', masagalaxiasprincipales:2:2 ,'kg y esto representa un ', Porcentaje(galaxias, masagalaxiasprincipales):2:2,'% de la masa de todas las galaxias');
	writeln('La cantidad de galaxias que no son irregulares que se encuentran a menos de 1000 parsecs es = ', noirregularesCercanas(galaxias));
	writeln('Galaxias con mayores masas : ', nombremax1, ' y ', nombremax2);
	writeln('Galaxias con menores masas : ', nombremin1, ' y ', nombremin2);
end.
