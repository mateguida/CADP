{ 8. Una entidad bancaria de la ciudad de La Plata solicita realizar un programa destinado a la administración de
 transferencias de dinero entre cuentas bancarias, efectuadas entre los meses de Enero y Noviembre del año
 2018.
 El banco dispone de una lista de transferencias realizadas entre Enero y Noviembre del 2018. De cada
 transferencia se conoce: número de cuenta origen, DNI de titular de cuenta origen, número de cuenta destino, 
 DNI de titular de cuenta destino, fecha, hora, monto y el código del motivo de la transferencia (1:
 alquiler, 2: expensas, 3: facturas, 4: préstamo, 5: seguro, 6: honorarios y 7: varios). Esta estructura no posee
 orden alguno.
 Se pide:
 a) Generar una nueva estructura que contenga sólo las transferencias a terceros (son aquellas en las que
 las cuentas origen y destino no pertenecen al mismo titular). Esta nueva estructura debe estar
 ordenada por número de cuenta origen.
 Una vez generada la estructura del inciso a), utilizar dicha estructura para:
 b) Calcular e informar para cada cuenta de origen el monto total transferido a terceros.
 c) Calcular e informar cuál es el código de motivo que más transferencias a terceros tuvo.
 d) Calcular e informar la cantidad de transferencias a terceros realizadas en el mes de Junio en las cuales
 el número de cuenta destino posea menos dígitos pares que impares.}
program EjAdicionales8;
type
    fecha = record
        hora : real;
        dia : integer;
        mes : integer;
        ano : integer;
        end;

    vectorMotivos = array[1..7] of integer;

    transferencia = record
        numeroCuentaOrigen : integer;
        dniTitularCuentaOrigen : integer;
        numeroCuentaDestino : integer;
        dniTitularCuentaDestino : integer;
        fechayHora : fecha;
        monto : real;
        codigoMotivo : 1..7;
        end;

    lista = ^nodo;

    nodo = record
        dato : transferencia;
        sig : lista;
        end;

//Procedimiento que cargara una transferencia a una lista que entra por parametro
procedure cargarTransferencia(t : transferencia; var l : lista);
var
    nuevaTransferencia, posAnterior, posActual : lista;
begin
    New(nuevaTransferencia);
    nuevaTransferencia^.dato = t;
    posAnterior := l;
    posActual := l;
    while((posActual <> nil) and (t.numeroCuentaOrigen > posActual^.dato.numeroCuentaOrigen))do begin
        posAnterior := posActual;
        posActual := posActual^.sig;
    end;
    if(posActual = posAnterior)then
        l := nuevaTransferencia
    else 
        posAnterior^.sig := nuevaTransferencia;
    nuevaTransferencia^.sig := posActual;
end;

procedure cargarListaTerceros(l : lista; var lt : lista);
begin
    while(l <> nil)do begin
        if(l^.dato.dniTitularCuentaOrigen <> l^.dato.dniTitularCuentaDestino)then //Si los dni son distintos, los titulares son distintos
            cargarTransferencia(l^.dato, lt);
        l := l^.sig;
    end;
end;

//funcion que devolvera si el numero tiene mas digitos impares que pares
function cumple(num : integer) : Boolean; 
var
    contadorPares, contadorImpares, digito : Integer
begin
    contadorPares := 0;
    contadorImpares:= 0;
    while(num <> 0)do begin
        digito := num mod 10;
        if(digito mod 2 = 0)then
            contadorPares := contadorPares + 1
        else 
            contadorImpares := contadorImpares + 1;
        num := num div 10;
    end;
    if(contadorImpares > contadorPares)then
        cumple := True
    else
        cumple := false;
end;

procedure informarMotivoMax(v : vectorMotivos);
var
    posMax, max, i : integer;
    motivoMax : string;
begin
    posMax := 0;
    max := -1;
    for i := 1 to 7 do begin //Recorro el arreglo
        if(v[i] > max)then begin //Si el valor dentro del lugar i del vector es mayor al maximo anterior
            max := v[i]; //Actualizo el valor maximo
            posMax := i; //Recuerdo la posicion
        end;
    end;
    case posMax of //Dependiendo la posicion del vector, encontramos el motivo, y definimos en string para luego imprimir
    1: motivoMax := 'alquiler';
    2: motivoMax := 'expensas'; 
    3: motivoMax := 'facturas'; 
    4: motivoMax := 'préstamo'; 
    5: motivoMax := 'seguro';
    6: motivoMax := 'honorarios';
    7: motivoMax := 'varios';
    else motivoMax := 'Error';
    end;
    writeln;
    writeln('El motivo que mas transferencias tuvo fue ', motivoMax); //Informar
end;

//  b) Calcular e informar para cada cuenta de origen el monto total transferido a terceros.
//  c) Calcular e informar cuál es el código de motivo que más transferencias a terceros tuvo.
//  d) Calcular e informar la cantidad de transferencias a terceros realizadas en el mes de Junio en las cuales
//  el número de cuenta destino posea menos dígitos pares que impares.}
procedure procesarLista(l : lista);
var
    vecContador : vectorMotivos;
    contadorJunio, numeroCuentaOrigenActual : integer;
    acumuladorMonto : real;
begin
    contadorJunio := 0;
    numeroCuentaOrigenActual := 0;
    while(l <> Nil)do begin

        //Corte de control para acumular el monto de cada cuenta y cuando cambia de cuenta informe el monto final
        acumuladorMonto := 0;
        numeroCuentaOrigenActual := l^.dato.numeroCuentaOrigen;
        while((l <> Nil) and (l^.dato.numeroCuentaOrigen = numeroCuentaOrigenActual))do begin //Recordar siempre en while anidados trasladar las condiciones de los while exteriores
            acumuladorMonto := acumuladorMonto + l^.dato.monto;
        end;
        writeln;
        WriteLn('El monto total transferido a terceros de la cuenta ', l^.dato.numeroCuentaOrigen, ' es ', acumuladorMonto:2:2); //Informo

        //Voy contando la cantidad de transferencias por motivo // Inciso C
        vecContador[l^.dato.codigoMotivo] := vecContador[l^.dato.codigoMotivo] + 1;

        //Si el mes es junio, y cumple con la condicion de los digitos, aumenta el contador en 1
        if((l^.dato.fechayHora.mes = 6) and (cumple(l^.dato.numeroCuentaDestino)))then
            contadorJunio := contadorJunio + 1;

        l := l^.sig; //Paso al siguiente elemento de la lista
    end;
    writeln;
    writeln('La cantidad de transferencias realizadas en el mes de junio en las cuales el numero de cuenta posee mas digitos impares que pares es ', contadorJunio); //informo
    WriteLn;
    informarMotivoMax(vecContador); //Modularizacion para informar el inciso B
end;

var
    listaTransferencias, listaTransferenciasTerceros : lista;
begin
    listaTransferencias := nil;
    listaTransferenciasTerceros := nil;
    //CargarLista(listaTransferencias) se dispone
    cargarListaTerceros(listaTransferencias, listaTransferenciasTerceros);
    procesarLista(listaTransferenciasTerceros);
end.