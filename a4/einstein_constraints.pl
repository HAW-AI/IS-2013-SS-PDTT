:- use_module(library(clpfd)).


%% colors :- [red, green, ivory, blue, yellow].
%% nationalities :- [englishman, spaniard, ukrainian, norwegian, japanese].
%% pets :- [dog, snake, zebra, fox, horse].
%% drinks :- [tea, orange_juice, milk, water, coffee].
%% cigarettes :- [old_gold, kools, chesterfield, lucky_strike, parliament].

%% house([Color, Nationality, Pet, Drink, Cigarette]) :-
%%   member(Color, colors),
%%   member(Nationality, nationalities),
%%   member(Pet, pets),
%%   member(Drink, drinks),
%%   member(Cigarette, cigarettes).




house([Color, Nationality, Pet, Drink, Cigarette]) :-
  color(Color),
  nationality(Nationality),
  pet(Pet),
  drink(Drink),
  cigarette(Cigarette).

right_of(Right, Left, [Left, Right | _]).
right_of(Right, Left, [_ | Houses]) :- right_of(Right, Left, Houses).

next_to(One, Two, Houses) :- right_of(One, Two, Houses).
next_to(One, Two, Houses) :- right_of(Two, One, Houses).


solve(Houses) :-
  Houses = Nationalities,
  %% [_, _, _, _, _] = Houses,

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
  (Chesterfield #= (Fox + 1)) #\/ (Chesterfield #= (Fox - 1)),
  (Kools #= (Horse + 1)) #\/ (Kools #= (Horse - 1)),
  LuckyStrike #= OrangeJuice,
  Japanese #= Parliament,
  (Norwegian #= (Blue + 1)) #\/ (Norwegian #= (Blue - 1)),

  %% index_of(Colors, 1, Color1),
  %% index_of(Nationalities, 1, Nationality1),
  %% index_of(Pets, 1, Pet1),
  %% index_of(Drinks, 1, Drink1),
  %% index_of(Cigarettes, 1, Cigarette1),

  %% [[Color1, Nationality1, Pet1, Drink1, Cigarette1] | _] = Houses,

  all_different(Colors),
  all_different(Nationalities),
  all_different(Pets),
  all_different(Drinks),
  all_different(Cigarettes).

print_solution(Hs) :- print_solution(1, Hs).
print_solution(_, []).
print_solution(N, [H | Hs]) :-
  [Color, Nationality, Pet, Drink, Cigarette] = H,
  format("House ~w: ~w ~w ~w ~w ~w\n", [N, Color, Nationality, Pet, Drink, Cigarette]),
  N_ is N + 1,
  print_solution(N_, Hs).

index_of([Element|_], Element, 1):- !.
index_of([_|Tail], Element, Index):-
  index_of(Tail, Element, Index1),
  !,
  Index is Index1+1.