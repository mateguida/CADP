{9. Un cine posee la lista de películas que proyectará durante el mes de Febrero. De cada película se tiene:
 código de película, título de la película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5:
 comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. Dicha estructura
 no posee orden alguno.
 Se pide:
 a) Actualizar (en la lista que se dispone) el puntaje promedio otorgado por las críticas. Para ello se debe
 leer desde teclado las críticas que han realizado críticos de cine, de cada crítica se lee: DNI del crítico,
 apellido y nombre del crítico, código de película y el puntaje otorgado. La lectura finaliza cuando se lee
 el código de película -1 y la información viene ordenada por código de película.
 b) Informar el código de género que más puntaje obtuvo entre todas las críticas.
 c) Informar el apellido y nombre de aquellos críticos que posean la misma cantidad de dígitos pares que
 impares en su DNI.
 d) Realizar un módulo que elimine de la lista que se dispone una película cuyo código se recibe como
 parámetro (el mismo puede no existir).}
program EjAdicionales9;
type

    vecGeneros = array[1..8] of Real;

    pelicula = record
        codigoPelicula :integer;
        titulo : string;
        codigoGenero : 1..8;
        puntajePromedioCriticas : Real;
        end;

    critica = record
        dniCritico : integer;
        nombreCompletoCritico : string;
        codigoPelicula : integer;
        puntajeOtorgado : real;
        end;

    listaC = ^nodoC;

    nodoC = record
        dato : critica;
        sig : listaC;
        end;
    
    listaP = ^nodoP;

    nodoP = record
        dato : pelicula;
        sig : lista;
        end;
    
procedure leerCritica(var c : critica);
begin
    writeln('CARGANDO CRITICA');
    write('Codigo de pelicula = ');
    readln(c.codigoPelicula);
    if(c.codigoPelicula <> -1)then begin
        write('DNI del critico = ');
        readln(c.dniCritico);
        write('Nombre del critico = ');
        readln(c.nombreCompletoCritico);
        write('Puntaje otorgado por el critico = ');
        readln(c.puntajeOtorgado);
    end;
end;

procedure cargarCritica(c : critica; var l : listaC;);
var
    nuevaCritica, posAnterior, posActual : listaC;
begin
    New(nuevaCritica);
    nuevaCritica^.dato := c;
    posAnterior := l;
    posActual := l;
    while((posActual <> nil) and (posActual^.dato.codigoPelicula <> c.codigoPelicula ))do begin //Inserto la informacion para que queden ordenadas por codigo de pelicula
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = posAnterior)then
        l := nuevaCritica
    else
        posAnterior^.sig := nuevaCritica;
    nuevaCritica^.sig := posActual;
end;

procedure cargarListaCriticas(listaCriticas : listaC);
var
    criticaActual : critica;
begin
    leerCritica(criticaActual);
    while(criticaActual.codigoPelicula <> -1)do begin
        cargarCritica(criticaActual, listaCriticas);
        leerCritica(criticaActual);
    end;
end;

function hayCritica( l : listaC ; codigoPelicula : integer) : boolean;
var
    encontre : boolean;
begin
    encontre := false;
    while((l <> nil) and (encontre = false))do begin //Busco el codigo de pelicula dentro de la lista de criticas
        if(l^.dato.codigoPelicula = codigoPelicula)then
            encontre := True
        else
            l := l^.sig;
    end;
    hayCritica := encontre; //Si esta el codigo, entonces se devolvera que si esta el codigo en la lista
end;

function puntajePromedio(l : listaC ; codigoPelicula : integer) :  real;
var
    posActual : listaC;
    encontre : boolean;
    acumulador : real;
    contador : integer;
begin
    acumulador := 0;
    contador := 0;
    encontre := false;
    posActual := l;
    while((posActual <> nil) and (encontre = false))do begin //Busco la posicion de la pelicula
        if(posActual^.dato.codigoPelicula = codigoPelicula)then
            encontre := True
        else
            posActual := posActual^.sig;
    end;
    while(posActual^.dato.codigoPelicula = codigoPelicula)do begin //mientras el codigo de pelicula sea el mismo, voy avanzando e incrementando tanto contador como acumulador
        acumulador := acumulador + posActual^.dato.puntajeOtorgado; //incremento
        contador := contador + 1; //incremento
        posActual := posActual^.sig; //Avanzo en la lista
    end;
    puntajePromedio := (acumulador/contador); //Saco el promedio y lo retorno
end;

procedure inicializarVector(var v : vecGeneros);
var
    i : integer;
begin
    for i := 1 to 8 do begin
        v[i] := 0;
    end;
end;

function puntajeTotal(l : listaC ; codigoPelicula : integer) :  real;
var
    posActual : listaC;
    encontre : boolean;
    acumulador : real;
begin
    acumulador := 0;
    contador := 0;
    encontre := false;
    posActual := l;
    while((posActual <> nil) and (encontre = false))do begin //Busco la posicion de la pelicula
        if(posActual^.dato.codigoPelicula = codigoPelicula)then
            encontre := True
        else
            posActual := posActual^.sig;
    end;
    while(posActual^.dato.codigoPelicula = codigoPelicula)do begin //mientras el codigo de pelicula sea el mismo, voy avanzando e incrementando tanto contador como acumulador
        acumulador := acumulador + posActual^.dato.puntajeOtorgado;
        posActual := posActual^.sig;
    end;
    puntajeTotal := acumulador; // retorno el total de todos los puntajes obtenidos
end;

procedure informarMaximo(v :vecGeneros);
var
    max : real;
    i, posMax : integer;
    generoMax : string;
begin
    max := 0;
    for i := 1 to 8 do begin
        if(v[i] > max)then begin //comparo el valor maximo de los campos del vector
            max := v[i];
            posMax := i; //si es el maximo, guardo el valor a superar, y la posicion donde se encontraba el valor maximo
        end;
    end;
    case posMax of //Dependiendo la posicion del maximo del vector, asignamos el genero al string del maximo
    1: generoMax := 'acción';
    2: generoMax := 'aventura'; 
    3: generoMax := 'drama'; 
    4: generoMax := 'suspenso'; 
    5: generoMax := 'comedia';
    6: generoMax := 'bélica';
    7: generoMax := 'documental';
    8: generoMax := 'terror';
    else generoMax := 'error';
    end;
    writeln;
    writeln('El genero que recibio mayor puntaje fue ', generoMax); //informo el genero que mayor puntaje obtuvo
end;

function cumpleDni(num : integer) : boolean;
var
    digito, contadorPares, contadorImpares : integer;
begin
    while(num <> 0)do begin
        digito := num mod 10; //Separo un digio
        if(digito mod 2 = 0)then //Veo si es para o no es par
            contadorPares := contadorPares + 1 //Incremento contadores
        else
            contadorImpares := contadorImpares + 1;
        num := num div 10; //Saco el digito del numero total
    end;
    cumpleDni := (contadorPares = contadorImpares); //Si tienen la misma cantidad, la igualdad sera true, si no, sera false
end;

procedure actualizarLista(l : listaP);
var
    vectorContador : vecGeneros;
    listaCriticas : listaC;
begin
    cargarListaCriticas(listaCriticas); //Cargo la lista
    inicializarVector(vectorContador); // Inicializo los lugares del vector en 0
    while(l <> nil)do begin //Recorro la lista de peliculas
        if(hayCritica(listaCriticas, l^.dato.codigoPelicula))then begin //Chequeo si la pelicula recibio nuevas criticas
            //Si recibio nuevas criticas:
            vectorContador[l^.dato.codigoGenero] := vectorContador[l^.dato.codigoGenero] + puntajeTotal(listaCriticas, l^.dato.codigoPelicula); 
            //Acumulo el puntaje obtenido al contador de codigos de genero ^^^^ 
            l^.dato.puntajePromedioCriticas := puntajePromedio(listaCriticas, l^.dato.codigoPelicula);
            //Actualizo el puntaje promedio de las criticas al puntaje promedio de la lista de nuevas criticas
        end
        else
            //Si no recibio nuevas criticas :
            writeln('La pelicula actual no recibio nuevas criticas');
        l := l^.sig; //Avanzo en la lista l
    end;
    while(listaCriticas <> nil)do begin //Recorro la lista de criticas
        if(cumpleDni(listaCriticas^.dato.dniCritico))then begin //Si el dni del critico tiene la misma cantidad de didgitos pares que impares, entonces informo
            writeln('El siguiente critico tiene la misma cantidad de digitos pares que impares en su DNI : ', listaCriticas^.dato.nombreCompletoCritico); //informo
        end;
        listaCriticas := listaCriticas^.sig; //Avanzo en la lista listaCriticas
    end;
    informarMaximo(vectorContador); //LLamo al modulo para procesar e informar el maximo de puntaje por genero
end;

procedure eliminarPelicula(var l : listaP; cod : integer);
var
    posAnterior, posActual : listaP
begin
    posAnterior := l; //Inicio los punteros auxiliares en el inicio de la lista
    posActual := l;
    while((posActual <> nil) and (posActual^.dato.codigoPelicula <> cod))do begin //Busco por codigo de pelicula
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual^.dato.codigoPelicula = cod)then begin //si el while anterior corto porque el codigo de pelicula actual es el mismo que el ingresado, se elimina el dato en posActual
        posAnterior^.sig := posActual^.sig; 
        Dispose(posActual); 
    end
    else
        //si no es igual, el while corto pq la lista llego a nil, por ende el codigo no esta y lo informo
        writeln('El codigo de pelicula ingresado no esta en la lista');
end;

var
    listaPeliculas : listaP;
    codigoEliminar : integer;
begin
    listaPeliculas := nil; //inicio la lista
    // cargarLista(listaPeliculas); //Se dispone
    actualizarLista(listaPeliculas); //Proceso la lista

    write('Ingrese el codigo de la pelicula que quiera eliminar = ');
    readln(codigoEliminar);
    eliminarPelicula(listaPeliculas, codigoEliminar); //Modulo que eliminara la pelicula por codigo de la misma
end.