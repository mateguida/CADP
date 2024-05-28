{6. La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales
 lanzadas al espacio en la última década. De cada sonda se conoce su nombre, duración estimada de la
 misión (cantidad de meses que permanecerá activa), el costo de construcción, el costo de
 mantenimiento mensual y rango del espectro electromagnético sobre el que realizará estudios. Dicho
 rango se divide en 7 categorías: 1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta;
 6. rayos X; 7. rayos gamma.
 Realizar un programa que lea y almacene la información de todas las sondas espaciales. La lectura
 finaliza al ingresar la sonda llamada “GAIA”, que debe procesarse.
 Una vez finalizada la lectura, informar:
 a. El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
 b. La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
 c. La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
 d. El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sondas.
 Nota: para resolver los incisos a), b), c) y d), la lista debe recorrerse la menor cantidad de veces posible}

program practicaListas6;
type
    //Creo el tipo "sonda"
    sonda = record
            nombre :string;
            mesesMision :integer;
            costoConstruccion : real;
            costoMantenimiento : real;
            espectroElectromagnetico : string;
            end;

    //Declaro lista con 2 componentes, una sonda y el puntero al siguiente nodo
    lista = ^nodo;
    
    nodo = record
           dato : sonda;
           sig : lista;
           end;
           
    vecContador = array[1..7] of integer;

//Procedimiento que lee los datos de una sonda ingresados por teclado
procedure leerSonda(var s :sonda);
begin
    writeln('CARGANDO SONDA');
    write('Nombre : ');
    readln(s.nombre);
    write('Meses que toma la mision = ');
    readln(s.mesesMision);
    write('Costo de construcción = ');
    readln(s.costoConstruccion);
    write('Costo de mantenimiento = ');
    readln(s.costoMantenimiento);
    writeln('Espectro Electromagnetico a estudiar : ');
    write('1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma. : ');
    readln(s.espectroElectromagnetico);
end;

//Procedimiento que agrega nodos adelante y carga los datos de la sonda en el registro del puntero
procedure cargarSonda(var L : lista; s : sonda);
var
    nuevoNodo : lista;
begin
    new(nuevoNodo); //Creo nuevo nodo en memoria
    nuevoNodo^.dato := s;   //Le cargo la sonda ingresada
    nuevoNodo^.sig := L;    //Le referencio al puntero del nodo el siguiente elemento
    L := nuevoNodo; //Actualizo el primer puntero
end;

//Procedimiento que buscara la sonda mas costosa y la informara en consola
//Inciso A
procedure informarSondaMasCostosa(l : lista);
var
    sondaMasCostosa : string;
    maxCosto, costoTotalSonda : real;
begin
    maxCosto := -1;
    while(l <> nil)do begin
        costoTotalSonda := (l^.dato.costoConstruccion + l^.dato.costoMantenimiento); //Encuentro el gasto final de la sonda
        if(costoTotalSonda > maxCosto) then begin //Comparo con el gasto maximo
            maxCosto := costoTotalSonda;
            sondaMasCostosa := l^.dato.nombre; //Recuerdo el nombre 
        end;
        l := l^.sig; //Paso al siguiente elemento de la lista
    end;
    //Una vez recorrida la lista informo
    writeln;
    writeln('La sonda mas costosa es la sonda "',sondaMasCostosa,'" con un costo de ', maxCosto:2:2, 'U$D');
    writeln;
end;

//Procedimiento que contara la cantidad de sondas que estudian cada espectro electromagnetico y luego los informara
//Inciso B
procedure informarEspectrosElectromagneticos(l:lista);
var
    i : integer;
    vectorContador : vecContador;
    espectroActual : string;
begin
    for i := 1 to 7 do begin
        vectorContador[i] := 0;
    end;
    while(l <> nil)do begin
        espectroActual := l^.dato.espectroElectromagnetico;
        case espectroActual of //Evaluo el espectro de cada sonda e incremento su respectivo contador
        'Radio' : vectorContador[1] := vectorContador[1] + 1;
        'Microondas': vectorContador[2] := vectorContador[2] + 1;
        'Infrarrojo': vectorContador[3] := vectorContador[3] + 1;
        'Luz visible': vectorContador[4] := vectorContador[4] + 1;
        'Ultravioleta': vectorContador[5] := vectorContador[5] + 1;
        'Rayos X': vectorContador[6] := vectorContador[6] + 1;
        'Rayos gamma': vectorContador[7] := vectorContador[7] + 1;
        end;
        l := l^.sig; //paso al siguiente elemento
    end;
    //Informo todos los espectros
    writeln;
    writeln('Estudios de espectros');
    writeln('Radio = ', vectorContador[1]);
    writeln('Microondas = ', vectorContador[2]);
    writeln('Infrarrojo = ', vectorContador[3]);
    writeln('Luz visible = ', vectorContador[4]);
    writeln('Ultravioleta = ', vectorContador[5]);
    writeln('Rayos X = ', vectorContador[6]);
    writeln('Rayos gamma = ', vectorContador[7]);
    writeln;
end;

//Funcion que retornara el valor promedio de cantidad de meses de mision de las sondas
function promMeses(l : lista): integer;
var
    duracionTotal, contadorPromedio : integer;
begin
    duracionTotal := 0;
    contadorPromedio := 0;
    while(l <> nil)do begin
        duracionTotal := duracionTotal + l^.dato.mesesMision;
        contadorPromedio := contadorPromedio + 1;
        l := l^.sig;
    end;
    promMeses := duracionTotal div contadorPromedio;
end;

//Procedimiento que informara la cantidad de sondas cuya duracion sea mayor a la promedio
//Inciso C
procedure informarSondasConMasDuracion(l : lista);
var
    contadorSondas, promedioDuracion : integer;
begin
    contadorSondas := 0;
    promedioDuracion := promMeses(l);
    while(l <> nil)do begin
        if(l^.dato.mesesMision > promedioDuracion)then begin
            contadorSondas := contadorSondas + 1;
        end;
        l := l^.sig;
    end;
    writeln;
    writeln('La cantidad de sondas cuya duracion esta sobre la duracion promedio es ', contadorSondas);
    writeln;
end;

//Funcion que retornara el valor promedio de los costos de las sondas
function promCosto(l : lista) : real;
var 
    costoTotal : real;
    contadorPromedio : real;
begin
    contadorPromedio := 0;
    costoTotal := 0;
    while(l <> nil)do begin
        costoTotal := costoTotal + (l^.dato.costoMantenimiento + l^.dato.costoConstruccion);
        contadorPromedio := contadorPromedio + 1;
        l := l^.sig;
    end;
    promCosto := costoTotal/contadorPromedio; 
end;

//Procedimiento que informara la cantidad de sondas cuyo costo es mayor al costo promedio
procedure informarSondasConMasCosto(l : lista);
var 
    promedioCosto : real;
    contadorSondas : integer;
begin
    promedioCosto := promCosto(l);
    contadorSondas := 0;
    while(l <> nil) do begin
        if((l^.dato.costoConstruccion + l^.dato.costoMantenimiento) > promedioCosto) then begin
            contadorSondas := contadorSondas + 1;
        end;
        l := l^.sig;
    end;
    writeln;
    writeln('La cantidad de sondas cuyo costo esta sobre el costo promedio es ', contadorSondas);
    writeln;
end;

var
    listaSondas : lista;
    sondaActual : sonda;
begin
    listaSondas := nil;
    //Leer sondas por teclado y guardarlas en la lista hasta que se ingrese 'Gaia' en el nombre de la sonda 
    repeat
        leerSonda(sondaActual);
        cargarSonda(listaSondas, sondaActual);
    until(sondaActual.nombre = 'Gaia');
    informarSondaMasCostosa(listaSondas);
    informarEspectrosElectromagneticos(listaSondas);
    informarSondasConMasDuracion(listaSondas);
    informarSondasConMasCosto(listaSondas);
end.

