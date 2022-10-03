create schema if not exists pics;

drop table gerente;
create table if not exists gerente (
	user_id int not null primary key auto_increment,
    nome_gerente varchar(30) not null
);

insert into gerente values ('1', 'Paulo');

drop table usina;
create table if not exists usina(
	id_usina int not null primary key auto_increment,
    nome_usina varchar(50) not null,
    endereco_usina varchar(50) not null
);
insert into usina values ('1', 'Hidrelétrica de Itaipu', 'Itaipu');
insert into usina values ('2', 'Hidrelétrica de IBelo Monte', 'Belo Monte');
insert into usina values ('3', 'Hidrelétrica de Tucuruí', 'Tucuruí');


drop table pontuacao;
create table if not exists pontuacao(
	id_usina int not null REFERENCES usina,
	id_pontuacao int not null primary key,
    id_area int not null REFERENCES area_quest,
    qnt_pontos double not null
);
insert into pontuacao values('1', '1', '1', '5');
insert into pontuacao values('2', '2', '1', '3');
insert into pontuacao values('3', '3', '1', '1');

drop table questoes;
create table if not exists questoes(
	id_questao int not null primary key,
    id_area int not null REFERENCES area_quest,
    desc_questao varchar(80) not null
);
insert into questoes values('1', '1', 'Há uma Zona DMZ Operativa na rede ?');

drop table area_quest;
create table if not exists area_quest(
	id_area int not null primary key,
    nome_area varchar(50) not null
);
insert into area_quest values('1', 'Firewalls');

drop table resposta_quest;
create table if not exists resposta_quest(
	resp_quest varchar(8) not null key,
    id_area int not null REFERENCES area_quest,
    nome_area varchar(20) not null REFERENCES area_quest,
    nome_usina varchar(50) not null REFERENCES usina,
    id_usina int not null REFERENCES usina
);
insert into resposta_quest values('Sim', '1', 'Firewalls', 'Hidrelétrica de Itaipu', '1');

drop table sugestao;
create table if not exists sugestao(
	id_sugestao int not null primary key,
    id_area int not null REFERENCES area_quest,
    id_usina int not null REFERENCES usina,
    qnt_pontos double not null REFERENCES pontuacao,
    sugest_texto varchar (200) not null
);
insert into sugestao values ('1', '1', '1','5', 'Parabéns! Seu sistema tem um bom Firewall.');

select * from pontuacao;
select * from usina;
select * from questoes;
select * from area_quest;
select * from resposta_quest;
select * from sugestao;
