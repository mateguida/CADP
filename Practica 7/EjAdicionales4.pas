 {4. Una maternidad dispone información sobre sus pacientes. De cada una se conoce: nombre, apellido y peso
 registrado el primer día de cada semana de embarazo (a lo sumo 42). La maternidad necesita un programa
 que analice esta información, determine e informe:
 a. Para cada embarazada, la semana con mayor aumento de peso.
 b. El aumento de peso total de cada embarazada durante el embarazo.}
 program EjAdicionales4;
 type 
    vecPesos = array[1..42] of Real;

    embarazada = record
        nombreYApellido : string;
        pesoSemanas : vecPesos;
        dimLPesos : integer;
        end;

    lista = ^nodo;

    nodo = record
        dato : embarazada;
        sig : lista;
        end;


function aumentoDePesoTotal(vector : vecPesos; dimL : integer) : real;
var
    i : Integer;
    acumuladorPeso : real;
begin
    for i := 1 to dimL do begin
        acumuladorPeso := acumuladorPeso + vector[i];
    end;
    aumentoDePesoTotal := acumuladorPeso;
end;

procedure semanaMayorAumento(vector : vecPesos;  dimL : integer);
var
    i, semanaMax : integer;
    aumentoActual, aumentoMax : Real;

begin
    aumentoActual := 0;
    aumentoMax := -1;
    semanaMax := 0;
    for i := 1 to dimL do begin
        aumentoActual := vector[i] - vector[i-1];
        if(aumentoActual > aumentoMax)then begin
            semanaMax := i;
            aumentoMax := aumentoActual;
        end;
    end;
    writeln('La semana con mas aumento fue la semana ', semanaMax, ' con un aumento de ', aumentoMax:2:2, 'kg');
end;

procedure procesarEmbarazadasLista(l : lista);
begin
    while(l <> nil)do begin
        writeln('Procesando embarazada ', l^.dato.nombreYApellido);
        WriteLn('El aumento total de ', l^.dato.nombreYApellido, ' fue de ', aumentoDePesoTotal(l^.dato.pesoSemanas, l^.dato.dimLPesos), 'kg');
        semanaMayorAumento(l^.dato.pesoSemanas, l^.dato.dimLPesos);
    end;
end;

var
    listaEmbarazadas : lista;
begin
    listaEmbarazadas := nil;
    //Cargar Lista
    //Cargar Lista
    //Cargar Lista
    procesarEmbarazadasLista(listaEmbarazadas);
end.