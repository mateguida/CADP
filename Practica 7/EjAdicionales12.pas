{12. El centro de deportes Fortaco’s quiere procesar la información de los 4 tipos de suscripciones que ofrece:
 1)Musculación, 2)Spinning, 3)Cross Fit, 4)Todas las clases. Para ello, el centro dispone de una tabla con
 información sobre el costo mensual de cada tipo de suscripción.
 Realizar un programa que lea y almacene la información de los clientes del centro. De cada cliente se conoce el
 nombre, DNI, edad y tipo de suscripción contratada (valor entre 1 y 4). Cada cliente tiene una sola suscripción.
 La lectura finaliza cuando se lee el cliente con DNI 0, el cual no debe procesarse.
 Una vez almacenados todos los datos, procesar la estructura de datos generada, calcular e informar:
 - La ganancia total de Fortaco’s
 - Las 2 suscripciones con más clientes.
 - Genere una lista con nombre y DNI de los clientes de más de 40 años que están suscritos a CrossFit o a Todas las clases. Esta lista debe estar ordenada por DNI.}
 program EjAdicionales12;
 type
    rangoSuscripciones = 1..4;
    costosSuscripciones = array[rangoSuscripciones] of real;
    contadorSuscripciones = array[rangoSuscripciones] of integer;

    cliente = record
        nombre : string;
        dni : integer;
        edad : integer;
        suscripcion : rangoSuscripciones;
        end;

    lista = ^nodo;
    nodo = record
        dato : cliente;
        sig : lista;
        end;

procedure leerCliente(var c : cliente);
begin
    WriteLn('CARGANDO CLIENTE');
    write('DNI = ');
    readln(c.dni);
    if(c.dni <> 0)then begin
        write('NOMBRE = ');
        readln(c.nombre);
        write('EDAD = ');
        readln(c.edad);
        write('SUSCRIPCION ( 1)Musculación, 2)Spinning, 3)Cross Fit, 4)Todas las clases )= ');
        readln(c.suscripcion);
    end;
end;

procedure cargarCliente(c : cliente; var l : lista);
var
    nuevoCliente : lista;
begin
    new(nuevoCliente);
    nuevoCliente^.dato := c;
    nuevoCliente^.sig := l;
    l := nuevoCliente;
end;

procedure cargarCostos(var c : costosSuscripciones);
begin
    c[1] := 4000;
    c[2] := 4500;
    c[3] := 6000;
    c[4] := 10000;
end;

procedure calcularMaximos(c : contadorSuscripciones);
var
    suscripcionMax, suscripcionMax2, clientesMax, clientesMax2, i : integer;
    stringMax, stringMax2 : string;
begin
    suscripcionMax := 0;
    suscripcionMax2 := 0;
    clientesMax := -1;
    clientesMax2 := -1;
    stringMax := 'None';
    stringMax2 := 'None';
    for i := 1 to 4 do begin
        if(c[i] > clientesMax)then begin
            suscripcionMax2 := suscripcionMax;
            clientesMax2 := clientesMax;
            suscripcionMax := i;
            clientesMax := c[i];
        end
        else begin
            if(c[i] > clientesMax2)then begin
                suscripcionMax2 := i;
                clientesMax2 := c[i];
            end;
        end;
    end;
    case suscripcionMax of
    1: stringMax := 'Musculación';
    2: stringMax := 'Spinning';
    3: stringMax := 'CrossFit';
    4: stringMax := 'Todas las Clases';
    else stringMax := 'Error';
    end;
    case suscripcionMax2 of
    1: stringMax2 := 'Musculación';
    2: stringMax2 := 'Spinning';
    3: stringMax2 := 'CrossFit';
    4: stringMax2 := 'Todas las Clases';
    else stringMax2 := 'Error';
    end;
    writeln;
    writeln('La suscripcion que mas clientes contrataron fue ', stringMax);
    writeln('La segunda suscripcion que mas clientes contrataron fue ', stringMax2);
end;

procedure insertarLista(var l : lista; c : cliente);
var 
    nuevoCliente, posAnterior, posActual : lista;
begin
    new(nuevoCliente);
    nuevoCliente^.dato := c;
    posAnterior := l;
    posActual := l;
    while((posActual <> nil) and (c.dni > posActual^.dato.dni))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posAnterior = posActual)then
        l := nuevoCliente
    else
        posAnterior^.sig := nuevoCliente;
    nuevoCliente^.sig := posActual;
end;

procedure imprimirLista(l : lista);
begin
    write('[');
    while(l <> nil)do begin
        write(l^.dato.nombre,'(',l^.dato.dni,') //');
        l := l^.sig;
    end;
    write(']');
end;

procedure inicializarVector(var v : contadorSuscripciones);
var
    i : integer;
begin
    for i := 1 to 4 do begin
        v[i] := 0;
    end;
end;

// - La ganancia total de Fortaco’s
// - Las 2 suscripciones con más clientes.
procedure procesarLista(l : lista ; costos : costosSuscripciones);
var
    gananciaFinal : real;
    suscripciones : contadorSuscripciones;
    listaIncisoC : lista;
begin
    inicializarVector(suscripciones);
    listaIncisoC := nil;
    gananciaFinal := 0;
    while(l <> nil)do begin 
        gananciaFinal := gananciaFinal + (costos[l^.dato.suscripcion]);
        suscripciones[l^.dato.suscripcion] := suscripciones[l^.dato.suscripcion] + 1;
        if((l^.dato.edad > 40) and ((l^.dato.suscripcion = 3) or (l^.dato.suscripcion = 4)))then
            insertarLista(listaIncisoC, l^.dato);
        l := l^.sig;
    end;
    calcularMaximos(suscripciones);
    writeln;
    WriteLn('La ganancia final de Fortacos fue de ', gananciaFinal:2:2,' pesos');
    writeln;
    imprimirLista(listaIncisoC);
end;

var
    listaClientes : lista;
    clienteActual : cliente;
    costos : costosSuscripciones;
begin
    listaClientes := nil;
    cargarCostos(costos); //Se dispone
    leerCliente(clienteActual);
    while(clienteActual.dni <> 0)do begin
        cargarCliente(clienteActual, listaClientes);
        leerCliente(clienteActual);
    end;
    procesarLista(listaClientes, costos);
end.