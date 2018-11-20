--Lab3
--Selekcja oparta na jednej tabeli: funkcje operujące na datach i napisach, porównywanie wzorców (like, similar to). Łączenie wyników zapytań (union, intersect, except). Obliczenia w zapytaniach.

--3.1 - Napisz zapytanie w języku SQL wyświetlające informacje na temat zamówień, które mają być zrealizowane:
--1 - między 12 i 20 listopada 2013,
select * from zamowienia where datarealizacji between '2013-11-12' and '2013-11-20';
--2 - między 1 i 6 grudnia lub między 15 i 20 grudnia 2013
select * from zamowienia where datarealizacji between '2013-12-01' and '2013-12-06' or datarealizacji between '2013-12-15' and '2013-12-20';
--3 - w grudniu 2013 (nie używaj funkcji date_part ani extract),
select * from zamowienia where datarealizacji between '2013-12-01' and '2013-12-30';
--4 - w listopadzie 2013 (w tym i kolejnych zapytaniach użyj funkcji date_part lub extract),
select * from zamowienia where extract(month from datarealizacji) = 11;
--5 - w listopadzie lub grudniu 2013,
select * from zamowienia where extract(month from datarealizacji) in (11,12);
--6 - 17, 18 lub 19 dnia miesiąca,
TODO - zle sie wypisuje?
select * from zamowienia where extract(day from datarealizacji) in(17,18,19);
--7 - 46 lub 47 tygodniu roku.
select * from zamowienia where extract(week from datarealizacji) in (46,47);

--3.2 - Napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek, których nazwa:
--1 - rozpoczyna się na literę 'S',
select nazwa from czekoladki where nazwa like 'S%'
--2 - rozpoczyna się na literę 'S' i kończy się na literę 'i',
select nazwa from czekoladki where nazwa like 'S%i'
--3 - rozpoczyna się na literę 'S' i zawiera słowo rozpoczynające się na literę 'm',
select nazwa from czekoladki where nazwa like 'S% m%'
--4 - rozpoczyna się na literę 'A', 'B' lub 'C',
select nazwa from czekoladki where nazwa similar to '(A|B|C)%'
--5 - zawiera rdzeń 'orzech' (może on wystąpić na początku i wówczas będzie pisany z wielkiej litery),,
select nazwa from czekoladki where nazwa similar to ('(O|o)rzech%');
--6 - rozpoczyna się na literę 'S' i zawiera w środku literę 'm',
select nazwa from czekoladki where nazwa like 'S%m%';
--7 - zawiera słowo 'maliny' lub 'truskawki',
select nazwa from czekoladki where nazwa like '%maliny%' or nazwa like '%truskawki%';
--8 - nie rozpoczyna się żadną z liter: 'D'-'K', 'S' i 'T',
TODO nawiasy kwadratowe czy okragle?
select nazwa from czekoladki where nazwa not similar to '[D-K|S|T]%';
--9 - rozpoczyna się od 'Slod' ('Słod'),
select nazwa from czekoladki where nazwa like 'Słod%';
--10 -składa się dokładnie z jednego słowa.
select nazwa from czekoladki where nazwa not like '% %';

--3.3 - Napisz zapytanie w języku SQL oparte na tabeli Klienci, które:
--1 - wyświetla nazwy miast, z których pochodzą klienci cukierni i które składają się z więcej niż jednego słowa,
select miejscowosc from klienci where miejscowosc like '% %';
--2 - wyświetla nazwy klientów, którzy podali numer stacjonarny telefonu,
select telefon from klienci where telefon like '% % % %'
--3 - wyświetla nazwy klientów, którzy podali numer komórkowy telefonu,
select telefon from klienci where telefon not like '% % % %'

--3.4 - Korzystając z zapytań z zadania 2.4 oraz operatorów UNION, INTERSECT, EXCEPT napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek, których:
--1 - masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr,
select nazwa,masa,koszt from czekoladki where masa between 15 and 24
intersect
select nazwa, masa, koszt from czekoladki where koszt between 0.15 and 0.24;
--2 - masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr,
select nazwa,masa,koszt from czekoladki where masa between 25 and 35
except
select nazwa, masa, koszt from czekoladki where koszt between 0.25 and 0.35;
--3 - masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr lub masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr,
select nazwa, masa, koszt from czekoladki where masa between 15 and 24
intersect
select nazwa, masa, koszt from czekoladki where koszt between 0.15 and 0.24
union
(select nazwa,masa, koszt from czekoladki where masa between 25 and 35
intersect
select nazwa,masa, koszt from czekoladki where koszt between 0.25 and 0.35);
--4 - masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr,
select nazwa, masa, koszt from czekoladki where masa between 15 and 24
intersect
select nazwa, masa, koszt from czekoladki where koszt between 0.15 and 0.24;
--5 - masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, ani w przedziale od 29 do 35 gr.
select nazwa, masa, koszt from czekoladki where masa between 25 and 35
except
(select nazwa, masa, koszt from czekoladki where koszt between 0.15 and 0.24
union
select nazwa, masa, koszt from czekoladki where koszt between 0.29 and 0.35);

--3.5 - Korzystając z operatorów UNION, INTERSECT, EXCEPT napisz zapytanie w języku SQL wyświetlające:
--1 - identyfikatory klientów, którzy nigdy nie złożyli żadnego zamówienia,
select idklienta from klienci
except
select idklienta from zamowienia;
--2 - identyfikatory pudełek, które nigdy nie zostały zamówione,
select idpudelka from pudelka
except
select idpudelka from artykuly;
--3 - nazwy klientów, czekoladek i pudełek, które zawierają rz (lub Rz),
select nazwa from klienci where nazwa similar to '%(rz|Rz)%'
union
select nazwa from czekoladki where nazwa similar to '%(rz|Rz)%'
union
select nazwa from pudelka where nazwa similar to '%(rz|Rz)%';
--4 - identyfikatory czekoladek, które nie występują w żadnym pudełku.
select idczekoladki from czekoladki
except
select idczekoladki from zawartosc;

--3.6 - Napisz zapytanie w języku SQL wyświetlające:
--1 - identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości,
select idmeczu, goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4], 0) + coalesce(goscie[5],0) as "Goście",
gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5],0) as "Gospodarze"
 from siatkowka.statystyki;
--2 - identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości, dla meczów, które skończyły się po 5 setach i zwycięzca ostatniego seta zdobył ponad 15 punktów,
select idmeczu, goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4], 0) + coalesce(goscie[5],0) as "Goście",
gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5],0) as "Gospodarze"
 from siatkowka.statystyki where goscie[5] > 15 or gospodarze[5] > 15;
--3 - identyfikator i wynik meczu w formacie x:y, np. 3:1 (wynik jest pojedynczą kolumną – napisem),
select idmeczu,
(case when(gospodarze[1] > goscie[1]) then 1 else 0 end +
case when(gospodarze[2] > goscie[2]) then 1 else 0 end +
case when(gospodarze[3] > goscie[3]) then 1 else 0 end +
case when(gospodarze[4] > goscie[4]) then 1 else 0 end +
case when(gospodarze[5] > goscie[5]) then 1 else 0 end)
 || ':' ||
 (case when(gospodarze[1] < goscie[1]) then 1 else 0 end +
 case when(gospodarze[2] < goscie[2]) then 1 else 0 end +
 case when(gospodarze[3] < goscie[3]) then 1 else 0 end +
 case when(gospodarze[4] < goscie[4]) then 1 else 0 end +
 case when(gospodarze[5] < goscie[5]) then 1 else 0 end)
 as "Wynik" from siatkowka.statystyki;
--4 - identyfikator meczu, sumę punktów zdobytych przez gospodarzy i sumę punktów zdobytych przez gości, dla meczów, w których gospodarze zdobyli ponad 100 punktów,
TODO - czy da się zrobić jakiś alias zamiast liczyć drugi raz
select idmeczu, goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4], 0) + coalesce(goscie[5],0) as "Goście",
gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5],0) as "Gospodarze"
 from siatkowka.statystyki where gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5],0) > 100;

--5 - identyfikator meczu, liczbę punktów zdobytych przez gospodarzy w pierwszym secie, sumę punktów zdobytych w meczu przez gospodarzy, dla meczów, w których pierwiastek kwadratowy z liczby punktów zdobytych w pierwszym secie jest mniejszy niż logarytm o podstawie 2 z sumy punktów zdobytych w meczu.
select idmeczu, gospodarze[1],
gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5],0) as "Gospodarze"
from siatkowka.statystyki
where sqrt(gospodarze[1] + goscie[1]) < log(2, gospodarze[1] + gospodarze[2] + gospodarze[3] + coalesce(gospodarze[4], 0) + coalesce(gospodarze[5],0) + goscie[1] + goscie[2] + goscie[3] + coalesce(goscie[4], 0) + coalesce(goscie[5],0) );
