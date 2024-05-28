{ 11.La Facultad de Informática debe seleccionar los 10 egresados con mejor promedio a los que la UNLP les
 entregará el premio Joaquín V. González. De cada egresado se conoce su número de alumno, apellido y
 el promedio obtenido durante toda su carrera.
 Implementar un programa que:
 a. Lea la información de todos los egresados, hasta ingresar el código 0, el cual no debe procesarse.
 b. Una vez ingresada la información de los egresados, informe el apellido y número de alumno de los
 egresados que recibirán el premio. La información debe imprimirse ordenada según el promedio
 del egresado (de mayor a menor). }
program PracticaListas11;
type
    listaAlumnos = ^nodo;
    
    alumno = record
        numeroDeAlumno : integer;
        apellido : string;
        promedio: real;
        end;

    nodo = record
        alum : alumno;
        sig : listaAlumnos;
        end;

//Procedimiento que leera la informacion ingresada por teclado y la guardara en el alumno
procedure leerAlumno(var a : alumno);
begin
    write('Ingrese numero de alumno = ');
    readln(a.numeroDeAlumno);
    if(a.numeroDeAlumno <> 0 )then begin
        write('Ingrese apellido del alumno : ');
        readln(a.apellido);
        write('Ingrese promedio del alumno ', a.apellido,' = ');
        readln(a.promedio);
    end;
end;

//Procedimiento que agregara alumnos a la lista y los agregara ordenados por promedio descendente
procedure insertarAlumnoOrdenado(var l : listaAlumnos; a : alumno);
var
    nuevoAlumno, posActual , posAnterior : listaAlumnos; //Punteros auxiliares
begin
    new(nuevoAlumno);
    nuevoAlumno^.alum := a;
    posActual := l;
    posAnterior := l;
    while((posActual <> nil) and (a.promedio < l^.alum.promedio)) do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = posAnterior)then//Principio de la lista o lista vacia
        l := nuevoAlumno
    else
        posAnterior^.sig := nuevoAlumno;
    nuevoAlumno^.sig := posActual;
end;

//Procedimiento que informara los primeros 10 elementos de la lista
procedure informarPremios(l : listaAlumnos);
var
    i : integer;
    tam : integer;
    aux : listaAlumnos;
begin
    while(l <> nil) do begin
        writeln(i,'. Apellido : ',l^.alum.apellido, '|| Promedio = ', l^.alum.Promedio:2:2);
        l := l^.sig;    
    end;
end;

var
    i : integer;
    lista : listaAlumnos;
    alumnoActual : alumno;
begin
    lista := nil;
    leerAlumno(alumnoActual);
    while(alumnoActual.numeroDeAlumno <> 0) do begin
        insertarAlumnoOrdenado(lista, alumnoActual);
        leerAlumno(alumnoActual);
    end;
    writeln('Alumnos que recibiran el premio');
    informarPremios(lista);
end.
