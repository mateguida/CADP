{12. Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de
 todos los dispositivos que poseen sus juegos instalados. De cada dispositivo se conoce la versión de
 Android instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee
 (medida en GB). La información disponible se encuentra ordenada por versión de Android. Realizar un
 programa que procese la información disponible de todos los dispositivos e informe:
 a. La cantidad de dispositivos para cada versión de Android.
 b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
 c. El tamaño promedio de las pantallas de todos los dispositivos.}
program PracticaListas12;
type
    listaDispositivos = ^nodo;
    
    disp = record
        versionAndroid : integer;
        tamanoPantalla : real;
        memoriaRAM : real;
        end;

    nodo = record
        dispositivo : disp;
        sig : listaDispositivos;
        end;

//Procedimiento que leera las caracteristicas del dispositivo ingresadas por teclado
procedure leerDispositivo(var d : disp);
begin
    write('Ingrese version de android del dispositivo = ');
    readln(d.versionAndroid);
    if(d.versionAndroid <> -1)then begin
        write('Ingrese el tamaño de pantalla del dispositivo = ');
        readln(d.tamanoPantalla);
        write('Ingrese la cantidad de memoria RAM del dispositivo = ');
        readln(d.memoriaRAM);
    end;
end;

//Procedimiento que insertara el nuevo dispositivo en la lista
procedure insertarDispositivo(d : disp ; var l : listaDispositivos);
var
    nuevoDisp, posAnterior , posActual : listaDispositivos;
begin
    posAnterior := l;
    posActual := l;
    new(nuevoDisp);
    nuevoDisp^.dispositivo := d;
    while((posActual <> nil) and (d.versionAndroid > posActual^.dispositivo.versionAndroid))do begin
        //Paso al siguiente nodo
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = posAnterior)then //Primero en la lista o lista vacia
        l := nuevoDisp
    else
        posAnterior^.sig := nuevoDisp; //Resto de los casos
    nuevoDisp^.sig := posActual;
end;

//Procedimiento que contara la cantidad de dispositivos con cada version de android
//Inciso A
procedure contarVersiones(l : listaDispositivos);
var
    contadorVersiones,versionActual : integer;
begin
    while(l <> nil)do begin
        contadorVersiones := 0;
        versionActual := l^.dispositivo.versionAndroid;
        while((l <> nil)and(l^.dispositivo.versionAndroid = versionActual))do begin
            contadorVersiones := contadorVersiones + 1;
            l := l^.sig;
        end;
        writeln('La cantidad de dispostivos de version ', versionActual, ' es ', contadorVersiones);
    end;
end;

//Procedimiento que contara la cantidad de dispositivos con mas de 3gb de ram o pantalla de 5 pulgadas
procedure contarDispositivosEspecificos(l : listaDispositivos);
var 
    contadorDispositivos : integer;
begin
    contadorDispositivos := 0;
    while(l <> nil) do begin
        if((l^.dispositivo.memoriaRAM > 3)or(l^.dispositivo.tamanoPantalla >= 5)) then
            contadorDispositivos := contadorDispositivos + 1;
        l := l^.sig;
    end;
    writeln('La cantidad de dispositivos con mas de 3gb de ram o al menos 5 pulgadas de pantalla ', contadorDispositivos);
end;

function promedioPantallas(l : listaDispositivos) : real;
var
    acumulador, contador : real;
begin
    acumulador := 0;
    contador := 0;
    while(l <> nil)do begin
        acumulador := acumulador + l^.dispositivo.tamanoPantalla;
        contador := contador + 1;
        l := l^.sig;
    end;
    promedioPantallas := (acumulador/contador);
end;

var
    listaDisp : listaDispositivos;
    dispActual : disp;
begin
    listaDisp := nil;
    leerDispositivo(dispActual);
    while(dispActual.versionAndroid <> -1)do begin
        insertarDispositivo(dispActual, listaDisp);
        leerDispositivo(dispActual);
    end;
    contarVersiones(listaDisp);
    contarDispositivosEspecificos(listaDisp);
    promedioPantallas(listaDisp);
end.



