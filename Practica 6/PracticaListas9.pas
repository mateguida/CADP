{9. Utilizando el programa del ejercicio 1, realizar los siguientes módulos:
 a. EstáOrdenada: recibe la lista como parámetro y retorna true si la misma se encuentra ordenada, o
 false en caso contrario.
 b. Eliminar: recibe como parámetros la lista y un valor entero, y elimina dicho valor de la lista (si
 existe). Nota: la lista podría no estar ordenada.
 c. Sublista: recibe como parámetros la lista L y dos valores enteros A y B, y retorna una nueva lista
 con todos los elementos de la lista L mayores que A y menores que B.
 d. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada
 de manera ascendente.
 e. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada
 de manera descendente.}
program PracticaListas9;
type
    lista = ^nodo;
    nodo = record
        num : integer;
        sig : lista;
        end;

//Procedimiento que agrega nodos de forma ordenada, en este caso, ascendentemente
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
        posActual := posActual^.sig; //Actualizo las posiciones de los punteros que recorren la lista
    end;
    if(posActual = posAnterior) then
        L := aux //Si la lista esta vacia o el lugar es al inicio de la lista Aux pasa a ser el primer nodo
    else
        posAnterior^.sig := aux; //Una vez encontrada la posicion, aux pasa un lugar mas adelante
    aux^.sig := posActual;  //Y se guarda el nuevo nodo atras de aux
end;

procedure insertarOrdenadoDescendente(var L: lista; v: integer);
var
    aux : lista;
    posActual, posAnterior : lista;
begin
    new(aux);
    aux^.num := v;
    posAnterior := L;
    posActual := L;
    while((posActual <> nil)and(v < posActual^.num))do begin
        posAnterior := posActual;
        posActual := posActual^.sig; //Actualizo las posiciones de los punteros que recorren la lista
    end;
    if(posActual = posAnterior) then
        L := aux //Si la lista esta vacia o el lugar es al inicio de la lista Aux pasa a ser el primer nodo
    else
        posAnterior^.sig := aux; //Una vez encontrada la posicion, aux pasa un lugar mas adelante
    aux^.sig := posActual;  //Y se guarda el nuevo nodo atras de aux
end;

//Proceimiento que imprime la lista
procedure imprimirLista(L: lista);
begin
    writeln;
    write('[');
    while(L <> nil) do begin
        write(L^.num, ' ,');
        L := L^.sig;
    end;
    write(']');
    writeln;
end;

//Funcion que recorrera la lista y devolvera si esta está ordenada o no lo esta
function estaOrdenada(l : lista) : boolean;
var
    posAnterior, posActual : lista;
begin
    posActual := l^.sig;
    posAnterior := l;
    while((posActual <> nil)and(posAnterior^.num < posActual^.num)) do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = nil)then
        estaOrdenada := true
    else    
        estaOrdenada := false;
end;

//Procedimiento que elimina un valor en la lista ingresado por teclado, si este se encuentra en la lista
procedure eliminarDato(var l : lista; num : integer);
var
    posActual, posAnterior : lista;
begin
    posAnterior := l;
    posActual := l;
    while((posActual <> nil)and(posActual^.num <> num))do begin
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

//Procedimiento que recibira la lista principal y 2 valores y creara una nueva lista, la cual tenga valores
//mayores al primer numero y menores al segundo numero
procedure sublista(l : lista; a, b : integer; var sl : lista);
begin
    while(l <> nil) do begin
    if((l^.num < b) or (l^.num > a))then
        armarNodo(sl, l^.num);
    l := l^.sig; //Avanzo en la lista
    end;
end;

//Procedimiento que hara una sublista con los mismos parametros de el modulo anterior pero la sublista
//Estara ordenada de forma descendente
procedure sublistaDescendente(l : lista; a, b : integer; var sl : lista);
begin
    while(l <> nil) do begin
    if((l^.num < b) or (l^.num > a))then
        insertarOrdenadoDescendente(sl, l^.num);
    l := l^.sig; //Avanzo en la lista
    end;
end;

var
    pri, subList, subListD : lista;
    valor, c, a, b : integer;
begin
    pri := nil;
    subList := nil;
    subListD := nil;
    write('Ingrese un numero = ');
    readln(valor);
    while (valor <> 0) do begin
        armarNodo(pri, valor); //Insertar ordenado
        write('Ingrese un numero = ');
        readln(valor);
    end;
    imprimirLista(pri); //Muesto la lista por consola
    
    //Inciso A
    writeln;
    writeln('La lista esta ordenada : ',estaOrdenada(pri));
    writeln;
    
    //Inciso B
    write('Ingrese un valor a eliminar = ');
    readln(c);
    eliminarDato(pri, c);
    imprimirLista(pri);
    
    //Inciso C
    //Inciso D tambien, ya que el modulo utilizado para crear la lista, es un insertar ordenado en forma descendente
    write('Ingrese un valor a = ');
    readln(a);
    write('Ingrese un valor b = ');
    readln(b);
    sublista(pri, a, b, subList);
    writeln;
    writeln('SubLista =');
    imprimirLista(subList);
    
    //Inciso E
    sublistaDescendente(pri, a, b, subListD);
    imprimirLista(subListD);
end.