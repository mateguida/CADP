{2. Implementar un programa que lea y almacene información de clientes de una empresa aseguradora
 automotriz. De cada cliente se lee: código de cliente, DNI, apellido, nombre, código de póliza contratada
 (1..6) y monto básico que abona mensualmente. La lectura finaliza cuando llega el cliente con código 1122,
 el cual debe procesarse.
 La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el cliente
 debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene contratada.
 Una vez finalizada la lectura de todos los clientes, se pide:
 a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente por su
 seguro automotriz (monto básico + monto adicional).
 b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.
 c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la
 estructura.}
 program EjAdicionales2;
 type
    cliente = record
        codigoCliente : integer;
        dni : integer;
        nomyApe : string;
        codigoPoliza : 1..6;
        montoMensual : real;
        end;

    lista = ^nodo;

    nodo = record
        dato : cliente;
        sig : lista;
        end;


//Procedimiento que leera datos del cliente por teclado y los guardara en el registro
procedure leerCliente(var c : cliente);
begin
    WriteLn('CARGANDO CLIENTE');
    Write('Codigo de cliente = ');
    ReadLn(c.codigoCliente);
    Write('DNI = ');
    ReadLn(c.dni);
    Write('Nombre y apellido : ');
    ReadLn(c.nomyApe);
    Write('Codigo de Poliza (Entre 1 y 6) = ');
    ReadLn(c.codigoPoliza);
    Write('Monto mensual = ');
    ReadLn(c.montoMensual);
    writeln;
end;

//Procedimiento que agregara clientes a la lista
procedure cargarCliente(c : cliente; var l : lista);
var
    nuevoCliente : lista;
begin
    New(nuevoCliente); //Agregar adelante
    nuevoCliente^.dato := c;
    nuevoCliente^.sig := l;
    l := nuevoCliente;
end;

//funcion que devolvera un numero real que corresponde a la suma del monto mensual base y al costo adicional de la poliza
function montoCompleto(codigo : integer; monto : real) : real;
begin
    case codigo of
        1: montoCompleto := monto + 1000;
        2: montoCompleto := monto + 2000;
        3: montoCompleto := monto + 3000;
        4: montoCompleto := monto + 4000;
        5: montoCompleto := monto + 5000;
        6: montoCompleto := monto + 6000;
        end;
end;

//Procedimiento que me informara todos los clientes y cuanto deben pagar sumando el costo adicional de la poliza
procedure informarPagos( l : lista);
begin
    writeln('INFORMANDO PAGOS');
    while(l <> nil)do begin
        writeln(l^.dato.dni);
        writeln(l^.dato.nomyApe);
        WriteLn('Monto a pagar = ', montoCompleto(l^.dato.codigoPoliza, l^.dato.montoMensual):2:2);
        writeln;
        l := l^.sig;
    end;
end;

//funcion que me devolvera un valor de verdad sobre si el dni que recibe por parametro tiene mas de 2 9
function cumpleNueves(dni : integer) : boolean;
var
    contadorNueves, digito : integer;
begin
    contadorNueves := 0;
    while(dni <> 0)do begin
        digito := dni mod 10;
        if(digito = 9)then
            contadorNueves := contadorNueves + 1;
        dni := dni div 10;
    end; 
    if(contadorNueves >= 2)then
        cumpleNueves := true
    else
        cumpleNueves := false;
end;

//Procedimiento que informara todos los clientes que tengan al menos 2 9 en el dni;
procedure informarClientesDosNueve(l : lista);
begin
    writeln('INFORMANDO CLIENTES CON DOS 9 EN EL DNI');
    while(l <> nil)do begin
        if(cumpleNueves(l^.dato.dni))then begin
            writeln(l^.dato.nomyApe);
            writeln(l^.dato.dni);
            writeln(l^.dato.codigoCliente);
            WriteLn;
        end;
        l := l^.sig;
    end;
end;

//Procedimiento que eliminara un cliente por su dni, que llega por parametro
procedure eliminarCliente(var l : lista; dni : integer);
var
    posAnterior , posActual, aux : lista;
    encontre : boolean;
begin
    posAnterior := l;
    posActual := l;
    encontre := false;
    while((posActual <> nil) and (encontre = false))do begin
        if(posActual^.dato.dni = dni)then
            encontre := True
        else begin
            posAnterior := posActual;
            posActual := posActual^.sig;
        end;
    end;
    if(encontre)then begin
        if(posActual = l)then begin
            aux := l;
            l := l^.sig;
            dispose(aux);
        end
        else begin
            posAnterior^.sig := posActual^.sig;
            Dispose(posActual);
        end;
    end
    else begin
        writeln('El cliente no esta en lista');
    end;
end;

var
    clienteActual : cliente;
    listaClientes : lista;
    dniAux : integer;
begin
    listaClientes := nil;
    repeat
        leerCliente(clienteActual);
        cargarCliente(clienteActual, listaClientes);
    until(clienteActual.codigoCliente = 1122);
    informarPagos(listaClientes);
    informarClientesDosNueve(listaClientes);
    writeln('Ingrese el dni del cliente que quiera eliminar = ');
    readln(dniAux);
    WriteLn;
    eliminarCliente(listaClientes, dniAux);
    informarPagos(listaClientes);
end.