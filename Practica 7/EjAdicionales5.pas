{5.  Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100 camiones.
 De cada camión se tiene: patente, año de fabricación y capacidad (peso máximo en toneladas que puede
 transportar).
 Realizar un programa que lea y almacene la información de los viajes realizados por la empresa. De cada
 viaje se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros recorrida,
 ciudad de destino, año en que se realizó el viaje y DNI del chofer. La lectura finaliza cuando se lee el código
 de viaje -1.
 Una vez leída y almacenada la información, se pide:
 1. Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que
 menos kilómetros recorridos posee.
 2. Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5 toneladas
 y que posean una antigüedad mayor a 5 años al momento de realizar el viaje (año en que se realizó el
 viaje).
 3. Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
 Nota: Los códigos de viaje no se repiten.}
 program EjAdicionales5;
 const
    cantidadCamiones = 5;
 type
    camion = record
        patente : string;
        anoFabricacion : integer;
        capacidad : real;
        end;
    
    vecCamiones = array[1..cantidadCamiones] of camion;

    viaje = record
        codigoViaje : integer;
        codigoCamion : 1..cantidadCamiones;
        distanciaRecorrida : real;
        ciudadDestino : string;
        anoViaje : integer;
        dniChofer: integer;
        end;
    
    lista = ^nodo;
    
    nodo = record
        dato : viaje;
        sig : lista;
        end;

//Procedimiento que lee los datos ingresados por teclado y los guarda en el registro viaje
procedure leerViaje(var v : viaje);
begin
    writeln;
    writeln('CARGANDO VIAJE');
    write('Codigo de Viaje = ');
    readln(v.codigoViaje);
    if(v.codigoViaje <> -1)then begin
        write('Codigo de Camion (Entre 1  y ', cantidadCamiones,') = ');
        readln(v.codigoCamion);
        write('Distancia Recorrida = ');
        readln(v.distanciaRecorrida);
        write('Ciudad de destino = ');
        readln(v.ciudadDestino);
        write('Año que se realizo el viaje = ');
        readln(v.anoViaje);
        write('DNI del chofer = ');
        readln(v.dniChofer);
    end;
end;

//Procedimiento que agrega viajes a la lista, metodo agregar Adelante
procedure cargarViaje(v : viaje; var l : lista);
var
    nuevoViaje : lista;
begin
    New(nuevoViaje);
    nuevoViaje^.dato := v;
    nuevoViaje^.sig := l;
    l := nuevoViaje;
end;

procedure iniciarVector(var vector : vecCamiones);
var
    i : integer;
begin
    vector[1].patente := 'AC187KE';
    vector[1].anoFabricacion := 2012;
    vector[1].capacidad := 40;
    vector[2].patente := 'AC220JP';
    vector[2].anoFabricacion := 2016;
    vector[2].capacidad := 37.5;
    vector[3].patente := 'AB225KA';
    vector[3].anoFabricacion := 2014;
    vector[3].capacidad := 22.8;
    vector[4].patente := 'AH605LL';
    vector[4].anoFabricacion := 2019;
    vector[4].capacidad := 60;
    vector[5].patente := 'AA990TQ';
    vector[5].anoFabricacion := 2011;
    vector[5].capacidad := 27.4;
end;

//funcion que devuelve booleano sobre si todos los digitos del numero son impares
function cumple(dni : Integer) : Boolean;
var
    digito : integer;
    impares : boolean;
begin
    impares := True;
    while((dni <> 0)and(impares = true))do begin
        digito := dni mod 10;
        if(digito mod 2 = 0)then
            impares := false
        else
            dni := dni div 10;
    end;
    cumple := impares;
end;

procedure informarMaxMin(l : lista ; flota : vecCamiones);
Var
    codigoCamionMax, codigoCamionMin : integer;
    kmsCamionMax, kmsCamionMin : real;
begin
    codigoCamionMax := 0;
    codigoCamionMin := 0;
    kmsCamionMax := -1;
    kmsCamionMin := 9999;
    while(l <> nil)do begin
        if(l^.dato.distanciaRecorrida > kmsCamionMax)then begin //Actualizo Maximo
            codigoCamionMax := l^.dato.codigoCamion;
            kmsCamionMax := l^.dato.distanciaRecorrida;
        end;
        if(l^.dato.distanciaRecorrida < kmsCamionMin)then begin //Actualizo Minimo
            codigoCamionMin := l^.dato.codigoCamion;
            kmsCamionMin := l^.dato.distanciaRecorrida;
        end;
        if(cumple(l^.dato.dniChofer))then
            writeln('El chofer del viaje ', l^.dato.codigoViaje, ' tiene todos digitos impares en su dni');
        l := l^.sig;
    end;
    writeln('Camion que mas kilometros recorrio : ', flota[codigoCamionMax].patente, ' Recorrio ', kmsCamionMax:2:2,'kms');
    writeln('Camion que menos kilometros recorrio : ', flota[codigoCamionMin].patente, ' Recorrio ', kmsCamionMin:2:2,'kms');
end;

//funcion que contara los viajes que cumplan : camion con capacidad mayor a 30,5 toneladas y que posea una antigüedad mayor a 5 años al momento de realizar el viaje
function viajesCumplen(l : lista ; flota :vecCamiones) : integer;
var
    contadorViajes : integer;
begin
    contadorViajes := 0; 
    while(l <> nil)do begin
        if((flota[l^.dato.codigoCamion].capacidad > 30.5)and(l^.dato.anoViaje - flota[l^.dato.codigoCamion].anoFabricacion > 5))then
            contadorViajes := contadorViajes + 1;
        l := l^.sig;
    end;
    viajesCumplen := contadorViajes;
end;

var
    viajeActual : viaje;
    listaViajes : lista;
    flotaCamiones : vecCamiones;
begin
    listaViajes := nil;
    iniciarVector(flotaCamiones);
    leerViaje(viajeActual);
    while(viajeActual.codigoViaje <> -1)do begin
        cargarViaje(viajeActual, listaViajes);
        leerViaje(viajeActual);
    end;
    informarMaxMin(listaViajes, flotaCamiones);
    viajesCumplen(listaViajes, flotaCamiones);
end.