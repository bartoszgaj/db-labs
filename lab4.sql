--Lab4
-- Zapytania oparte na wielu tabelach.

--4.1 - Porównaj wyniki poniższych zapytań: ZŁĄCZENIA TABEL
--1
SELECT k.nazwa FROM klienci k;
--klienci z tablicy klienci
--2
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z;
--klienci i zamówienia - każdy z każdym
--3
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z WHERE z.idklienta = k.idklienta;
--5
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z ON z.idklienta=k.idklienta;
--6
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z USING (idklienta);
--4
SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z;
--W którym zapytaniu występuje iloczyn kartezjański? W 2.
--Które zapytanie dostarcza bezwartościowych danych? No 2.

--4.2 - Napisz zapytanie w języku SQL wyświetlające informacje na temat zamówień (data realizacji, idzamowienia), które:
--1 - zostały złożone przez klienta, który ma na imię Antoni,
SELECT * FROM zamowienia natural join klienci;
SELECT datarealizacji, idzamowienia, nazwa FROM zamowienia natural join klienci where nazwa like '% Antoni';
--2 - zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica),
SELECT datarealizacji, idzamowienia, ulica FROM zamowienia natural join klienci where ulica like '%/%';
--3 - zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.
SELECT datarealizacji, idzamowienia, miejscowosc FROM zamowienia natural join klienci where miejscowosc = 'Kraków' and extract(month from datarealizacji) = 11 and extract(year from datarealizacji) = 2013;

--4.3 - Napisz zapytanie w języku SQL wyświetlające informacje na temat klientów (nazwa, ulica, miejscowość), którzy:
--1 - złożyli zamówienia z datą realizacji nie starszą niż sprzed pięciu lat,
SELECT nazwa, ulica, miejscowosc, datarealizacji from klienci natural join zamowienia where datarealizacji < now() - interval '5 years';
--2 - zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,
select k.nazwa, ulica, miejscowosc, p.nazwa from klienci k natural join zamowienia z natural join artykuly a join pudelka p using (idpudelka) where p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna');
--3 - złożyli przynajmniej jedno zamówienie,
select distinct nazwa from zamowienia natural join klienci;
--4 - nie złożyli żadnych zamówień, (złożenie zewnętrzne)
--TODO - złożenia zewnętrzne
select distinct nazwa from klienci full join zamowienia using(idklienta) where idzamowienia is null;
--5 - złożyli zamówienia z datą realizacji w listopadzie 2013,
SELECT nazwa, datarealizacji, idzamowienia FROM zamowienia natural join klienci where extract(month from datarealizacji) = 11 and extract(year from datarealizacji) = 2013;
--6 - zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia,
select k.nazwa, a.sztuk, p.nazwa from klienci k natural join zamowienia natural join artykuly a join pudelka p using (idpudelka) where p.nazwa in ('Kremowa fantazja', 'Kolekcja jesienna') and a.sztuk >=2;
--7 - zamówili pudełka, które zawierają czekoladki z migdałami.
select distinct k.nazwa, orzechy from klienci k natural join zamowienia natural join artykuly join pudelka using (idpudelka) join zawartosc using (idpudelka) join czekoladki using (idczekoladki)
where orzechy = 'migdały';

--4.4 - Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek i ich zawartości (nazwa, opis, nazwa czekoladki, opis czekoladki):
--1 - wszystkich pudełek,
select p.nazwa, p.opis, c.nazwa, c.opis from pudelka p natural join zawartosc z join czekoladki c using(idczekoladki) order by 1;
--2 - pudełka o wartości klucza głównego heav,
select p.idpudelka, p.nazwa, p.opis, c.nazwa, c.opis from pudelka p natural join zawartosc z join czekoladki c using(idczekoladki) where p.idpudelka = 'heav';
--3 - pudełek, których nazwa zawiera słowo Kolekcja.
select p.nazwa, p.opis, c.nazwa, c.opis from pudelka p natural join zawartosc z join czekoladki c using(idczekoladki) where p.nazwa like '%Kolekcja%';


--4.5 - Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek z czekoladkami (nazwa, opis, cena), które:
--1 - zawierają czekoladki o wartości klucza głównego d09
select c.idczekoladki, p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki) where c.idczekoladki = 'd09';
--2 - zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S,
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki) where c.nazwa like 'S%';
--3 - zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym),
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki) where z.sztuk >= 3;
--4 - zawierają czekoladki z nadzieniem truskawkowym,
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki) where c.nadzienie = 'truskawki';
--5 - nie zawierają czekoladek w gorzkiej czekoladzie, (można wykorzystać operator EXCEPT)
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki)
EXCEPT
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki) where czekolada = 'gorzka';
--6 - zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa,
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc z join czekoladki c using (idczekoladki) where z.sztuk >=3 and c.nazwa = 'Gorzka truskawkowa';
--7 - nie zawierają czekoladek z orzechami, (można wykorzystać operator EXCEPT)
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki)
EXCEPT
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki) where orzechy is not null;
--8 - zawierają czekoladki Gorzka truskawkowa,
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki) where c.nazwa = 'Gorzka truskawkowa';
--9 - zawierają przynajmniej jedną czekoladkę bez nadzienia.
select distinct p.nazwa, p.opis, p.cena from pudelka p natural join zawartosc join czekoladki c using (idczekoladki) where c.nadzienie is null;

-- Uwaga: Zdania: “Pudełko nie zawiera czekoladek w gorzkiej czekoladzie.” i “Pudełko zawiera jakieś czekoladki, które nie są w gorzkiej czekoladzie” nie oznaczają tego samego ;)

--4.6 - Napisz poniższe zapytania w języku SQL (należy użyć samozłączeń (złączeń własnych)):
--1 - Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od kosztu czekoladki o wartości klucza głównego równej d08.
select c1.idczekoladki, c1.nazwa, c1.koszt, c2.idczekoladki, c2.nazwa, c2.koszt from czekoladki c1, czekoladki c2 where c2.idczekoladki = 'd08' and c1.koszt > c2.koszt;
--2 - Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Górka Alicja. (można znacznie uprościć stosując konstrukcję z WITH)
select distinct k2.nazwa from klienci k1 natural join zamowienia z1 natural join artykuly a1, klienci k2 natural join zamowienia z2 natural join artykuly a2 where k1.nazwa = 'Górka Alicja' and a1.idpudelka = a2.idpudelka;
--3 - Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.
select distinct k2.nazwa from klienci k1 natural join zamowienia z1 natural join artykuly a1, klienci k2 natural join zamowienia z2 natural join artykuly a2 where k1.miejscowosc = 'Katowice' and a1.idpudelka = a2.idpudelka;
