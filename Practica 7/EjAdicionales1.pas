{1. Una productora nacional realiza un casting de personas para la selección de actores extras de una
nueva película, para ello se debe leer y almacenar la información de las personas que desean
participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de
género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura
finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.
Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
b. Informar los dos códigos de género más elegidos.
c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho módulo en el programa principal.}
program EjAdicionales1;
type
    actor = record
        dni : integer;
        nombreyApellido : string;
        edad : integer;
        codigoGenero : 1..5;
        end;

    lista = ^nodo;
    
    nodo = record
        dato : actor;
        sig : lista;
        end;

    vecContador = array[1..5]of integer;
    
//Procedimiento que leera el actor
procedure leerActor(var a : actor);
begin
    writeln('Cargando Actor');
    write('DNI = ');
    readln(a.dni);
    write('Nombre y Apellido : ');
    readln(a.nombreyApellido);
    write('Edad = ');
    readln(a.edad);
    write('Codigo de genero {1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror} : ');
    readln(a.codigoGenero);
end;

//Procedimiento que agregara un actor a la lista
procedure agregarActor(a : actor; var l : lista);
var
    nuevoActor : lista;
begin
    new(nuevoActor);
    nuevoActor^.dato := a;
    nuevoActor^.sig := l;
    l := nuevoActor;
end;

//funcion que me devolvera un boolean sobre si el numero tiene mas digitos pares que impares
function cumplePares(num : integer) : boolean;
var
    contadorPares, contadorImpares, digito : integer;
begin
    contadorImpares := 0;
    contadorPares := 0;
    while(num <> 0)do begin
        digito := num mod 10;
        if(digito mod 2 = 0)then
            contadorPares := contadorPares + 1
        else
            contadorImpares := contadorImpares + 1;
        num := num div 10;
    end;
    if(contadorPares > contadorImpares)then
        cumplePares := true
    else
        cumplePares := false;
end;

procedure generoAString(num : integer; var g : string);
begin
    case num of 
    1 : g := 'Drama';
    2 : g := 'Romantico';
    3 : g := 'Accion';
    4 : g := 'Suspenso';
    5 : g := 'Terror';
    else g := 'Error';
    end;
end;

//Procedimiento que hara los procesamientos necesarios para los incisos A, B y C
procedure procesarLista(l : lista);
var
    primerGeneroString, segundoGeneroString : string;
    vectorGeneros : vecContador;
    primerGenero, segundoGenero, i,contadorMasParesQueImpares : integer;
begin
    primerGenero := -1;
    segundoGenero := -1; //inicializo los maximos
    for i := 1 to 5 do begin
        vectorGeneros[i] := 0; //Inicializo el vector contador en 0
    end;
    contadorMasParesQueImpares := 0;
    while(l <> nil)do begin
        if(cumplePares(l^.dato.dni))then
            contadorMasParesQueImpares := contadorMasParesQueImpares + 1; //Inciso A
        
        vectorGeneros[l^.dato.codigoGenero] := vectorGeneros[l^.dato.codigoGenero] + 1; //Inciso B
        
        l := l^.sig;
    end;
    for i := 1 to 5 do begin
        if(vectorGeneros[i] > primerGenero)then begin
            segundoGenero := primerGenero;
            primerGenero := i;
        end
        else begin
            if(vectorGeneros[i] > segundoGenero)then
                segundoGenero := i;
        end;
    end;
    generoAString(primerGenero, primerGeneroString); //Convertir el genero en numero a una cadena
    generoAString(segundoGenero, segundoGeneroString);
    
    //Informar
    writeln;
    writeln('La cantidad de personas con mas numeros pares que impares en su dni es ', contadorMasParesQueImpares);
    writeln('El genero mas popular es ', primerGeneroString, ' y el segundo es ', segundoGeneroString);
end;

procedure imprimirLista(l: lista);
begin
    while(l <> nil)do begin
        write(l^.dato.dni, ' || ');
        l := l^.sig;
    end;
end;

//procedimiento que recibira un dni y lo eliminara de la lista
procedure eliminarPorDni(dni : integer ; var l : lista);
var
    aux, posAnterior, posActual : lista;
    encontre : boolean;
begin
    posActual := l;
    posAnterior := l;
    encontre := false;
    while((posActual <> nil) and (encontre = false))do begin
        if(posActual^.dato.dni = dni)then
            encontre := true
        else begin
            posAnterior := posActual;
            posActual := posActual^.sig;
        end;
    end;
    if(encontre)then begin
        //Elimino el nodo
        if(posActual = l)then begin
            aux := l; //Es el primer nodo
            l := l^.sig;
            dispose(aux);
        end
        else begin
            posAnterior^.sig := posActual^.sig; //Es cualquier otro nodoo
            dispose(posActual);
        end;
    end
    else
        writeln('El DNI ingresado no esta en la lista');
end;

var
    actorActual : actor;
    listaActores : lista;
    dniAux : integer;
begin
    listaActores := nil;
    repeat
        leerActor(actorActual);
        agregarActor(actorActual, listaActores);
    until(actorActual.dni = 3554);
    
    writeln;
    writeln('Ingrese un dni a eliminar = ');
    readln(dniAux);
    
    procesarLista(listaActores);
    imprimirLista(listaActores);
    eliminarPorDni(dniAux, listaActores);
    writeln;
    imprimirLista(listaActores);
end.

