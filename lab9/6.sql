Wyświetla nazwisko, wiek oraz roczne pobory pracownika posortowane wg poborów oraz nazwiska (pole pobory w tabeli pracownicy określa pobory miesięczne).
select nazwisko, age(wiek), 12*pobory from pracownicy order by pobory desc, nazwisko asc;
Wyświetla nazwisko, imię, datę urodzenia, stanowisko, dział i pobory pracownika, który pracuje na stanowisku robotnik lub analityk i zarabia więcej niż 2000 miesięcznie.
select * from pracownicy where stanowisko in ('robotnik','analityk') and pobory > 2000;
Wyświetla nazwiska i imiona pracowników, którzy zarabiają więcej niż zarabia Adam Kowalik.
select nazwisko, imie from pracownicy where pobory > (select pobory from pracownicy where imie = "Adam" and nazwisko = "Kowalik");
TODO
Podnosi zarobki o 10% na stanowisku robotnik.
update pracownicy set pobory = 1.1 * pobory where stanowisko = 'robotnik';
Oblicza średnie zarobki oraz ilość pracowników na poszczególnych stanowiskach z wyłączeniem stanowisk kierownik.
select stanowisko, sum(pobory) / count(*), count(*) from pracownicy where stanowisko <> 'kierownik' group by stanowisko;
