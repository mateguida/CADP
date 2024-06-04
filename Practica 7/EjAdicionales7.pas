{7. La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de
 Analista Programador Universitario. Para ello se deberá leer la información de cada alumno, a saber:
 número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, año de egreso y las
 notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran).
 1. Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el alumno
 con número de alumno -1, el cual no debe procesarse. Las 24 notas correspondientes a cada alumno
 deben quedar ordenadas de forma descendente.
 2. Una vez leída y almacenada la información del inciso 1, se solicita calcular e informar:
 a. El promedio de notas obtenido por cada alumno.
 b. La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto únicamente
 por dígitos impares.
 c. El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido se
 recibieron (o sea, que tardaron menos años)
 3. Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de la
 estructura generada en el inciso 1. El alumno puede no existir.}
 program EjAdicionales7;
 const
    cantidadNotas = 4;
 type

    vecNotas = array[1..cantidadNotas] of real;

    alumno = record
        numeroAlumno : integer;
        nombreYApellido : string;
        direccionCorreo : string;
        anoIngreso : integer;
        anoEgreso : integer;
        notasMaterias : vecNotas;
        dimLNotas : integer;
        end;

    lista = ^nodo;

    nodo = record
        dato : alumno;
        sig : lista;
        end;


procedure agregarAlVector(var vector : vecNotas; nota : real; var dimL : integer);
var
    i : integer;
begin
    i := 1;
    while((i <> dimL) and (nota <= vector[i]))do begin
        i := i + 1;
    end;
    vector[i+1] := vector[i];
    vector[i] := nota;
    dimL := dimL + 1;
end;

procedure leerAlumno(var a : alumno);
var
    i : integer;
    notaActual : real;
begin
    notaActual := 0;
    writeln;
    writeln('Cargando Alumno : ');
    write('Numero de alumno : ');
    readln(a.numeroAlumno);
    if(a.numeroAlumno <> -1)then begin
        write('Nombre completo : ');
        readln(a.nombreYApellido);
        write('Direccion de correo electronico : ');
        readln(a.direccionCorreo);
        write('Año en el cual ingreso : ');
        readln(a.anoIngreso);
        write('Año en el cual egreso : ');
        readln(a.anoEgreso);
        a.dimLNotas := 0;
        for i := 1 to cantidadNotas do begin
            Write('Ingrese nota ', i, ' = ');
            ReadLn(notaActual);
            agregarAlVector(a.notasMaterias, notaActual, a.dimLNotas);
        end;
    end;
end;

procedure cargarAlumno(a : alumno;var l : lista);
var
    nuevoNodo : lista;
begin
    new(nuevoNodo);
    nuevoNodo^.dato := a;
    nuevoNodo^.sig := l;
    l := nuevoNodo;
end;


procedure cargarLista(var l : lista);
var
    alumnoActual : alumno;
begin
    leerAlumno(alumnoActual);
    while(alumnoActual.numeroAlumno <> -1)do begin
        cargarAlumno(alumnoActual, l);
        leerAlumno(alumnoActual);
    end;
end;

function cumple(num : integer) : boolean;
var 
    cumpleAux : boolean;
    digito : Integer;
begin
    cumpleAux := true;
    while(num <>0)do begin
        digito := num mod 10;
        if(digito mod 2 = 0)then
            cumpleAux := false;
        num := num div 10;
    end;
    cumple := cumpleAux;
end;

function promedioNotas(v : vecNotas; dimL : integer) : real;
var
    i : integer;
    acumulador, promedio : real;
    contador :integer;
begin
    acumulador := 0;
    contador := 0;
    for i := 1 to cantidadNotas do begin
        acumulador := acumulador + v[i];
        // contador := contador + 1;
    end;
    promedio := (acumulador/cantidadNotas);
    promedioNotas := promedio;
end;

procedure actualizarMinimos(var nombreMin, nombreMin2, correoMin, correoMin2 : string; var anosMin, anosMin2 : integer; nombreActual, correoActual :string; anosActual: integer);
begin
    if(anosActual < anosMin)then begin
        anosMin2 := anosMin;
        nombreMin2 := nombreMin;
        correoMin2 := correoMin;
        anosMin := anosActual;
        nombreMin := nombreActual;
        correoMin := correoActual;
    end
    else begin
        if(anosActual < anosMin2)then begin
            anosMin2 := anosActual;
            nombreMin2 := nombreActual;
            correoMin2 := correoActual;
        end;
    end;
end;

procedure procesarLista(l : lista);
var
    anosMin, anosMin2, tiempoCarrera, contador2012 : integer;
    nombreMin, nombreMin2, correoMin, correoMin2 : string;
begin
    contador2012 := 0;
    anosMin := 999;
    anosMin2 := 999;
    nombreMin2 := 'None';
    correoMin2 := 'None';
    nombreMin := 'None';
    correoMin := 'None';
    writeln;
    while(l <> nil)do begin
        writeln('El promedio de notas del alumno ', l^.dato.nombreYApellido ,' es ', promedioNotas(l^.dato.notasMaterias, l^.dato.dimLNotas):2:2);

        if((l^.dato.anoIngreso = 2012) and (cumple(l^.dato.numeroAlumno)))then
            contador2012 := contador2012 + 1;

        tiempoCarrera := l^.dato.anoEgreso - l^.dato.anoIngreso;
        actualizarMinimos(nombreMin, nombreMin2, correoMin, correoMin2, anosMin, anosMin2, l^.dato.nombreYApellido, l^.dato.direccionCorreo, tiempoCarrera);

        l := l^.sig;
    end;
    writeln;
    writeln('La cantidad de alumnos que ingresaron en 2012 y tienen todos digitos impares en su numero de alumno son ', contador2012);
    writeln;
    writeln('El alumno que mas rapido se recibio se llama ', nombreMin, ', su correo es ', correoMin, ' y se recibio en ', anosMin,' años');
    writeln('El segundo alumno que mas rapido se recibio se llama ', nombreMin2, ', su correo es ', correoMin2, ' y se recibio en ', anosMin2,' años');
    writeln;
end;

var
    listaAlumnos : lista;
begin
    listaAlumnos := nil;
    cargarLista(listaAlumnos);
    procesarLista(listaAlumnos);
end.