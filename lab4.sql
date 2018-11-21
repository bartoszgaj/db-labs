--Lab4
-- Zapytania oparte na wielu tabelach.

--4.1 - Porównaj wyniki poniższych zapytań:
--1
SELECT k.nazwa FROM klienci k;
--2
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z;
--3
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z WHERE z.idklienta = k.idklienta;
--4
SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z;
--5
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z ON z.idklienta=k.idklienta;
--6
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z USING (idklienta);
--W którym zapytaniu występuje iloczyn kartezjański?
--Które zapytanie dostarcza bezwartościowych danych?

--4.2 - Napisz zapytanie w języku SQL wyświetlające informacje na temat zamówień (data realizacji, idzamowienia), które:
--1 - zostały złożone przez klienta, który ma na imię Antoni,
--2 - zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica),
--3 - zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.

--4.3 - Napisz zapytanie w języku SQL wyświetlające informacje na temat klientów (nazwa, ulica, miejscowość), którzy:
--1 - złożyli zamówienia z datą realizacji nie starszą niż sprzed pięciu lat,
--2 - zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,
--3 - złożyli przynajmniej jedno zamówienie,
--4 - nie złożyli żadnych zamówień, (złożenie zewnętrzne)
--5 - złożyli zamówienia z datą realizacji w listopadzie 2013,
--6 - zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia,
--7 - zamówili pudełka, które zawierają czekoladki z migdałami.


--4.4 - Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek i ich zawartości (nazwa, opis, nazwa czekoladki, opis czekoladki):
--1 - wszystkich pudełek,
--2 - pudełka o wartości klucza głównego heav,
--3 - pudełek, których nazwa zawiera słowo Kolekcja.

--4.5 - Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek z czekoladkami (nazwa, opis, cena), które:
--1 - zawierają czekoladki o wartości klucza głównego d09
--2 - zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S,
--3 - zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym),
--4 - zawierają czekoladki z nadzieniem truskawkowym,
--5 - nie zawierają czekoladek w gorzkiej czekoladzie, (można wykorzystać operator EXCEPT)
--6 - zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa,
--7 - nie zawierają czekoladek z orzechami, (można wykorzystać operator EXCEPT)
--8 - zawierają czekoladki Gorzka truskawkowa,
--9 - zawierają przynajmniej jedną czekoladkę bez nadzienia.

-- Uwaga: Zdania: “Pudełko nie zawiera czekoladek w gorzkiej czekoladzie.” i “Pudełko zawiera jakieś czekoladki, które nie są w gorzkiej czekoladzie” nie oznaczają tego samego ;)

--4.6 - Napisz poniższe zapytania w języku SQL (należy użyć samozłączeń (złączeń własnych)):

--1 - Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od kosztu czekoladki o wartości klucza głównego równej d08.
--2 - Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Górka Alicja. (można znacznie uprościć stosując konstrukcję z WITH)
--3 - Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.
