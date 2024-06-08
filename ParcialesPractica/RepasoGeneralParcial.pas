program repasoGeneral; //REPASO GENERAL DE LOS MODULOS PARA LISTAS
type
    
    infoNumeros = record
        numero : integer;
        end;
    
    lista = ^nodo;
    nodo = record
        dato : infoNumeros;
        sig : lista;
        end;

procedure agregarAdelante(numActual : integer ;var l : lista);
var
    nuevoNumero : lista;
begin
    new(nuevoNumero);
    nuevoNumero^.dato.numero := numActual;
    nuevoNumero^.sig := l;
    l := nuevoNumero; 
end;

procedure agregarAtras(numeroActual : integer; var l, ultimoLista : lista);
var
    nuevoNumero : lista;
begin
    new(nuevoNumero);
    nuevoNumero^.dato.numero := numeroActual;
    nuevoNumero^.sig := nil;
    if(l = nil)then begin
        l := nuevoNumero;
    end
    else
        ultimoLista^.sig := nuevoNumero;
    ultimoLista := nuevoNumero;
end;

procedure insertarOrdenadoAscendente(numeroActual : integer; var l : lista);
var
    nuevoNumero, posActual, posAnterior : lista;
begin
    new(nuevoNumero);
    nuevoNumero^.dato.numero := numeroActual;
    posActual := l;
    posAnterior := l;
    while((posActual <> nil) and (numeroActual > posActual^.dato.numero))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posAnterior = posActual)then
        l := nuevoNumero
    else
        posAnterior^.sig := nuevoNumero;
    nuevoNumero^.sig := posActual;
end;

procedure insertarOrdenadoDescendente(numeroActual : integer; var l : lista);
var
    nuevoNumero, posActual, posAnterior : lista;
begin
    new(nuevoNumero);
    nuevoNumero^.dato.numero := numeroActual;
    posActual := l;
    posAnterior := l;
    while((posActual <> nil) and (numeroActual < posActual^.dato.numero))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posAnterior = posActual)then
        l := nuevoNumero
    else
        posAnterior^.sig := nuevoNumero;
    nuevoNumero^.sig := posActual;
end;

procedure imprimirLista(l : lista);
begin
    Write('[');
    while(l <> nil) do begin
        write(l^.dato.numero, ' // ');
        l := l^.sig;
    end;
    write(']');
end;

procedure eliminarNumero(var l : lista; num : integer);
var
    posActual, posAnterior : lista;
begin
    posActual := l;
    posAnterior := l;
    while((posActual <> nil) and (posActual^.dato.numero <> num))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = nil)then
        writeln('El numero no esta en la lista')
    else begin
        posAnterior^.sig := posActual^.sig;
        dispose(posActual);
    end;
end;

var
    listaNumerosAgregarAdelante, listaNumerosAgregarAtras, ultimoListaAgregarAtras, listaNumerosInsertarOrdenadoA, listaNumerosInsertarOrdenadoD  : lista;
    numeroActual : integer;
begin
    listaNumerosAgregarAdelante := nil;
    listaNumerosAgregarAtras := nil;
    ultimoListaAgregarAtras := nil;
    listaNumerosInsertarOrdenadoA := nil;
    listaNumerosInsertarOrdenadoD := nil;
    write('Ingrese un numero = ');
    ReadLn(numeroActual);
    while(numeroActual <> -1)do begin
        agregarAdelante(numeroActual, listaNumerosAgregarAdelante);
        agregarAtras(numeroActual, listaNumerosAgregarAtras, ultimoListaAgregarAtras);
        insertarOrdenadoAscendente(numeroActual, listaNumerosInsertarOrdenadoA);
        insertarOrdenadoDescendente(numeroActual, listaNumerosInsertarOrdenadoD);
        write('Ingrese un numero = ');
        ReadLn(numeroActual);
    end;

    writeln('LISTA DESPUES DE AGREGAR ADELANTE');
    imprimirLista(listaNumerosAgregarAdelante);
    writeln;
    writeln;
    writeln('LISTA DESPUES DE AGREGAR ATRAS');
    imprimirLista(listaNumerosAgregarAtras);
    writeln;
    writeln;
    writeln('LISTA DESPUES DE INSERTAR ORDENADO ASCENDENTE');
    imprimirLista(listaNumerosInsertarOrdenadoA);
    writeln;
    writeln;
    writeln('LISTA DESPUES DE INSERTAR ORDENADO DESCENDENTE');
    imprimirLista(listaNumerosInsertarOrdenadoD);
    writeln;
    writeln;

    write('Ingrese un numero para eliminar (Eliminar uno solo) = ');
    readln(numeroActual);
    eliminarNumero(listaNumerosAgregarAdelante, numeroActual);
    eliminarNumero(listaNumerosAgregarAtras, numeroActual);
    eliminarNumero(listaNumerosInsertarOrdenadoA, numeroActual);
    eliminarNumero(listaNumerosInsertarOrdenadoD, numeroActual);

    writeln('LISTAS DESPUES DE ELIMINAR NUMERO');
    writeln;
    writeln;
    writeln('AGREGAR ADELANTE');
    imprimirLista(listaNumerosAgregarAdelante);
    writeln;
    writeln;
    writeln('AGREGAR ATRAS');
    imprimirLista(listaNumerosAgregarAtras);
    writeln;
    writeln;
    writeln('INSERTAR ORDENADO ASCENDENTE');
    imprimirLista(listaNumerosInsertarOrdenadoA);
    writeln;
    writeln;
    writeln('INSERTAR ORDENADO DESCENDENTE');
    imprimirLista(listaNumerosInsertarOrdenadoD);
    writeln;
    writeln;
end.