{5.  Realizar un programa que lea y almacene la información de productos de un supermercado. De cada
 producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se
 ingresa el código-1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular
 e informar:
 a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
 b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
 c. Código delos dos productos más económicos.}
 
 program PracticaListas5;
 type
    //Declaro el tipo producto
    producto  = record
                codigo : integer;
                descripcion : string;
                stockActual : integer;
                stockMinimo : integer;
                precio : real;
                end;
    
    //Declaro la lista y los campos de la misma
    lista = ^nodo;
    
    nodo  = record
            dato : producto;
            sig : lista;
            end;

//Procedimiento que lee los datos del producto ingresado por teclado
procedure leerProducto(var p : producto);
begin
    writeln('Cargando Producto');
    write('Ingrese codigo = ');
    readln(p.codigo);
    if(p.codigo <> -1)then begin
        write('Ingrese descripción : ');
        readln(p.descripcion);
        write('Ingrese stock actual = ');
        readln(p.stockActual);
        write('Ingrese stock minimo = ');
        readln(p.stockMinimo);
        write('Ingrese precio = ');
        readln(p.precio);
    end;
end;

//Procedimiento que cargara los productos por delante en la lista
procedure cargarProducto(var L : lista; p : producto);
var
    nuevoNodo : lista;
begin
    new(nuevoNodo); //Creo el nodo en memoria
    nuevoNodo^.dato := p;   //Guardo el dato ingresado en el nodo
    nuevoNodo^.sig := L;    //Hago que el nuevo nodo apunte al nodo inicial previo
    L := nuevoNodo; //Actualizo el puntero inicial para poder referenciar al primer dato
end;

//Funcion que devuelve el porcentaje de elementos con stock actual menor que el stock minimo
function porcentajeStock(L : lista) : real;
var
    acumuladorproductos, productosMenorStock : integer;
begin
    acumuladorproductos := 0;
    productosMenorStock := 0;
    while(L <> nil) do begin
        if(L^.dato.stockActual < L^.dato.stockMinimo)then
            productosMenorStock := productosMenorStock + 1;
        acumuladorproductos := acumuladorproductos + 1; //Cuento la cantidad de productos de la lista
        L := L^.sig;
    end;
    
    porcentajeStock := (productosMenorStock/acumuladorproductos);
end;

//Funcion que devuelve un booleano respecto si el numero ingresado tiene al menos 3 digitos pares
function digitosPares(num : integer) : boolean;
var
    contadorDigitosPares,digito : integer;
begin
    contadorDigitosPares := 0;
    digito := num mod 10;
    while(digito <> 0) do begin
        if(digito mod 2 = 0)then
            contadorDigitosPares := contadorDigitosPares + 1;
        num := num div 10;
        digito := num mod 10;
    end;
    digitosPares := (contadorDigitosPares >= 3);
end;

//Procedimiento que imprimira las descripciones de los productos que tengan al menos 3 digitos pares en el codigo
//Inciso B
procedure imprimirDescripciones(L : lista);
begin
    while(L <> nil)do begin
        if(digitosPares(L^.dato.codigo))then begin //Check de que el codigo tenga 3 nuemeros pares
            writeln('Producto con digitos pares : ', L^.dato.descripcion);   //Si tiene 3 numeros pares, se imprime la descripcion
        end;
        L := L^.sig;
    end;
end;

//Procedimiento que busca los elementos mas baratos e imprime los codigos de los mismos
//Inciso C
procedure imprimirMinimos(L : lista);
var
    codMin1, codMin2 : integer;
    precioMin1 , precioMin2 : real;
begin
    precioMin2 := 9999;
    precioMin1 := 9999;
    codMin1 := 0;
    codMin2 := 0;
    while (L <> nil) do begin
        if(L^.dato.precio < precioMin1)then begin
            //Actualizo el minimo 2 ya que el minimo 1 fue reemplazado por otro valor
            codMin2 := codMin1;
            precioMin2 := precioMin1;
            //Actualizo el minimo 1 
            codMin1 := L^.dato.codigo;
            precioMin1 := L^.dato.codigo;
            end
        else begin
            //Si el dato no es menor que minimo 1, puede ser menor que minimo 2, por eso contemplo esta posibilidad
            if(L^.dato.precio < precioMin2)then begin
                codMin2 := L^.dato.codigo; //Actualizo minimo 2
                precioMin2 := L^.dato.precio;
            end;
            
        end;
        L := L^.sig;
    end;
    //Imprimo los minimos
    writeln('Producto mas barato = Codigo ', codMin1);
    writeln('Segundo producto mas barato = Codigo ', codMin2);
end;

var
    listaProductos : lista;
    prodIngresado : producto;
begin
    //Inicializo la lista
    listaProductos := nil;
    leerProducto(prodIngresado);  //Leo producto inicial para si el codigo es -1 no entra al while
    while(prodIngresado.codigo <> -1)do begin  //Cargo Condicion de corte
        cargarProducto(listaProductos, prodIngresado); //Cargo producto
        leerProducto(prodIngresado);    //Leo nuevo producto
    end;
    
    //Comienzo a procesar para informar
    //Inciso A
    writeln('El porcentaje de productos con stock actual menor al stock minimo es ', porcentajeStock(listaProductos):2:2, '%');
    imprimirDescripciones(listaProductos);
    imprimirMinimos(listaProductos);
end.