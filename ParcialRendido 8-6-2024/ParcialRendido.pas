program parcialRendido;
const
    cantidadMarcas = 130;
type
    rangoMarcas = 1..cantidadMarcas;
    vecMarcas = array[rangoMarcas] of string;
    vecMinimos = array[rangoMarcas] of real;

    repuesto = record
        codRepuesto : integer;
        precio : real;
        codMarca : rangoMarcas;
        paisProcedencia : string;
        end;

    lista =  ^nodo;
    nodo = record
        dato : repuesto;
        sig : lista;
        end;

procedure cargarVector(var v : vecMarcas);
var
    i : integer;
    codigoMarcaActual : rangoMarcas;
begin
    for i := 1 to cantidadMarcas do begin
        write('Ingrese codigo de la marca = ');
        ReadLn(codigoMarcaActual);
        write('Ingrese nombre de la marca ', codigoMarcaActual, ' : ');
        readln(v[codigoMarcaActual]);
    end;
end;

procedure cargarLista(var l : lista); //Se dispone

procedure inicializarVectorMinimos(var v : vecMinimos);
var
    i : Integer;
begin
    for i := 1 to cantidadMarcas do 
        v[i] := 999;
end;

procedure informarMarcas(vectorNombres : vecMarcas; vectorMinimos : vecMinimos);
var
    i : integer;
begin
    writeln;
    writeln('Informando Marcas');
    for i := 1 to cantidadMarcas do begin
        writeln('Nombre : ', vectorNombres[i]);
        writeln('Precio del producto mas barato de ', vectorNombres[i], '= ', vectorMinimos[i]:2:2, '$');
    end;
end;

procedure actualizarMinimos(var v : vecMinimos; marcaActual : rangoMarcas; precioActual : real);
begin
    if(precioActual < v[marcaActual])then
        v[marcaActual] := precioActual;
end;

procedure procesarLista(l : lista; vectorNombres : vecMarcas; var vectorMinimos : vecMinimos);
var
    contadorMas100, contadorRepuestosActual : integer;
    paisActual : string;
begin
    inicializarVectorMinimos(vectorMinimos);
    contadorMas100 := 0;
    while(l <> nil) do begin
        contadorRepuestosActual := 0;
        paisActual := l^.dato.paisProcedencia;
        while((l <> nil) and (l^.dato.paisProcedencia = paisActual))do begin
            contadorRepuestosActual := contadorRepuestosActual + 1;
            actualizarMinimos(vectorMinimos, l^.dato.codMarca, l^.dato.precio);
            l := l^.sig;
        end;
        if(contadorRepuestosActual > 100)then
            contadorMas100 := contadorMas100 + 1;
    end;
    writeln;
    writleln('La cantidad de paises que se le compro mas de 100 repuestos es ', contadorMas100);
end;

var
    listaRepuestos : lista;
    vectorNombres : vecMarcas;
    vectorMinimos : vecMinimos;
begin
    listaRepuestos := nil;
    cargarLista(listaRepuestos); //Se dispone
    cargarVector(vectorNombres);
    procesarLista(listaRepuestos, vectorNombres, vectorMinimos);
    informarMarcas(vectorNombres, vectorMinimos);
end.