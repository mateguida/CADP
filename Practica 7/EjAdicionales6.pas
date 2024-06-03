{6. El Observatorio Astronómico de La Plata ha realizado un relevamiento sobre los distintos objetos
 astronómicos observados durante el año 2015. Los objetos se clasifican en 7 categorías: 1: estrellas, 2:
 planetas, 3: satélites, 4: galaxias, 5: asteroides, 6: cometas y 7: nebulosas.
 Al observar un objeto, se registran los siguientes datos: código del objeto, categoría del objeto (1..7),
 nombre del objeto, distancia a la Tierra (medida en años luz), nombre del descubridor y año de su
 descubrimiento.
 A. Desarrolle un programa que lea y almacene la información de los objetos que han sido observados.
 Dicha información se lee hasta encontrar un objeto con código -1 (el cual no debe procesarse). La
 estructura generada debe mantener el orden en que fueron leídos los datos.
 B. Una vez leídos y almacenados todos los datos, se pide realizar un reporte con la siguiente
 información:
 1. Los códigos de los dos objetos más lejanos de la tierra que se hayan observado.
 2. La cantidad de planetas descubiertos por "Galileo Galilei" antes del año 1600.
 3. La cantidad de objetos observados por cada categoría.
 4. Los nombres de las estrellas cuyos códigos de objeto poseen más dígitos pares que impares.}
 program EjAdicionales6;
 type
    lista = ^nodo;

    vecCategorias = array[1..7] of integer;

    objetoAstronomico = record
        codigoObjeto : integer;
        categoriaObjeto : 1..7;
        nombreObjeto : string;
        distanciaALaTierra : real;
        nombreDescubridor : string;
        anoDescubrimiento : integer;
        end;

    nodo = record
        dato : objetoAstronomico;
        sig : lista;
        end;

procedure leerObjeto(var o : objetoAstronomico);
begin
    writeln('CARGANDO OBJETO ASTRONOMICO');
    write('Codigo del objeto = ');
    readln(o.codigoObjeto);
    if(o.codigoObjeto <> -1)then begin
        write('Categoria del objeto (1 a 7) = ');
        readln(o.categoriaObjeto);
        write('Nombre del objeto = ');
        readln(o.nombreObjeto);
        write('Distancia a la tierra = ');
        readln(o.distanciaALaTierra);
        write('Nombre del descubridor = ');
        readln(o.nombreDescubridor);
        write('Año en el cual se descubrio el objeto = ');
        readln(o.anoDescubrimiento);
    end;
end;

procedure cargarObjeto(o : objetoAstronomico; var l, ult : lista);
var
    nuevoObjeto : lista;
begin
    new(nuevoObjeto);
    nuevoObjeto^.dato := o;
    nuevoObjeto^.sig := Nil;
    if(l = nil)then begin
        l := nuevoObjeto;
        ult := nuevoObjeto; 
    end
    else begin
        ult^.sig := nuevoObjeto;
        ult := nuevoObjeto;
    end;
end;

procedure iniciarVector(var vector : vecCategorias);
var
    i : integer;
begin
    for i := 1 to 7 do begin
        vector[i] := 0;
    end;
end;

function cumpleDigitos(num : integer) : boolean;
var
    digito, contadorPares, contadorImpares : integer;
begin
    contadorPares := 0;
    contadorImpares := 0;
    while(num <> 0) do begin
        digito := num mod 10;
        if(digito mod 2 = 0)then
            contadorPares := contadorPares + 1
        else
            contadorImpares := contadorImpares + 1;
        num := num div 10;
    end;
    if(contadorPares > contadorImpares)then
        cumpleDigitos := true
    else
        cumpleDigitos := false;
end;

procedure estrellasPares(l : lista); //Inciso 4
begin
    writeln('ESTRELLAS CUYO CODIGO TIENE MAS DIGITOS PARES QUE IMPARES : ');
    while(l <> nil)do begin
        if((l^.dato.categoriaObjeto = 1) and (cumpleDigitos(l^.dato.codigoObjeto)))then
            writeln('Nombre : ',l^.dato.nombreObjeto);
        l := l^.sig;
    end;
    writeln;
end;


// 1: estrellas, 2:planetas, 3: satélites, 4: galaxias, 5: asteroides, 6: cometas y 7: nebulosas.
procedure informarCantidadPlanetas(v : vecCategorias);
var
    i : Integer;
begin
    writeln;
    writeln('CANTIDAD DE OBJETOS POR CATEGORIA');
    for i := 1 to 7 do begin
        case i of
        1 : writeln('Estrellas = ', v[i]);
        2 : writeln('Planetas = ', v[i]);
        3 : writeln('Satelites = ', v[i]);
        4 : writeln('Galaxias = ', v[i]);
        5 : writeln('Asteroides = ', v[i]);
        6 : writeln('Cometas = ', v[i]);
        7 : writeln('Nebulosas = ', v[i]);
        end;
    end;
end;


procedure actualizarMaximos(var codMax, codMax2 : integer; var distMax, distMax2 : real; distanciaActual : real; codigoActual : integer);
begin
    if(distanciaActual > distMax)then begin
        codMax2 := codMax;
        distMax2 := distMax;
        codMax := codigoActual;
        distMax := distanciaActual;
    end
    else begin
        if(distanciaActual > distMax2)then begin
            codMax2 := codigoActual;
            distMax2 := distanciaActual;
        end;
    end;
end;
//Procedimiento que me generara el informe con el siguiente contenido
//  1. Los códigos de los dos objetos más lejanos de la tierra que se hayan observado.
//  2. La cantidad de planetas descubiertos por "Galileo Galilei" antes del año 1600.
//  3. La cantidad de objetos observados por cada categoría.
//  4. Los nombres de las estrellas cuyos códigos de objeto poseen más dígitos pares que impares.
procedure generarReporte(l : lista);
var
    contadorGalileo, codObjetoMax, codObjetoMax2 : Integer;
    vectorContador : vecCategorias;
    distanciaObjMax, distanciaObjMax2 : real;
begin
    codObjetoMax := 0;
    codObjetoMax2 := 0;
    distanciaObjMax := -1;
    distanciaObjMax2 := -1;
    contadorGalileo := 0;
    iniciarVector(vectorContador);
    while(l <> nil)do begin
    
        if((l^.dato.nombreDescubridor = 'Galileo Galilei') and (l^.dato.anoDescubrimiento < 1600) and (l^.dato.categoriaObjeto = 2))then //Inciso 2
            contadorGalileo := contadorGalileo + 1;
        
        vectorContador[l^.dato.categoriaObjeto] := vectorContador[l^.dato.categoriaObjeto] + 1; //Inciso 3

        if(l^.dato.categoriaObjeto = 2)then
            actualizarMaximos(codObjetoMax, codObjetoMax2, distanciaObjMax, distanciaObjMax2, l^.dato.distanciaALaTierra, l^.dato.codigoObjeto); //Inciso 1

        l := l^.sig;
    end;
    WriteLn;
    WriteLn('Cantidad de planetas descubiertos por Galileo Galilei fue ', contadorGalileo);
    informarCantidadPlanetas(vectorContador);
    WriteLn;
    WriteLn('El codigo del planeta mas alejado de la tierra es ', codObjetoMax, ' y esta a ', distanciaObjMax:2:2,'kms');
    WriteLn('El codigo del segundo planeta mas alejado de la tierra es ', codObjetoMax2, ' y esta a ', distanciaObjMax2:2:2,'kms');
    writeln;
end;
var
    objetoActual : objetoAstronomico;
    listaObjetos, ultimoLista : lista;
begin
    listaObjetos := nil;
    leerObjeto(objetoActual);
    while(objetoActual.codigoObjeto <> -1)do begin
        cargarObjeto(objetoActual, listaObjetos, ultimoLista);
        leerObjeto(objetoActual);
    end;
    generarReporte(listaObjetos);
    estrellasPares(listaObjetos);
end.
