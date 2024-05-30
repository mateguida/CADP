{16. La empresa distribuidora de una app móvil para corredores ha organizado una competencia mundial,
 en la que corredores de todos los países participantes salen a correr en el mismo momento en distintos
 puntos del planeta. La app registra, para cada corredor, el nombre y apellido, la distancia recorrida (en
 kilómetros), el tiempo (en minutos) durante el que corrió, el país y la ciudad desde donde partió, y la
 ciudad donde finalizó su recorrido. Realizar un programa que permita leer y almacenar toda la
 información registrada durante la competencia. La lectura finaliza al ingresar la distancia-1. Una vez
 que se han almacenado todos los datos, informar:
 ● La cantidad total de corredores, la distancia total recorrida y el tiempo total de carrera de todos
 los corredores.
 ● El nombre de la ciudad que convocó la mayor cantidad de corredores y la cantidad total de
 kilómetros recorridos por los corredores de esa ciudad.
 ● La distancia promedio recorrida por corredores de Brasil.
 ● La cantidad de corredores que partieron de una ciudad y finalizaron en otra ciudad.
 ● El paso(cantidad de minutos por km) promedio de los corredores de la ciudad de Boston.}

program PracticaListas16;
type
    corredor = record
            nombreyApellido : string;
            distanciaRecorrida :real;
            tiempoCorrido : real;
            paisOrigen : string;
            ciudadPartio : string;
            ciudadFinalizo : string;
            end;
    
    lista = ^nodo;

    nodo = record
        dato : corredor;
        sig : lista;
        end;

    listaCiudades = ^nodoCiudades;

    nodoCiudades = record
        ciudad : string;
        corredores : integer;
        kmsRecorridos : real;
        sig : listaCiudades;
        end;

//Procedimiento que leera un corredor y lo guardara en el parametro
procedure leerCorredor(var c : corredor );
begin
    writeln('CARGANDO CORREDOR');
    write('Ingrese distancia recorrida = ');
    readln(c.distanciaRecorrida);
    if(c.distanciaRecorrida <> -1)then begin
        write('Ingrese nombre y apellido = ');
        readln(c.nombreyApellido);
        write('Ingrese tiempo corrido = ');
        readln(c.tiempoCorrido);    
        write('Ingrese pais de origen = ');
        readln(c.paisOrigen);    
        write('Ingrese ciudad de donde partio = ');
        readln(c.ciudadPartio);    
        write('Ingrese ciudad donde finalizo = ');
        readln(c.ciudadFinalizo);        
    end;
end;

//Procedimiento que insertara el corredor en la lista (Agregar adelante)
procedure agregarCorredor(c :corredor; var l : lista);
Var
    nuevoCorredor : lista;
begin
    New(nuevoCorredor);
    nuevoCorredor^.dato := c;
    nuevoCorredor^.sig := l;
    l := nuevoCorredor;
end;

//Procedimiento que me encontrara la ciudad que tenga mas corredores y la distancia sumada de todos ellos
procedure ActualizarCiudadMaximo(l : listaCiudades ; var ciudadMax : string ; var kmsMax : real);
var
    corredoresMax : integer;
begin
    corredoresMax := -1;
    while(l <> nil)do begin
        if(l^.corredores > corredoresMax)then begin
            ciudadMax := l^.ciudad;
            kmsMax := l^.kmsRecorridos;
            corredoresMax := l^.corredores;
        end;
        l := l^.sig;
    end;
end;

//Procedimiento que actualizara la lista contadora
procedure actualizarLista(var l : listaCiudades; ciudadActual : string; kmsActuales : real; var ciudadMax : string ; var kmsMax : real);
var
    encontre : boolean;
    nuevaCiudad, aux : listaCiudades;
begin
    aux := l;
    encontre := false;
    while((aux <> nil) and (encontre = false))do begin
        if(aux^.ciudad = ciudadActual)then
            encontre := True
        else
            aux := aux^.sig;
    end;
    if(encontre)then begin
        aux^.corredores := aux^.corredores + 1;
        aux^.kmsRecorridos := aux^.kmsRecorridos + kmsActuales;
    end
    else begin
        new(nuevaCiudad);
        nuevaCiudad^.ciudad := ciudadActual;
        nuevaCiudad^.sig := l;
        nuevaCiudad^.corredores := nuevaCiudad^.corredores + 1;
        nuevaCiudad^.kmsRecorridos := nuevaCiudad^.kmsRecorridos + kmsActuales;
        l := nuevaCiudad;
    end;
    ActualizarCiudadMaximo(l, ciudadMax, kmsMax);
end;

//Procedimiento que calculara los valores generales de la maraton
procedure calculoGeneral(l : lista);
var
    ciudadMasCorredores : String;
    listaContadora : listaCiudades;
    cantCorredoresTot, corredoresBrasil, contadorCorredoresDosCiudades : integer;
    distanciaTotRecorrida, tiempoTotCarrera, kmsCiudadMasCorredores, acumuladorBrasil, promedioDistanciaBrasil, tiempoBoston, ritmoBoston : real;
    dB : real;
begin
    ciudadMasCorredores := 'None';
    cantCorredoresTot := 0;
    distanciaTotRecorrida := 0;
    tiempoTotCarrera := 0;
    acumuladorBrasil := 0;
    corredoresBrasil := 0;
    dB := 0;
    tiempoBoston := 0;
    contadorCorredoresDosCiudades := 0;
    listaContadora := nil;
    while(l <> nil)do begin
        cantCorredoresTot := cantCorredoresTot + 1; //Cantidad total de corredores
        distanciaTotRecorrida := distanciaTotRecorrida + l^.dato.distanciaRecorrida; //Distancia total recorrida
        tiempoTotCarrera := tiempoTotCarrera + l^.dato.tiempoCorrido; //Tiempo total corriendo

        actualizarLista(listaContadora, l^.dato.ciudadPartio, l^.dato.distanciaRecorrida, ciudadMasCorredores, kmsCiudadMasCorredores); 
        // Voy llevando una lista la que tenga el nombre de la ciudad y acumule distancia de la ciudad
        // En este mismo modulo, al actualizar voy actualizando la ciudad que mas corredores convoco.

        if(l^.dato.paisOrigen = 'Brasil')then begin // si el corredor es de brasil, sus estadisticas sumaran al promedio de brasil
            acumuladorBrasil := acumuladorBrasil + l^.dato.distanciaRecorrida;
            corredoresBrasil := corredoresBrasil + 1;
        end;

        if(l^.dato.ciudadPartio <> l^.dato.ciudadFinalizo)then //Si la ciudad desde dionde partio es distinta a la que finalizo, sumara 1
            contadorCorredoresDosCiudades := contadorCorredoresDosCiudades +1;

        if(l^.dato.ciudadPartio = 'Boston')then begin //Si el corredor es de boston, sus estadisticas seran sumadas a las estadisticas de Boston
            tiempoBoston := tiempoBoston + l^.dato.tiempoCorrido;
            dB := dB + l^.dato.distanciaRecorrida;
        end;
        l := l^.sig;
    end;

    if(corredoresBrasil <> 0)then
        promedioDistanciaBrasil := acumuladorBrasil / corredoresBrasil
    else
        promedioDistanciaBrasil := 0;

    if(dB <> 0)then
        ritmoBoston := tiempoBoston / dB
    else
        ritmoBoston := 0;

    writeln;
    writeln('Cantidad total de corredores = ', cantCorredoresTot);
    writeln('Distancia total Recorrida = ', distanciaTotRecorrida:2:2, 'km');
    writeln('Tiempo total en carrera = ', tiempoTotCarrera:2:2, 'mins');
    writeln;
    writeln('La ciudad que convoco mas corredores fue ', ciudadMasCorredores, ' y recorrieron ', kmsCiudadMasCorredores:2:2, 'km');
    writeln;
    writeln('La distancia promedio recorrida por Brasileros fue ', promedioDistanciaBrasil:2:2,'km');
    writeln;
    writeln('Corredores que iniciaron la carrera en una ciudad y terminaron en otra fueron ', contadorCorredoresDosCiudades);
    writeln;
    writeln('El ritmo promedio de los corredores de Boston fue ', ritmoBoston:2:2,'min/km');
end;

var 
    corredorActual : corredor;
    listaCorredores : lista;
begin
    listaCorredores := nil;
    leerCorredor(corredorActual);
    while(corredorActual.distanciaRecorrida <> -1)do begin
        agregarCorredor(corredorActual, listaCorredores);
        leerCorredor(corredorActual);
    end;
    calculoGeneral(listaCorredores);
end.