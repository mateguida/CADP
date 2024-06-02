{3. Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de 2020. De
 cada viaje se conoce: número de viaje, código de auto, dirección de origen, dirección de destino y
 kilómetros recorridos durante el viaje. Esta información se encuentra ordenada por código de auto y para
 un mismo código de auto pueden existir 1 o más viajes. Se pide:
 a. Informar los dos códigos de auto que más kilómetros recorrieron.
 b. Generar una lista nueva con los viajes de más de 5 kilómetros recorridos, ordenada por número de
 viaje}
 program EjAdicionales3;
 type
    viaje = record  
        numeroViaje : integer;
        codigoAuto : integer;
        direccionOrigen : string;
        direccionDestino : String;
        kmsRecorridos : real;
        end;

    lista = ^nodo;

    nodo = record 
        dato : viaje;
        sig : lista;
        end;

procedure leerViaje(var v : viaje);
begin
    WriteLn('CARGANDO VIAJE');
    write('Codigo de Auto = ');
    ReadLn(v.codigoAuto);
    if(v.codigoAuto <> -1)then begin
        write('Numero de viaje = ');
        ReadLn(v.numeroViaje);
        write('Direccion de origen = ');
        ReadLn(v.direccionOrigen);
        write('Direccion de destino = ');
        ReadLn(v.direccionDestino);
        write('Kilometros recorridos = ');
        ReadLn(v.kmsRecorridos);
    end;
end;

procedure insertarViaje(var l : lista; v : viaje);
var
    nuevoViaje, posAnterior, posActual : lista;
begin
    New(nuevoViaje);
    nuevoViaje^.dato := v;
    posAnterior := l;
    posActual := l;
    while((posActual <> nil) and (v.codigoAuto > posActual^.dato.codigoAuto))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = posAnterior)then begin
        l := nuevoViaje;
    end
    else
        posAnterior^.sig := nuevoViaje;
    nuevoViaje^.sig := posActual;
end;

procedure actualizarMaximos(var codAutoMax, codAutoMax2 : integer; var kmsAutoMax, kmsAutoMax2 : real; kmsActuales : real; codigoActual : integer);
begin
    if(kmsActuales > kmsAutoMax)then begin
            kmsAutoMax2 := kmsAutoMax;
            codAutoMax2 := codAutoMax;
            codAutoMax := codigoActual;
            kmsAutoMax := kmsActuales;
        end
        else begin
            if(kmsActuales > kmsAutoMax2)then begin
                codAutoMax2 := codigoActual;
                kmsAutoMax2 := kmsActuales;
            end;
        end;
end;

procedure dosViajesMaximos(l : lista);
var
    codAutoMax, codAutoMax2, codAutoActual : integer;
    kmsAutoMax, kmsAutoMax2, acumuladorAuto : real;
begin
    codAutoMax := 0;
    codAutoMax2 := 0;
    kmsAutoMax := -1;
    kmsAutoMax2 := -1;
    while(l <> nil)do begin
        acumuladorAuto := 0;
        codAutoActual := l^.dato.codigoAuto;
        while((l <> nil) and (l^.dato.codigoAuto = codAutoActual))do begin
            acumuladorAuto := acumuladorAuto + l^.dato.kmsRecorridos;
            actualizarMaximos(codAutoMax, codAutoMax2, kmsAutoMax, kmsAutoMax2, acumuladorAuto, l^.dato.codigoAuto);
            l := l^.sig;
        end;
    end;
    WriteLn('El auto que recorrio mas kilometros fue el auto ', codAutoMax, ' y recorrio ', kmsAutoMax:2:2);
    WriteLn('El segundo auto que recorrio mas kilometros fue el auto ', codAutoMax2, ' y recorrio ', kmsAutoMax2:2:2);
end;

procedure insertarViajePorNumeroDeViaje(var l : lista; v : viaje);
var
    nuevoViaje, posAnterior, posActual : lista;
begin
    New(nuevoViaje);
    nuevoViaje^.dato := v;
    posAnterior := l;
    posActual := l;
    while((posActual <> nil) and (v.numeroViaje > posActual^.dato.numeroViaje))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = posAnterior)then begin
        l := nuevoViaje;
    end
    else
        posAnterior^.sig := nuevoViaje;
    nuevoViaje^.sig := posActual;
end;

procedure armarNuevaLista(l : lista; var nuevaL : lista);
begin
    while(l <> nil)do begin
        if(l^.dato.kmsRecorridos > 5)then begin
            insertarViajePorNumeroDeViaje(nuevaL ,l^.dato);
        end;
        l := l^.sig;
    end;
end;

procedure imprimirLista(l : lista);
begin
    while(l <> nil)do begin
        writeln;
        write(l^.dato.numeroViaje, ' ,');
        write(l^.dato.codigoAuto);
        l := l^.sig;
    end;
end;

var
    listaViajes, listaViajesMas5km : lista;
    viajeActual : viaje;
begin
    listaViajes := nil;
    listaViajesMas5km := nil;
    leerViaje(viajeActual);
    while(viajeActual.codigoAuto <> -1)do begin
        insertarViaje(listaViajes,viajeActual);
        leerViaje(viajeActual);
    end;
    dosViajesMaximos(listaViajes);
    armarNuevaLista(listaViajes, listaViajesMas5km);
    writeln;
    imprimirLista(listaViajes);
    imprimirLista(listaViajesMas5km);
end.
    