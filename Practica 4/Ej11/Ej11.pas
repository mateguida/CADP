Program P4E11;
const
	tam = 5;
type
	post = record
		titulo :string;
		autor : string;
		cantlikes : integer;
		cantclicks : integer;
		cantcomentarios : integer;
		end;
	
	posts = array[1..tam]of post;
	
procedure leerPost(var p : post);
begin
	writeln;
	writeln('CARGANDO POST');
	write('Titulo : ');
	readln(p.titulo);
	write('Autor : ');
	readln(p.autor);
	write('Cantidad de likes = ');
	readln(p.cantlikes);
	write('Cantidad de clicks = ');
	readln(p.cantclicks);
	write('Cantidad de comentarios = ');
	readln(p.cantcomentarios);
	
end;

procedure actualizarFotoMasVista(publis : posts; var titulomasvisto : string);
var
	max,i: integer;
begin
	max := -1;
	for i := 1 to tam do
		begin
			if(publis[i].cantclicks > max)then
				titulomasvisto := publis[i].titulo;
				max := publis[i].cantclicks;
		end;
end;

function ArtVandelay(publis : posts) : integer;
var
	acumuladorlikes, i : integer;
begin
	acumuladorlikes := 0;
	for i := 1 to tam do
		begin
			if(publis[i].autor = 'Art Vandelay')then
				acumuladorlikes := acumuladorlikes + publis[i].cantlikes;
		end;
	ArtVandelay := acumuladorlikes;
end;

function contarComentarios(publis : posts):integer;
var
	acumuladorcomentarios,i: integer;
begin
	acumuladorcomentarios := 0;
	for i:= 1 to tam do
		begin
			acumuladorcomentarios := acumuladorcomentarios + publis[i].cantcomentarios;
		end;
	contarComentarios := acumuladorcomentarios;
end;

var
	titulomasvisto : string;
	publicaciones : posts;
	i:integer;
begin
	titulomasvisto := '';
	for i := 1 to tam do
		begin
			leerPost(publicaciones[i])
		end;
	actualizarFotoMasVista(publicaciones, titulomasvisto);
	writeln('La foto mas vista tiene como titulo : "', titulomasvisto,'" ');
	writeln('La cantidad total de likes de todas las fotos de "Art Vandelay" es = ', ArtVandelay(publicaciones));
	writeln('La cantidad de comentarios que recibieron todos los post de la pagina fue = ', contarComentarios(publicaciones));
end.
