color(red).
color(green).
color(ivory).
color(blue).
color(yellow).

nationality(englishman).
nationality(spaniard).
nationality(ukrainian).
nationality(norwegian).
nationality(japanese).

pet(dog).
pet(snake).
pet(zebra).
pet(fox).
pet(horse).

drink(tea).
drink(orange_juice).
drink(milk).
drink(water).
drink(coffee).

cigarette(old_gold).
cigarette(kools).
cigarette(chesterfield).
cigarette(lucky_strike).
cigarette(parliament).

%% House = [Color, Nationality, Pet, Drink, Cigarette]

right_of(Right, Left, [Left, Right | _]).
right_of(Right, Left, [_ | Houses]) :- right_of(Right, Left, Houses).

next_to(One, Two, Houses) :- right_of(One, Two, Houses).
next_to(One, Two, Houses) :- right_of(Two, One, Houses).

house([Color, Nationality, Pet, Drink, Cigarette]) :-
  color(Color),
  nationality(Nationality),
  pet(Pet),
  drink(Drink),
  cigarette(Cigarette).


solve(Houses) :-
  [_, _, _, _, _] = Houses,

  member([red, englishman, _, _, _], Houses),
  member([_, spaniard, dog, _, _], Houses),
  member([green, _, _, coffee, _], Houses),
  member([_, ukrainian, _, tea, _], Houses),
  right_of([green, _, _, _, _], [ivory, _, _, _, _], Houses),
  member([_, _, snake, _, old_gold], Houses),
  member([yellow, _, _, _, kools], Houses),
  [_, _, [_, _, _, milk, _], _, _] = Houses,
  [[_, norwegian, _, _, _] | _] = Houses,
  next_to([_, _, _, _, chesterfield], [_, _, fox, _, _], Houses),
  next_to([_, _, _, _, kools], [_, _, horse, _, _], Houses),
  member([_, _, _, orange_juice, lucky_strike], Houses),
  member([_, japanese, _, _, parliament], Houses),
  next_to([_, norwegian, _, _, _], [blue, _, _, _, _], Houses),

  maplist(house, Houses),

  findall(Pet, pet(Pet), ExistingPets),
  findall(Pet, member([_, _, Pet, _, _], Houses), UsedPets),
  permutation(UsedPets, ExistingPets),

  findall(Drink, drink(Drink), ExistingDrinks),
  findall(Drink, member([_, _, _, Drink, _], Houses), UsedDrinks),
  permutation(UsedDrinks, ExistingDrinks).

print_solution(Hs) :- print_solution(1, Hs).
print_solution(_, []).
print_solution(N, [H | Hs]) :-
  [Color, Nationality, Pet, Drink, Cigarette] = H,
  format("House ~w: ~w ~w ~w ~w ~w\n", [N, Color, Nationality, Pet, Drink, Cigarette]),
  N_ is N + 1,
  print_solution(N_, Hs).