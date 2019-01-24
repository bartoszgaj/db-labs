10.1
SELECT DISTINCT nazwa
FROM pudelka NATURAL JOIN zawartosc
WHERE idczekoladki
  IN (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3);
Zwraca te czekoladki, które zwróciło podzapytanie(3 najtańsze/najdroższe)

SELECT nazwa
FROM czekoladki
WHERE koszt = (SELECT MAX(koszt) FROM czekoladki);
Zwraca najdroższą czekoladke (najdroższe)

SELECT p.nazwa, idpudelka
FROM (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3)
  AS ulubioneczekoladki
NATURAL JOIN zawartosc
NATURAL JOIN pudelka p;
Zwraca czekoladki które znajdują się w 3 nadroższych / najtańszych pudełkach

SELECT nazwa, koszt, (SELECT MAX(koszt) FROM czekoladki) AS MAX FROM czekoladki;
Dodaje kolumne z maxem

10.2
in/not in/exists/any/all,

1. zostały złożone przez klienta, który ma na imię Antoni,
select * from zamowienia where idklienta in (select idklienta from klienci where nazwa like '%Antoni%');
2. zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica),
select * from zamowienia where idklienta in (select idklienta from klienci where ulica like '%/%');
3.★ zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.
select * from zamowienia where extract(year from datarealizacji) = 2013 and extract(month from datarealizacji) = 11 and idklienta in (select idklienta from klienci where miejscowosc = 'Kraków' )

10.3
1. złożyli zamówienia z datą realizacji 12.11.2013,
select * from klienci where idklienta in (select idklienta from zamowienia where datarealizacji = '12-11-2013');
2. złożyli zamówienia z datą realizacji w listopadzie 2013,
select * from klienci where idklienta in (select idklienta from zamowienia where extract(month from datarealizacji) = 11 and extract(year from datarealizacji) = 2013);
3. zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,
select * from klienci where idklienta in
    (select idklienta from zamowienia where idzamowienia in
        (select idzamowienia from artykuly where idpudelka in
              (select idpudelka from pudelka where nazwa in ('Kremowa fantazja','Kolekcja jesienna'))));
lub
select DISTINCT k.nazwa,ulica,miejscowosc from klienci k natural join zamowienia natural join artykuly join pudelka p using (idpudelka) where p.nazwa in ('Kremowa fantazja','Kolekcja jesienna')
lub
select DISTINCT nazwa,ulica,miejscowosc from klienci natural join zamowienia natural join artykuly where idpudelka in (select idpudelka from pudelka where nazwa in ('Kremowa fantazja','Kolekcja jesienna'));
4. zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia,
select * from klienci where idklienta in
    (select idklienta from zamowienia where idzamowienia in
          (select idzamowienia from artykuly where sztuk >=2 and idpudelka in
                (select idpudelka from pudelka where nazwa in ('Kremowa fantazja','Kolekcja jesienna'))))

5. zamówili pudełka, które zawierają czekoladki z migdałami,
select * from klienci where idklienta in
    (select idklienta from zamowienia where idzamowienia in
          (select idzamowienia from artykuly where idpudelka in
                (select idpudelka from pudelka where idpudelka in
                      (select idpudelka from zawartosc where idczekoladki in
                            (select idczekoladki from czekoladki where orzechy = 'migdały')))))
6. złożyli przynajmniej jedno zamówienie,
select * from klienci where idklienta in (select idklienta from zamowienia);
7. nie złożyli żadnych zamówień.
select * from klienci where idklienta not in (select idklienta from zamowienia);
-- z exists
select * from klienci k where not exists (select * from zamowienia z where z.idklienta = k.idklienta);

10.4 Napisz zapytanie wyświetlające informacje na temat pudełek z czekoladkami (nazwa, opis, cena), używając odpowiedniego operatora, np. in/not in/exists/any/all, które:
1.★ zawierają czekoladki o wartości klucza głównego D09
select * from pudelka where idpudelka in (select idpudelka from zawartosc where idczekoladki = 'd09');
select * from pudelka where idpudelka = any(select idpudelka from zawartosc where idczekoladki = 'd09');
2.★ zawierają czekoladki Gorzka truskawkowa,
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc where idczekoladki in
          (select idczekoladki from czekoladki where nazwa = 'Gorzka truskawkowa'));
3.★ zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S,
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc where idczekoladki in
          (select idczekoladki from czekoladki where nazwa like 'S%'));
4.★ zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym),
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc where sztuk >= 4)
5.★ zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa,
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc where sztuk >= 3 and idczekoladki in
          (select idczekoladki from czekoladki where nazwa = 'Gorzka truskawkowa'));
6.★ zawierają czekoladki z nadzieniem truskawkowym,
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc where idczekoladki in
          (select idczekoladki from czekoladki where nadzienie = 'truskawki'));
7.nie zawierają czekoladek w gorzkiej czekoladzie,
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc where idczekoladki not in
          (select idczekoladki from czekoladki where czekolada = 'gorzka'));
8.nie zawierają czekoladek z orzechami,
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc where idczekoladki in
          (select idczekoladki from czekoladki where orzechy is not null));
9.zawierają przynajmniej jedną czekoladkę bez nadzienia.
select * from pudelka where idpudelka in
    (select idpudelka from zawartosc z where exists
          (select * from czekoladki c where nadzienie is null and c.idczekoladki = z.idczekoladki ));


10.5Napisz poniższe zapytania w języku SQL (używając odpowiedniego operatora, np. in/not in/exists/any/all):
1. Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od czekoladki o wartości klucza głównego równej D08.
select * from czekoladki where koszt > (select koszt from czekoladki where idczekoladki = 'd08')
2.★ Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Gorka Alicja.
select distinct k.nazwa from klienci k natural join zamowienia natural join artykuly where idpudelka in (select idpudelka from klienci natural join zamowienia natural join artykuly where nazwa = 'Górka Alicja');
3.★ Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.
select distinct nazwa, ulica from klienci natural join zamowienia natural join artykuly where idpudelka in (select idpudelka from klienci natural join zamowienia natural join artykuly where miejscowosc = 'Katowice');

10.6
1.pudełka o największej liczbie czekoladek (bez użycia klauzuli limit),

select distinct nazwa, sum(sztuk) from pudelka natural join zawartosc group by idpudelka having sum(sztuk) = ( select max(p.sumy) from (select sum(sztuk) as sumy from zawartosc group by idpudelka) p );
2.★ pudełka o najmniejszej liczbie czekoladek (bez użycia klauzuli limit),
select distinct nazwa, sum(sztuk) from pudelka natural join zawartosc group by idpudelka having sum(sztuk) = ( select min(p.sumy) from (select sum(sztuk) as sumy from zawartosc group by idpudelka) p );
3.★ pudełka, w którym liczba czekoladek jest powyżej średniej.
select distinct nazwa, sum(sztuk) from pudelka natural join zawartosc group by idpudelka having sum(sztuk) > ( select avg(p.sumy) from (select sum(sztuk) as sumy from zawartosc group by idpudelka) p );
4.★ pudełka o największej lub najmniejszej liczbie czekoladek.
with p as (select sum(sztuk) as sumy from zawartosc group by idpudelka)
select distinct nazwa, sum(sztuk) from pudelka natural join zawartosc group by idpudelka having sum(sztuk) = ( select max(p.sumy) from p ) or sum(sztuk) = ( select min(p.sumy) from p ) ;
-- or
with p as (select sum(sztuk) as sumy from zawartosc group by idpudelka)
select distinct nazwa, sum(sztuk) from pudelka natural join zawartosc group by idpudelka having sum(sztuk) in (( select max(p.sumy) from p ) , ( select min(p.sumy) from p )) ;

10.7
Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.
Użyj podzapytania w klauzuli select: select kolumna1, kolumna2, (select ...) from ...

select nazwa, (select count(*) + 1 from pudelka p1 where p2.idpudelka < p1.idpudelka) from pudelka p2 order by 2 asc;
