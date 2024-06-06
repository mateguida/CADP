{ 11. Realizar un programa para una empresa productora que necesita organizar 100 eventos culturales. De cada
 evento se dispone la siguiente información: nombre del evento, tipo de evento (1: música, 2: cine, 3: obra de
 teatro, 4: unipersonal y 5: monólogo), lugar del evento, cantidad máxima de personas permitidas para el evento
 y costo de la entrada. Se pide:
 1. Generar una estructura con las ventas de entradas para tales eventos culturales. De cada venta se debe
 guardar: código de venta, número de evento (1..100), DNI del comprador y cantidad de entradas
 adquiridas. La lectura de las ventas finaliza con código de venta-1.
 2. Una vez leída y almacenada la información de las ventas, calcular e informar:
 a. El nombre y lugar de los dos eventos que han tenido menos recaudación.
 b. La cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos pares que impares
 y que sean para el evento de tipo “obra de teatro”.
 c. Si la cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad máxima de
 personas permitidas}
 program EjAdicionales11;
 const
    cantidadEventos = 100;
 type
    tiposEventos = 1..5;
    rangoEventos = 1..cantidadEventos;

    vectorRecaudaciones = array[rangoEventos] of real;

    evento = record
        nombre : string;
        tipoEvento : tiposEventos;
        lugar : String;
        cantidadMaximaPersonas : integer;
        costoEntrada : real;
        end;

    vectorEventos = array[rangoEventos] of evento;
    
    venta = record
        codigoVenta : Integer;
        numeroEvento : rangoEventos;
        dniComprador : integer;
        cantidadEntradas : integer;
        end;
    
    lista = ^nodo;
    nodo = record
        dato : venta;
        sig : lista;
        end;

procedure leerVenta(var v : venta);
begin
    writeln('CARGANDO VENTA');
    write('Codigo de venta = ');
    readln(v.codigoVenta);
    if(v.codigoVenta <> -1)then begin
        write('Numero de venta de la entrada (1 a 100) = ');
        readln(v.numeroEvento);
        write('DNI del comprador = ');
        readln(v.dniComprador);
        write('Cantidad entradas que compro = ');
        readln(v.cantidadEntradas);
    end;
end;

procedure cargarVenta(v : venta; var l : lista);
var
    nuevaVenta : lista;
begin
    new(nuevaVenta); //Metodo agregar Adelante
    nuevaVenta^.dato := v;
    nuevaVenta^.sig := l;
    l := nuevaVenta;
end;

procedure cargarVector(var v : vectorEventos);
begin
end;


//Procedimiento que comparara los valores del vector de recaudaciones y recordara la recaudacion minima, junto con el nombre y el lugar del evento, y lo mismo pero para el 2do minimo
procedure informarMinimos(v : vectorRecaudaciones ; vE : vectorEventos);
var
    i :Integer;
    nombreMin, lugarMin, nombreMin2, lugarMin2 : string;
    recaudacionMin, recaudacionMin2 : real;
begin
    recaudacionMin := 9999; //Inicializo minimos
    recaudacionMin2 := 9999;
    nombreMin := 'None'; //Inicializo string, para a la hora de imprimir, no imprimir basura sin querer
    nombreMin2 := 'None'; 
    lugarMin := 'None'; 
    lugarMin2 := 'None'; 
    for i:= 1 to cantidadEventos do begin //Recorro el vector de recaudaciones
        if(v[i] < recaudacionMin)then begin 
        //Si la recaudacion actual, es menor a la recaudacion minima entonces :
            nombreMin2 := nombreMin; //Paso el minimo, al segundo minimo
            lugarMin2 := lugarMin;
            recaudacionMin2 := recaudacionMin;
            nombreMin := vE[i].nombre; //Paso la nueva informacion al minimo
            lugarMin := vE[i].lugar;
            recaudacionMin := v[i];
        end
        else begin
            //Si la recaudacion actual no es menor al primer minimo, puede serlo al segundo, entonces :
            if(v[i] < recaudacionMin2)then begin
                nombreMin2 := vE[i].nombre; //Recuerdo valores
                lugarMin2 := vE[i].lugar;
                recaudacionMin2 := v[i];
            end;
        end;
    end;
    writeln;
    writeln('El evento que menos recaudacion ha tenido fue el evento ', nombreMin,' en el lugar ', lugarMin, ' con una recaudacion total de ', recaudacionMin); //Informo
    writeln('El segundo evento que menos recaudacion ha tenido fue el evento ', nombreMin2,' en el lugar ', lugarMin2, ' con una recaudacion total de ', recaudacionMin2);
    writeln;
end;

//Funcion que devolvera si el numero ingresado por paramtetro tiene mas digitos pares que impares
function cumpleDni(num : integer) : Boolean;
var 
    digito, contadorPares, contadorImpares : integer;
begin
    while(num <> 0)do begin
        digito := num mod 10;
        if(digito mod 2 = 0)then
            contadorPares := contadorPares + 1
        else
            contadorImpares := contadorImpares + 1;
        num := num div 10;
    end;
    cumpleDni := contadorPares > contadorImpares;
end;

//  a. El nombre y lugar de los dos eventos que han tenido menos recaudación.
//  b. La cantidad de entradas vendidas cuyo comprador contiene en su DNI más dígitos pares que impares
//  y que sean para el evento de tipo “obra de teatro”.
//  c. Si la cantidad de entradas vendidas para el evento número 50 alcanzó la cantidad máxima de
//  personas permitidas
procedure procesarLista(l : lista; vecEventos : vectorEventos);
var
    contadorDni, acumuladorEvento50 : integer;
    recaudaciones : vectorRecaudaciones;
begin
    contadorDni := 0; //incializo contadores y acumuladores
    acumuladorEvento50 := 0;
    while(l <> nil)do begin // recorro la lista
        //Aumento las recaudaciones del evento actual, en la cantidad de entradas compradas en esta venta x precio de la entrada para el evento actual
        recaudaciones[l^.dato.numeroEvento] := recaudaciones[l^.dato.numeroEvento] + (l^.dato.cantidadEntradas * vecEventos[l^.dato.numeroEvento].costoEntrada);

        //Si el dni cumple que tiene mas digitos pares que impares, y el tipo de evento que corresponde al numero de envento de la venta actual es igual a 3(corresponde a obra de teatro)
        //Incremento el contador
        if((cumpleDni(l^.dato.dniComprador)) and (vecEventos[l^.dato.numeroEvento].tipoEvento = 3))then
            contadorDni := contadorDni + 1;
        
        //Voy contando la cantidad de entradas que vendio el evento numero 50
        if(l^.dato.numeroEvento = 50)then
            acumuladorEvento50 := acumuladorEvento50 + l^.dato.cantidadEntradas;

        l := l^.sig;
    end;
    informarMinimos(recaudaciones, vecEventos); //Informo los minimos del vector de recaudaciones, envio tambien el vector de eventos para leer nombre y lugar del evento min

    //Informo incisoB
    writeln('La cantida de ventas de entradas a compradores cuyo dni tiene mas digitos pares que impares y el tipo de obra que compraron fue "Obra de teatro" es ', contadorDni);

    //Comparo el contador de entradas del evento numero 50, con la capacidad maxima de personas del evento 50
    if(acumuladorEvento50 >= vecEventos[50].cantidadMaximaPersonas)then
        writeln('El evento numero 50, lleno la capacidad total de personas') //Informo
    else
        writeln('El evento numero 50, no lleno la capacidad maxima de personas');// informo
end;

var
    listaVentas : lista;
    ventaActual : venta;
    eventos : vectorEventos;
begin
    listaVentas := nil;
    cargarVector(eventos); //Se dispone
    leerVenta(ventaActual);
    while(ventaActual.codigoVenta <> -1)do begin
        cargarVenta(ventaActual, listaVentas);
        leerVenta(ventaActual);
    end;
    procesarLista(listaVentas, eventos);
end.