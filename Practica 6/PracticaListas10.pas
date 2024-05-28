{10. Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. Su
 funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un
 número (que es el siguiente al último número entregado). El cliente quedará esperando a ser llamado
 por su número, en cuyo caso sale de la lista de espera. Se pide:
 a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.
 b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de
 clientes en espera, asigna un número al cliente y retorna la lista de espera actualizada.
 c. Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera,
 y retorna el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe
 eliminarse de la lista de espera.
 d. Implementar un programa que simule la atención de los clientes. En dicho programa, primero
 llegarán todos los clientes juntos, se les dará un número de espera a cada uno de ellos, y luego se
 los atenderá de a uno por vez. El ingreso de clientes se realiza hasta que se lee el DNI 0, que no
 debe procesarse}
 
 program PracticaListas10;
 type
    //Inciso a
    fila = ^nodo;
    
    nodo = record
        dniCliente : integer;
        turno : integer;
        siguiente : fila;
        end;

//Procedimiento que recibira la fila de espera y un cliente y retornara la fila actualizada
//Inciso B
procedure recibirCliente(dniActual : integer; var filaEspera : fila; var ult : fila);
var
    nuevoCliente : fila;
begin
    new(nuevoCliente);
    nuevoCliente^.dniCliente := dniActual;
    if(filaEspera = nil)then begin
        filaEspera := nuevoCliente;
        nuevoCliente^.turno := 1;
        ult := nuevoCliente;
    end
    else begin
        ult^.siguiente := nuevoCliente; //Al anterior al ultimo lo apunto al nuevo elemento que se pondra atras
        nuevoCliente^.turno := ult^.turno + 1;  //Aumento uno el turno anterior
        ult := nuevoCliente; //puntero de ultimo apunta al nuevo ultimo elemento
    end;
end;

//Procedimiento que recibira la lista de espera y eliminara el primer cliente, despues de retornar el numero de turno y el dni
//del cliente
//Inciso C
procedure atenderCliente(var filaEspera : fila);
var
    puntAux : fila;
begin
    writeln('Turno del cliente con dni = ', filaEspera^.dniCliente, ' con turno ', filaEspera^.turno);//informo el turno y dni
    puntAux := filaEspera;
    filaEspera := filaEspera^.siguiente; //Paso al siguiente de la lista
    dispose(puntAux); //Libero memoria del primer cliente
end;

//Procedimiento que leera el dni del cliente y lo devolvera al programa modificado
procedure cargarDniCliente(var dni : integer);
begin
    write('Ingrese numero de dni : ');
    readln(dni);
end;

//Procedimiento que me imprimira la fila de espera
procedure imprimirFila(filaEspera : fila);
begin
    while(filaEspera <> nil) do begin
        writeln('Turno : ', filaEspera^.turno);
        writeln('Dni = ', filaEspera^.dniCliente);
        writeln;
        filaEspera := filaEspera^.siguiente;
    end;    
end;

var
    filaEspera, ultimoFila : fila;
    dniCliente : integer;
begin
    filaEspera := nil;
    ultimoFila := nil;
    cargarDniCliente(dniCliente);
    while(dniCliente <> 0)do begin
        recibirCliente(dniCliente, filaEspera, ultimoFila);
        cargarDniCliente(dniCliente);
    end;
    imprimirFila(filaEspera);
    while(filaEspera <> nil) do begin
        atenderCliente(filaEspera);
        writeln;
        imprimirFila(filaEspera);
    end;    
end.
