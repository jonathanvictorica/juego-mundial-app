
create table partida
(
    codigopartida int auto_increment,
    nombrejugador varchar(50),
    estado varchar(20),
    primary key(codigopartida),
    unique(nombrejugador)
);



create table albumpais
(
    codigoalbum int auto_increment,
    nombre_pais varchar(50),
    nacionalidad varchar(50),
    primary key(codigoalbum),
    unique (nombre_pais)
);

create table figuritas
(
    codigofigurita int auto_increment,
    codigoalbum int,
    pose int,
    nombrejugador varchar(50),
    posicion varchar(50),
    direccionimagen varchar(50),
    dificultad varchar(20),
    primary key(codigofigurita),
    foreign key(codigoalbum) references albumpais(codigoalbum),
    unique (codigoalbum,nombrejugador)

);






create table preguntas
(
    codigopregunta int auto_increment,
    pregunta varchar(150),
    niveldificultad varchar(20),
    primary key(codigopregunta),
    unique(pregunta)
);






create table respuestas
(
    codigopregunta int,
    respuesta varchar(150),
    correcta boolean,
    primary key(codigopregunta,respuesta),
    foreign key(codigopregunta) references preguntas(codigopregunta)

);

create table combos
(
    codigocombo int auto_increment,
    nombrecombo varchar(50),
    dificultadcombo varchar(20),
    imagencombo varchar(50),
    primary key(codigocombo),
    unique(nombrecombo)

);



create table figuritascombo
(
    codigocombo int,
    codigofigurita int,
    primary key(codigocombo,codigofigurita),
    foreign key(codigocombo) references combos(codigocombo),
    foreign key(codigofigurita) references figuritas(codigofigurita)
);


create table partidafiguritas
(
    codigopartida int,
    codigofigurita int,
    primary key(codigopartida,codigofigurita),
    foreign key(codigopartida) references partida(codigopartida),
    foreign key(codigofigurita) references figuritas(codigofigurita)
);

create table partidacombo
(
    codigopartida int,
    codigocombo int,
    primary key(codigopartida,codigocombo),
    foreign key(codigopartida) references partida(codigopartida),
    foreign key(codigocombo) references combos(codigocombo)
);


create table preguntasdificiles
(
    codigopregunta int auto_increment,
    codigopreg int,
    primary key(codigopregunta),
    foreign key(codigopreg) references preguntas(codigopregunta)

);

create table preguntasfaciles
(
    codigopregunta int auto_increment,
    codigopreg int,
    primary key(codigopregunta),
    foreign key(codigopreg) references preguntas(codigopregunta)

);

create table figuritasrepetidas
(
    codigorepetido int auto_increment,
    codigopartida int,
    codigofigurita int,
    index rep(codigopartida,codigofigurita),
    primary key(codigorepetido),
    foreign key(codigopartida) references partida(codigopartida),
    foreign key(codigofigurita) references figuritas(codigofigurita)

);


create view combofigu as select combos.codigocombo as ccodigo,combos.nombrecombo as cnombre, combos.dificultadcombo as cdificultad, combos.imagencombo as cimagen, albumpais.codigoalbum as acodigo, albumpais.nombre_pais as apais, albumpais.nacionalidad as anacionalidad,
                                figuritas.nombrejugador as fjugador, figuritas.direccionimagen as fimagen, figuritas.dificultad as fdificultad
                         from figuritas,albumpais,combos,figuritascombo
                         where figuritas.codigoalbum = albumpais.codigoalbum and figuritas.codigofigurita=figuritascombo.codigofigurita
                           and figuritascombo.codigocombo =combos.codigocombo order by ccodigo;

create view figuritasinicializadas as select albumpais.codigoalbum as acodigo, albumpais.nombre_pais as apais, albumpais.nacionalidad as anacionalidad,
                                             figuritas.nombrejugador as fjugador, figuritas.direccionimagen as fimagen, figuritas.posicion as posicion,figuritas.pose as pose, figuritas.dificultad as fdificultad
                                      from figuritas,albumpais
                                      where figuritas.codigoalbum = albumpais.codigoalbum;