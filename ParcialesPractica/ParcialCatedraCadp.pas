program ParcialCatedraCadp;
const
    cantidadClases = 12;
type
    rangoNotas = 4..10;
    rangoTurnos = 1..4;
    vectorPresentes = array[1..cantidadClases] of boolean;
    vectorTurnos = array[1..4] of integer;

    alumno = record
        dni :integer;
        nombreCompleto : string;
        notaCursoIngreso : rangoNotas;
        turno : rangoTurnos;
        presentes : vectorPresentes;
        end;
    
    lista = ^nodo;
    nodo = record
        dato : alumno;
        sig: lista;
        end;

procedure cargarLista(var l : lista); begin end; //Se dispone

procedure agregarLista(a : alumno; var l : lista);
var
    nuevoAlumno : lista;
begin
    new(nuevoAlumno); //Metodo agregar adelante
    nuevoAlumno^.dato := a;
    nuevoAlumno^.sig := l;
    l := nuevoAlumno;
end;

procedure cargarListaAptos(l : lista; var lAptos : lista);
var
    contadorPresentes, i : integer;
begin
    while(l <> nil)do begin
        contadorPresentes := 0; //Inicializo el contador de presentes del alumno actual
        for i := 1 to cantidadClases do begin
            if(l^.dato.presentes[i])then //Si el presente es true, se incrementa la cantidad de presentes
                contadorPresentes := contadorPresentes + 1;
        end;
        if(contadorPresentes >= 8)then //Si tiene 8 presentes o mas, se agrega el alumno a la lista
            agregarLista(l^.dato, lAptos);
        l := l^.sig;
    end;
end;

function cumple(num : integer) :  Boolean;
var
    digito : integer;
begin
    while(num <> 0)do begin
        digito := num mod 10;
        if(digito = 0)then
            cumple := false;
        num := num div 10;
    end;
    cumple := true;
end;

procedure inicializarVector(var v :vectorTurnos);
var
    i : integer;
begin
    for i := 1 to 4 do v[i] := 0;
end;

procedure informarTurnoMax(v : vectorTurnos);
var
    cantAlumnosMax, turnoMax,i : integer;
begin
    cantAlumnosMax := -1; //inicializo maximo
    turnoMax := 0;
    for i := 1 to 4 do begin //Recorro vector
        if(v[i] > cantAlumnosMax)then begin
            cantAlumnosMax := v[i]; //si la cantidad de alumnos aptos es mayor al maximo, recuerdo valores
            turnoMax := i;
        end;
    end;
    writeln('El turno con mas alumnos aptos para rendir, es el turno ', turnoMax, ' con ', cantAlumnosMax, ' alumnos aptos'); //Informo maximo
end;

procedure procesarListaAptos( l :lista);
var
    vectorContador : vectorTurnos;
    contadorAlumnosDni : integer;
begin
    inicializarVector(vectorContador); //Inicializo variables
    contadorAlumnosDni := 0;
    writeln('ALUMNOS QUE OBTUVIERON 8 O MAS EN EL INGRESO');
    while(l <> nil)do begin

        if(l^.dato.notaCursoIngreso >= 8)then begin //Informo inciso A, si el alumno obtuvo nota alta, se informa nombre completo y dni
            writeln('-',l^.dato.nombreCompleto);
            writeln(' ',l^.dato.dni);
        end;

        vectorContador[l^.dato.turno] := vectorContador[l^.dato.turno] + 1; //Cuento alumno por turno

        if(cumple(l^.dato.dni))then //Si el dni no tiene ningun digito 0, entonces aumento el contador
            contadorAlumnosDni := contadorAlumnosDni + 1;

        l := l^.sig;
    end;
    informarTurnoMax(vectorContador); //Proceso Maximo e Informo B
    writeln('La cantidad de alumnos que no poseen ningun digito 0 en su dni son ', contadorAlumnosDni); //Informo C
end;

var
    listaAlumnos, listaAlumnosAptos : lista;
begin
    listaAlumnos := nil;
    listaAlumnosAptos := nil;
    cargarLista(listaAlumnos); //Se dispone
    cargarListaAptos(listaAlumnos, listaAlumnosAptos);
    procesarListaAptos(listaAlumnosAptos);
end.