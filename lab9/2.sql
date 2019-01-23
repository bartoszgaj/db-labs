drop schema if exists firma cascade;
create schema if not exists firma;

create table firma.dzialy(
  iddzialu char(5) primary key,
  nazwa varchar(32) not null,
  lokalizacja varchar(24) not null,
  kierownik integer
);

create table firma.pracownicy(
  idpracownika integer primary key,
  nazwisko varchar(32) not null,
  imie varchar(16) not null,
  dataUrodzenia date not null,
  dzial char(5) not null references firma.dzialy,
  stanowisko varchar(24),
  pobory numeric(7,2)
);

alter table dzialy add constraint dzial_fk foreign key(kierownik)
  references pracownicy(idpracownika) on update cascade deferrable;
