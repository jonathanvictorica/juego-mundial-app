SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE DATABASE IF NOT EXISTS `mundial` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `mundial`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CANJEAR`(in codigo_partida int,nombre_jugador_rep varchar(50),nombre_jugador_can varchar(50),out mensaje varchar(120))
begin

    DECLARE codigo_fig_canje INT;
	DECLARE codigo_fig_rep INT;
	DECLARE dificultad_canje varchar(20);
	DECLARE dificultad_rep varchar(20);
    set mensaje = "Esta figurita no la tiene en su coleccion de figuritas repetidas";
	set codigo_fig_rep =(select distinct FIGURITAS.codigofigurita from FIGURITAS,FIGURITASREPETIDAS WHERE FIGURITASREPETIDAS.codigopartida=codigo_partida and FIGURITASREPETIDAS.codigofigurita = FIGURITAS.codigofigurita AND FIGURITAS.nombrejugador=nombre_jugador_rep);
 
    if((select count(*) from FIGURITASREPETIDAS where codigofigurita=codigo_fig_rep)<>0) then
	           set codigo_fig_canje =(select distinct codigofigurita from FIGURITAS WHERE FIGURITAS.nombrejugador=nombre_jugador_can);
    
			   set dificultad_rep = (select dificultad from FIGURITAS WHERE CODIGOFIGURITA=codigo_fig_rep);
	           set dificultad_canje = (select dificultad from FIGURITAS WHERE CODIGOFIGURITA=codigo_fig_canje);
	            
			   if(dificultad_rep=dificultad_canje) then
			     
	               delete from FIGURITASREPETIDAS where codigofigurita = codigo_fig_rep AND codigopartida=codigo_partida;
				   if((select count(*) from PARTIDAFIGURITAS where codigopartida=codigo_partida and codigofigurita=codigo_fig_canje) =0 )then
					  insert into partidafiguritas values(codigo_partida,codigo_fig_canje);
					 set mensaje = "Felicitaciones. Magnifico canje. Su album tiene una nueva figurita";
					else
					   insert into FIGURITASREPETIDAS(codigopartida,codigofigurita) values(codigo_partida,codigo_fig_canje);
					   set mensaje = "Felicitaciones. Ha canjeado una nueva figurita por otra que ya tiene repetida.";
					end if;
			   else
			    set mensaje = "Estas figurita no tienen el mismo nivel de dificultad de conseguirlas, para canjearlas.";
	
			   end if;
	    
	end if;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CREARPARTIDA`(IN nombrepartida varchar(50),out mensaje varchar(50))
begin
   if((select count(*) from partida where nombrejugador = nombrepartida) = 0) then
     insert into partida(nombrejugador,estado) values (nombrepartida,"en juego");
	 set mensaje = "La partida se ha iniciado con exito. Suerte";
   else
     set mensaje = (select concat("El jugador ",nombrepartida," ya existe"));
    end if;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINARPARTIDA`(IN nombrepartida varchar(50),out mensaje varchar(50))
begin
    DECLARE codigopar int;
   if((select count(*) from partida where nombrejugador = nombrepartida) <> 0) then
     set codigopar = (select codigopartida from partida where nombrejugador = nombrepartida);
	 delete from PARTIDACOMBO where codigopar = codigopartida;
	 delete from PARTIDAFIGURITAS where codigopar = codigopartida;
	
	 delete from PARTIDA WHERE codigopar =  codigopartida;
	 set mensaje = "La partida se ha eliminado completamente";
   else
     set mensaje = (select concat("El jugador ",nombrepartida," no existe"));
    end if;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GANARCOMBO`(in nombre_combo varchar(50),in codigo_partida int,out mensaje varchar(150))
begin
 
   DECLARE DONE BOOL DEFAULT FALSE;
   DECLARE codigo_combo int;
   DECLARE codigo_figurita int;

   DECLARE figurit CURSOR FOR SELECT FIGURITASCOMBO.codigofigurita FROM COMBOS,FIGURITASCOMBO WHERE COMBOS.codigocombo=FIGURITASCOMBO.codigocombo
   and  COMBOS.nombrecombo = nombre_combo;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
   
		   OPEN figurit;
		   read_loop: LOOP
		   
		           FETCH figurit INTO codigo_figurita;
		       IF done THEN
					  LEAVE read_loop;
					END IF;
				   
				   if((select count(*) from PARTIDAFIGURITAS where codigopartida=codigo_partida and codigofigurita=codigo_figurita) =0 )then
					  insert into partidafiguritas values(codigo_partida,codigo_figurita);
					else
					   insert into FIGURITASREPETIDAS(codigopartida,codigofigurita) values(codigo_partida,codigo_figurita);
					end if;
				
				 
		   END LOOP;
		   CLOSE figurit;
		   set codigo_combo = (select codigocombo from combos where nombrecombo = nombre_combo);
		   insert into PARTIDACOMBO VALUES(codigo_partida,codigo_combo);
	       set mensaje = "Felicitaciones ganó el combo";
	
	
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GANARFIGURITA`( in nombre_figurita varchar(50),in codigo_partida int,OUT mensaje varchar(70))
begin

     declare codigo_figurita int;
	 
	 set codigo_figurita = (select codigofigurita from FIGURITAS where nombrejugador = nombre_figurita);
     IF((select count(*) from PARTIDAFIGURITAS where codigo_partida=codigopartida and codigofigurita=codigo_figurita) =0 )then
		      insert into partidafiguritas values(codigo_partida,codigo_figurita);
	          set mensaje = "Nueva figurita en tu album";
	else
			   insert into FIGURITASREPETIDAS(codigopartida,codigofigurita) values(codigo_partida,codigo_figurita);
	           set mensaje = ("Tenes una nueva figurita repetida, aprovecha y canjeala por otra");
	end if;


end$$

DELIMITER ;

CREATE TABLE IF NOT EXISTS `albumpais` (
  `codigoalbum` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_pais` varchar(50) DEFAULT NULL,
  `nacionalidad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigoalbum`),
  UNIQUE KEY `nombre_pais` (`nombre_pais`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

INSERT INTO `albumpais` (`codigoalbum`, `nombre_pais`, `nacionalidad`) VALUES(1, 'Argentina', 'Argentino');
INSERT INTO `albumpais` (`codigoalbum`, `nombre_pais`, `nacionalidad`) VALUES(2, 'Nigeria', 'Nigeriano');
INSERT INTO `albumpais` (`codigoalbum`, `nombre_pais`, `nacionalidad`) VALUES(3, 'Bosnia', 'Bosnia');
INSERT INTO `albumpais` (`codigoalbum`, `nombre_pais`, `nacionalidad`) VALUES(4, 'Iran', 'Irani');
CREATE TABLE IF NOT EXISTS `combofigu` (
`CCODIGO` int(11)
,`CNOMBRE` varchar(50)
,`CDIFICULTAD` varchar(20)
,`CIMAGEN` varchar(50)
,`ACODIGO` int(11)
,`APAIS` varchar(50)
,`ANACIONALIDAD` varchar(50)
,`FJUGADOR` varchar(50)
,`FIMAGEN` varchar(50)
,`FDIFICULTAD` varchar(20)
);
CREATE TABLE IF NOT EXISTS `combos` (
  `codigocombo` int(11) NOT NULL AUTO_INCREMENT,
  `nombrecombo` varchar(50) DEFAULT NULL,
  `dificultadcombo` varchar(20) DEFAULT NULL,
  `imagencombo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigocombo`),
  UNIQUE KEY `nombrecombo` (`nombrecombo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(1, 'Super Argentina', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(2, 'Argentina Alpha', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(3, 'Argentina Beta', 'Facil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(4, 'Super Nigeria', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(5, 'Nigeria Alpha', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(6, 'Nigeria Beta', 'Facil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(7, 'Super Bosnia', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(8, 'Bosnia Alpha', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(9, 'Bosnia Beta', 'Facil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(10, 'Super Iran', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(11, 'Iran Alpha', 'Dificil', 'nin');
INSERT INTO `combos` (`codigocombo`, `nombrecombo`, `dificultadcombo`, `imagencombo`) VALUES(12, 'Iran Beta', 'Facil', 'nin');

CREATE TABLE IF NOT EXISTS `figuritas` (
  `codigofigurita` int(11) NOT NULL AUTO_INCREMENT,
  `codigoalbum` int(11) DEFAULT NULL,
  `pose` int(11) DEFAULT NULL,
  `nombrejugador` varchar(50) DEFAULT NULL,
  `posicion` varchar(50) DEFAULT NULL,
  `direccionimagen` varchar(50) DEFAULT NULL,
  `dificultad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigofigurita`),
  UNIQUE KEY `codigoalbum` (`codigoalbum`,`nombrejugador`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=73 ;

INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(1, 1, 2, 'Sergio Romero', 'Portero', 'sergioromero', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(2, 1, 3, 'Ever Vanega', 'Centrocampista', 'evervanega', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(3, 1, 4, 'Ezequiel Garay', 'Defensa', 'ezequielgaray', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(4, 1, 5, 'Hugo Campagnaro', 'Defensa', 'hugocampagnaro', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(5, 1, 6, 'Pablo Zabaleta', 'Defensa', 'pablozabaleta', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(6, 1, 7, 'Fernando Gago', 'Centrocampista', 'fernandogago', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(7, 1, 8, 'Lucas Biglia', 'Centrocampista', 'lucasbigilia', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(8, 1, 9, 'Ángel Di María', 'Centrocampista', 'angeldimaria', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(9, 1, 10, 'Gonzalo Higuaín', 'Delantero', 'gonzalohiguain', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(10, 1, 11, 'Lionel Messi', 'Delantero', 'lionelmessi', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(11, 1, 12, 'Maximiliano Rodríguez', 'Centrocampista', 'maxirodriguez', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(12, 1, 13, 'Javier Mascherano', 'Centrocampista', 'javiermascherano', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(13, 1, 14, 'Marcos Rojo', 'Defensa', 'marcosrojo', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(14, 1, 15, 'Federico Fernández', 'Defensa', 'federicofernandez', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(15, 1, 16, 'Rodrigo Palacio', 'Delantero', 'rodrigopalacio', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(16, 1, 17, 'Sergio Agüero', 'Delantero', 'sergioaguero', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(17, 1, 18, 'Ezequiel Lavezzi', 'Delantero', 'ezequiellavezzi', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(18, 1, 1, 'Equipo Argentino', 'Equipo Argentino', 'equipoargentina', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(19, 2, 1, 'Equipo Bosnia', 'Equipo Bosnia', 'equipobosnia', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(20, 2, 2, 'Asmir Begovic', 'Portero', 'asmirbegovic', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(21, 2, 3, 'Emir Spahic', 'Defensa', 'emirspahic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(22, 2, 4, 'Avdija Vr?ajevic', 'Defensa', 'avdijavrsajevic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(23, 2, 5, 'Ermin Bicakcic', 'Defensa', 'emirbicakcic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(24, 2, 6, 'Toni ?unjic', 'Defensa', 'tonisunjic', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(25, 2, 7, 'Sead Kola?inac', 'Defensa', 'seadkolasinac', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(26, 2, 8, 'Senad Lulic', 'Centrocampista', 'senadlulic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(27, 2, 9, 'Senijad Ibricic', 'Centrocampista', 'senijadibricic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(28, 2, 10, 'Mensur Mujd?a', 'Centrocampista', 'mensurmujdza', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(29, 2, 11, 'Haris Medunjanin', 'Centrocampista', 'harismedunjanin', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(30, 2, 12, 'Zvjezdan Misimovic', 'Centrocampista', 'zvjezdanmisimovic', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(31, 2, 13, 'Miralem Pjanic', 'Centrocampista', 'miralempjanic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(32, 2, 14, 'Sejad Salihovic', 'Centrocampista', 'sejadsalihovic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(33, 2, 15, 'Adnan Zahirovic', 'Centrocampista', 'adnanzahirovic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(34, 2, 16, 'Izet Hajrovic', 'Centrocampista', 'izethajrovic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(35, 2, 17, 'Vedad Ibi?evic', 'Delantero', 'vedadibisevic', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(36, 2, 18, 'Edin Dzeko', 'Delantero', 'edindzeko', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(37, 3, 1, 'Equipo Iran', 'Equipo Iran', 'equipoiran', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(38, 3, 2, 'Daniel Davari', 'Portero', 'danieldavari', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(39, 3, 3, 'Jalal Hosseini', 'Defensa', 'jalalhosseini', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(40, 3, 4, 'Khosro Heydari', 'Delantero', 'khosroheydari', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(41, 3, 5, 'Hossein Mahini', 'Defensa', 'hosseinmahini', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(42, 3, 6, 'Pejman Montazeri', 'Defensa', 'pejmanmontazeri', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(43, 3, 7, 'Ehsan Hajsafi', 'Centrocampista', 'ehsanhajsafi', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(44, 3, 8, 'Hashem Beikzadeh', 'Defensa', 'hashembeikzadeh', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(45, 3, 9, 'Amir Sadeghi', 'Defensa', 'amirhosseinsadeghi', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(46, 3, 10, 'Javad Nekounam', 'Centrocampista', 'javadnekounam', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(47, 3, 11, 'Andranik Teymourian', 'Centrocampista', 'andranikteymourian', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(48, 3, 12, 'Mojtaba Jabbari', 'Delantero', 'mojtabajabbari', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(49, 3, 13, 'Masoud Shojaei', 'Delantero', 'masoudshojaei', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(50, 3, 14, 'Ashkan Dejagah', 'Delantero', 'ashkandejagah', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(51, 3, 15, 'Reza Ghoochannejhad', 'Delantero', 'rezagroochannejhad', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(52, 3, 16, 'Grolamreza Rezaei', 'Delantero', 'grolamrezarezaei', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(53, 3, 17, 'Karim Ansarifard', 'Delantero', 'karimansarifard', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(54, 3, 18, 'Mohammad Khalatbari', 'Delantero', 'mohammadkhalatbari', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(55, 4, 1, 'Equipo Nigeria', 'Equipo Nigeria', 'equiponigeria', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(56, 4, 2, 'Vincent Enyeama', 'Portero', 'vincentenyeama', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(57, 4, 3, 'Joseph Yobo', 'Defensa', 'josephyobo', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(58, 4, 4, 'Efe Ambrose', 'Defensa', 'efeambrose', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(59, 4, 5, 'Godfrey Oboabona', 'Defensa', 'godfreyoboabona', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(60, 4, 6, 'Azubuike Egwuekwe', 'Defensa', 'azubuikeegwuekwe', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(61, 4, 7, 'Kenneth Omeruo', 'Defensa', 'kennethomeruo', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(62, 4, 8, 'John Ogu', 'N/C', 'johnogu', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(63, 4, 9, 'Ogenyi Onazi', 'Centrocampista', 'ogenyionazi', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(64, 4, 10, 'Sunday Mba', 'N/C', 'sundaymba', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(65, 4, 11, 'Victor Moses', 'Delantero', 'victormoses', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(66, 4, 12, 'Nnamdi Oduamadi', 'Delantero', 'nnamdioduamadi', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(67, 4, 13, 'Ahmed Musa', 'Delantero', 'ahmedmusa', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(68, 4, 14, 'Ideye Brown ', 'N/C', 'ideyebrown', 'Facil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(69, 4, 15, 'Shola Ameobi', 'Delantero', 'sholaameobi', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(70, 4, 16, 'Emmanuel Emenike', 'Delantero', 'emmanuelemenike', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(71, 4, 17, 'Elderson Echiéjilé', 'Defensa', 'eldersonechiejile', 'Dificil');
INSERT INTO `figuritas` (`codigofigurita`, `codigoalbum`, `pose`, `nombrejugador`, `posicion`, `direccionimagen`, `dificultad`) VALUES(72, 4, 18, 'Mikel John Obi', 'N/C', 'mikeljohnobi', 'Dificil');

CREATE TABLE IF NOT EXISTS `figuritascombo` (
  `codigocombo` int(11) NOT NULL DEFAULT '0',
  `codigofigurita` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codigocombo`,`codigofigurita`),
  KEY `codigofigurita` (`codigofigurita`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(2, 7);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(3, 7);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(2, 8);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(3, 8);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(2, 9);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(3, 9);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(3, 10);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(3, 11);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(3, 12);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(1, 13);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(2, 13);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(1, 14);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(2, 14);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(1, 15);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(2, 15);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(1, 16);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(1, 17);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(1, 18);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(4, 19);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(4, 20);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(4, 21);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(4, 22);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(6, 22);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(4, 23);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(6, 23);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(4, 24);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(6, 24);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(5, 25);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(6, 25);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(5, 26);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(6, 26);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(5, 27);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(6, 27);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(5, 28);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(5, 29);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(5, 30);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(7, 37);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(7, 38);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(9, 38);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(7, 39);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(7, 40);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(7, 41);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(7, 42);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(8, 43);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(8, 44);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(8, 45);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(8, 46);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(8, 47);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(8, 48);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(9, 49);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(9, 50);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(9, 51);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(9, 52);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(9, 53);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(10, 55);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(10, 56);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(10, 57);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(10, 58);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(10, 59);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(10, 60);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(11, 61);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(11, 62);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(11, 63);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(11, 64);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(11, 65);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(11, 66);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(12, 67);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(12, 68);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(12, 69);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(12, 70);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(12, 71);
INSERT INTO `figuritascombo` (`codigocombo`, `codigofigurita`) VALUES(12, 72);
CREATE TABLE IF NOT EXISTS `figuritasinicializadas` (
`ACODIGO` int(11)
,`APAIS` varchar(50)
,`ANACIONALIDAD` varchar(50)
,`FJUGADOR` varchar(50)
,`FIMAGEN` varchar(50)
,`posicion` varchar(50)
,`pose` int(11)
,`FDIFICULTAD` varchar(20)
);
CREATE TABLE IF NOT EXISTS `figuritasrepetidas` (
  `codigorepetido` int(11) NOT NULL AUTO_INCREMENT,
  `codigopartida` int(11) DEFAULT NULL,
  `codigofigurita` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigorepetido`),
  KEY `rep` (`codigopartida`,`codigofigurita`),
  KEY `codigofigurita` (`codigofigurita`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=94 ;

INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(92, 1, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(4, 1, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(93, 1, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(5, 1, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(6, 1, 9);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(1, 1, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(2, 1, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(3, 1, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(9, 3, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(10, 3, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(7, 3, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(8, 3, 11);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(13, 6, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(14, 6, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(15, 6, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(11, 6, 10);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(12, 6, 38);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(16, 7, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(18, 7, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(23, 7, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(19, 7, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(24, 7, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(25, 7, 9);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(26, 7, 12);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(20, 7, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(21, 7, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(22, 7, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(17, 7, 16);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(27, 7, 22);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(28, 7, 23);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(29, 7, 24);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(30, 7, 25);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(31, 7, 26);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(32, 7, 27);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(33, 7, 38);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(37, 8, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(38, 8, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(39, 8, 9);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(34, 8, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(35, 8, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(36, 8, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(40, 9, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(41, 9, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(42, 9, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(46, 10, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(43, 10, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(44, 10, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(45, 10, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(47, 11, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(48, 11, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(49, 11, 9);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(50, 11, 10);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(51, 11, 11);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(52, 11, 12);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(56, 14, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(57, 14, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(58, 14, 9);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(53, 14, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(54, 14, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(55, 14, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(59, 14, 22);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(60, 14, 23);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(61, 14, 24);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(62, 14, 25);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(63, 14, 26);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(64, 14, 27);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(76, 15, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(77, 15, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(78, 15, 9);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(65, 15, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(66, 15, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(67, 15, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(70, 15, 22);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(71, 15, 23);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(72, 15, 24);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(73, 15, 25);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(74, 15, 26);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(75, 15, 27);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(69, 15, 30);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(68, 15, 38);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(82, 16, 1);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(83, 16, 7);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(84, 16, 8);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(85, 16, 9);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(79, 16, 13);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(80, 16, 14);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(81, 16, 15);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(86, 16, 22);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(87, 16, 23);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(88, 16, 24);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(89, 16, 25);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(90, 16, 26);
INSERT INTO `figuritasrepetidas` (`codigorepetido`, `codigopartida`, `codigofigurita`) VALUES(91, 16, 27);

CREATE TABLE IF NOT EXISTS `partida` (
  `codigopartida` int(11) NOT NULL AUTO_INCREMENT,
  `nombrejugador` varchar(50) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigopartida`),
  UNIQUE KEY `nombrejugador` (`nombrejugador`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(1, 'Jonathan', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(2, 'augus', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(3, 'Pepeganga', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(4, 'NACHO', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(5, '943TJGH9035905NMH', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(6, 'PUTITO', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(7, 'ian', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(8, 'carrau', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(9, 'Julian', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(10, 'checa', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(11, 's6lqui', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(12, 'pablo', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(13, 'lclf', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(14, 'huiy', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(15, 'kju', 'en juego');
INSERT INTO `partida` (`codigopartida`, `nombrejugador`, `estado`) VALUES(16, 'ñ´0ik', 'en juego');

CREATE TABLE IF NOT EXISTS `partidacombo` (
  `codigopartida` int(11) NOT NULL DEFAULT '0',
  `codigocombo` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codigopartida`,`codigocombo`),
  KEY `codigocombo` (`codigocombo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(1, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(2, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(3, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(4, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(6, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(8, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(9, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(10, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(11, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(14, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(16, 1);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(1, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(8, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(9, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(10, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(14, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(16, 2);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(1, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(3, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(6, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(8, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(11, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(14, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(16, 3);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(2, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(5, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(8, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(9, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(14, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(16, 4);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 5);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(9, 5);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(14, 5);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 5);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(16, 5);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(6, 6);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 6);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(14, 6);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 6);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(16, 6);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(3, 7);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(6, 7);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 7);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 7);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(6, 8);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 8);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(9, 8);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 8);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(6, 9);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 9);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(8, 9);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 9);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(3, 10);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(5, 10);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(7, 10);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(9, 10);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 10);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(9, 11);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 11);
INSERT INTO `partidacombo` (`codigopartida`, `codigocombo`) VALUES(15, 12);

CREATE TABLE IF NOT EXISTS `partidafiguritas` (
  `codigopartida` int(11) NOT NULL DEFAULT '0',
  `codigofigurita` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codigopartida`,`codigofigurita`),
  KEY `codigofigurita` (`codigofigurita`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(12, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 1);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 2);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 2);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 3);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 4);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 4);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 4);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 6);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 7);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 8);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 9);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 10);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 11);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 12);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(4, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 13);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(4, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 14);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(4, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 15);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(4, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 16);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(4, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 17);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(1, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(4, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(10, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(11, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 18);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 19);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 20);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 21);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 22);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 23);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(2, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 24);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 25);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 25);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 25);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 25);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 25);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 25);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 26);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 26);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 26);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 26);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 26);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 26);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 27);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 27);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 27);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 27);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 27);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 27);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 28);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 28);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 28);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 28);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 28);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 29);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 29);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 29);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 29);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 29);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 30);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 30);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(14, 30);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 30);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(16, 30);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 34);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 37);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 37);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 37);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 37);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 38);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 38);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 38);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 38);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 38);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 39);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 39);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 39);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 39);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 40);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 40);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 40);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 40);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 41);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 41);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 41);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 41);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 42);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 42);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 42);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 42);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 43);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 43);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 43);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 43);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 44);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 44);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 44);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 44);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 45);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 45);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 45);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 45);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 46);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 46);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 46);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 46);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 47);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 47);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 47);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 47);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 48);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 48);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 48);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 48);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 49);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 49);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 49);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 49);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 50);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 50);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 50);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 50);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 51);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 51);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 51);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 51);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 52);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 52);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 52);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 52);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(6, 53);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 53);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(8, 53);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 53);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 55);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 55);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 55);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 55);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 55);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 56);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 56);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 56);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 56);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 56);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 57);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 57);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 57);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 57);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 57);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 58);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 58);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 58);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 58);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 58);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 59);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 59);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 59);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 59);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 59);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 60);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(5, 60);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(7, 60);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 60);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 60);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 61);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 61);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 61);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 62);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 62);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 63);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 63);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 64);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 64);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 65);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 65);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(9, 66);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 66);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 67);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 68);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 69);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(3, 70);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 70);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 71);
INSERT INTO `partidafiguritas` (`codigopartida`, `codigofigurita`) VALUES(15, 72);

CREATE TABLE IF NOT EXISTS `preguntas` (
  `codigopregunta` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(150) DEFAULT NULL,
  `niveldificultad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`codigopregunta`),
  UNIQUE KEY `pregunta` (`pregunta`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(1, '¿Cuál de los siguientes equipos no se encuentra en el grupo a?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(2, '¿En donde se hizo la inauguración?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(3, '¿Dónde se juega la final del mundial?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(4, '¿Cuál de los siguientes jugadores no se encuentra en el plantel argentino?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(5, '¿En que año gano Argentina, por ultima vez, un mundial?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(6, '¿Quién gano el último mundial en África?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(7, '¿Cual fue el último mundial ganado por Alemania?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(8, '¿Cuál de los siguientes equipos fue el primer eliminado del actual mundial?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(9, '¿Cuál fue la primera sede del mundial de futbol?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(10, '¿Cuál fue el resultado del partido España-Holanda?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(11, '¿Qué grupo tiene en todas sus banderas el color blanco y en ninguna amarillo?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(12, '¿Qué fecha se juega la final de la copa del mundo?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(13, '¿Cuál fue el resultado del partido Argentina-Bosnia?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(14, 'En el mundial de 2002 organizado entre Japón y corea del sur ¿Dónde se jugo la final?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(15, '¿Cuál fue la lesión que sufrió el arquero Argentino Nery Pumpido en 1990?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(16, '¿Cuántos países no ganaron la copa siendo cede del mundial?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(17, '¿Cuántos países ganaron la copa siendo cede del mundial?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(18, '¿Qué eligió la selección de Japón como mascota?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(19, '¿Qué colores tiene la bandera de Grecia?', 'dificl');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(20, '¿Cuántos años tenia el jugador mas joven de los mundiales?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(21, '¿Cuántos países integran el mundial?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(22, '¿Cuántos partidos de la final terminaron en penales? ', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(23, '¿Quién o quienes tienen el record de la mayor cantidad de goles en un mundial?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(24, '¿Qué equipo fue el responsable del 10 a 1 contra El Salvador en 1982?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(25, '¿Qué país tiene el record de quedar en 3er puesto?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(26, '¿Cuál es la cantidad de goles en contra efectuados en los mundiales?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(27, '¿Quién gano el balón de oro en el mundial de Sudáfrica?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(28, '¿Cuántos trofeos se entregan en la copa del mundo?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(29, '¿Cando se implemento el ojo de halcón en el mundial?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(30, '¿Cuántos grupos hay en un mundial?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(31, '¿Cuántas pelotas hay en juego en un partido de futbol?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(32, '¿Cuántos jueces hay en un partido de futbol?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(33, '¿Cuándo es penal?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(34, '¿Cuántos jugadores hay en un partido de futbol?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(35, '¿Quién mordió al jugador italiano en la ronda de eliminatorias?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(36, '¿Quién provocó el famoso cabezazo en el mundial de Alemania?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(37, '¿Quién hizo la canción del mundial 2014?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(38, '¿A que país pertenece el tema del mundial mas famoso?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(39, '¿Cuántos cambios se pueden hacer en un partido?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(40, '¿Cuántos equipos Han participado en la copa del mundo? ', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(41, '¿Quién fue el autor del gol llamado la mano de dios?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(42, '¿Qué es una vuvuzela?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(43, '¿Cómo se llamo la mascota del mundial de 1978?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(44, '¿Cómo se llama la pelota del mundial 2014?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(45, '¿De que marca son los botines que usa Messi en el mundial 2014?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(46, '¿Cuál es el número de la camiseta de Higuain?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(47, '¿Cómo se llama la asociación que organiza el mundial?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(48, '¿Qué país invento el aerosol de espuma que se utiliza en los tiros libres?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(49, '¿Cuál es la cancha con mayor capacidad del mundial de Brasil?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(50, '¿Quién metió el primer gol olímpico en un mundial?', 'dificil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(51, '¿En cuantos Mundiales participo Messi?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(52, '¿En que grupo esta Argentina?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(53, '¿Qué colores tiene la bandera de Japón?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(54, '¿Contra que equipo se enfrenta Argentina en octavos de final?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(55, '¿Con que numero de camiseta juega Messi?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(56, '¿En que equipo juega Ronaldo?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(57, '¿Cuál de los siguientes no equipos no paso a octavos de final?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(58, '¿Qué animal representa la mascota del mundial 2014?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(59, '¿Cómo se llama el arquero de la selección argentina?', 'facil');
INSERT INTO `preguntas` (`codigopregunta`, `pregunta`, `niveldificultad`) VALUES(60, '¿Cada cuantos años se realizan los mundiales de futbol?', 'facil');

CREATE TABLE IF NOT EXISTS `preguntasdificiles` (
  `codigopregunta` int(11) NOT NULL AUTO_INCREMENT,
  `codigopreg` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigopregunta`),
  KEY `codigopreg` (`codigopreg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `preguntasfaciles` (
  `codigopregunta` int(11) NOT NULL AUTO_INCREMENT,
  `codigopreg` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigopregunta`),
  KEY `codigopreg` (`codigopreg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `respuestas` (
  `codigopregunta` int(11) NOT NULL DEFAULT '0',
  `respuesta` varchar(150) NOT NULL DEFAULT '',
  `correcta` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`codigopregunta`,`respuesta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(1, 'Argentina', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(1, 'Brasil', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(1, 'Camerun', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(1, 'Mexico', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(1, 'Ninguno de los anteriores', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(2, 'Curitiba', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(2, 'Fortaleza', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(2, 'Porto Alegre', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(2, 'Rio de Janeiro', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(2, 'San Pablo', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(3, 'Belo Horizonte', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(3, 'Brasilia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(3, 'Fortaleza', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(3, 'Porto Alegre', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(3, 'Rio de Janeiro', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(4, 'Agüero', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(4, 'Higuain', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(4, 'Messi', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(4, 'Rojo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(4, 'Tevez', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(5, '1978', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(5, '1986', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(5, '1987', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(5, '1988', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(5, '1996', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(6, 'Brasil', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(6, 'Camerun', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(6, 'España', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(6, 'Ninguno de los anteriores', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(6, 'Paises Bajos', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(7, '1974', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(7, '1987', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(7, '1989', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(7, '1990', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(7, '1991', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(8, 'Costa Rica', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(8, 'Croacia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(8, 'España', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(8, 'Inglaterra', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(8, 'Italia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(9, 'Brasil', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(9, 'Francia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(9, 'Italia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(9, 'Suiza', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(9, 'Uruguay', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(10, '0 a 0', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(10, '1 a 5', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(10, '2 a 0', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(10, '2 a 3', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(10, '3 a 4', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(11, 'C', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(11, 'D', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(11, 'E', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(11, 'F', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(11, 'H', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(12, '10 de julio', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(12, '12 de julio', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(12, '13 de julio', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(12, '14 de julio', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(12, '9 de julio', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(13, '1 a 0', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(13, '1 a 1', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(13, '2 a 1', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(13, '2 a 2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(13, '3 a 2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(14, 'Deagu', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(14, 'Kyoto', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(14, 'seul', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(14, 'Tokyo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(14, 'Yokohama', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(15, 'Fisura de costilla', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(15, 'Fractura de clavicula', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(15, 'Fractura de muñeca', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(15, 'Fractura de tivia y perone', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(15, 'Perdio un dedo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(16, '10', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(16, '13', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(16, '15', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(16, '8', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(16, '9', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(17, '4', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(17, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(17, '6', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(17, '9', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(17, 'Ninguno ', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(18, 'No tiene mascota', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(18, 'Un animal', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(18, 'Un edificio', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(18, 'Un pokemon', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(18, 'Una planta', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(19, 'Amarillo y rojo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(19, 'Blanco y azul', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(19, 'Blanco y rojo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(19, 'Blanco y verde', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(19, 'Verde y amarillo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(20, '16', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(20, '17', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(20, '18', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(20, '20', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(20, '21', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(21, '24', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(21, '28', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(21, '32', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(21, '36', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(21, '38', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(22, '2', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(22, '3', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(22, '4', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(22, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(22, 'Ninguno', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(23, 'Batistuta-Pelé', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(23, 'Ninguno de estos', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(23, 'Pelé', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(23, 'Ronaldo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(23, 'Ronaldo-Miroslav', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(24, 'Alemaña', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(24, 'El Salvador', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(24, 'Ninguno de estos', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(24, 'Portugal', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(24, 'Ungria', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(25, 'Alemaña', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(25, 'Argentina', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(25, 'Brasil', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(25, 'Corea del sur', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(25, 'Costa Rica', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(26, '20', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(26, '26', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(26, '35', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(26, '36', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(26, '40', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(27, 'Forlán', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(27, 'Maradona', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(27, 'Messi', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(27, 'Pirlo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(27, 'Virlo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(28, '3', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(28, '4', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(28, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(28, '6', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(28, '7', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(29, 'En Alemaña', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(29, 'En españa', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(29, 'En este mundial', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(29, 'En Francia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(29, 'En Sudafrica', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(30, '2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(30, '4', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(30, '6', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(30, '8', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(30, 'Ninguno', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(31, '1', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(31, '2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(31, '32', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(31, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(31, '6', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(32, '1', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(32, '2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(32, '3', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(32, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(32, '7', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(33, 'Falta en el area', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(33, 'Se agarra la pelota con la mano ', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(33, 'Se cabecea a otro jugador', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(33, 'Se muerde a otro jugador', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(33, 'Una falta normal', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(34, '11', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(34, '15', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(34, '22', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(34, '24', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(34, '25', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(35, 'Cavani', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(35, 'Forlán', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(35, 'Godín', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(35, 'Muslera', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(35, 'Suarez', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(36, 'Maradona', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(36, 'Pelé', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(36, 'Pirlo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(36, 'Suarez', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(36, 'Zidane', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(37, 'La Mona Jimenez', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(37, 'Pitbull y Yenifer Lopez', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(37, 'Ricki Martin', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(37, 'Tan bionica', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(37, 'Wisin y Yandel', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(38, 'Argentina', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(38, 'Chile', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(38, 'Italia', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(38, 'Japon-Corea del Sur', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(38, 'Portugal', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(39, '2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(39, '3', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(39, '4', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(39, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(39, 'Se arregla antes del partido', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(40, '100', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(40, '40', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(40, '76', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(40, '80', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(40, '96', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(41, 'Harry Potter', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(41, 'Lor baldomero', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(41, 'Maradona', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(41, 'Pelé', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(41, 'Ronaldo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(42, 'Un tambor', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(42, 'Una corneta', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(42, 'Una parte del cuerpo huano', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(42, 'Una pelota', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(42, 'Una trompeta', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(43, 'Ciao', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(43, 'Footix', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(43, 'Gauchito', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(43, 'Juanito', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(43, 'Zakumi', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(44, 'Brazuca', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(44, 'Crack', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(44, 'Fevernova', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(44, 'Tango', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(44, 'Tricolore', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(45, 'Adidas', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(45, 'Nike', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(45, 'Olympikus', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(45, 'Puma', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(45, 'Topper', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(46, '10', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(46, '11', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(46, '19', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(46, '22', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(46, '9', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(47, 'AFA', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(47, 'FAFA', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(47, 'FAFI', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(47, 'FIFA', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(47, 'IFA', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(48, 'Alemania', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(48, 'Argentina', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(48, 'Brasil', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(48, 'Inglaterra', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(48, 'Mexico', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(49, 'Amazônia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(49, 'Das Dunas', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(49, 'Fonte Nova', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(49, 'Maracana', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(49, 'Pernambuco', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(50, 'Adan Godoy', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(50, 'Marcelo Pagani', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(50, 'Marcos Coll', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(50, 'Oscar Rossi', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(50, 'Sergio Valdez', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(51, '2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(51, '3', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(51, '4', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(51, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(51, 'Niguno', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(52, 'Grupo B', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(52, 'Grupo D', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(52, 'Grupo F', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(52, 'Grupo G', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(52, 'Grupo H', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(53, 'Amarillo y rojo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(53, 'Azul y rojo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(53, 'Banco y celeste', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(53, 'Blanco y rojo', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(53, 'Verde y amarillo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(54, 'Brasil', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(54, 'Francia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(54, 'Grecia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(54, 'Nigeria', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(54, 'Suiza', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(55, '10', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(55, '11', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(55, '17', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(55, '22', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(55, '9', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(56, 'Alemania', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(56, 'Brasil', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(56, 'Colombia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(56, 'Mexico', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(56, 'Portugal', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(57, 'Argentina', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(57, 'Colombia', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(57, 'Mexico', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(57, 'Nigeria', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(57, 'Portugal', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(58, 'Armadillo', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(58, 'Coati', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(58, 'Mulita', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(58, 'Perro', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(58, 'Puercoespin', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(59, 'Carlos Abbondanzieri', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(59, 'Guillermo Ochoa', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(59, 'Mariano Andújar', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(59, 'Pablo Carrizo', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(59, 'Sergio Romero', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(60, '2', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(60, '3', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(60, '4', 1);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(60, '5', 0);
INSERT INTO `respuestas` (`codigopregunta`, `respuesta`, `correcta`) VALUES(60, '6', 0);
DROP TABLE IF EXISTS `combofigu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `combofigu` AS select `combos`.`codigocombo` AS `CCODIGO`,`combos`.`nombrecombo` AS `CNOMBRE`,`combos`.`dificultadcombo` AS `CDIFICULTAD`,`combos`.`imagencombo` AS `CIMAGEN`,`albumpais`.`codigoalbum` AS `ACODIGO`,`albumpais`.`nombre_pais` AS `APAIS`,`albumpais`.`nacionalidad` AS `ANACIONALIDAD`,`figuritas`.`nombrejugador` AS `FJUGADOR`,`figuritas`.`direccionimagen` AS `FIMAGEN`,`figuritas`.`dificultad` AS `FDIFICULTAD` from (((`figuritas` join `albumpais`) join `combos`) join `figuritascombo`) where ((`figuritas`.`codigoalbum` = `albumpais`.`codigoalbum`) and (`figuritas`.`codigofigurita` = `figuritascombo`.`codigofigurita`) and (`figuritascombo`.`codigocombo` = `combos`.`codigocombo`)) order by `combos`.`codigocombo`;
DROP TABLE IF EXISTS `figuritasinicializadas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `figuritasinicializadas` AS select `albumpais`.`codigoalbum` AS `ACODIGO`,`albumpais`.`nombre_pais` AS `APAIS`,`albumpais`.`nacionalidad` AS `ANACIONALIDAD`,`figuritas`.`nombrejugador` AS `FJUGADOR`,`figuritas`.`direccionimagen` AS `FIMAGEN`,`figuritas`.`posicion` AS `posicion`,`figuritas`.`pose` AS `pose`,`figuritas`.`dificultad` AS `FDIFICULTAD` from (`figuritas` join `albumpais`) where (`figuritas`.`codigoalbum` = `albumpais`.`codigoalbum`);


ALTER TABLE `figuritas`
  ADD CONSTRAINT `figuritas_ibfk_1` FOREIGN KEY (`codigoalbum`) REFERENCES `albumpais` (`codigoalbum`);

ALTER TABLE `figuritascombo`
  ADD CONSTRAINT `figuritascombo_ibfk_1` FOREIGN KEY (`codigocombo`) REFERENCES `combos` (`codigocombo`),
  ADD CONSTRAINT `figuritascombo_ibfk_2` FOREIGN KEY (`codigofigurita`) REFERENCES `figuritas` (`codigofigurita`);

ALTER TABLE `figuritasrepetidas`
  ADD CONSTRAINT `figuritasrepetidas_ibfk_1` FOREIGN KEY (`codigopartida`) REFERENCES `partida` (`codigopartida`),
  ADD CONSTRAINT `figuritasrepetidas_ibfk_2` FOREIGN KEY (`codigofigurita`) REFERENCES `figuritas` (`codigofigurita`);

ALTER TABLE `partidacombo`
  ADD CONSTRAINT `partidacombo_ibfk_1` FOREIGN KEY (`codigopartida`) REFERENCES `partida` (`codigopartida`),
  ADD CONSTRAINT `partidacombo_ibfk_2` FOREIGN KEY (`codigocombo`) REFERENCES `combos` (`codigocombo`);

ALTER TABLE `partidafiguritas`
  ADD CONSTRAINT `partidafiguritas_ibfk_1` FOREIGN KEY (`codigopartida`) REFERENCES `partida` (`codigopartida`),
  ADD CONSTRAINT `partidafiguritas_ibfk_2` FOREIGN KEY (`codigofigurita`) REFERENCES `figuritas` (`codigofigurita`);

ALTER TABLE `preguntasdificiles`
  ADD CONSTRAINT `preguntasdificiles_ibfk_1` FOREIGN KEY (`codigopreg`) REFERENCES `preguntas` (`codigopregunta`);

ALTER TABLE `preguntasfaciles`
  ADD CONSTRAINT `preguntasfaciles_ibfk_1` FOREIGN KEY (`codigopreg`) REFERENCES `preguntas` (`codigopregunta`);

ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`codigopregunta`) REFERENCES `preguntas` (`codigopregunta`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
