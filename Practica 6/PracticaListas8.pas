{8. Utilizando el programa del ejercicio 1, modificar el módulo armarNodo para que los elementos de la
 lista queden ordenados de manera ascendente (insertar ordenado).}
program PracticaListas8;
type
    lista = ^nodo;
    nodo = record
        num : integer;
        sig : lista;
        end;

procedure armarNodo(var L: lista; v: integer);
var
    aux : lista;
    posActual, posAnterior : lista;
begin
    new(aux);
    aux^.num := v;
    posAnterior := L;
    posActual := L;
    while((posActual <> nil)and(v > posActual^.num))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = posAnterior) then
        L := aux
    else
        posAnterior^.sig := aux;
    aux^.sig := posActual;
end;

//Proceimiento que imprime la lista, inciso C
procedure imprimirLista(L: lista);
begin
    writeln;
    write('[');
    while(L <> nil) do begin
        write(L^.num, ' ,');
        L := L^.sig;
    end;
    write(']');
end;

var
    pri : lista;
    valor, c : integer;
begin
    pri := nil;
    write('Ingrese un numero = ');
    readln(valor);
    while (valor <> 0) do begin
        armarNodo(pri, valor);
        write('Ingrese un numero = ');
        readln(valor);
    end;
{ imprimir lista }
    imprimirLista(pri);
end.

