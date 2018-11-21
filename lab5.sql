--Lab5
--Zapytania wykorzystujące funkcje agregujące i elementy podzapytań (podzapytania skalarne).

--5.1 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - łącznej liczby czekoladek w bazie danych,
--2 - łącznej liczby czekoladek z nadzieniem (na 2 sposoby) - podpowiedź: count(*), count(nazwaKolumny),
--3 - pudełka, w którym jest najwięcej czekoladek (uwaga: konieczne jest użycie LIMIT),
--4 - łącznej liczby czekoladek w poszczególnych pudełkach,
--5 - łącznej liczby czekoladek bez orzechów w poszczególnych pudełkach,
--6 - łącznej liczby czekoladek w mlecznej czekoladzie w poszczególnych pudełkach.

--5.2 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - masy poszczególnych pudełek,
--2 - pudełka o największej masie,
--3 - średniej masy pudełka w ofercie cukierni,
--4 - średniej wagi pojedynczej czekoladki w poszczególnych pudełkach,

--5.3 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - liczby zamówień na poszczególne dni,
--2 - łącznej liczby wszystkich zamówień,
--3 - łącznej wartości wszystkich zamówień,
--4 - klientów, liczby złożonych przez nich zamówień i łącznej wartości złożonych przez nich zamówień.

--5.4 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - czekoladki, która występuje w największej liczbie pudełek,
--2 - pudełka, które zawiera najwięcej czekoladek bez orzechów,
--3 - czekoladki, która występuje w najmniejszej liczbie pudełek,
--4 - pudełka, które jest najczęściej zamawiane przez klientów.

--5.5 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - liczby zamówień na poszczególne kwartały,
--2 - liczby zamówień na poszczególne miesiące,
--3 - liczby zamówień do realizacji w poszczególnych tygodniach,
--4 - liczby zamówień do realizacji w poszczególnych miejscowościach.

--5.6 - Napisz zapytanie w języku SQL wyświetlające informacje na temat:
--1 - łącznej masy wszystkich pudełek czekoladek znajdujących się w cukierni,
--2 - łącznej wartości wszystkich pudełek czekoladek znajdujących się w cukierni.

--5.7 - Zakładając, że koszt wytworzenia pudełka czekoladek jest równy kosztowi wytworzenia zawartych w nim czekoladek, napisz zapytanie wyznaczające:

--1 - zysk ze sprzedaży jednej sztuki poszczególnych pudełek (różnica między ceną pudełka i kosztem jego wytworzenia),
--2 - zysk ze sprzedaży zamówionych pudełek,
--3 - zysk ze sprzedaży wszystkich pudełek czekoladek w cukierni.

--5.8 - Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.
--Uwaga: Można zastosować samozłączenie.
