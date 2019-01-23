DROP SCHEMA IF EXISTS kwiaciarnia CASCADE;
CREATE SCHEMA IF NOT EXISTS kwiaciarnia;

create table kwiaciarnia.klienci (
  idklienta varchar(10) PRIMARY KEY,
  haslo varchar(10) check(length(haslo) >= 4),
  nazwa varchar(40) not null,
  miasto varchar(40) not null,
  kod char(40) not null,
  adres varchar(40) not null,
  email varchar(40),
  telefon varchar(16) not null,
  fax varchar(16),
  nip char(13),
  regon char(9)
);

create table kwiaciarnia.kompozycje (
  idkompozycji char(5) primary key,
  nazwa varchar(40) not null,
  opis varchar(100),
  cena numeric(7,2) check (cena <= 40),
  minimum integer,
  stan integer
);

create table kwiaciarnia.odbiorcy (
  idodbiorcy serial primary key,
  nazwa varchar(40) not null,
  miasto varchar(40) not null,
  kod varchar(6) not null,
  adres varchar(40) not null
);

create table kwiaciarnia.zamowienia (
  idzamowienia integer primary key,
  idklienta varchar(10) not null references kwiaciarnia.klieci,
  idodbiorcy integer not null references kwiaciarnia.odbiorcy,
  idkompozycji char(5) not null references kwiaciarnia.kompozycje,
  termin date not null,
  cena numeric(7,2),
  zaplacone boolean,
  uwagi varchar(200),
);

create table kwiaciarnia.historia (
  idzamowienia integer primary key,
  idklienta varchar(10),
  idkompozycji char(5),
  cena numeric(7,2),
  termin date

);
create table kwiaciarnia.zapotrzebowanie (
  idkompozycji char(5) primary key references kwiaciarnia.kompozycje,
  data date
);
