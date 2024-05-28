{13. El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte
 de los usuarios. Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal. De
 cada usuario se conoce su email, su rol (1: Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que
 participa y cantidad de días desde el último acceso.
 a. Imprimir el nombre de usuario y la cantidad de días desde el último acceso de todos los usuarios
 de la revista Económica. El listado debe ordenarse a partir de la cantidad de días desde el último
 acceso (orden ascendente).
 b. Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
 c. Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.}
program PracticaListas13;
const
    cantidadUsers = 5;
type
    lista = ^nodo;
    
    vecContadorUsuarios = array[1..4] of integer;
    
    listaC = ^nodoC;
    
    nodoC = record
        revista : string;
        usuarios : vecContadorUsuarios;
        sig : listaC;
        end;
    
    usuario = record
        mail : string;
        rol : string;
        revista : string;
        diasUltimoAcceso : integer;
        end;
    
    nodo = record
        dato : usuario;
        sig : lista;
        end;

//Procedimiento que leera usuarios ingresados por teclado
procedure leerUsuario(var u : usuario);
begin
    write('Ingrese mail : ');
    readln(u.mail);
    write('Ingrese rol : ');
    readln(u.rol);
    write('Ingrese revista : ');
    readln(u.revista);
    write('Ingrese dias desde el ultimo acceso : ');
    readln(u.diasUltimoAcceso);
end;

//Procedimiento que insertara los nodos de forma ascendente segun la cantidad de dias de ultima conexion
procedure insertarUsuario(var l : lista ; u : usuario);
var
    nuevoUsuario, posAnterior, posActual : lista; //Punteros Auxiliares
begin
    new(nuevoUsuario);
    nuevoUsuario^.dato := u;
    posAnterior:= l;
    posActual := l;
    while((posActual <> nil)and(u.diasUltimoAcceso > posActual^.dato.diasUltimoAcceso))do begin
        posAnterior := posActual;
        posActual := posActual^.sig; //Paso al siguiente
    end;
    if(posActual = posAnterior) then
        l := nuevoUsuario
    else
        posAnterior^.sig := nuevoUsuario;
    nuevoUsuario^.sig := posActual;
end;

//Procedimiento que imprimira usuario y dias del ultimo acceso de todos los usuarios que pertenezcan a la revista economica
procedure imprimirEconomica(l : lista);
begin
	writeln;
    writeln('USUARIOS DE LA REVISTA ECONOMICA');
    while(l <> nil)do begin
        if(l^.dato.revista = 'Economica')then begin
            writeln('Usuario : ', l^.dato.mail);
            writeln('Dias desde la ultima conexion = ', l^.dato.diasUltimoAcceso);
            writeln;
        end;
        l := l^.sig;
    end;
    writeln;
end;

//Procedimiento que informara la cantidad de usuarios de cada tipo para todas las revistas del sistemas
procedure informarUsuarios(l : lista);
var
    listaContador, aux, nuevaRevista : listaC;
    encontre : boolean;
begin
    listaContador := nil;
    encontre := false;
    while(l <> nil) do begin
		aux := listaContador;
        while((aux <> nil) and (encontre = false))do begin
            //Busco la revista actual dentro de la lista contadora
            if(aux^.revista = l^.dato.revista)then
				encontre := true
			else
				aux := aux^.sig;
        end;
        if(encontre = false) then begin //No esta la revista en la lista contadora
            new(nuevaRevista);
            nuevaRevista^.revista := l^.dato.revista;
            nuevaRevista^.sig := listaContador;
            listaContador := nuevaRevista; //Agrego la revista a la lista
            case l^.dato.rol of //Agrego el usuario del nodo al contador de usuarios
            'Editor' : nuevaRevista^.usuarios[1] := nuevaRevista^.usuarios[1] + 1;
            'Autor' : nuevaRevista^.usuarios[2] := nuevaRevista^.usuarios[2] + 1;
            'Revisor' : nuevaRevista^.usuarios[3] := nuevaRevista^.usuarios[3] + 1;
            'Lector' : nuevaRevista^.usuarios[4] := nuevaRevista^.usuarios[4] + 1;
            end;
        end
        else begin //Si esta la revista en la lista contadora
            case l^.dato.rol of //Agrego el usuario del nodo al contador de usuarios
            'Editor' : aux^.usuarios[1] := aux^.usuarios[1] + 1;
            'Autor' : aux^.usuarios[2] := aux^.usuarios[2] + 1;
            'Revisor' : aux^.usuarios[3] := aux^.usuarios[3] + 1;
            'Lector' : aux^.usuarios[4] := aux^.usuarios[4] + 1;
            end;
        end;
        l := l^.sig;
    end;
    while(listaContador <> nil) do begin //Imprimo los usuarios para todos los tipos de revistas que hay
        writeln('Usuarios de la revista ', listaContador^.revista);
        writeln('Editores = ', listaContador^.usuarios[1]);
        writeln('Autores = ', listaContador^.usuarios[2]);
        writeln('Revisores = ', listaContador^.usuarios[3]);
        writeln('Lectores = ', listaContador^.usuarios[4]);
        writeln;
        listaContador := listaContador^.sig;
    end;
end;

//procedimiento que informara el mail de los 2 usuarios que hace mas tiempo que no ingresan a la plataforma
procedure masInactivos(l : lista);
var 
    diasMasInactivo, diasSegMasInactivo : integer;
    mailMasInactivo, mailSegMasInactivo : string;
begin
    diasSegMasInactivo := -1;
    diasMasInactivo := -1;
    while(l <> nil)do begin
        if(l^.dato.diasUltimoAcceso > diasMasInactivo)then begin
            diasSegMasInactivo := diasMasInactivo;
            mailSegMasInactivo := mailMasInactivo;
            diasMasInactivo := l^.dato.diasUltimoAcceso;
            mailMasInactivo := l^.dato.mail;
            end
        else begin
            if(l^.dato.diasUltimoAcceso > diasSegMasInactivo)then begin
                diasSegMasInactivo := l^.dato.diasUltimoAcceso;
                mailSegMasInactivo := l^.dato.mail;
            end;
        end;
    end;
    writeln;
    writeln('El usuario mas inactivo tiene como mail ', mailMasInactivo, ' y no se conecta hace ', diasMasInactivo);
    writeln('El segundo usuario mas inactivo tiene como mail ', mailSegMasInactivo, ' y no se conecta hace ', diasSegMasInactivo);
end;

var
    i : integer;
    listaUsuarios : lista;
    usuarioActual : usuario;
begin
    listaUsuarios := nil;
    for i := 1 to cantidadUsers do begin
        leerUsuario(usuarioActual);
        insertarUsuario(listaUsuarios, usuarioActual);
    end;
    
    imprimirEconomica(listaUsuarios);
    informarUsuarios(listaUsuarios);
    
end.
