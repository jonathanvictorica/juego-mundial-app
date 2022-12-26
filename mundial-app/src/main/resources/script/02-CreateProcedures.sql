

create procedure crearpartida(in nombrepartida varchar(50),out mensaje varchar(50))
begin
   if((select count(*) from partida where nombrejugador = nombrepartida) = 0) then
     insert into partida(nombrejugador,estado) values (nombrepartida,"en juego");
	 set mensaje = "la partida se ha iniciado con exito. suerte";
else
     set mensaje = (select concat("el jugador ",nombrepartida," ya existe"));
end if;

end$$

create procedure eliminarpartida(in nombrepartida varchar(50),out mensaje varchar(50))
begin
    declare codigopar int;
   if((select count(*) from partida where nombrejugador = nombrepartida) <> 0) then
     set codigopar = (select codigopartida from partida where nombrejugador = nombrepartida);
delete from partidacombo where codigopar = codigopartida;
delete from partidafiguritas where codigopar = codigopartida;

delete from partida where codigopar =  codigopartida;
set mensaje = "la partida se ha eliminado completamente";
else
     set mensaje = (select concat("el jugador ",nombrepartida," no existe"));
end if;

end$$

create procedure ganarfigurita( in nombre_figurita varchar(50),in codigo_partida int,out mensaje varchar(70))
begin

     declare codigo_figurita int;

	 set codigo_figurita = (select codigofigurita from figuritas where nombrejugador = nombre_figurita);
     if((select count(*) from partidafiguritas where codigo_partida=codigopartida and codigofigurita=codigo_figurita) =0 )then
		      insert into partidafiguritas values(codigo_partida,codigo_figurita);
	          set mensaje = "nueva figurita en tu album";
else
			   insert into figuritasrepetidas(codigopartida,codigofigurita) values(codigo_partida,codigo_figurita);
	           set mensaje = ("tenes una nueva figurita repetida, aprovecha y canjeala por otra");
end if;


end$$


create procedure ganarcombo(in nombre_combo varchar(50),in codigo_partida int,out mensaje varchar(150))
begin

   declare done bool default false;
   declare codigo_combo int;
   declare codigo_figurita int;

   declare figurit cursor for select figuritascombo.codigofigurita from combos,figuritascombo where combos.codigocombo=figuritascombo.codigocombo
                                                                                                and  combos.nombrecombo = nombre_combo;
declare continue handler for not found set done = true;


open figurit;
read_loop: loop

		           fetch figurit into codigo_figurita;
		       if done then
					  leave read_loop;
end if;

				   if((select count(*) from partidafiguritas where codigopartida=codigo_partida and codigofigurita=codigo_figurita) =0 )then
					  insert into partidafiguritas values(codigo_partida,codigo_figurita);
else
					   insert into figuritasrepetidas(codigopartida,codigofigurita) values(codigo_partida,codigo_figurita);
end if;


end loop;
close figurit;
set codigo_combo = (select codigocombo from combos where nombrecombo = nombre_combo);
insert into partidacombo values(codigo_partida,codigo_combo);
set mensaje = "felicitaciones ganó el combo";


end$$

create procedure canjear(in codigo_partida int,nombre_jugador_rep varchar(50),nombre_jugador_can varchar(50),out mensaje varchar(120))
begin

    declare codigo_fig_canje int;
	declare codigo_fig_rep int;
	declare dificultad_canje varchar(20);
	declare dificultad_rep varchar(20);
    set mensaje = "esta figurita no la tiene en su coleccion de figuritas repetidas";
	set codigo_fig_rep =(select distinct figuritas.codigofigurita from figuritas,figuritasrepetidas where figuritasrepetidas.codigopartida=codigo_partida and figuritasrepetidas.codigofigurita = figuritas.codigofigurita and figuritas.nombrejugador=nombre_jugador_rep);

    if((select count(*) from figuritasrepetidas where codigofigurita=codigo_fig_rep)<>0) then
	           set codigo_fig_canje =(select distinct codigofigurita from figuritas where figuritas.nombrejugador=nombre_jugador_can);

			   set dificultad_rep = (select dificultad from figuritas where codigofigurita=codigo_fig_rep);
	           set dificultad_canje = (select dificultad from figuritas where codigofigurita=codigo_fig_canje);

			   if(dificultad_rep=dificultad_canje) then

delete from figuritasrepetidas where codigofigurita = codigo_fig_rep and codigopartida=codigo_partida;
if((select count(*) from partidafiguritas where codigopartida=codigo_partida and codigofigurita=codigo_fig_canje) =0 )then
					  insert into partidafiguritas values(codigo_partida,codigo_fig_canje);
					 set mensaje = "felicitaciones. magnifico canje. su album tiene una nueva figurita";
else
					   insert into figuritasrepetidas(codigopartida,codigofigurita) values(codigo_partida,codigo_fig_canje);
					   set mensaje = "felicitaciones. ha canjeado una nueva figurita por otra que ya tiene repetida.";
end if;
else
			    set mensaje = "estas figurita no tienen el mismo nivel de dificultad de conseguirlas, para canjearlas.";

end if;

end if;

end$$


