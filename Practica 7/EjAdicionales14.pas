{ 14. La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar información de
 préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información de los préstamos
 realizados. De cada préstamo se lee: nro. de préstamo, ISBN del libro prestado, nro. de socio al que se prestó el
 libro, día del préstamo (1..31). La información de los préstamos se lee de manera ordenada por ISBN y finaliza
 cuando se ingresa el ISBN -1 (que no debe procesarse).
 Se pide:
 A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado.
 Esta estructura debe quedar ordenada por ISBN de libro.
 B) Calcular e informar el día del mes en que se realizaron menos préstamos.
 C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.}
 program EjAdicionales14;
 type
    diasMes = 1..31;
    prestamo = record
        numeroPrestamo : integer;
        ISBNLibro : integer;
        numeroSocio : integer;
        diaPrestamo : diasMes;
        end;

    vecDiasMes = array[diasMes] of Integer;
    
    ISBN = record
        numero : Integer;
        vecesPrestado : integer;
        end;

    listaISBN = ^nodoISBN;
    nodoISBN = record
        dato : ISBN;
        sig: listaISBN;
        end;

    lista = ^nodo;
    nodo = record
        dato : prestamo;
        sig : lista;
        end;

procedure leerPrestamo(var p : prestamo);
begin
    writeln('CARGANDO PRESTAMO');
    write('ISBN DEL LIBRO = ');
    ReadLn(p.ISBNLibro);
    if(p.ISBNLibro <> -1)then begin
        write('NUMERO DE PRESTAMO = ');
        readln(p.numeroPrestamo);
        write('NUMERO DE SOCIO = ');
        readln(p.numeroSocio);
        write('DIA DEL PRESTAMO = ');
        readln(p.diaPrestamo);
    end;
end;
    
procedure agregarAtras(p : prestamo; var l, ultimo : lista);
var
    nuevoPrestamo : lista;
begin
    new(nuevoPrestamo);
    nuevoPrestamo^.dato := p;
    nuevoPrestamo^.sig := nil;
    if(l = nil)then 
        l := nuevoPrestamo
    else
        ultimo^.sig := nuevoPrestamo;
    ultimo := nuevoPrestamo;
end;

procedure inicializarVector(var v : vecDiasMes);
var
    i : integer;
begin
    for i := 1 to 31 do begin
        v[i] := 0;
    end;
end;

procedure informarMinimo(v : vecDiasMes);
var
    prestamosMin, diaMin, i : integer;
begin
    prestamosMin := 9999;
    diaMin := 0;
    for i := 1 to 31 do begin
        if(v[i] <> 0)then begin
            if(v[i] < prestamosMin)then begin
                prestamosMin := v[i];
                diaMin := i;
            end;
        end;
    end;
    writeln('El dia del mes que menos prestamos se hicieron fue el dia ', diaMin, ' y se hicieron ', prestamosMin, ' prestamos');
end; 

procedure agregarALaLista(var l : listaISBN; ISBNActual : integer);
var
    nuevoISBN, posActual, posAnterior : listaISBN;
begin
    new(nuevoISBN);
    nuevoISBN^.dato.numero := ISBNActual;
    nuevoISBN^.dato.vecesPrestado := 1;
    posActual := l;
    posAnterior := l;
    while((posActual <> nil) and (ISBNActual > posActual^.dato.numero))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posAnterior = posActual)then
        l := nuevoISBN //lista vacia o primer nodo
    else
        posAnterior^.sig := nuevoISBN; //Resto
    nuevoISBN^.sig := posActual;
end;

procedure actualizarLista(var l : listaISBN; ISBNActual : integer);
var
    posActual : listaISBN;
    encontre : Boolean;
begin
    encontre := false;
    posActual := l;
    while((posActual <> nil) and (encontre = false))do begin
        if(posActual^.dato.numero = ISBNActual)then
            encontre := true
        else begin
            posActual := posActual^.sig;
        end;
    end;
    if(encontre)then
        posActual^.dato.vecesPrestado := posActual^.dato.vecesPrestado + 1
    else
        agregarALaLista(l, ISBNActual);
end;

procedure imprimirLista(l : listaISBN);
begin
    writeln;
    write('[');
    while(l <> nil)do begin
        write(l^.dato.numero,'(Prestado = ',l^.dato.vecesPrestado,') // ');
        l := l^.sig;
    end;
    write(']');
end;

//  A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado. Esta estructura debe quedar ordenada por ISBN de libro.
//  B) Calcular e informar el día del mes en que se realizaron menos préstamos.
//  C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.
procedure procesarLista(l : lista; var l2 : listaISBN);
var
    vecContador : vecDiasMes;
    contadorPrestamos, contadorPrestamosTotales : integer;
    porcentajeFinal : real;
begin
    inicializarVector(vecContador);
    contadorPrestamos := 0;
    contadorPrestamosTotales := 0;
    while(l <> nil) do begin
        actualizarLista(l2, l^.dato.ISBNLibro);
        vecContador[l^.dato.diaPrestamo] := vecContador[l^.dato.diaPrestamo] + 1;
        contadorPrestamosTotales := contadorPrestamosTotales + 1;
        if((l^.dato.numeroPrestamo mod 2 <> 0) and (l^.dato.numeroSocio mod 2 = 0))then
            contadorPrestamos := contadorPrestamos + 1;
        
        l := l^.sig;
    end;

    if(contadorPrestamosTotales <> 0)then
        porcentajeFinal := (contadorPrestamos/contadorPrestamosTotales) * 100
    else
        porcentajeFinal := 0;
    writeln;
    writeln('El porcentaje de prestamos que poseen numero de prestamo impar y numero de socio par es ', porcentajeFinal:2:2, '%');
    informarMinimo(vecContador);
    imprimirLista(l2);
end;

var
    listaPrestamos, ultimoLista : lista;
    listaLibros : listaISBN;
    prestamoActual : prestamo;
begin
    listaPrestamos := nil;
    leerPrestamo(prestamoActual);
    while(prestamoActual.ISBNLibro <> -1)do begin
        agregarAtras(prestamoActual, listaPrestamos, ultimoLista);
        leerPrestamo(prestamoActual);
    end;
    procesarLista(listaPrestamos, listaLibros);
end.