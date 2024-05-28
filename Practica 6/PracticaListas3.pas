{
    a. El programa crea una lista de enteros a la cual le agrega adelante 
    numeros ingresados por teclado hasta que el usuario ingrese el valor 0
    
    b. La lista quedara [48 , 13 , 21 , 10]
    
}
program PracticaListas1;
type
    lista = ^nodo;
    nodo = record
        num : integer;
        sig : lista;
        end;

procedure armarNodoAtras(var L,  ult: lista; v: integer);
var
    aux : lista;
begin
    new(aux);
    aux^.num := v;
    aux^.sig := nil;
    if(L = nil) then begin
        L := aux;
        ult := aux;
        end
    else
      ult^.sig:= aux;
    ult:= aux;
end;

//Proceimiento que imprime la lista, inciso C
procedure imprimirLista(L: lista);
begin
    write('[');
    while(L <> nil) do begin
        write(L^.num, ' ,');
        L := L^.sig;
    end;
    write(']');
end;

//Procedimiento que incrementara cada elemento de la lista en X cantidad
//Inciso D
procedure incrementarLista(L : lista ; constante : integer);
begin
    while(L <> nil) do begin
        L^.num := L^.num + constante;
        L := L^.sig;
    end;
end;


var
    pri, ult : lista;
    valor, c : integer;
begin
    pri := nil;
    write('Ingrese un numero = ');
    readln(valor);
    while (valor <> 0) do begin
        armarNodoAtras(pri,ult, valor);
        write('Ingrese un numero = ');
        readln(valor);
    end;
{ imprimir lista }
    writeln('Lista antes de incrementar');
    imprimirLista(pri);
    
    write('Ingrese la constante a incrementar = ');
    readln(c);
    
    incrementarLista(pri, c);
    writeln('Lista despues de incrementar');
    imprimirLista(pri);
end.