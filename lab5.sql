--Lab5
--Zapytania wykorzystujące funkcje agregujące i elementy podzapytań (podzapytania skalarne).

--5.1 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - łącznej liczby czekoladek w bazie danych,
select count(*) from czekoladki;
--2 - łącznej liczby czekoladek z nadzieniem (na 2 sposoby) - podpowiedź: count(*), count(nazwaKolumny),
select count(*) from czekoladki where nadzienie is not null;
select count(nadzienie) from czekoladki;
--3 - pudełka, w którym jest najwięcej czekoladek (uwaga: konieczne jest użycie LIMIT),
select sum(sztuk) from zawartosc group by idpudelka order by 1 desc limit 1;
--4 - łącznej liczby czekoladek w poszczególnych pudełkach,
select idpudelka, sum(sztuk) from zawartosc group by idpudelka order by 2 desc;
--5 - łącznej liczby czekoladek bez orzechów w poszczególnych pudełkach,
select idpudelka, sum(sztuk) from zawartosc natural join czekoladki where orzechy is null group by idpudelka order by 2 desc;
--6 - łącznej liczby czekoladek w mlecznej czekoladzie w poszczególnych pudełkach.
select idpudelka, sum(sztuk) from zawartosc natural join czekoladki where czekolada = 'mleczna' group by idpudelka order by 2 desc;

--5.2 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - masy poszczególnych pudełek,
select idpudelka, sum(masa * sztuk) from zawartosc natural join czekoladki group by idpudelka order by 2 desc;
--2 - pudełka o największej masie,
select idpudelka, sum(masa * sztuk) from zawartosc natural join czekoladki group by idpudelka order by 2 desc limit 1;
--3 - średniej masy pudełka w ofercie cukierni,
select avg(pudelka.masa) from (select sum(masa * sztuk) as masa from zawartosc natural join czekoladki group by idpudelka) pudelka;
--4 - średniej wagi pojedynczej czekoladki w poszczególnych pudełkach,
select idpudelka, avg(masa * sztuk) as masa from zawartosc natural join czekoladki group by idpudelka order by 2 desc;
--5.3 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - liczby zamówień na poszczególne dni,
select datarealizacji, count(*) from zamowienia group by datarealizacji order by 1;
--2 - łącznej liczby wszystkich zamówień,
select count(*) from zamowienia;
--3 - łącznej wartości wszystkich zamówień,
select sum(cena*sztuk) from artykuly natural join pudelka;
--4 - klientów, liczby złożonych przez nich zamówień i łącznej wartości złożonych przez nich zamówień.
select idklienta, count(*), sum(cena * sztuk) from klienci natural join zamowienia natural join artykuly join pudelka using (idpudelka) group by idklienta order by 1;

--5.4 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - czekoladki, która występuje w największej liczbie pudełek,
select idczekoladki, count(*) from zawartosc group by idczekoladki order by 2 desc limit 1;
--2 - pudełka, które zawiera najwięcej czekoladek bez orzechów,
select idpudelka, sum(sztuk) from zawartosc natural join czekoladki where orzechy is null group by idpudelka order by 2 desc;
--TODO check
--3 - czekoladki, która występuje w najmniejszej liczbie pudełek,
select idczekoladki, count(*) from zawartosc group by idczekoladki order by 2 asc limit 1;
--4 - pudełka, które jest najczęściej zamawiane przez klientów.
select idpudelka, count(*) from artykuly group by idpudelka order by 2 desc limit 1;

--5.5 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - liczby zamówień na poszczególne kwartały,
select extract(quarter from datarealizacji), count(*) from zamowienia group by extract(quarter from datarealizacji);
--2 - liczby zamówień na poszczególne miesiące,
select extract(year from datarealizacji) as "Rok", extract(month from datarealizacji) as "Miesiąc", count(*) from zamowienia group by extract(year from datarealizacji), extract(month from datarealizacji) order by extract(year from datarealizacji), extract(month from datarealizacji);
--3 - liczby zamówień do realizacji w poszczególnych tygodniach,
select extract(year from datarealizacji) as "Rok", extract(week from datarealizacji) as "Tydzien", count(*) from zamowienia group by extract(year from datarealizacji), extract(week from datarealizacji) order by extract(year from datarealizacji), extract(week from datarealizacji);
--4 - liczby zamówień do realizacji w poszczególnych miejscowościach.
select miejscowosc, count(*) from zamowienia natural join klienci group by miejscowosc order by 2 desc;

--5.6 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - łącznej masy wszystkich pudełek czekoladek znajdujących się w cukierni,
select sum(stan*sztuk*masa) from pudelka natural join zawartosc join czekoladki using(idczekoladki);
--2 - łącznej wartości wszystkich pudełek czekoladek znajdujących się w cukierni.
select sum(stan*cena) from pudelka;

--5.7 - Zakładając, że koszt wytworzenia pudełka czekoladek jest równy kosztowi wytworzenia zawartych w nim czekoladek, napisz zapytanie wyznaczające:
--1 - zysk ze sprzedaży jednej sztuki poszczególnych pudełek (różnica między ceną pudełka i kosztem jego wytworzenia),
SELECT idpudelka, cena - sum(koszt*sztuk) as "Zysk" from pudelka natural join zawartosc join czekoladki using(idczekoladki) group by idpudelka;
--2 - zysk ze sprzedaży zamówionych pudełek,
SELECT sum(zamowienia.zysk * a.sztuk ) from (SELECT idpudelka, p.cena - sum(koszt*sztuk) as zysk from pudelka p natural join zawartosc z join czekoladki using(idczekoladki)  group by idpudelka) zamowienia natural join artykuly a;
--3 - zysk ze sprzedaży wszystkich pudełek czekoladek w cukierni.
SELECT sum(zamowienia.zysk) from (SELECT idpudelka, p.stan*(p.cena - sum(koszt*sztuk)) as zysk from pudelka p natural join zawartosc z join czekoladki using(idczekoladki)  group by idpudelka) zamowienia;
--5.8 - Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.
--Uwaga: Można zastosować samozłączenie.
SELECT (select count(*) from pudelka p2 where p1.idpudelka >= p2.idpudelka) as nr, p1.idpudelka from pudelka p1

select row_number() over (order by idpudelka) as nr, idpudelka from pudelka;
