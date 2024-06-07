{una revista deportiva dispone de informacion de los jugadores
de futbol participantes de la liga profesional 2022. de cada jugador conoce
codigo de jugador, apellido y nombre, codigo de equipo (1..28)
ano de nacimiento y la calificacion obtenida para cada una de las 27 fechas de torneo ya finalizado. la calificacion
es numerica de 0 a 10, donde el valor 0 significa que el jugador no ha participado
de la fecha.

se solicita:
a- informar para cada equipo la cantidad de jugadores mayores a 35 anos.
b- informar los codigos de los 2 jugadores con mejor calificacion promedio en los partidos en los que participo.
solo deben considerarse los jugadores que participaron en mas de 14 fechas.
c- implementar e invocar un modulo que genere una lista con los jugadores cuyo codigo posee exactamente
3 digitos impares y haya nacido entre 1983 y 1990. la lista debe estar ordenada por codigo de jugador.}
program ParcialitoPrueba;
const
    anoActual = 2024;
    cantidadFechas = 27;
    cantidadEquipos = 28;
type
    rangoEquipo = 1..cantidadEquipos;

    calificacion = 0..10;
    calificacionesFechas = array[1..cantidadFechas] of calificacion;

    vecContador35anos = array[rangoEquipo] of integer;

    jugador = record    
        codJugador : integer;
        apeyNom : string;
        codEquipo : rangoEquipo;
        anoNacimiento : Integer;
        calificacionesJugador : calificacionesFechas;
        end;

    lista = ^nodo;
    nodo = record
        dato : jugador;
        sig : lista;
        end;

procedure cargarLista(var l : lista);
begin
end;

procedure inicializarVector(var v : vecContador35anos);
var
    i : integer;
begin
    for i := 1 to cantidadEquipos do begin
        v[i] := 0;
    end;
end;

function cumpleFechas(c : calificacionesFechas) : Boolean;
var
    i, contadorJugo : integer
begin
    contadorJugo := 0;
    for i := 1 to cantidadFechas do begin
        if(c[i] <> 0)then
            contadorJugo := contadorJugo + 1;
    end;
    cumpleFechas := (contadorJugo > 14)
end;

function sacarPromedio( c :calificacionesFechas) : real;
var
    fechasJugadas ,i : integer;
    acumuladorCalificaciones : real;
begin
    fechasJugadas := 0;
    acumuladorCalificaciones := 0;
    for i := 1 to cantidadFechas do begin
        if(c[i] <> 0)then begin
            acumuladorCalificaciones := acumuladorCalificaciones + c[i];
            fechasJugadas := fechasJugadas + 1;
        end;
    end;
    sacarPromedio := acumuladorCalificaciones/fechasJugadas;
end;

procedure actualizoMaximos(codigoActual : integer; calificacionActual : real; var codigoMax, codigoMax2 : integer; var calificacionMax, calificacionMax2 : real;);
begin
    if(calificacionActual > calificacionMax)then begin
        calificacionMax2 := calificacionMax;
        codigoMax2 := codigoMax;
        calificacionMax := calificacionActual;
        codigoMax := codigoActual;
    end
    else begin
        if(calificacionActual > calificacionMax2)then begin
            calificacionMax2 := calificacionActual;
            codigoMax2 := codigoActual;
        end;
    end;
end;

// a- informar para cada equipo la cantidad de jugadores mayores a 35 anos.
// b- informar los codigos de los 2 jugadores con mejor calificacion promedio en los partidos en los que participo.
// solo deben considerarse los jugadores que participaron en mas de 14 fechas.
// c- implementar e invocar un modulo que genere una lista con los jugadores cuyo codigo posee exactamente
// 3 digitos impares y haya nacido entre 1983 y 1990. la lista debe estar ordenada por codigo de jugador.}
procedure procesarLista(l : lista);
var
    jugadores35anos : vecContador35anos;
    edadJugadorActual, i, codigoMax, codigoMax2 : integer;
    calificacionPromedio, calificacionMax, calificacionMax2 : real;
begin
    inicializarVector(jugadores35anos);
    edadJugadorActual := 0;
    calificacionMax := -1; //Inicializo maximos
    calificacionMax2 := -1;
    codigoMax := 0;
    codigoMax2 := 0;
    while(l <> nil)do begin
        edadJugadorActual := anoActual - l^.dato.anoNacimiento; //Calculo la edad actual del jugador
        if(edadJugadorActual > 35)then begin
            //Inciso A
            //Si es mayor a 35, aumento en 1 el contador de jugadores de 35 años en su equipo (lo se por el codigo de equipo)
            jugadores35anos[l^.dato.codEquipo] := jugadores35anos[l^.dato.codEquipo] + 1;
        end;

        //Inciso B
        if(cumple(l^.dato.calificacionesJugador))then begin //Si el jugador jugo mas de 14 fechas, entra al if
            calificacionPromedio := sacarPromedio(l^.dato.calificacionesJugador); //Saco el promedio de calificaciones
            actualizoMaximos(l^.dato.codJugador , calificacionPromedio ,codigoMax, codigoMax2, calificacionMax, calificacionMax2); //Actualizo
        end;

        l := l^.sig;
    end;
    for i := 1 to cantidadEquipos do begin //Informo inciso A
        if(jugadores35anos[i] = 0)then
            writeln('El equipo ', i, ' no tiene jugadores con mas de 35 años')
        else
            writeln('La cantidad de jugadores con mas de 35 anos del equipo ', i, ' es de ', jugadores35anos[i]);
    end;
    writeln;
    writeln('El jugador con maxima calificacion fue el jugador con codigo ', codigoMax, ' con un puntaje promedio de ', calificacionMax);
    writeln('El segundo jugador con maxima calificacion fue el jugador con codigo ', codigoMax2, ' con un puntaje promedio de ', calificacionMax2);
    writeln;
end;

function cumpleCodigo(num : integer) : Boolean;
var
    contadorImpares, digito :integer;
begin
    while(num <> 0) do begin
        digito := num mod 10;
        if(digito mod 2 <> 0)then
            contadorImpares := contadorImpares + 1;
        num := num div 10;
    end;
    cumpleCodigo := (contadorImpares = 3)
end;

procedure insertarLista(jugadorActual : jugador; var l : lista);
var
    nuevoJugador, posAnterior, posActual : lista;
begin
    new(nuevoJugador);
    nuevoJugador^.dato := jugadorActual;
    posAnterior := l;
    posActual := l;
    while((posActual <> nil) and (jugadorActual.codJugador > posActual^.dato.codJugador))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posAnterior = posActual)then
        l := nuevoJugador
    else
        posAnterior^.sig := nuevoJugador;
    nuevoJugador^.sig := posActual;
end;

procedure generarListaSecundaria(l : lista);
var
    listaSec : lista;
begin
    while(l <> nil) do begin
        if((cumpleCodigo(l^.dato.codJugador)) and ((l^.dato.anoNacimiento > 1983) and (l^.dato.anoNacimiento < 1990)))then begin
            insertarLista(l^.dato, listaSec);
        end;
        l := l^.sig;
    end;
end;

var
    listaJugadores : lista;
begin
    listaJugadores := nil;
    cargarLista(listaJugadores); //SE DISPONE
    procesarLista(listaJugadores);
    generarListaSecundaria(listaJugadores);
end.