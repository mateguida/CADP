{7.  El Programa Horizonte 2020 (H2020) de la Unión Europea ha publicado los criterios para financiar
 proyectos de investigación avanzada. Para los proyectos de sondas espaciales vistos en el ejercicio
 anterior, se han determinado los siguientes criterios:
 -  Sólo se financiarán proyectos cuyo costo de mantenimiento no supere el costo de construcción.
 -  No se financiarán proyectos espaciales que analicen ondas de radio, ya que esto puede realizarse desde la superficie terrestre con grandes antenas.
 A partir de la información disponible de las sondas espaciales (la lista generada en ejercicio 6), implementar un programa que:
 
 a. Invoque un módulo que reciba la información de una sonda espacial, y retorne si cumple o no con los nuevos criterios H2020.
 
 b. Utilizando el módulo desarrollado en a) implemente un módulo que procese la lista de sondas de
 la ESA y retorne dos listados, uno con los proyectos que cumplen con los nuevos criterios y otro
 con aquellos que no los cumplen.
 
 c. Invoque a un módulo quereciba una lista de proyectos de sondas espaciales e informe la cantidad
 y el costo total (construcción y mantenimiento) de los proyectos que no serán financiados por
 H2020. Para ello, utilice el módulo realizado en b}
program practicaListas7;
type
    //Creo el tipo "sonda"
    sonda = record
            nombre :string;
            mesesMision :integer;
            costoConstruccion : real;
            costoMantenimiento : real;
            espectroElectromagnetico : string;
            end;

    //Declaro lista con 2 componentes, una sonda y el puntero al siguiente nodo
    lista = ^nodo;
    
    nodo = record
           dato : sonda;
           sig : lista;
           end;

//Procedimiento que lee los datos de una sonda ingresados por teclado
procedure leerSonda(var s :sonda);
begin
    writeln('CARGANDO SONDA');
    write('Nombre : ');
    readln(s.nombre);
    write('Meses que toma la mision = ');
    readln(s.mesesMision);
    write('Costo de construcción = ');
    readln(s.costoConstruccion);
    write('Costo de mantenimiento = ');
    readln(s.costoMantenimiento);
    writeln('Espectro Electromagnetico a estudiar : ');
    write('1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma. : ');
    readln(s.espectroElectromagnetico);
end;

//Procedimiento que agrega nodos adelante y carga los datos de la sonda en el registro del puntero
procedure cargarSonda(var L : lista; s : sonda);
var
    nuevoNodo : lista;
begin
    new(nuevoNodo); //Creo nuevo nodo en memoria
    nuevoNodo^.dato := s;   //Le cargo la sonda ingresada
    nuevoNodo^.sig := L;    //Le referencio al puntero del nodo el siguiente elemento
    L := nuevoNodo; //Actualizo el primer puntero
end;

//Funcion que retorna un valor de verdad correspondiente a si la sonda cumple o no los parametros del 'H2020'
function cumpleParametrosH2020(s : sonda) : boolean;
var
    condicion1, condicion2 : boolean;
begin
    condicion1 := false;
    condicion2 := false;
    if(s.costoMantenimiento <= s.costoConstruccion) then
        condicion1 := true;
    if(s.espectroElectromagnetico <> 'Radio') then
        condicion2 := true;
    cumpleParametrosH2020 := (condicion1 and condicion2)
end;

//Procedimiento que generara 2 listas, una con las sondas que cumplan con los parametros del H2020 y otra con las sondas que no cumplan
procedure generarListas(l: lista; var cumplen, noCumplen: lista);
begin
    while(l <> nil) do begin
        if(cumpleParametrosH2020(l^.dato))then 
            cargarSonda(cumplen, l^.dato)
        else
            cargarSonda(noCumplen, l^.dato);
        l := l^.sig;
    end;
end;

//Procedimiento que calculara la cantidad de proyectos y el costo total de los mismos, en este caso, aquellos que no seran financiados
procedure procesarNoCumplen(l : lista);
var
    contadorProyectos : integer;
    acumuladorCosto : real;
begin
    contadorProyectos := 0;
    acumuladorCosto := 0;
    while(l <> nil)do begin
        acumuladorCosto := acumuladorCosto + (l^.dato.costoConstruccion+l^.dato.costoMantenimiento);
        contadorProyectos := contadorProyectos + 1;
        l := l^.sig;
    end;
    writeln;
    writeln('La cantidad de proyectos que no se financiaran son ', contadorProyectos, ' y tenian un costo total de ', acumuladorCosto:2:2,'USD');
    writeln;
end;

var
    listaSondas, listaSondasCumplen, listaSondasNoCumplen : lista;
    sondaActual : sonda;
begin
    listaSondas := nil;
    listaSondasNoCumplen := nil;
    listaSondasCumplen:= nil;
    //Leer sondas por teclado y guardarlas en la lista hasta que se ingrese 'Gaia' en el nombre de la sonda 
    repeat
        leerSonda(sondaActual);
        cargarSonda(listaSondas, sondaActual);
    until(sondaActual.nombre = 'Gaia');
    generarListas(listaSondas, listaSondasCumplen, listaSondasNoCumplen);
    procesarNoCumplen(listaSondasNoCumplen);
end.

