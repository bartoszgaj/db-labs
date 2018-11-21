--Lab6
--Manipulowanie danymi, instrukcje INSERT, UPDATE, DELETE.

--6.1
--1 - Napisz i wykonaj zapytanie (użyj INSERT), które dodaje do tabeli czekoladki następujące informacje:
--2 - Napisz i wykonaj trzy zapytania (użyj INSERT), które dodadzą do tabeli klienci następujące dane osobowe:
--3 - Dodaj do tabeli klienci dane Izy Matusiak (idklienta 93). Pozostałe dane osobowe Izy Matusiak muszą być takie same jak dla Pana Edwarda Matusiaka. Użyj podzapytań.
--4 Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.

--6.2
--1 - Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj wartości NULL w poleceniu INSERT:
--2 - Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.

--6.3
--1 - Napisz zapytanie, które usunie informacje dodane w Zadaniu 6.2, użyj DELETE.
--2 - Sprawdź, czy odpowiednie rekordy zostały usunięte.
--3 - Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj nazwy kolumn w poleceniu INSERT:
--4 - Sprawdź, czy napisane przez Ciebie zapytania odniosły pożądany skutek tj. czy do w/w tabel zostały dodane odpowiednie wiersze, wykorzystaj SELECT.

--6.4 - Napisz instrukcje aktualizujące dane w bazie cukiernia. Sprawdź za pomocą instrukcji SELECT, czy odpowiednie rekordy zostały zmienione.
--1 - Zmiana nazwiska Izy Matusiak na Nowak.
--2 - Obniżenie kosztu czekoladek o identyfikatorach (idczekoladki): W98, M98 i X91, o 10%.
--3 - Ustalenie kosztu czekoladek o nazwie Nieznana Nieznajoma na taką samą jak cena czekoladki o identyfikatorze W98.
--4 - Zmiana nazwy z Leningrad na Piotrograd w tabeli klienci.
--5 - Podniesienie kosztu czekoladek, których dwa ostatnie znaki identyfikatora (idczekoladki) są większe od 90, o 15 groszy.

--6.5 - Napisz instrukcje usuwające z bazy danych informacje o:
--1 - klientach o nazwisku Matusiak,
--2 - klientach o identyfikatorze większym niż 91,
--3 - czekoladkach, których koszt jest większy lub równy 0.45 lub masa jest większa lub równa 36, lub masa jest równa 0.

--6.6
--1 - Napisz skrypt zawierający instrukcje INSERT wstawiające do bazy danych Cukiernia dwa nowe rekordy do tabeli Pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli Zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.

--6.7
--1 - Polecenie COPY pozwala m.in. kopiowanie danych między bazą danych i standardowym systemem plików. Polecenie COPY FROM kopiuje dane z pliku do wskazanej tabeli. Domyślnie wartości atrybutów są oddzielane tabulatorem, zaś NULL jest oznaczany symbolem \N. Polecenie COPY TO kopiuje dane z bazy danych (cała tabela, wybrane kolumny lub wynik instrukcji SELECT) do pliku. Opcje polecenia pozwalają zdefiniować m.in. separator, oznaczenia wartości null, oznaczenie napisu pustego itp. http://www.postgresql.org/docs/9.1/static/sql-copy.html
--2 - Napisz skrypt zawierający instrukcje COPY wstawiające do bazy danych cukiernia dwa nowe rekordy do tabeli pudelka oraz odpowiednie rekordy związane z tymi pudełkami do tabeli zawartosc. Każde z nowych pudełek ma zawierać łącznie co najmniej 10 czekoladek, w co najmniej 4 różnych smakach.

--6.8
--1 - Napisz instrukcję UDPATE, która dla pudełek dodanych w poprzednich dwóch zadaniach, zwiększa o 1 liczbę czekoladek każdego smaku, które w nich występują.
--2 - Napisz skrypt zawierający instrukcje UPDATE, które modyfikują tabelę czekoladki zastępując w kolumnach: czekolada, orzechy i nadzienie wartości Null wartością “brak”.
--3 - Napisz skrypt zawierający instrukcje UPDATE, które anulują zmiany wprowadzone w poprzednim punkcie.
