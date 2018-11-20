--Lab2
--Wykonywanie prostych zapytań (rzutowanie, selekcja) opartych na pojedynczych tabelach. Praca z wartościami null.

--2.1 Napisz zapytanie w języku SQL, które:
--1 - wyświetla listę klientów (nazwa, ulica, miejscowość) posortowaną według nazw klientów,
Select nazwa, ulica, miejscowosc from klienci order by nazwa;
--2 - wyświetla listę klientów posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów,
select nazwa, ulica, miejscowosc from klienci order by miejscowosc, nazwa;
--3 - wyświetla listę klientów z Krakowa lub z Warszawy posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów (zapytanie utwórz na dwa sposoby stosując w kryteriach or lub in).
select nazwa, ulica, miejscowosc from klienci where miejscowosc in ('Kraków', 'Warszawa') order by miejscowosc desc, nazwa asc;
select nazwa, ulica, miejscowosc from klienci where miejscowosc='Kraków' or miejscowosc = 'Warszawa' order by miejscowosc desc, nazwa asc;

--4 - wyświetla listę klientów posortowaną malejąco według nazw miejscowości,
select nazwa, ulica, miejscowosc from klienci order by miejscowosc desc;
--5 - wyświetla listę klientów z Krakowa posortowaną według nazw klientów.
select nazwa,ulica,miejscowosc from klienci where miejscowosc = 'Kraków' order by nazwa;

--2.2 Napisz zapytanie w języku SQL, które:
--1 - wyświetla nazwę i masę czekoladek, których masa jest większa niż 20 g,
select nazwa, masa from czekoladki where masa > 20;
--2 - wyświetla nazwę, masę i koszt produkcji czekoladek, których masa jest większa niż 20 g i koszt produkcji jest większy niż 25 gr,
select nazwa, masa, koszt from czekoladki where masa > 20 and koszt > 0.25;
--3 - j.w. ale koszt produkcji musi być podany w groszach,
select nazwa, masa, (koszt * 100)::int as "koszt w groszach" from czekoladki where masa > 20 and koszt > 0.25;
--4 - wyświetla nazwę oraz rodzaj czekolady, nadzienia i orzechów dla czekoladek, które są w mlecznej czekoladzie i nadziane malinami lub są w mlecznej czekoladzie i nadziane truskawkami lub zawierają orzechy laskowe, ale nie są w gorzkiej czekoladzie,
select nazwa, czekolada, nadzienie, orzechy from czekoladki where (czekolada = 'mleczna' and nadzienie = 'maliny') or (czekolada = 'mleczna' and nadzienie = 'truskawki');
select nazwa, czekolada, nadzienie, orzechy from czekoladki where czekolada = 'mleczna' and nadzienie in ('maliny', 'truskawki');
--5 - wyświetla nazwę i koszt produkcji czekoladek, których koszt produkcji jest większy niż 25 gr,
select nazwa, koszt from czekoladki where koszt > 0.25;
--6 - wyświetla nazwę i rodzaj czekolady dla czekoladek, które są w białej lub mlecznej czekoladzie.
select nazwa, czekolada from czekoladki where czekolada in ('biała', 'mleczna');
--2.3 Potraktuj psql jak kalkulator i wyznacz:
--1 124 * 7 + 45,
select 124 * 7 + 45;
--2 2 ^ 20,
select 2^20;
--3 √3,
select sqrt(3);
 --4 π.
select pi();

 --2.4 Napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek, których:
 --1 - masa mieści się w przedziale od 15 do 24 g,
select nazwa, masa from czekoladki where masa between 15 and 24;
 --2 - koszt produkcji mieści się w przedziale od 25 do 35 gr,
select nazwa, koszt from czekoladki where koszt between 0.25 and 0.35;
 --3 - masa mieści się w przedziale od 25 do 35 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr.
select nazwa, masa, koszt from czekoladki where masa between 25 and 35 or koszt between 0.15 and 0.24;
 --2.5 Napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek, które:

 --1 - zawierają jakieś orzechy,
select nazwa, orzechy from czekoladki where orzechy is not null;
 --2 - nie zawierają orzechów,
select nazwa, orzechy from czekoladki where orzechy is null;
 --3 - zawierają jakieś orzechy lub jakieś nadzienie,
select nazwa, orzechy, nadzienie from czekoladki where orzechy is not null or nadzienie is not null;
 --4 - są w mlecznej lub białej czekoladzie (użyj IN) i nie zawierają orzechów,
 select nazwa, czekolada, orzechy from czekoladki where czekolada in ('mleczna', 'biała') and orzechy is null;
 --5 - nie są ani w mlecznej ani w białej czekoladzie i zawierają jakieś orzechy lub jakieś nadzienie,
 select nazwa, czekolada, orzechy, nadzienie from czekoladki where czekolada not in ('mleczna', 'biała') and (orzechy is not null or nadzienie is not null);
 --6 - zawierają jakieś nadzienie,
 select nazwa, nadzienie from czekoladki where nadzienie is not null;
 --7 - nie zawierają nadzienia,
 select nazwa, nadzienie from czekoladki where nadzienie is null;
 --8 - nie zawierają orzechów ani nadzienia,
 select nazwa, nadzienie, orzechy from czekoladki where nadzienie is null and orzechy is null;
 --9 - są w mlecznej lub białej czekoladzie i nie zawierają nadzienia.
select nazwa, czekolada, nadzienie from czekoladki where czekolada in ('mleczna', 'biała') and nadzienie is null;

 --2.6 Napisz zapytanie w języku SQL, które wyświetli czekoladki których:
 --1 - masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr,
 select nazwa, masa, koszt from czekoladki where masa between 15 and 24 or koszt between 0.15 and 0.24;
 --2 -masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr lub masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr,
select nazwa, masa, koszt from czekoladki where (masa between 15 and 24 and koszt between 0.15 and 0.24) or (masa between 25 and 25 and koszt between 0.25 and 0.35);
 --3 - masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr,
 select nazwa, masa, koszt from czekoladki where masa between 15 and 24 and koszt between 0.15 and 0.24;
 --4 - masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr,
  select nazwa, masa, koszt from czekoladki where masa between 25 and 35 and koszt not between 0.25 and 0.35;
 --5 - masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, ani w przedziale od 25 do 35 gr.
  select nazwa, masa, koszt from czekoladki where masa between 25 and 35 and (koszt not between 0.15 and 0.24 and koszt not between 0.25 and 0.35);
