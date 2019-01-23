--RZEKI

--Gr.A
--1 Napisz zapytanie, które zwraca wszystkie ostrzezenia (id_ostrzezenia, czas_ostrzezenia, zmiana_poizomu) niestarsze niz półtora roku, dla których poziom rzeki wzrósł od poprzedniego pomiaru w danym punkcie o co najmniej 7%. Uwaga: atrybut zmiana_poziomu zawiera liczby, a nie procenty
select id_ostrzezenia, czas_ostrzerzenia, zmiana_poziomu from ostrzezenia
where age(czas_ostrzezenia) < interval '6 months' and zmiana_poziomu >= 0.07
--2 Napisz zapytanie, które zwróci identyfikatory punktów, dla których wykonano pomiary, ale dla których w ciagu ostatnich 2 miesiecy nie zaistniało ostrzezenie (uzyj operatorów algebry relacji).
select id_punktu from pomiary
except
select id_punktu from ostrzezenia where age(czas_ostrzerzenia) <= interval '2 months'
--3 Napisz zapytanie, które wypisze nazwy gmin, dla których kiedykolwiek odnotowano przekroczenie stanu alarmowego. Uwaga: zwrócone gminy nie powinny sie powtarzac w otrzymanym wyniku
select distinct nazwa from gminy natural join punty_pomiarowe natural join ostrzezenia
where przekroczony_stan_alarm is not null;
--4 Napisz zapytanie zwracajace daty rekordowych (maksymalnych) poziomów wody na kazdej z rzek (wraz z ich nazwami). Rekordowy poziom wody na konkretnej rzece mógł wystapic wiecej niz raz (tzn. został zanotowany w dwa rózne dni) - wtedy dana rzeka powinna pojawic sie w wynikach równiez wiecej niz raz.
select rz.nazwa, p.czas_pomiaru::date from pomiary p natural join punkty_pomiarowe pp natural join rzeki rz join
(select id_rzeki, max(poziom_wody) as maxym_pw from pomiary natural join punkty_pomiarowe group by (id_rzeki)) as P_M using (id_rzeki)
where p.poziom_wody=P_M.maxym_pw;

--5 .) Napisz dwa polecenia UPDATE:
  --1 Zmniejszajace w tabeli punkty_pomiarowe wartosc kolumny stan_alarmowy o 5 cm dla punkty o ID równym 10.
update punkty_pomiarowe set stan_alarmowy = stan_alarmowy - 5 where id_punktu = 10
  --2Aktualizujace wszystkie ostrzezenia dotyczace tego punktu, tj. ustawiajace odpowiednia wartosc kolumny przekroczony_stan_alarm.
update ostrzezenia set przekroczony_stan_alarm = coalesce(przekroczony_stan_alarm,0) + 5 where id_punktu = 10

--Gr.B
--1 Napisz zapytanie, które zwróci wszystkie punkty pomiarowe (id_punktu, stan_alarmowy, stan_ostrzegawczy) z gminy o id=5, dla których poziom stanu alarmowego jest o co najmniej 5 ∗ π % wyzszy od poziomu stanu ostrzegawczego
select id_punktu, stan_alarmowy, stan_ostrzegawczy from punkty_pomiarowe where id_gminy = 5 and stan_alarmowy > stan_ostrzegawczy * 1.05 * pi()
--2  Napisz zapytanie, które zwróci identyfikatory gmin z powiatu o id=1, w których nie znajduje sie zaden punkt pomiarowy na rzece o id=1 (uzyj operatorów algebry relacji).
select identyfikator from gminy where id_powiatu = 1
EXCEPT
select id_gminy from punkty_pomiarowe where id_rzeki = 1;
--3 Napisz zapytanie, które zwróci informacje o wszystkich punktach pomiarowych (id_punktu, stan_alarmowy) zlokalizowanych na rzece Wisła na terenie gminy Skoczów.
select id_punktu, stan_alarmowy from punkty_pomiarowe natural join rzeki r join gminy g on (id_gminy = identyfikator) where r.nazwa = 'Wisła' and g.nazwa = 'Skoczów'
--4 Napisz zpytanie zwracajace daty rekordowych (maksymalnych) poziomów wody w kazdej gminie (wraz z ich nazwami). Rekordowy poziom wody w konkretnej gminie mógł wystapic wi˛ecej niz raz (wtedy w wynikach dana gmina powinna pojawic sie równiez wiecej niz raz).
select g.nazwa, p.czas_pomiaru::date from gminy h natural join punkty pomiarowe pp, natural join pomiary p join (select id_gminy, max(poziom_wody) as max_pw from pomiary natural join punkty_pomiarowe group by id_gminy) P_M using (id_gminy) where p.poziom_wody= P_M.maxym_p;
--5 Napisz zapytanie,które doda do bazy nowy punkt pomiarowy z nastepujacymi danymi:
insert into punkty_pomiarowe values (select 34, 10, 246, 3, 50.134, 22.11, stan_ostrzegawczy, stan_alarmowy from punkty_pomiarowe where id_punktu = 25);

--Wykorzystujac podzapytania wypisz nazwy rzek, na których nie odnotowano zadnych ostrzezen. W zapytaniu nie uzywaj operatorów UNION, INTERSECT, EXCEPT
--Podaj instrukcje wyswietlajaca nazwy rzek które przepływaja przez Województwo Małopolskie (tj. na terenie tego województwa maja zlokalizowane punkty pomiarowe) i które nie przekroczyły stanu alarmowego w zadnym swoim punkcie pomiarowym na terenie tego województwa w kwietniu 2016 r. Uwaga: Rekordy w tabeli ostrzezenia sa umieszczane tylko wtedy gdy w wyniku pomiaru stwierdzono przekroczenie stanu ostrzegawczego.

--Podaj instrukcje wyswietlajaca dni z 2016 roku (daty) wraz z liczba ostrzezen o przekroczeniu stanu alarmowego w tych dniach, wyłacznie dla tych dni dla których liczba ostrzezen była maksymalna. Uwaga: Nalezy wyswietlic informacje o wszystkich takich dniach i tylko o takich dniach




-- NALEŚNIKI
--Gr A
--1 Napisz zapytanie w języku SQL wyświetlające informacje na temat składników (id_skladnika, koszt), których koszt mieści się w przedziale 1.50 - 2.50 zł lub których nazwa to “czekolada”.
select id_skladnika, koszt from skladniki where koszt between 1.5 and 2.5 or nazwa = "czekolada";
-- 2 Napisz zapytanie w języku SQL wyświetlające informacje na temat zamówień (id_zamowienia, data) które zostały złożone między 20 a 30 grudnia 2015.
select id_zamowienia, data from zamowienia where data_realizacji between '2015-12-20' and '2015-12-30';
-- 3 Napisz zapytanie w języku SQL wyświetlające informacje na temat klientów (id_klienta, nazwa) którzy posiadają dwuczłonowe nazwisko. Możesz założyć, że nazwisko dwuczłonowe jest rozdzielone łącznikiem (znak ‘-’).
select id_klienta, nazwa from klienci where nazwa not like '%-%';
--4 Korzystając z operatorów UNION, INTERSECT lub EXCEPT napisz zapytanie w języku SQL wyświetlające identyfikatory składników które były zamawiane jako składniki dodatkowe, a nie występują w żadnym z naleśników bazowych.
select id_skladnika from dodatkowe_skladniki
EXCEPT
select id_skladnika from zawartosc_nalesnika;
--5 Napisz zapytanie w języku SQL wyświetlające informacje na temat bazowych naleśników (id_nalesnika, nazwa) które zostały zamówione przez klienta o nazwie “Anna Wolna”.
select id_nalesnika, nazwa from bazowe_nalesniki b join kompozycje k on (id_nalesnika = id_bazowego_nalesnika) natural join zamowienia join klienci kl using (id_klienta) where kl.nazwa = 'Anna Wolna'
--6 Napisz zapytanie w języku SQL wyświetlające łączną masę wszystkich składników naleśnika o nazwie “Hawajski”.
select sum(masa) from skladniki natural join zawartosc_nalesnika join bazowe_nalesniki bn using (id_nalesnika) where bn.nazwa = "Hawajski"
--7 Napisz zapytanie w języku SQL wyświetlające informacje o klientach (id_klienta, nazwa), którzy zamówili więcej naleśników niż klient od identyfikatorze 2.
select id_klienta, nazwa, count(*) from klienci k1 natural join zamowienia z1 group by id_klienta having count(*) > (select count(*) from zamowienia where id_kienta = 2 );
--8 Napisz zapytanie w języku SQL obniżające koszt wszystkich składników droższych od 2 zł o 10%.
update skladniki set koszt = koszt * 0.9 where koszt > 2.0
--9 Napisz zapytanie w języku SQL, które doda do tabeli bazowe_nalesniki naleśnik o następujących danych: id_nalesnika = 99, nazwa = “Szpinakowy”, koszt = 17.50, bez opisu.

--GR B
--1 Wyświetl informacje o składnikach (nazwa, id_skladnika), których masa jest pomiędzy 10 a 30 gram, oraz id_typ = 100
select nazwa, id_skladnika from skladniki where masa between 10 and 30 and id_typ = 100;
--2 Wyświetl informacje o zamówieniach z grudnia 2015
select * from zamowienia where extract(month from data_realizacji) = 12 and extract(year from data_realizacji) = 2015
--3 Wyświetl informacje o bazowych naleśnikach, które miały w opisie słowo "pikantny". Uwzględnij, że słowo może pojawić się na początku opisu (czyli może tez być "Pikantny")
select * from bazowe_nalesniki where opis like '%pikantny%' or opis like 'Pikantny%';
select * from bazowe_nalesniki where opis similar to '(P|p)ikanty%';
--4 Używając jednego z tych operatorów: UNION, EXCEPT, INTERSECT wyświetl informacje o klientach, którzy nie złożyli żadnego zamówienia
select id_kienta from klienci
INTERSECT
select id_klienta from zamowienia
--5 Wyświetl adresy, na które przynajmniej raz zamówiono naleśnik o nazwie "Hawajski"
select id_adresu from adresy natural join zamowienia natural join kompozycje natural join bazowe_nalesniki where nazwa = "Hawajski"
--6 Zlicz wszystkie dodatkowe składniki, jakie zostały zamówione dnia 21 grudnia 2015
select count(*) from dodatkowe_skladniki naturl join kompozycje natural join zamowienia where data_realizacji = '2015-12-21'
--7 Wyświetl informacje o naleśnikach (id, nazwa) w których średni koszt składników jest większy niż średni koszt składników naleśnika o id=2
select n1.id, n1.nazwa from bazowe_nalesniki n1, bazowe_nalesniki b2 where b2.id = 2 and b1.koszt > b2.koszt
--8 Powiększ o 20% koszt naleśników, których id_nalesnika < 3
update bazowe_nalesniki set koszt = 1.2 * koszt where id_nalesnika < 3;
--9 Wstaw rekord do tabeli adresy. Wartości: (id_adresu=’dw5’, id_klienta=48,ulica=’Imperatora Dudy’, nr_domu=49), nr_mieszkania: nieznany
insert into adresy values('dw5', 48, 'Imperatora Dudy',49, null)

-- MEBLE
--A
--1 Napisz zapytanie zwracające wszystkie informacje o zamówieniach, które zostały złożone przez ostatnie 7 dni, dla których nie zostały podane informacje o odbiorcy lub nazwa odbiorcy zaczyna się od y (wielkość liter nierozróżnialna).
select * from zamowienia where data > current_date - interval '7 days' and (odbiorca is null or odbiorca ilike 'y%');
--2 Napisz zapytanie zwracające identyfikator zamówienia (idzamow) oraz identyfikator mebla (idmebla) niezależnie od tego, czy zamówienia dotyczą mebli czy pojedynczych paczek, uporządkowane malejąco po drugiej kolumnie, a w ramach tego porządku rosnąco po kolumnie idzamow.
select idzamow, idmebla from zamawiane_meble
UNION
select idzamow, idmebla from zamawiane_paczki order by 2 desc, 1 asc;
--3. Napisz zapytanie zwracające nazwę i cenę elementu oraz kod paczki, w której dany element występuje, uwzględniające elementy, które nie wchodzą w skład żadnej paczki.
select nazwa, cena from elementy left join zawartosc natural join paczka;
--4 Napisz zapytanie, które obliczy sumaryczną wartość zamawianych paczek w każdym zamówieniu. Wyniki powinny zawierać identyfikator zamówienia, nazwę odbiorcy oraz wartość zamawianych paczek, jako kolumnę o nazwie wartosc. Obliczone wartości nie mogą brać pod uwagę wartości całych mebli, które mogą znajdować się w tych samych zamówieniach.
select idzamow, odbiorca, sum(ilosc*cena) as wartosc from zamowienia natural join zamawiane_paczki natural join paczka group by idzamow
--5 Napisz zapytanie, które wyświetli dane jednoznacznie identyfikujące mebel, który dostarczany jest w najwększej liczbie paczek. Zakłada się, że poprawną wartością jest pierwszy rekord zwrócony przez zapytanie.
select count(*) from zamawiane_paczki group by idmebla order by 1 asc limit 1
--6 Napisz zapytanie, które doda do tabeli element nowe rekordy – po jednym dla każdego elementu zawierającego w swojej nazwie słowo „śruba” (niezależnie od wielkości liter), których opis rozpoczyna się od od liter ‘M’–‘Z’ oraz cyfry 3 (np. M3, N3, X3). Nazwa nowych elementów powinna być identyczna z poprzednią. Opis nowych śrub powinien zawierać tekst: „Wersja wzmacniana”. Cena powinna być podniesiona o 2 zł w stosunku do ceny wersji zwykłej. Załóż, że wartość pola idelementu generowana jest automatycznie
insert into element values (select null, nazwa, 'Wersja wzmacniana', cena + 2 from elementy where nazwa ilike '%śruba%' and opis similar to '[M-Z]3%')
