:- use_module(library(clpfd)).


my_nth1(X, Xs, Idx) :- nth1(Idx, Xs, X).

atomified_house(NumberedHouse, House) :-
  Colors = [red, green, ivory, blue, yellow],
  Nationalities = [englishman, spaniard, ukrainian, norwegian, japanese],
  Pets = [dog, snake, zebra, fox, horse],
  Drinks = [tea, orange_juice, milk, water, coffee],
  Cigarettes = [old_gold, kools, chesterfield, lucky_strike, parliament],

  maplist(nth1, NumberedHouse, [Colors, Nationalities, Pets, Drinks, Cigarettes], House).


solve(Houses) :-
  Colors = [Red, Green, Ivory, Blue, Yellow],
  Nationalities = [Englishman, Spaniard, Ukrainian, Norwegian, Japanese],
  Pets = [Dog, Snake, Zebra, Fox, Horse],
  Drinks = [Tea, OrangeJuice, Milk, Water, Coffee],
  Cigarettes = [OldGold, Kools, Chesterfield, LuckyStrike, Parliament],

  Colors ins 1..5,
  Nationalities ins 1..5,
  Pets ins 1..5,
  Drinks ins 1..5,
  Cigarettes ins 1..5,

  Englishman #= Red,
  Spaniard #= Dog,
  Coffee #= Green,
  Ukrainian #= Tea,
  Green #= (Ivory + 1),
  OldGold #= Snake,
  Kools #= Yellow,
  Milk #= 3,
  Norwegian #= 1,
  LuckyStrike #= OrangeJuice,
  Japanese #= Parliament,
  %% (Norwegian #= (Blue + 1)) #\/ (Norwegian #= (Blue - 1)),
  Blue #= 2,

  (Chesterfield #= (Fox + 1)) #\/ (Chesterfield #= (Fox - 1)),
  (Kools #= (Horse + 1)) #\/ (Kools #= (Horse - 1)),

  all_different(Colors),
  all_different(Nationalities),
  all_different(Pets),
  all_different(Drinks),
  all_different(Cigarettes),

  % uncomment this for testing to find out the number of inferences
  %% Houses = [Colors, Nationalities, Pets, Drinks, Cigarettes],
  %% maplist(label, Houses).

  % how could this be shortened?
  maplist(my_nth1(1), [Colors, Nationalities, Pets, Drinks, Cigarettes], NumberedHouse1),
  maplist(my_nth1(2), [Colors, Nationalities, Pets, Drinks, Cigarettes], NumberedHouse2),
  maplist(my_nth1(3), [Colors, Nationalities, Pets, Drinks, Cigarettes], NumberedHouse3),
  maplist(my_nth1(4), [Colors, Nationalities, Pets, Drinks, Cigarettes], NumberedHouse4),
  maplist(my_nth1(5), [Colors, Nationalities, Pets, Drinks, Cigarettes], NumberedHouse5),

  NumberedHouses = [NumberedHouse1, NumberedHouse2, NumberedHouse3, NumberedHouse4, NumberedHouse5],
  maplist(atomified_house, NumberedHouses, Houses).

print_solution(Hs) :- print_solution(1, Hs).
print_solution(_, []).
print_solution(N, [H | Hs]) :-
  [Color, Nationality, Pet, Drink, Cigarette] = H,
  format("House ~w: ~w ~w ~w ~w ~w\n", [N, Color, Nationality, Pet, Drink, Cigarette]),
  N_ is N + 1,
  print_solution(N_, Hs).

solve_and_print :- solve(Hs), print_solution(Hs).