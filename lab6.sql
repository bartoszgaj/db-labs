--Lab6
--Manipulowanie danymi, instrukcje INSERT, UPDATE, DELETE.

--6.1
--1 - Napisz i wykonaj zapytanie (użyj INSERT), które dodaje do tabeli czekoladki następujące informacje:
insert into czekoladki values('w98', 'Biały kieł', 'biała', 'laskowe', 'marcepan','Rozpływające się w rękach i kieszeniach', 45, 0.20);
--2 - Napisz i wykonaj trzy zapytania (użyj INSERT), które dodadzą do tabeli klienci następujące dane osobowe:
insert into klienci values
(90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');
--3 - Dodaj do tabeli klienci dane Izy Matusiak (idklienta 93). Pozostałe dane osobowe Izy Matusiak muszą być takie same jak dla Pana Edwarda Matusiaka. Użyj podzapytań.
insert into klienci (select '93', 'Matusiak Iza', ulica, miejscowosc, kod, telefon from klienci where nazwa = 'Matusiak Edward');
--4 Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.
select * from klienci;
select * from czekoladki;
--6.2
--1 - Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj wartości NULL w poleceniu INSERT:
insert into czekoladki values
('x91', 'Nieznana Nieznajoma', null, null, null, 'Niewidzialna czekoladka wspomagajaca odchudzanie.',26,0.0),
('m98', 'Mleczny Raj', 'mleczna', null, null, 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.',26,0.36);

--2 - Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.
select * from czekoladki;

--6.3
--1 - Napisz zapytanie, które usunie informacje dodane w Zadaniu 6.2, użyj DELETE.
delete from czekoladki where idczekoladki in ('x91','m98');
--2 - Sprawdź, czy odpowiednie rekordy zostały usunięte.
select * from czekoladki;
--3 - Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj nazwy kolumn w poleceniu INSERT:
insert into czekoladki(idczekoladki, nazwa, czekolada ,opis, koszt, masa) values
  ('x91','Nieznana nieznajoma',null,'Niewidzialna czekoladka wspomagajaca odchudzanie.',26,0),
  ('m98', 'Mleczny Raj','mleczna','Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.',26,36);
--4 - Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.

--6.4 - Napisz instrukcje aktualizujące dane w bazie cukiernia. Sprawdź za pomocą instrukcji SELECT, czy odpowiednie rekordy zostały zmienione.
--1 - Zmiana nazwiska Izy Matusiak na Nowak.
update klienci set nazwa = 'Nowak Iza' where nazwa = 'Matusiak Iza';
--2 - Obniżenie kosztu czekoladek o identyfikatorach (idczekoladki): W98, M98 i X91, o 10%.
update czekoladki set koszt = 0.9 * koszt where idczekoladki in ('w98','m98', 'x91');
--3 - Ustalenie kosztu czekoladek o nazwie Nieznana Nieznajoma na taką samą jak cena czekoladki o identyfikatorze W98.
update czekoladki set koszt = (select koszt from czekoladki where idczekoladki = 'w98') where nazwa = 'Nieznana nieznajoma';
--4 - Zmiana nazwy z Leningrad na Piotrograd w tabeli klienci.
update klienci set miejscowosc = 'Piotrograd' where miejscowosc = 'Leningrad';
--5 - Podniesienie kosztu czekoladek, których dwa ostatnie znaki identyfikatora (idczekoladki) są większe od 90, o 15 groszy.
update czekoladki set koszt = koszt + 0.15 where substr(idczekoladki, 2,3)::integer > 90;

--6.5 - Napisz instrukcje usuwające z bazy danych informacje o:
--1 - klientach o nazwisku Matusiak,
delete from klienci where nazwa like 'Matusiak%';
--2 - klientach o identyfikatorze większym niż 91,
delete from klienci where idklienta > 91;
--3 - czekoladkach, których koszt jest większy lub równy 0.45 lub masa jest większa lub równa 36, lub masa jest równa 0.
delete from czekoladki where koszt >= 0.45 or masa >=36 or masa = 0;
--6.6
--1 - Napisz skrypt zawierający instrukcje INSERT wstawiające do bazy danych Cukiernia dwa nowe rekordy do tabeli Pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli Zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.
select * from pudelka;
select * from zawartosc;
insert into pudelka values
  ('bali','Moje pudełeczko', 'Specjalnie przygotowane dla mnie', 69.00, 1000),
  ('apud','Pudelko pisane wspak', '!okzcełedup enjaf elA', 96.00, 9999);
insert into zawartosc values
  ('bali', 'b02', 5),
  ('bali', 'b04', 7),
  ('bali', 'm01', 3),
  ('bali', 'b06', 5),
  ('apud', 'b07', 4),
  ('apud', 'm08', 8),
  ('apud', 'm05', 1),
  ('apud', 'm17', 4);
--6.7
--1 - Polecenie COPY pozwala m.in. kopiowanie danych między bazą danych i standardowym systemem plików. Polecenie COPY FROM kopiuje dane z pliku do wskazanej tabeli. Domyślnie wartości atrybutów są oddzielane tabulatorem, zaś NULL jest oznaczany symbolem \N. Polecenie COPY TO kopiuje dane z bazy danych (cała tabela, wybrane kolumny lub wynik instrukcji SELECT) do pliku. Opcje polecenia pozwalają zdefiniować m.in. separator, oznaczenia wartości null, oznaczenie napisu pustego itp. http://www.postgresql.org/docs/9.1/static/sql-copy.html
--2 - Napisz skrypt zawierający instrukcje COPY wstawiające do bazy danych cukiernia dwa nowe rekordy do tabeli pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.

--6.8
--1 - Napisz instrukcję UDPATE, która dla pudełek dodanych w poprzednich dwóch zadaniach, zwiększa o 1 liczbę czekoladek każdego smaku, które w nich występują.
update zawartosc set sztuk = sztuk + 1 where idpudelka in ('bali', 'apud');
--2 - Napisz skrypt zawierający instrukcje UPDATE, które modyfikują tabelę czekoladki zastępując w kolumnach: czekolada, orzechy i nadzienie wartości Null wartością “brak”.
update czekoladki set czekolada = 'brak' where czekolada is null;
update czekoladki set orzechy = 'brak' where orzechy is null;
update czekoladki set nadzienie = 'brak' where nadzienie is null;
--3 - Napisz skrypt zawierający instrukcje UPDATE, które anulują zmiany wprowadzone w poprzednim punkcie.
update czekoladki set czekolada = null where czekolada = 'brak';
update czekoladki set orzechy = null where orzechy = 'brak';
update czekoladki set nadzienie = null where nadzienie = 'brak';
