{10. Una compañía de venta de insumos agrícolas desea procesar la información de las empresas a las que les
 provee sus productos. De cada empresa se conoce su código, nombre, si es estatal o privada, nombre de la
 ciudad donde está radicada y los cultivos que realiza (a lo sumo 20). Para cada cultivo de la empresa se
 registra: tipo de cultivo (trigo, maíz, soja, girasol, etc.), cantidad de hectáreas dedicadas y la cantidad de
 meses que lleva el ciclo de cultivo.
 a. Realizar un programa que lea la información de las empresas y sus cultivos. Dicha información se
 ingresa hasta que llegue una empresa con código -1 (la cual no debe procesarse). Para cada empresa
 se leen todos sus cultivos, hasta que se ingrese un cultivo con 0 hectáreas (que no debe procesarse).
 Una vez leída y almacenada la información, calcular e informar:
 b. Nombres de las empresas radicadas en “San Miguel del Monte” que cultivan trigo y cuyo código de
 empresa posee al menos dos ceros.
 c. La cantidad de hectáreas dedicadas al cultivo de soja y qué porcentaje representa con respecto al
 total de hectáreas.
 d. La empresa que dedica más tiempo al cultivo de maíz
 e. Realizar un módulo que incremente en un mes los tiempos de cultivos de girasol de menos de 5
 hectáreas de todas las empresas que no son estatales}
 program EjAdicionales10;
 const
    cantidadCultivos = 20;
 type

    cultivo = record 
        tipoCultivo :string;
        hectareasDedicadas : integer;
        mesesCiclo : integer;
        end;
    
    vectorCultivos = array[1..cantidadCultivos] of cultivo;

    empresa = record
        codigoEmpresa : integer;
        nombreEmpresa : string;
        esPrivada : Boolean;
        nombreCiudad : string;
        cultivos : vectorCultivos;
        dimLCultivos : integer;
        end;

    lista = ^nodo;
    nodo = record
        dato : empresa;
        sig : lista;
        end;

procedure leerCultivo(var c : cultivo);
begin
    write('Cantidad de hectareas dedicadas al cultivo = ');
    ReadLn(c.hectareasDedicadas);
    if(c.hectareasDedicadas <> 0)then begin
        write('Tipo de cultivo: ');
        readln(c.tipoCultivo);
        write('Cantidad de meses que durara el ciclo = ');
        ReadLn(c.mesesCiclo);
    end;
end;


//Procedimiento que leera informacion ingresada por teclado y la ingresara en el vector por parametro
procedure leerCultivos(var c : vectorCultivos; var dimL : Integer);
var 
    i : Integer;
    cultivoActual : cultivo;
begin
    i := 1;
    writeln('CARGANDO CULTIVOS DE LA EMPRESA');
    leerCultivo(cultivoActual);
    while((dimL < cantidadCultivos) and (cultivoActual.hectareasDedicadas <> 0))do begin
        c[i] := cultivoActual;
        dimL := dimL + 1;
        leerCultivo(cultivoActual);
        i := i + 1;
    end;
end;

//Procedimiento que leera informacion ingresada por teclado y la ingresara en la variable por parametro
procedure leerEmpresa(var e : empresa);
var
    esPrivadaAux : String;
begin
    writeln('CARGANDO EMPRESA');
    write('Codigo de empresa = ');
    readln(e.codigoEmpresa);
    if(e.codigoEmpresa <> -1)then begin
        write('Nombre de la empresa = ');
        readln(e.nombreEmpresa);
        write('Es privada? (Si/No) : ');
        readln(esPrivadaAux);
        if(esPrivadaAux = 'Si')then
            e.esPrivada := true
        else
            e.esPrivada := false;
    
        write('Nombre ciudad donde se encuentra la empresa = ');
        readln(e.nombreCiudad);
        e.dimLCultivos := 0;
        leerCultivos(e.cultivos, e.dimLCultivos);
    end;
end;

//Procedimiento que cargara una empresa a la lista de empresas
procedure cargarEmpresa(e : empresa; var l : lista);
var
    nuevaEmpresa : lista;
begin
    new(nuevaEmpresa);
    nuevaEmpresa^.dato := e;
    nuevaEmpresa^.sig := l;
    l := nuevaEmpresa;
end;

//Procedimiento que leera informacion de las empresas y la guardara en la lista que llega por parametro
procedure leerEmpresasYCargarLista(var l : lista);
var
    empresaActual : empresa;
begin
    leerEmpresa(empresaActual);
    while(empresaActual.codigoEmpresa <> -1)do begin
        cargarEmpresa(empresaActual, l);
        leerEmpresa(empresaActual);
    end;
end;

function cumpleCod(num : integer) : boolean;
var
    digito, contadorCeros : integer;
begin
    contadorCeros := 0;
    while(num <> 0)do begin
        digito := num mod 10;
        if(digito = 0)then
            contadorCeros := contadorCeros + 1;
        num := num div 10;
    end;
    cumpleCod := contadorCeros >= 2;
end;

function cumpleB(e : empresa) : boolean;
var
    i : integer;
    cumpleSanMiguel, cumpleTrigo, cumpleCodigo : boolean;
begin
    cumpleSanMiguel := False;
    cumpleCodigo := False;
    cumpleTrigo := False;
    if(e.nombreCiudad = 'San Miguel del Monte')then
        cumpleSanMiguel := true;
    
    for i:= 1 to e.dimLCultivos do begin
        if(e.cultivos[i].tipoCultivo = 'Trigo')then
            cumpleTrigo := true;
    end;

    if(cumpleCod(e.codigoEmpresa))then
        cumpleCodigo := true;
    
    if(cumpleSanMiguel and cumpleTrigo and cumpleCodigo)then
        cumpleB := true
    else
        cumpleB := false;
end;

function contarHtasSoja(e : empresa) : integer;
var
    i : integer;
    acumuladorAux : integer;
begin
    acumuladorAux := 0;
    for i := 1 to e.dimLCultivos do begin
        if(e.cultivos[i].tipoCultivo = 'Soja')then
            acumuladorAux := acumuladorAux + e.cultivos[i].hectareasDedicadas
    end;
    contarHtasSoja := acumuladorAux;
end;

function contarHtasTotalesEmpresa(e : empresa) : integer;
var
    i, acumuladorHtas : integer;
begin
    acumuladorHtas := 0;
    for i := 1 to e.dimLCultivos do begin
        acumuladorHtas := acumuladorHtas + e.cultivos[i].hectareasDedicadas;
    end;
    contarHtasTotalesEmpresa := acumuladorHtas;
end;

//Procedimeinto que me actualizara el maximo de tiempo de maiz de la empresa
procedure actualizarMaxMaiz(empresaActual : empresa; var nombreMax : string; var tiempoMax : integer);
var
    i : Integer;
begin
    for i := 1 to empresaActual.dimLCultivos do begin
        if(empresaActual.cultivos[i].tipoCultivo = 'Maiz')then begin
            if(empresaActual.cultivos[i].mesesCiclo > tiempoMax)then begin
                tiempoMax := empresaActual.cultivos[i].mesesCiclo;
                nombreMax := empresaActual.nombreEmpresa;
            end;
        end;
    end;
end;

//Procedimiento que procesara la lista, para cumplir los siguientes incisos
//  b. Nombres de las empresas radicadas en “San Miguel del Monte” que cultivan trigo y cuyo código de
//  empresa posee al menos dos ceros.
//  c. La cantidad de hectáreas dedicadas al cultivo de soja y qué porcentaje representa con respecto al
//  total de hectáreas.
//  d. La empresa que dedica más tiempo al cultivo de maíz
//  e. Realizar un módulo que incremente en un mes los tiempos de cultivos de girasol de menos de 5
//  hectáreas de todas las empresas que no son estatales
procedure procesarLista(l : lista);
var
    acumuladorHectareasSoja ,acumuladorHectareasTotal : integer;
    porcentajeSoja : real;
    nombreEmpresaMax : string;
    tiempoMaizMax : integer;
begin
    tiempoMaizMax := 0;
    nombreEmpresaMax := 'none';
    acumuladorHectareasSoja := 0;
    acumuladorHectareasTotal := 0;
    writeln;
    writeln('Empresas que cumplen el inciso B :');
    while(l <> nil)do begin

        if(cumpleB(l^.dato))then
            writeln(l^.dato.nombreEmpresa);

        acumuladorHectareasSoja := acumuladorHectareasSoja + contarHtasSoja(l^.dato);
        acumuladorHectareasTotal := acumuladorHectareasTotal + contarHtasTotalesEmpresa(l^.dato);

        actualizarMaxMaiz(l^.dato, nombreEmpresaMax, tiempoMaizMax);

        l := l^.sig;
    end;
    if(acumuladorHectareastotal <> 0)then
        porcentajeSoja := (acumuladorHectareasSoja/acumuladorHectareasTotal) * 100;
    
    writeln;
    writeln('La cantidad de hectareas dedicadas a la soja es ', acumuladorHectareasSoja, ' y representa un ', porcentajeSoja:2:2, '% del total de las hectareas');
    writeln;
    writeln('La empresa que mas tiempo dedica al cultivo de maiz es ', nombreEmpresaMax, ' y dedicara ', tiempoMaizMax, ' meses a cultivar maiz');
    writeln;
    writeln('Cantidad de hectareas Totales = ', acumuladorHectareasTotal);
    writeln('Cantidad de hectareas soja = ', acumuladorHectareasSoja);
end;

procedure incrementarGirasol(l : lista);
var
    i, posGirasol :Integer;
    encontreGirasol : boolean;
begin
    while(l <> nil) do begin
        for i := 1 to l^.dato.dimLCultivos do begin
            if(l^.dato.cultivos[i].tipoCultivo = 'Girasol')then begin
                encontreGirasol := true;
                posGirasol := i;
            end;
        end;
        if((encontreGirasol) and (l^.dato.esPrivada = true) and (l^.dato.cultivos[posGirasol].hectareasDedicadas < 5))then begin
            l^.dato.cultivos[posGirasol].mesesCiclo := l^.dato.cultivos[posGirasol].mesesCiclo + 1;
        end;
        l := l^.sig;
    end;
end;

var
    listaEmpresas : lista;
begin
    listaEmpresas := nil;
    leerEmpresasYCargarLista(listaEmpresas);
    procesarLista(listaEmpresas);
    incrementarGirasol(listaEmpresas);
end.