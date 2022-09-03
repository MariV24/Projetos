create schema ichord;
---------------------------------------------------------------------------------------------
drop table ichord.usuario;
create table if not exists ichord.usuario
	(
		user_id integer not null primary key auto_increment,
			nivel_user varchar(5) DEFAULT '1' not null,
            nome varchar(30) not null,
            genero_usuario enum('M', 'F') not null
		)auto_increment = 1;
        
INSERT INTO ichord.usuario VALUES('1', '1', 'Aparecida', 'F');
INSERT INTO ichord.usuario VALUES('2', '1', 'Bruno', 'M');
INSERT INTO ichord.usuario VALUES('3', '2', 'Gus', 'M');
INSERT INTO ichord.usuario VALUES('4', '4', 'Yeager', 'M');
INSERT INTO ichord.usuario VALUES('5', '1', 'Cheng Hsiu', 'M');
INSERT INTO ichord.usuario VALUES('6', '1', 'Osmar', 'M');
INSERT INTO ichord.usuario VALUES('7', '3', 'mario', 'M');
INSERT INTO ichord.usuario VALUES('8', '4', 'Renata', 'F');
INSERT INTO ichord.usuario VALUES('9', '1', 'karina', 'F');
INSERT INTO ichord.usuario VALUES('10', '2', 'Diego Torres', 'M');
INSERT INTO ichord.usuario VALUES('11', '1', 'jane lucia goncalves', 'F');
INSERT INTO ichord.usuario VALUES('12', '3', 'Nathalia Oliveira', 'F');
INSERT INTO ichord.usuario VALUES('13', '1', 'Quevaldo da silva', 'M');
INSERT INTO ichord.usuario VALUES('14', '1', 'Senilda Francisca', 'F');
INSERT INTO ichord.usuario VALUES('15', '2', 'Lara Sofia', 'F');
INSERT INTO ichord.usuario VALUES('16', '1', 'helder sebroeck', 'M');
INSERT INTO ichord.usuario VALUES('17', '1', 'Elias Spader', 'M');
INSERT INTO ichord.usuario VALUES('18', '2', 'talita da chinelato', 'F');
INSERT INTO ichord.usuario VALUES('19', '1', 'Patricia', 'F');
INSERT INTO ichord.usuario VALUES('20', '5', 'Zanin', 'F');
        
select * from usuario order by user_id asc;

-- Quantidade de pessoas cadastradas no banco de dados do app.
select count(user_id) from ichord.usuario;

-- Quantidade de pessoas por nível.
select nivel_user, count(user_id) from ichord.usuario group by nivel_user;

-- Quantidade de pessoas por gênero biológico.
select genero_usuario, count(genero_usuario) from ichord.usuario group by genero_usuario;

-- Contagem de gostos musicais por gênero musical
select g.genero_musica, count(a.user_id) from genero_musicas as g
	join algoritmo_musica as a on g.id_musica = a.id_musica
		group by g.genero_musica;
        
-- Mapeamento da ultima atividade dos usuários por tipo de assinatura
select a.user_id, t.last_activity, s.assinatura_tipo from assinatura as a
	join atividade_usuario as t on a.user_id = t.user_id
    join tipo_assinatura as s on s.user_id = a.user_id
    order by t.last_activity desc;
    
-- Usuários e seus tipos de assinatura
select t.user_id, u.nome, t.assinatura_tipo from tipo_assinatura as t
	join usuario as u on u.user_id = t.user_id;
    
-- Genero mais ativo para gráfico
select genero_usuario, count(u.genero_usuario), t.last_activity from atividade_usuario as t
	join usuario as u on u.user_id = t.user_id group by t.last_activity
    order by last_activity desc ;

-- Genero em maior nivel
-- Funciona, errado. ----------------------------
select nivel_user, genero_usuario from usuario
	group by nivel_user order by nivel_user desc;

-- Contagem de gênero por assinatura
-- Não está funcional ----------------------------
select count(u.genero_usuario), u.genero_usuario , t.assinatura_tipo from tipo_assinatura as t
	join usuario as u on u.user_id = t.user_id
    group by t.assinatura_tipo;
    
-- Contagem de genero biologico por genero musical
-- Não está funcional ----------------------------
select g.genero_musica, count(a.user_id), u.genero_usuario, count(genero_usuario) from genero_musicas as g
	join algoritmo_musica as a on g.id_musica = a.id_musica
    join usuario as u on a.user_id = u.user_id
		group by g.genero_musica;
        

---------------------------------------------------------------------------------------------        
drop table ichord.login_usuario;
create table if not exists ichord.login
	(
		login varchar(256) not null primary key,
			senha varchar(30) not null,
            user_id integer not null REFERENCES usuario
		);
        
INSERT INTO ichord.login VALUES('aparecida@rotimeio.com', '********', '1');
INSERT INTO ichord.login VALUES('brun@gemeio.com', '********', '2');
INSERT INTO ichord.login VALUES('gustav@rotimeio.com', '********', '3');
INSERT INTO ichord.login VALUES('igor@rotimeio.com', '********', '4');
INSERT INTO ichord.login VALUES('cheng@rotimeio.com', '********', '5');
INSERT INTO ichord.login VALUES('osm@rotimeio.com', '**********', '6');
INSERT INTO ichord.login VALUES('mario@rotimeio.com', '****************', '7');
INSERT INTO ichord.login VALUES('renat@gemeio.com', '************', '8');
INSERT INTO ichord.login VALUES('karina@rotimeio.com', '********************', '9');
INSERT INTO ichord.login VALUES('diego@gemeio.com', '********', '10');
INSERT INTO ichord.login VALUES('jane@gemeio.com', '******************************', '11');
INSERT INTO ichord.login VALUES('nath@gemeio.com', '************', '12');
INSERT INTO ichord.login VALUES('quev@rotimeio.com', '****************', '13');
INSERT INTO ichord.login VALUES('senilda@rotimeio.com', '****************', '14');
INSERT INTO ichord.login VALUES('lara@gemeio.com', '********', '15');
INSERT INTO ichord.login VALUES('helder@gemeio.com', '********', '16');
INSERT INTO ichord.login VALUES('elias@rotimeio.com', '**********', '17');
INSERT INTO ichord.login VALUES('talit@gemeio.com', '****************', '18');
INSERT INTO ichord.login VALUES('patricia@gemeio.com', '********', '19');
INSERT INTO ichord.login VALUES('fern@gemeio.com', '********', '20');

select * from ichord.login order by user_id asc;
---------------------------------------------------------------------------------------------        
drop table ichord.atividade_usuario;
create table if not exists ichord.atividade_usuario
	(
		last_activity_id_user integer not null primary key,
			last_activity date not null,
			user_id integer not null REFERENCES usuario
		);
        
INSERT INTO ichord.atividade_usuario VALUES('1','2022-06-02', '1');
INSERT INTO ichord.atividade_usuario VALUES('2','2022-06-03', '2');
INSERT INTO ichord.atividade_usuario VALUES('3','2022-06-02', '3');
INSERT INTO ichord.atividade_usuario VALUES('4','2022-05-29', '4');
INSERT INTO ichord.atividade_usuario VALUES('5','2022-06-02', '5');
INSERT INTO ichord.atividade_usuario VALUES('6','2022-05-20', '6');
INSERT INTO ichord.atividade_usuario VALUES('7','2022-05-30', '7');
INSERT INTO ichord.atividade_usuario VALUES('8','2022-06-03', '8');
INSERT INTO ichord.atividade_usuario VALUES('9','2022-06-05', '9');
INSERT INTO ichord.atividade_usuario VALUES('10','2022-06-05', '10');
INSERT INTO ichord.atividade_usuario VALUES('11','2022-04-01', '11');
INSERT INTO ichord.atividade_usuario VALUES('12','2022-05-31', '12');
INSERT INTO ichord.atividade_usuario VALUES('13','2022-05-01', '13');
INSERT INTO ichord.atividade_usuario VALUES('14','2022-05-15', '14');
INSERT INTO ichord.atividade_usuario VALUES('15','2022-06-02', '15');
INSERT INTO ichord.atividade_usuario VALUES('16','2022-06-06', '16');
INSERT INTO ichord.atividade_usuario VALUES('17','2022-06-04', '17');
INSERT INTO ichord.atividade_usuario VALUES('18','2022-06-05', '18');
INSERT INTO ichord.atividade_usuario VALUES('19','2022-04-05', '19');
INSERT INTO ichord.atividade_usuario VALUES('20','2022-05-31', '20');

select * from ichord.atividade_usuario;

---------------------------------------------------------------------------------------------        
drop table ichord.musicas;
create table if not exists ichord.musicas
	(
		id_musica integer not null primary key auto_increment,
            nome_musica varchar(60) not null,
            nome_cantor varchar(50) not null
        )auto_increment=1;
        
INSERT INTO ichord.musicas VALUES('1', 'Desenrola, Bate, Joga de Ladin (part. Os Hawaianos)', 'MC Reizin');
INSERT INTO ichord.musicas VALUES('2', 'Bad Romance', 'Lady Gaga');
INSERT INTO ichord.musicas VALUES('3', 'Alô', 'Cavaleiros do Forró');
INSERT INTO ichord.musicas VALUES('4', 'Quero Ser Feliz Também', 'Natiruts');
INSERT INTO ichord.musicas VALUES('5', 'Admirável Gado Novo', 'Zé Ramalho');
INSERT INTO ichord.musicas VALUES('6', 'A Fila Anda', 'VIBE');
INSERT INTO ichord.musicas VALUES('7', 'Eu e Você Sempre', 'Exaltasamba');
INSERT INTO ichord.musicas VALUES('8', 'Garçom', 'Reginaldo Rossi');
INSERT INTO ichord.musicas VALUES('9', 'DOPE', 'BTS');
INSERT INTO ichord.musicas VALUES('10', 'Na Sua Estante', 'Pitty');
INSERT INTO ichord.musicas VALUES('11', 'Sobrevivendo no Inferno', 'Racionais');
INSERT INTO ichord.musicas VALUES('12', 'Emoções', 'Roberto Carlos');
INSERT INTO ichord.musicas VALUES('13', 'Stop the Madness', 'Lil Skies');
INSERT INTO ichord.musicas VALUES('14', 'Seven Deadly Sins', 'MAN WITH A MISSION');
INSERT INTO ichord.musicas VALUES('15', 'Bang Bang', 'David Guetta');
INSERT INTO ichord.musicas VALUES('16', 'You Are My Sunshine', 'Johnny Cash');
INSERT INTO ichord.musicas VALUES('17', 'Chop Suey!', 'System Of A Down');
INSERT INTO ichord.musicas VALUES('18', 'Barcelona Girl', 'Corella');
INSERT INTO ichord.musicas VALUES('19', 'O Que Pensa Que Eu Sou', 'Banda Djavú');
INSERT INTO ichord.musicas VALUES('20', 'SUPERA', 'Marília Mendonça');

select * from ichord.musicas;
        
---------------------------------------------------------------------------------------------
drop table ichord.genero_musicas;
create table if not exists ichord.genero_musicas
	(
		id_musica integer not null primary key,
			genero_musica varchar(20) not null
		);
        
INSERT INTO ichord.genero_musicas VALUES('1', 'Funk');
INSERT INTO ichord.genero_musicas VALUES('2', 'Pop');
INSERT INTO ichord.genero_musicas VALUES('3', 'Forró');
INSERT INTO ichord.genero_musicas VALUES('4', 'Reggae');
INSERT INTO ichord.genero_musicas VALUES('5', 'MPB');
INSERT INTO ichord.genero_musicas VALUES('6', 'Pagode');
INSERT INTO ichord.genero_musicas VALUES('7', 'Samba');
INSERT INTO ichord.genero_musicas VALUES('8', 'Brega');
INSERT INTO ichord.genero_musicas VALUES('9', 'K-pop');
INSERT INTO ichord.genero_musicas VALUES('10', 'Rock');
INSERT INTO ichord.genero_musicas VALUES('11', 'Rap');
INSERT INTO ichord.genero_musicas VALUES('12', 'Velha Guarda');
INSERT INTO ichord.genero_musicas VALUES('13', 'Trap');
INSERT INTO ichord.genero_musicas VALUES('14', 'J-Rock');
INSERT INTO ichord.genero_musicas VALUES('15', 'Eletrônica');
INSERT INTO ichord.genero_musicas VALUES('16', 'Country');
INSERT INTO ichord.genero_musicas VALUES('17', 'Heavy Metal'); 
INSERT INTO ichord.genero_musicas VALUES('18', 'Indie');
INSERT INTO ichord.genero_musicas VALUES('19', 'Tecnobrega');
INSERT INTO ichord.genero_musicas VALUES('20', 'Sertanejo');         
        
select * from ichord.genero_musicas;
        
---------------------------------------------------------------------------------------------
drop table ichord.letra;
create table if not exists ichord.letra
	(
		id_letra integer not null primary key,
			id_musica integer not null REFERENCES musicas
		);
        
INSERT INTO ichord.letra VALUES('1', '1');
INSERT INTO ichord.letra VALUES('2', '2');
INSERT INTO ichord.letra VALUES('3', '3');
INSERT INTO ichord.letra VALUES('4', '4');
INSERT INTO ichord.letra VALUES('5', '5');
INSERT INTO ichord.letra VALUES('6', '6');
INSERT INTO ichord.letra VALUES('7', '7');
INSERT INTO ichord.letra VALUES('8', '8');
INSERT INTO ichord.letra VALUES('9', '9');
INSERT INTO ichord.letra VALUES('10', '10');
INSERT INTO ichord.letra VALUES('11', '11');
INSERT INTO ichord.letra VALUES('12', '12');
INSERT INTO ichord.letra VALUES('13', '13');
INSERT INTO ichord.letra VALUES('14', '14');
INSERT INTO ichord.letra VALUES('15', '15');
INSERT INTO ichord.letra VALUES('16', '16');
INSERT INTO ichord.letra VALUES('17', '17');
INSERT INTO ichord.letra VALUES('18', '18');
INSERT INTO ichord.letra VALUES('19', '19');
INSERT INTO ichord.letra VALUES('20', '20');
        
select * from ichord.letra;
        
---------------------------------------------------------------------------------------------
/*drop table ichord.api_spotify;
create table if not exists ichord.api_spotify
	(
		id_musica integer not null,
        id_letra integer not null
        );*/
---------------------------------------------------------------------------------------------        
drop table ichord.licoes;
create table if not exists ichord.licoes
	(
		id_licao integer not null primary key,
			nivel_licao varchar(5) not null,
            nivel_user varchar(5) not null REFERENCES usuario
           );
/*alter table ichord.licoes add CONSTRAINT fk_muslicoes FOREIGN KEY (id_musica) REFERENCES musicas (id_musica);
alter table ichord.licoes add CONSTRAINT fk_usulicoes FOREIGN KEY (nivel_user) REFERENCES usuario (nivel_user);*/

INSERT INTO ichord.licoes VALUES('1', '1','1');
INSERT INTO ichord.licoes VALUES('2', '2','2');
INSERT INTO ichord.licoes VALUES('3', '3','3');
INSERT INTO ichord.licoes VALUES('4', '4','4');
INSERT INTO ichord.licoes VALUES('5', '5','5');

select * from ichord.licoes;

---------------------------------------------------------------------------------------------
drop table ichord.algoritmo;
create table if not exists ichord.algoritmo
	(
		sugestao_id integer not null primary key,
			user_id integer not null REFERENCES usuario,
			nivel_user varchar(5) not null REFERENCES usuario,
			nivel_licao varchar(5) not null REFERENCES licoes
        );
/*alter table ichord.algoritmo add CONSTRAINT fk_usualgoritmo FOREIGN KEY (user_id) REFERENCES usuario (user_id);
alter table ichord.algoritmo add CONSTRAINT fk_usualgoritmo FOREIGN KEY (nivel_user) REFERENCES usuario (nivel_user);
alter table ichord.algoritmo add CONSTRAINT fk_usulicoes FOREIGN KEY (nivel_licao) REFERENCES licoes (nivel_licao);*/

INSERT INTO ichord.algoritmo VALUES('1', '1','1','1');
INSERT INTO ichord.algoritmo VALUES('2', '2','1','1');
INSERT INTO ichord.algoritmo VALUES('3', '3','2','2');
INSERT INTO ichord.algoritmo VALUES('4', '4','4','4');
INSERT INTO ichord.algoritmo VALUES('5', '5','1','1');
INSERT INTO ichord.algoritmo VALUES('6', '6','1','1');
INSERT INTO ichord.algoritmo VALUES('7', '7','3','3');
INSERT INTO ichord.algoritmo VALUES('8', '8','4','4');
INSERT INTO ichord.algoritmo VALUES('9', '9','3','3');
INSERT INTO ichord.algoritmo VALUES('10', '10','2','2');
INSERT INTO ichord.algoritmo VALUES('11', '11','1','1');
INSERT INTO ichord.algoritmo VALUES('12', '12','3','3');
INSERT INTO ichord.algoritmo VALUES('13', '13','1','1');
INSERT INTO ichord.algoritmo VALUES('14', '14','1','1');
INSERT INTO ichord.algoritmo VALUES('15', '15','2','2');
INSERT INTO ichord.algoritmo VALUES('16', '16','1','1');
INSERT INTO ichord.algoritmo VALUES('17', '17','1','1');
INSERT INTO ichord.algoritmo VALUES('18', '18','2','2');
INSERT INTO ichord.algoritmo VALUES('19', '19','1','1');
INSERT INTO ichord.algoritmo VALUES('20', '20', '5', '5');

select * from ichord.algoritmo;

---------------------------------------------------------------------------------------------
drop table ichord.algoritmo_musica;
create table if not exists algoritmo_musica
	(
		sugestao_musica_id integer not null primary key,
			user_id integer not null REFERENCES usuario,
            id_musica integer not null REFERENCES genero_musicas
		);
            
INSERT INTO ichord.algoritmo_musica VALUES('1', '1', '1');
INSERT INTO ichord.algoritmo_musica VALUES('2', '2', '3');
INSERT INTO ichord.algoritmo_musica VALUES('3', '3', '20');
INSERT INTO ichord.algoritmo_musica VALUES('4', '4', '7');
INSERT INTO ichord.algoritmo_musica VALUES('5', '5', '5');
INSERT INTO ichord.algoritmo_musica VALUES('6', '6', '20');
INSERT INTO ichord.algoritmo_musica VALUES('7', '7', '9');
INSERT INTO ichord.algoritmo_musica VALUES('8', '8', '1');
INSERT INTO ichord.algoritmo_musica VALUES('9', '9', '10');
INSERT INTO ichord.algoritmo_musica VALUES('10', '10', '10');
INSERT INTO ichord.algoritmo_musica VALUES('11', '11', '20');
INSERT INTO ichord.algoritmo_musica VALUES('12', '12', '20');
INSERT INTO ichord.algoritmo_musica VALUES('13', '13', '1');
INSERT INTO ichord.algoritmo_musica VALUES('14', '14', '14');
INSERT INTO ichord.algoritmo_musica VALUES('15', '15', '10');
INSERT INTO ichord.algoritmo_musica VALUES('16', '16', '15');
INSERT INTO ichord.algoritmo_musica VALUES('17', '17', '20');
INSERT INTO ichord.algoritmo_musica VALUES('18', '18', '7');
INSERT INTO ichord.algoritmo_musica VALUES('19', '19', '19');
INSERT INTO ichord.algoritmo_musica VALUES('20', '20', '20');

select * from ichord.algoritmo_musica;

---------------------------------------------------------------------------------------------
drop table ichord.assinatura;
create table if not exists ichord.assinatura
	(
		cpf bigint(11) not null primary key,
			user_id integer not null REFERENCES usuario,
			nome varchar(50) not null REFERENCES usuario
        );
/*alter table ichord.assinatura add CONSTRAINT fk_usuassinatura FOREIGN KEY (user_id) REFERENCES usuario (user_id);
alter table ichord.assinatura add CONSTRAINT fk_usuassinatura FOREIGN KEY (nome) REFERENCES usuario (nome);*/

INSERT INTO ichord.assinatura VALUES(38104241110, '1','Aparecida Cordeiro Gamelas Mochon');
INSERT INTO ichord.assinatura VALUES(85085187734, '2','Bruno da Silva Santana');
INSERT INTO ichord.assinatura VALUES(34582440186, '3', 'Gustavo jorge grinszpan');
INSERT INTO ichord.assinatura VALUES(43806341321, '4','igor santos jacinto');
INSERT INTO ichord.assinatura VALUES(65516521239, '5','Cheng Hsiu Lemmi');
INSERT INTO ichord.assinatura VALUES(34632101600, '6','Osmar hauagge Nogueira');
INSERT INTO ichord.assinatura VALUES(37728356781, '7','Mario Jorge da Silva Sugizaki');
INSERT INTO ichord.assinatura VALUES(81064074546, '8','Renata Lemos Curiati');
INSERT INTO ichord.assinatura VALUES(72321622785, '9','Karina Soares Canedo');
INSERT INTO ichord.assinatura VALUES(08635573332, '10','Diego Torres Correa');
INSERT INTO ichord.assinatura VALUES(88277732741, '11','Jane Lucia Goncalves');
INSERT INTO ichord.assinatura VALUES(77670053229, '12','Nathalia Oliveira Barreto');
INSERT INTO ichord.assinatura VALUES(68152155714, '13','Quevaldo da Silva Sampaio');
INSERT INTO ichord.assinatura VALUES(86207173679, '14','Senilda Francisca Nitz');
INSERT INTO ichord.assinatura VALUES(53016682266, '15','Lara Sofia Hasson');
INSERT INTO ichord.assinatura VALUES(11452884308, '16','Helder Amaral Sebroeck');
INSERT INTO ichord.assinatura VALUES(53610320771, '17','Elias Eneas Spader');
INSERT INTO ichord.assinatura VALUES(26541851094, '18','Talita Teixeira da Chinelato');
INSERT INTO ichord.assinatura VALUES(57625553729, '19','Patricia Venancio Almeida');
INSERT INTO ichord.assinatura VALUES(28645637465, '20','Fernanda Zanin Tisatto');

select * from ichord.assinatura order by user_id asc;

---------------------------------------------------------------------------------------------
drop table tipo_assinatura;
create table if not exists ichord.tipo_assinatura
	(
		tipo_assinatura_id integer not null primary key,
			assinatura_tipo enum('grátis','mensal', 'anual') DEFAULT 'grátis' not null,
			user_id integer not null REFERENCES usuario
		);
        
INSERT INTO ichord.tipo_assinatura VALUES('1','grátis', '1');
INSERT INTO ichord.tipo_assinatura VALUES('2','mensal', '2');
INSERT INTO ichord.tipo_assinatura VALUES('3','mensal', '3');
INSERT INTO ichord.tipo_assinatura VALUES('4','mensal', '4');
INSERT INTO ichord.tipo_assinatura VALUES('5','grátis', '5');
INSERT INTO ichord.tipo_assinatura VALUES('6','grátis', '6');
INSERT INTO ichord.tipo_assinatura VALUES('7','mensal', '7');
INSERT INTO ichord.tipo_assinatura VALUES('8','mensal', '8');
INSERT INTO ichord.tipo_assinatura VALUES('9','grátis', '9');
INSERT INTO ichord.tipo_assinatura VALUES('10','anual', '10');
INSERT INTO ichord.tipo_assinatura VALUES('11','grátis', '11');
INSERT INTO ichord.tipo_assinatura VALUES('12','grátis', '12');
INSERT INTO ichord.tipo_assinatura VALUES('13','mensal', '13');
INSERT INTO ichord.tipo_assinatura VALUES('14','grátis', '14');
INSERT INTO ichord.tipo_assinatura VALUES('15','anual', '15');
INSERT INTO ichord.tipo_assinatura VALUES('16','grátis', '16');
INSERT INTO ichord.tipo_assinatura VALUES('17','grátis', '17');
INSERT INTO ichord.tipo_assinatura VALUES('18','mensal', '18');
INSERT INTO ichord.tipo_assinatura VALUES('19','grátis', '19');
INSERT INTO ichord.tipo_assinatura VALUES('20','anual', '20');

select * from ichord.tipo_assinatura;