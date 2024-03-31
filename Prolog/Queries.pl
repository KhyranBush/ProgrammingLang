:- use_module(library(lists)).

% Define the months and days of the week
month(march).
month(february).
month(june).
month(december).
month(july).

day(monday).
day(tuesday).
day(wednesday).
day(thursday).
day(friday).
day(saturday).
day(sunday).

% Define the sister predicate
sister(abigail).
sister(brenda).
sister(mary).
sister(paula).
sister(tara).

% Predicate to check if two elements are different
different(X, Y) :- X \= Y.

% Clues
clues(Sisters) :-
    Sisters = [_, _, _, _, _],

    % Clue 1: Paula was born in March but not on Saturday.
    member([paula, march, Day1], Sisters),
    member(Day1, [monday, tuesday, wednesday, thursday, friday, sunday]),
    different(Day1, saturday),

    % Clue 2: Abigail's birthday was not on Friday or Wednesday.
    member([abigail, Month2, Day2], Sisters),
    different(Day2, friday),
    different(Day2, wednesday),

    % Clue 3: The girl whose birthday is on Monday was born earlier in the year than Brenda and Mary.
    member([_, Month3, monday], Sisters),
    earlier(Month3, february, Sisters, february, march),

    % Clue 4: Tara wasn't born in February and her birthday was on the weekend.
    member([tara, Month4, Day4], Sisters),
    different(Month4, february),
    member(Day4, [saturday, sunday]),

    % Clue 5: Mary was not born in December nor was her birthday on a weekday. The girl whose birthday was in June was born on Sunday.
    member([mary, Month5, Day5], Sisters),
    different(Month5, december),
    different(Day5, monday),
    member([_, june, sunday], Sisters),

    % Additional constraints based on clues
    member([_, december, Day6], Sisters), different(Day6, sunday),
    member([_, _, monday], Sisters), different(Day6, monday),
    member([_, july, saturday], Sisters),
    member([brenda, december, _], Sisters), different(Day6, wednesday),
    member([_, june, sunday], Sisters), different(Day5, sunday),
    member([paula, march, Day7], Sisters), different(Day7, saturday),
    member([_, february, Day8], Sisters), different(Day8, friday),
    member([tara, _, Day9], Sisters), different(Day9, monday), different(Day9, wednesday), different(Day9, friday),
    member([mary, _, Day10], Sisters), different(Day10, friday), different(Day10, wednesday),

    % All sisters must have different birthdays
    maplist(unique, Sisters).

% Predicate to check if the first month is earlier than the second month
earlier(Month1, Month2, _, Month1, _) :- !.
earlier(_, Month2, _, _, Month2) :- !, fail.
earlier(_, _, Sisters, Month1, Month2) :-
    member([_, Month1, _], Sisters),
    member([_, Month2, _], Sisters).

% Predicate to ensure uniqueness of elements
unique(X) :- member(X, [abigail, brenda, mary, paula, tara]).

% Solve the puzzle
solve(Sisters) :-
    clues(Sisters),
    write_solution(Sisters).

% Write the solution
write_solution([]).
write_solution([[Sister, Month, Day]|Rest]) :-
    write(Sister), write(': '), write(Month), write(', '), write(Day), nl,
    write_solution(Rest).
